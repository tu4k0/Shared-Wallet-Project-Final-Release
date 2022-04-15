pragma solidity ^0.5.13;

contract SharedWallet
{

    address public owner;

    modifier onlyOwner() 
    {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    constructor() public
    {
        owner = msg.sender;
    }

    function () external payable
    {

    }

    function Withdraw(address payable _to, uint _amount) public onlyOwner
    {
        _to.transfer(_amount);
    } 
}
