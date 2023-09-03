// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MeetdAppEventVariables {
	mapping(address => bool) public eventAttendees;

	uint eventId;
	string eventName;
	string eventDescription;
	string eventLocation;
	uint256 eventDate;
	uint256 eventStartTime;
	uint256 eventEndTime;
	uint eventTotalTickets;
	uint eventRemainingTickets;
	address payable eventOwner;
}
