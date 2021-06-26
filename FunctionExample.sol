pragma solidity ^0.8.4;

contract FunctionExample{
    
    mapping(address => uint64) public balanceReceived;
    address payable owner;
    
    constructor() {
        owner = payable(msg.sender);
    }
    
    function getOwner() public view returns(address){
        return owner;
    }
    
    //A pure function can call another pure function
    function convertWeiToEther(uint _amountInWei) public pure returns(uint){
        return _amountInWei / 1 ether;
    }
    
    function destroySmartContract() public{
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }
    
    //Assert is used to validate invariants
    //Require is used to validate inputs
    function receiveMoney() public payable{
        //Make sure that the wallet's balance will be higher after receiveing the amount
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public{
        require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");
        //Make sure that the address has correct leftover balance
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
     fallback() external payable{
        receiveMoney();
    }
    
     receive() external payable {
        receiveMoney();
    }
}