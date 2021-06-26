pragma solidity ^0.8.4;

contract Operations {
    address owner;
    bool paused;

    constructor() {
        owner = msg.sender;
    }
    
    function sendMoney() public payable{
    }
    
    function setPaused(bool _paused) public{
        require(msg.sender == owner, "You are not the owner ");
        paused = _paused;
    }
    
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(!paused, "Contact is paused");
        _to.transfer(address(this).balance);    
    }
    
    function destroySmartContract(address payable _to ) public{
        require(msg.sender == owner, "You are not allowed to rug pull");
        selfdestruct(_to);
    }
    
    function getPaused() public view returns(bool){
        return paused;
    }
    
    function getOwner() public view returns(address){
        return owner;
    }
    
}