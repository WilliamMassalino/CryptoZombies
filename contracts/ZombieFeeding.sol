// SPDX-License-Identifier: MIT
pragma solidity ^0.4.19;

import "./ZombieFactory.sol";
/** 
* @title Kitty Interface
* @dev Interface to interact with external Kitty contract to fetch kitty details.
*/
contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

/** 
* @title Zombie Feeding
* @dev Extends Zombie Factory for functionalities related to feeding zombies.
*/
contract ZombieFeeding is ZombieFactory {
    //address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface KittyContract;
    /// @dev Ensures the function is called only by the owner of the zombie.
    modifier onlyOwnerOf(uint _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }
/** 
* @dev Sets the KittyContract address for interaction.
* @param _address The address of the KittyContract
*/
    function setKittyContractAddress(address _address) external {
        KittyContract = KittyInterface(_address);
    }
/** 
* @dev Triggers cooldown for a zombie after feeding.
* @param _zombie Zombie struct passed by reference.
*/
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
/** 
* @dev Checks if the zombie is ready to feed.
* @param _zombie Zombie struct passed by reference.
* @return True if the zombie is ready, False otherwise.
*/
    function _isReady(Zombie storage _zombie) internal view returns (bool){
        return (_zombie.readyTime <= now);
    }

/** 
* @dev Feeds a zombie and possibly creates a new zombie.
* @param _zombieId The ID of the zombie feeding.
* @param _targetDna tHE dna of the target creature to base the new zombie's DNA on.
* @param _species The species of the target, affects the DNA mixing.
*/
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna, string _species) internal onlyOwnerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species) ) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        _triggerCooldown(myZombie);
    }

/** 
* @dev Public functin allowing a zombie to feed on a kitty.
* @param _zombieId The ID of the zombie.
* @param _kittyId The ID of the kitty to feed on.
*/

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = KittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}


