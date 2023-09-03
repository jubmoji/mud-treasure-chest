// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

interface IAttackSystem {
  function attack(
    bytes32 guildId,
    bytes32 rawNullifier,
    address chestPublicKey,
    bytes32 chestSignature
  ) external returns (uint32);
}
