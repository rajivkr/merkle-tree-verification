// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract Whitelist {
    // Create this as bytes32 to store the data as merkle tree.
    bytes32 public merkleRoot;

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    function checkInWhitelist(
        bytes32[] calldata proof,
        uint64 maxAllowanceToMint
    ) public view returns (bool) {
        // keccak256 - generates the hash from the encoded string of address & tokens to mint.
        bytes32 leaf = keccak256(abi.encode(msg.sender, maxAllowanceToMint));
        // Verify using Openzepplin's MerkleProof contract
        bool verified = MerkleProof.verify(proof, merkleRoot, leaf);
        return verified;
    }
}
