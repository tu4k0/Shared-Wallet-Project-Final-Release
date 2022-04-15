// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)
pragma solidity ^0.8.0;

import "./Allowance.sol";

contract SharedWallet is Allowance
{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    fallback () external payable
    {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function RenounceOwnership() public onlyOwner
    {
        revert("Can`t renounce ownership");
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
