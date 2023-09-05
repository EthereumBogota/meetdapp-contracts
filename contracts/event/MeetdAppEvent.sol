// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/access/Ownable.sol';
import './MeetdAppEventVariables.sol';
import '../utils/constans.sol';
import '../interfaces/IMeetdAppNFT.sol';

contract MeetdAppEvent is MeetdAppEventVariables, Ownable {
	constructor(
		address[] memory _varAdr,
		string[] memory _varStr,
		uint256[] memory _varInt
	) {
		eventOwner = _varAdr[uint256(consVarAdr.owner)];
		eventNfts = _varAdr[uint256(consVarAdr.nfts)];

		eventId = _varStr[uint256(consVarStr.eventId)];
		eventName = _varStr[uint256(consVarStr.eventName)];
		eventDescription = _varStr[uint256(consVarStr.eventDescription)];
		eventLocation = _varStr[uint256(consVarStr.eventLocation)];

		eventStartTime = _varInt[uint256(consVarInt.startDate)];
		eventEndTime = _varInt[uint256(consVarInt.endDate)];
		eventTotalTickets = eventRemainingTickets = _varInt[
			uint256(consVarInt.capacity)
		];
	}

	function reedemNft(string calldata _eventSecretWord) public {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');
		require(
			block.timestamp <= eventReedemableTime,
			'You cannot reedem your NFT yet'
		);
		require(
			keccak256(abi.encodePacked(_eventSecretWord)) == eventSecretWordHash,
			'Secret word is incorrect'
		);
		require(
			IMeetdAppNFT(eventNfts).balanceOf(msg.sender) == 0,
			'You already have a NFT'
		);

		IMeetdAppNFT(eventNfts).safeMint(msg.sender);
	}

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

	function updateEventOwner(address _eventOwner) public onlyOwner {
		eventOwner = _eventOwner;

		emit UpdatedEventOwner(eventOwner);
	}

	function buyTicket() public {
		require(eventAttendees[msg.sender] == false, 'You already have a ticket');

		eventAttendees[msg.sender] = true;
		eventRemainingTickets -= 1;

		emit BoughtTicket(msg.sender);
	}

	function refundTicket() public {
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
