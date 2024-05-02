// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;
/** 
* @title ERC721 Non-Fungible Token Standard basic interface.
* @dev See https://eips.ethereum.org/EIPS/eip-721
*/
contract ERC721 {
/// @dev This emits when ownership of any NFT changes by any mechanism.
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
/// @dev This emits when the owner of an NFT approves another to transfer the ownership fo the NFT.
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
/** 
* @dev Returns the number of NFTs assigned to an owner.
* @param _owner The owner whose NFTs are to be counted.
* @return The number of NFTs owned by '_owner'.
*/
  function balanceOf(address _owner) public view returns (uint256 _balance);
/** 
* @dev Returns the owner of an NFT.
* @param _tokenId The identifier for an NFT.
* @return The address of the owner fo the NFT.
*/
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
/** 
* @dev Transfer the ownership of an NFT.
* @param _to The new owner.
* @param _tokenId The NFT to transfer.
*/
  function transfer(address _to, uint256 _tokenId) public;
/** 
* @dev Gives permission to '_to' to transfer '_tokenId' to another account.
* @param _to The address being authorized.
* @param _tokenId The NFT to which access is being granted.
*/
  function approve(address _to, uint256 _tokenId) public;
/** 
* @dev Transfers the ownership of an NFT from one address to another address.
* @param _tokenId The NFT to transfer.
*/
  function takeOwnership(uint256 _tokenId) public;
}