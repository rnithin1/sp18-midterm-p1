pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {

	address owner;
    Queue public buyers;
	Token public tokens;
	uint public totalTokensSold;

	uint public startTime;
    uint public endTime;

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        owner = msg.sender;
        tokens = new Token(_totalSupply);
        startTime = now;
        endTime = now + _saleTime;
    }

}
