import { mudConfig } from "@latticexyz/world/register";

export default mudConfig({
  tables: {
    Health: {
      keySchema: {
        signer: "address",
      },
      schema: {
        maxHealth: "uint32",
        health: "uint32",
      },
    },
    ChestId: {
      schema: "bytes32",
    },
    Nullifier: {
      schema: "bytes32",
    },
    Points: {
      schema: "uint32",
    },
    Coins: "uint32", // leaderboard, TODO: make better name
    Guild: {
      keySchema: {
        id: "bytes32",
      },
      schema: { members: "bytes32[]" },
    },
  },
  modules: [
    {
      name: "UniqueEntityModule",
      root: true,
    },
  ],
});
