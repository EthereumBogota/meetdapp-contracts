// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MeetdAppEventVariables {
	// event variables

	string public eventId;
	string public eventName;
	string public eventDescription;
	string public eventLocation;
	uint public eventTotalTickets;
	uint public eventRemainingTickets;
	uint256 public eventStartTime;
	uint256 public eventEndTime;
	uint256 public eventReedemableTime;
	bytes32 public eventSecretWordHash;
	address public eventFactory;
	address public eventOwner;
	address public eventNfts;

	// event mappings

	mapping(address => bool) public eventAttendees;

	// event events

	event BoughtTicket(address buyer);

	event RefundedTicket(address buyer);

	event TransferredTicket(address buyer, address newOwner);

	event UpdatedEventName(string eventName);

	event UpdatedEventDescription(string eventDescription);

	event UpdatedEventLocation(string eventLocation);

	event UpdatedEventTotalTickets(uint eventTotalTickets);

	event UpdatedEventStartTime(uint256 eventStartTime);

	event UpdatedEventEndTime(uint256 eventEndTime);

	event UpdatedReedemableTimeAndSecretWordHash(
		uint256 eventReedemableTime,
		bytes32 eventSecretWordHash
	);

	event UpdatedEventOwner(address eventOwner);

	event BoughtTicket(address buyer);

	event RefundedTicket(address buyer);

	event TransferredTicket(address buyer, address newOwner);
}
