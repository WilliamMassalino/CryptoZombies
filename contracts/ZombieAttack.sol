// SPDX-License-Identifier: MIT

pragma solidity ^0.4.19;
import "./ZombieHelper.sol";

/** 
* @title Zombie Battle
* @dev Extends ZombieHelper to allow zombies to attack each other.
*/

contract ZombieBattle is ZombieHelper {
    uint randNonce = 0;
    uint attackVictoryProbability = 70;
/** 
* @dev Generates a pseudo-random number based on the input modulus.
* @param _modulus The modulus to bound the random number.
* @return A pseudo-random number.
*/
    function randMod(uint _modulus) internal returns(uint){
        randNonce++;
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
    }
/** 
* @dev Allows a zombie to attack another zombie.
* @param _zombieId The ID of the attacking zombie.
* @param _zombieId The ID of the target zombie.
*/
    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId){
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        if (rand <= attackVictoryProbability){
            myZombie.winCount = myZombie.winCount.add(1);
            myZombie.level = myZombie.level.add(1);
            enemyZombie.lossCount = enemyZombie.lossCount.add(1);
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");

        } else {
            myZombie.lossCount = myZombie.lossCount.add(1);
            enemyZombie.winCount = enemyZombie.winCount.add(1);
        }
    _triggerCooldown(myZombie);
    }
}
