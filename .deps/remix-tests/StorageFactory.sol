// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;


import "./SimpleStorage.sol";

// this storage factory inherits from the simple storage hence havin the
// access to the all the methods in the simple storage
contract StorageFactory is SimpleStorage {


    // these lines are no longer needed because of the inheritance
    // im just keeping for reference sake
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber) public {
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage simpleStorage =  SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.retrieve();
    }

}