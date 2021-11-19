pragma solidity ^0.4.25;

import "./petfactory.sol";

contract PetHelper is PetFactory {

  modifier aboveLevel(uint _level, uint _petId) {
    require(pets[_petId].level >= _level);
    _;
  }

  modifier petOnlyOwner(uint _petId) {
      require(msg.sender == petToOwner[_petId]);
      _;
  }

  function changeName(uint _petId, string _newName) external aboveLevel(2, _petId), petOnlyOwner(_petId) {
    pets[_petId].name = _newName;
  }

 /*  function changeDna(uint _petId, uint _newDna) external aboveLevel(20, _petId), petOnlyOwner(_petId) {
    pets[_petId].dna = _newDna;
  } */

  function getPetsByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerPetCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < pets.length; i++) {
      if (petToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}