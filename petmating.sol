pragma solidity ^0.4.25;

import "./petfactory.sol";

contract PetMating is PetFactory {
   /*  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress); */

/**
* @dev Takes two pets and generates a new one mixing their dna. Both pets
* have to belong to msg.sender and be same species.
*
**/
  function mateAndMultiply(uint _petId, uint _targetId) public petOnlyOwner(_petId), petOnlyOwner(_targetId){
    Pet storage firstPet = pets[_petId];
    Pet storage secondPet = pets[_targetId];
    require (keccak256(abi.encodePacked(firstPet.species)) == keccak256(abi.encodePacked(secondPet.species)));
    uint newDna = (firstPet.dna + secondPet.dna) / 2;
    newDna = newDna % dnaModulus;
    _createPet("Baby", newDna);
  }
}