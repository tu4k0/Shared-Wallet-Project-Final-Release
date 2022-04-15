// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable
{
    event AllowanceDetails(address indexed _fromWho, address indexed _toWho, uint _oldAmount, uint _newAmount);

    mapping(address=>uint) public allowance;

    function setAllowance(address _who, uint _amount) public onlyOwner
    {
        emit AllowanceDetails(msg.sender, _who, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier OwnerORAllowed(uint _amount)
    {
        require(owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal
    {
        emit AllowanceDetails(msg.sender, _who, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
}

contract SharedWallet is Allowance
{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    fallback () external payable
    {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function Withdraw(address payable _to, uint _amount) public OwnerORAllowed(_amount)
    {
        require(address(this).balance >= _amount, "Not enough balance in the smart contract");
        if(owner()!=msg.sender)
        {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
        emit MoneySent(_to, _amount);
    } 

}
