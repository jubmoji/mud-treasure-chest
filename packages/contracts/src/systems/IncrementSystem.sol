// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Counter } from "../codegen/Tables.sol";

contract IncrementSystem is System {
  function increment() public returns (uint32) {
    uint32 counter = Counter.get(_msgSender());
    uint32 newValue = counter + 1;
    Counter.set(_msgSender(), newValue);
    return newValue;
  }
}
