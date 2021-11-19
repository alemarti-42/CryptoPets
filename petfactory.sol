pragma solidity ^0.4.25;

import "./ownable.sol";

contract PetFactory is Ownable {

    event NewPet(uint petId, string name, uint dna, string species);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Pet {
        string name;
        uint dna;
        uint level;
        string species;
    }

    Pet[] public pets;

    mapping (address => uint) public ownerPetCount;
    mapping (uint => address) public petToOwner;

    function _createPet(string _name, uint _dna, string _species) internal {
        uint id = pets.push(Pet(_name, _dna, 0, _species));
        petToOwner[id] == msg.sender;
        ownerPetCount[msg.sender]++;
        emit NewPet(id, _name, _dna, _species);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomPet(string _name, string _species) public {
        require (ownerPetCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        //randDna = randDna - randDna % 100;   //Sets last two digits to 0 for storing 'special' traits.
        _createPet(_name, randDna, _species);
    }
}