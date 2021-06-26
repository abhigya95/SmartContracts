pragma solidity ^0.8.4;

contract SendMoney{
    
    uint public balanceReceived;
    
    function receiveMoney() public payable{
        balanceReceived += msg.value;
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function withdrawMoney() public {
        address to = msg.sender;
        payable(to).transfer(this.getBalance());
    }
    
    function withdrawMoneyTo(address payable _to) public{
        _to.transfer(this.getBalance());
    }
}