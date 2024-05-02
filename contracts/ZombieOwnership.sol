// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

import "./ZombieAttack.sol";
import "./erc721.sol";

/** 
* @title Zombie Ownership
* @dev Extends ZombieBattle to implement ERC721 compliance for zombie trading.
*/
contract ZombieOwnership is ZombieBattle, ERC721 {

  mapping (uint => address) zombieApprovals;
/** 
* @dev Returns the number of zombies owned by a given address.
* @param _owner The address to query.
* @return The number of zombies.
*/
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerZombieCount[_owner];
  }
/** 
* @dev Returns the owner of a specific zombie ID.
* @param _tokenId The zombie ID.
* @return The address of the owner.
*/
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }
/** 
* @dev Transfer a zombie from one owner to another.
* @param _from The current owner of the zombie.
* @param _to The new owner.
* @param _tokenId The zombie ID.
*/
  function _transfer( address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    ownerZombieCount[_from] = ownerZombieCount[_from].sub(1);
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }
/** 
* @dev Public function to transfer a zombie ID to a new owner.
* @param _to The new owner.
* @param _tokenId The zombie ID.
*/
  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);

  }
/** 
* @dev Apprves another address to claim for the ownership of a zombie.
* @param _to The address being approved.
* @param _tokenId The ID of the zombie.
*/
  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }
/** 
* @dev Allows an approved address to take ownership of a zombie.
* @param _tokenId The ID of the zombie to be transferred.
*/
  function takeOwnership(uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);

  }
}
