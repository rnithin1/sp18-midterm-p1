pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
    struct _Queue {
        address[] data;
        uint8 front;
        uint8 back;
    }
	uint8 size = 5;
    _Queue arr;
	// YOUR CODE HERE
    	/* Add events */
	// YOUR CODE HERE

	/* Add constructor */
    function Queue() public {
        arr = _Queue({data : new address[](size), front : 0, back : 1});
    }
/*
    function Queue(address[] _data, uint8 _front, uint8 _back) public {
        arr = _Queue({data : _data, front : _front, back : _back});
    }
*/
	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		// YOUR CODE HERE
		return arr.back - arr.front;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		// YOUR CODE HERE
		return arr.front == arr.back;
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return arr.data[arr.front];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
	    for (uint8 i = 0; i < arr.back; i++) {
            if (arr.data[arr.front + i] == msg.sender) {
                return i;
            }
        }
        return size + 1;
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		// YOUR CODE HERE
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
        arr.data[arr.front] = address(0x0);
        arr.front = (arr.front + 1) % size;
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		if (qsize() == size) {
            throw;
        } else {
            arr.data[arr.back] = addr;
            arr.back = (arr.back + 1) % size;
        }
	}
}
