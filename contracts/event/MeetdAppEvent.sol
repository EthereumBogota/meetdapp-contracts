// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/access/Ownable.sol';
import './MeetdAppEventVariables.sol';

contract MeetdAppEvent is MeetdAppEventVariables, Ownable {
	function updateEventName(string memory _eventName) public onlyOwner {
		eventName = _eventName;

		emit UpdatedEventName(eventName);
		(_eventName);
	}

	function updateEventDescription(
		string memory _eventDescription
	) public onlyOwner {
		eventDescription = _eventDescription;

		emit UpdatedEventDescription(eventDescription);
	}

	function updateEventLocation(string memory _eventLocation) public onlyOwner {
		eventLocation = _eventLocation;

		emit UpdatedEventLocation(eventLocation);
	}

	function updateEventStartTime(uint256 _eventStartTime) public onlyOwner {
		require(
			_eventStartTime > eventStartTime,
			'Start time must be greater than start time'
		);

		eventStartTime = _eventStartTime;

		emit UpdatedEventStartTime(eventStartTime);
	}

	function updateEventEndTime(uint256 _eventEndTime) public onlyOwner {
		require(
			_eventEndTime > eventStartTime,
			'End time must be greater than start time'
		);

		eventEndTime = _eventEndTime;

		emit UpdatedEventEndTime(eventEndTime);
	}

	function updateEventTotalTickets(uint _eventTotalTickets) public onlyOwner {
		require(
			_eventTotalTickets >= eventRemainingTickets,
			'Total tickets must be greater than or equal to remaining tickets'
		);

		eventTotalTickets = _eventTotalTickets;

		emit UpdatedEventTotalTickets(eventTotalTickets);
	}

	function updateEventOwner(address payable _eventOwner) public onlyOwner {
		eventOwner = _eventOwner;

		emit UpdatedEventOwner(eventOwner);
	}

	function buyTicket() public payable {
		require(eventAttendees[msg.sender] == false, 'You already have a ticket');

		eventAttendees[msg.sender] = true;
		eventRemainingTickets -= 1;

		emit BoughtTicket(msg.sender);
	}

	function refundTicket(uint _id) public payable {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');

		eventAttendees[msg.sender] = false;
		eventRemainingTickets += 1;

		emit RefundedTicket(msg.sender);
	}

	function transferTicket(address _newOwner) public {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');

		eventAttendees[msg.sender] = false;
		eventAttendees[_newOwner] = true;

		emit TransferredTicket(msg.sender, _newOwner);
	}
}
