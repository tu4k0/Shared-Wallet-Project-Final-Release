pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable
{

    fallback () external payable
    {

    }

    function Withdraw(address payable _to, uint _amount) public onlyOwner
    {
        _to.transfer(_amount);
    } 
    
}
