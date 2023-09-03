// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MeetdAppEventVariables {
	// event variables

	string eventId;
	string eventName;
	string eventDescription;
	string eventLocation;
	uint256 eventStartTime;
	uint256 eventEndTime;
	uint eventTotalTickets;
	uint eventRemainingTickets;
	address eventOwner;

	// event mappings

	mapping(address => bool) public eventAttendees;

	// event events

	event UpdatedEventName(string eventName);

	event UpdatedEventDescription(string eventDescription);

	event UpdatedEventLocation(string eventLocation);

	event UpdatedEventStartTime(uint256 eventStartTime);

	event UpdatedEventEndTime(uint256 eventEndTime);

	event UpdatedEventTotalTickets(uint eventTotalTickets);

	event UpdatedEventOwner(address eventOwner);

	event BoughtTicket(address buyer);

	event RefundedTicket(address buyer);

	event TransferredTicket(address buyer, address newOwner);
}
