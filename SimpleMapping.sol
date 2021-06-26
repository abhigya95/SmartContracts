pragma solidity ^0.8.4;

contract SimpleMapping{
    
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping(uint => mapping(uint=>bool)) uintUintMapping;
    
    function setUintUintBoolMapping(uint _index1, uint _index2, bool _value) public{
        uintUintMapping[_index1][_index2] = _value;
    }
    
    function getUintUintMapping(uint _index1, uint _index2) public view returns(bool){
        return uintUintMapping[_index1][_index2];
    }
    
    function setValue(uint _index) public{
        myMapping[_index] = true;
    }
    
    function setMyAddressToTrue() public{
        myAddressMapping[msg.sender] = true;
    }
}