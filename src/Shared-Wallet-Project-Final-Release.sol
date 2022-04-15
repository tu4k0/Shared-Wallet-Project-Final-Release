pragma solidity ^0.5.13;

contract SharedWallet
{
    function () external payable
    {

    }

    function Withdraw(address payable _to, uint _amount) public
    {
        _to.transfer(_amount);
    } 
}
