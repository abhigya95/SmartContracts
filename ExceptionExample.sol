pragma solidity ^0.8.4;

contract ExceptionExample{
    
    mapping(address => uint64) public balanceReceived;
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
}