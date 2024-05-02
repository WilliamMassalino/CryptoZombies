// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

import "./ZombieFeeding.sol";

/** 
* @title Zombie Helper.
* @dev Extends ZombieFeeding to provide utility functions for zombies.
*/

contract ZombieHelper is ZombieFeeding {

    uint leveUpFee = 0.001 ether;

    /// @dev Restricts the function to be callable only by zombies above a certain level.

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
/** 
* @dev Withdraws balance to the owner's address. Only the owner can call this.
*/
    function withdraw() external onlyOwner {
        owner.transfer(address(this).balance);
    }
/** 
* @dev Sets the fee required to level up a zombie.
* @param _fee The fee in wei.
*/
    function setLevelUpFee (uint _fee) external onlyOwner {
        leveUpFee = _fee;
    }
/** 
* @dev Levels up a zombie after payment.
* @param _zombieId The ID of the zombie to level up.
*/
    function levelUp (uint _zombieId) external payable {
        require(msg.value == leveUpFee);
        zombies[_zombieId].level = zombies[_zombieId].level.add(1);
    }
/** 
* @dev Changes the name of a zombie. Requires the zombie to be above level 2 and the caller to be the owner.
* @param _zombieId The ID of the zombie.
* @param _newName The new name for the zombie.
*/
    function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId){
        //require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
     }
/** 
* @dev Changes the DNA of a zombie. Require the zombie to be above level 20.
* @param _zombieId The ID of the zombie.
* @param _newDna The new DNA for the zombie.
*/
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId){
        //require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }
/** 
* @dev Returns an array of zombie IDs owned by a given owner.
* @param _owner The address of the owner.
* @return An array of zombie IDs.
*/

    function getZombiesByOwner(address _owner) external view returns(uint[]){
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter = counter.add(1);
            }
        }

        return result;
    }

}