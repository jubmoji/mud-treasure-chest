// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";
import { Guild, Nullifier, Points, Health, ChestId, Coins } from "../codegen/Tables.sol";
import { LibSignature } from "../libraries/LibSignature.sol";

contract AttackSystem is System {
  function attack(bytes32 guildId, bytes32 rawNullifier, address chestPublicKey, bytes32 chestSignature) public returns (uint32) {
		// TODO: use SemaphoreVerifier.sol
		require(Guild.get(guildId).length > 0, "AttackSystem: Guild does not exist");
		address signer = LibSignature.recoverSigner(rawNullifier, abi.encodePacked(chestSignature));
		bytes32 chestEntity = bytes32(uint256(uint160((chestPublicKey))));
		bytes32 chestId = ChestId.get(chestEntity);
		require(chestId != bytes32(0), "AttackSystem: Chest does not exist");
		require(signer == address(uint160(uint256(chestId))), "AttackSystem: Invalid signature");
		require(Nullifier.get(rawNullifier) == 0, "AttackSystem: Nullifier already used");	
	  bytes32 playerEntity = bytes32(uint256(uint160((_msgSender()))));		
		Nullifier.set(playerEntity, rawNullifier);
		uint32 currentHealth = Health.getHealth(signer);
		require(currentHealth > 0, "AttackSystem: Chest already looted");
		uint32 points = Points.get(guildId);
		Points.set(guildId, points + 1);
		if (currentHealth == 1) {
			Health.setHealth(signer, 0);
			Coins.set(guildId, 100);
			return points + 1;
		}
		Health.setHealth(signer, currentHealth - 1);
    return points + 1;
  }
}
