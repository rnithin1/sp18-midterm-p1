pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
    address[] data;
    uint8 pointer;
	uint8 size = 5;
    uint time_limit;
    uint time_spent;
	// YOUR CODE HERE
    event removed(address);
	// YOUR CODE HERE

	/* Add constructor */
    function Queue(uint8 _time_limit) public {
        data = new address[](size);
        pointer = 0;
        time_limit = _time_limit;
    }

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		// YOUR CODE HERE
        return pointer;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		// YOUR CODE HERE
		return pointer == 0;
	}

	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return data[0];
	}

	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
	    for (uint8 i = 0; i < size; i++) {
            if (data[i] == msg.sender) {
                return i + 1;
            }
        }
        return size + 1;
	}

	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
        if (now >= time_spent + time_limit) {
            removed(data[0]);
            dequeue();
        }
	}

	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
        data[pointer] = address(0x0);
        for (uint8 i = 0; i < pointer - 1; i++) {
            data[i] = data[i + 1];
        }
        data[pointer - 1] = 0;
        pointer--;
        time_spent = now;
    }

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		if (qsize() == size) {
            throw;
        } else if (empty()) {
            time_spent = now;
        } else {
            data[pointer] = addr; 
            pointer++;
        }
	}

    function () {

    }
}
