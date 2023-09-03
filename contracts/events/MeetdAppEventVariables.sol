// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MeetdAppEventVariables {
	// event mapping

	mapping(address => bool) public eventAttendees;

	// Event variables

	uint eventId;
	string eventName;
	string eventDescription;
	string eventLocation;
	uint256 eventDate;
	uint256 eventTime;
	uint eventTotalTickets;
	uint eventRemainingTickets;
	address payable eventOwner;
}
