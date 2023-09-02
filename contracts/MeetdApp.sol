// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/utils/Counters.sol';

contract MeetdApp {
	using Counters for Counters.Counter;

	Counters.Counter private _eventIdCounter;

	struct Event {
		uint id;
		string name;
		string description;
		string location;
		uint date;
		uint time;
		uint price;
		uint totalTickets;
		uint remainingTickets;
		address payable owner;
	}
}
