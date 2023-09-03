// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { IBaseWorld } from "@latticexyz/world/src/interfaces/IBaseWorld.sol";
import { Guild } from "../codegen/Tables.sol";

contract GuildSystem is System {
  function createGuild(bytes32 guildId, bytes32[] memory members) public returns (bytes32) {
		require(Guild.get(guildId).length == 0, "GuildSystem: Guild already created");
    Guild.set(guildId, members);
    return guildId;
  }
}
