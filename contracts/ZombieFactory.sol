// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

import "./ownable.sol";
import "./SafeMath.sol";

/** 
* @title Zombie Factory
* @dev A contarct to generate zombies with unique DNAs and manage their ownership.
*/

contract ZombieFactory is Ownable {
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    /// @dev Emitted when a new zombie is created.

    event NewZombie(uint256 zombieID, string name, uint256 dna);

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;
    uint256 cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint256 dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) ownerZombieCount;

    /**
    * @dev Internal function to create a zombie and assign it to an owner.
    * @param _name The name of the zombie.
    * @param _dna The DNA of the zombie, which determines its unique traits.
    */

    function _createZombie(string _name, uint256 _dna) internal  {
        uint256 id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0,0)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
        emit NewZombie(id, _name, _dna);
    }

    /** 
    * @dev Private function to generate a pseudo-random DNA based on the input string.
    * @param  _str The input used to generate random DNA.
    * @return The generated pseudo-random DNA.
    */

    function _generateRandomDna(string _str) private view returns (uint256) {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    /** 
    * @dev Public function to create a random zombie for the sender if they don't own any.
    * @param _name The name fo the zombie to create.
    */

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
