pragma solidity ^0.8.4;

import "./Owned.sol";

contract InheritanceModifier is Owned{
    
    mapping(address => uint) public tokenBalance;
    
    uint tokenPrice = 1 ether;
    
    constructor() {
        tokenBalance[owner] = 100;
    }
    
    
    function createNewToken() public onlyOwner{
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner{
        tokenBalance[owner]--;
    }
    
    
}