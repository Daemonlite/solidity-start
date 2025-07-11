// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;


import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {

        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);


    }

}