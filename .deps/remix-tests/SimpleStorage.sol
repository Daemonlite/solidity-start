// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract SimpleStorage {

    // struct
    // struct is used to create nw objects
    // the fields are private by default

    struct People {
        uint256 favouriteNunmber;
        string name;
    }

    // instatiating / creating a new people instance
    // People public person = People({favouriteNunmber: 56,name:"Angel"});

    // array of people structs
    People[] public people;

    //mappings
    mapping(string => uint256) public nameToFavouriteNumber; 

    // this wil be initialized with 0
    uint256 public favouriteNunmber;

    function store(uint256 _favouriteNumber) public {
        favouriteNunmber = _favouriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favouriteNunmber;
    }
     
    // adding items to the array and modifying using memory
    // difference between memory and storage 
    // storage imeans to keep the value even after function is no longer called
     // memory means to use save the variable only when the function is called and delete after

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        people.push(People({favouriteNunmber: _favouriteNumber,name: _name}));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }

  
}