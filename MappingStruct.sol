pragma solidity ^0.8.4;

contract MappingStruct{
    
    struct Payment{
        uint amount;
        uint timestamps;
    }
    struct  Balance{
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping(address =>  Balance) public balanceReceived;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable{
        balanceReceived[msg.sender].totalBalance += msg.value;
        //Create a payment in memonry
        Payment memory payment = Payment(msg.value, block.timestamp);
        //Get the balance and then get the payments of the sender 
        //balanceReceived[msg.sender] = balance
        //balance.payments = payments array within Balance
        //payments[balanceReceived[msg.sender].numPayments] = number of payments so far in the Balance
        //In the line right below, we are logging in the new payment we just received
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        //Increment the numPayments for this address so we can log new payment in the future
        balanceReceived[msg.sender].numPayments++;
    }
    
    
    function withdrawMoney(address payable _to, uint _amount) public{
        require(balanceReceived[msg.sender].totalBalance >= _amount, "Not enough funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function withdrawAllMoney(address payable _to) public {
        
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }

}
