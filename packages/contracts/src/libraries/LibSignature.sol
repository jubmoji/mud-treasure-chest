// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

library LibSignature {
  function getEthSignedMessageHash(bytes32 _messageHash) internal pure returns (bytes32) {
    /*
        Signature is produced by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
    return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
  }

  function verify(
    address _signer,
    bytes32 hashedMsg,
    bytes memory signature // pure returns (bool) {
  ) internal pure returns (bool) {
    bytes32 ethSignedMessageHash = getEthSignedMessageHash(hashedMsg);

    return recoverSigner(ethSignedMessageHash, signature) == _signer;
  }

  function recoverSigner(bytes32 hashedMsg, bytes memory _signature)
   internal 
    pure
    returns (
      // pure
      address
    )
  {
    uint8 v;
    bytes32 r;
    bytes32 s;
    (v, r, s) = splitSignature(_signature);
    return ecrecover(hashedMsg, v, r, s);
  }

  function splitSignature(bytes memory sig)
   internal 
    pure
    returns (
      uint8,
      bytes32,
      bytes32
    )
  {
    require(sig.length == 65, "Invalid signature length");
    bytes32 r;
    bytes32 s;
    uint8 v;

    assembly {
      // first 32 bytes, after the length prefix
      r := mload(add(sig, 32))
      // second 32 bytes
      s := mload(add(sig, 64))
      // final byte (first byte of the next 32 bytes)
      v := byte(0, mload(add(sig, 96)))
    }
    return (v, r, s);
  }
}
