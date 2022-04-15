pragma solidity ^0.5.13;

contract SharedWallet
{

    address public owner;

    constructor() public
    {
        owner = msg.sender;
    }

    function () external payable
    {

    }

    function Withdraw(address payable _to, uint _amount) public
    {
        _to.transfer(_amount);
    } 
}
