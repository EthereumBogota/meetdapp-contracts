// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import './MeetdAppEventVariables.sol';

contract MeetdAppEvent is MeetdAppEventVariables, Ownable {
	function updateEventName(string memory _name) public onlyOwner {
		name = _name;

		emit UpdatedEventName(eventName);
		(_name);
	}

	function updateEventDescription(string memory _description) public onlyOwner {
		description = _description;

		emit UpdatedEventDescription(eventDescription);
	}

	function updateEventLocation(string memory _location) public onlyOwner {
		location = _location;

		emit UpdatedEventLocation(eventLocation);
	}

	function updateEventStartTime(uint256 _startTime) public onlyOwner {
		require(
			_startTime > startTime,
			'Start time must be greater than start time'
		);

		startTime = _startTime;

		emit UpdatedEventStartTime(eventStartTime);
	}

	function updateEventEndTime(uint256 _endTime) public onlyOwner {
		require(_endTime > startTime, 'End time must be greater than start time');

		endTime = _endTime;

		emit UpdatedEventEndTime(eventEndTime);
	}

	function updateEventTotalTickets(uint _totalTickets) public onlyOwner {
		require(
			_totalTickets >= remainingTickets,
			'Total tickets must be greater than or equal to remaining tickets'
		);

		totalTickets = _totalTickets;

		emit UpdatedEventTotalTickets(eventTotalTickets);
	}

	function updateEventNfts(address _nfts) public onlyOwner {
		require(
			msg.sender == eventFactory,
			'Only the event factory can update the nfts'
		);
		nfts = _nfts;
	}

	function updateEventOwner(address payable _owner) public onlyOwner {
		owner = _owner;

		emit UpdatedEventOwner(eventOwner);
	}

	function updateReedemableTimeAndSecretWordHash(
		uint256 _reedemableTime,
		bytes32 _secretWordHash
	) public onlyOwner {
		reedemableTime = _reedemableTime;
		secretWordHash = _secretWordHash;
	}

	function buyTicket() public payable {
		require(eventAttendees[msg.sender] == false, 'You already have a ticket');

		eventAttendees[msg.sender] = true;
		remainingTickets -= 1;

		emit BoughtTicket(msg.sender);
	}

	function refundTicket(uint _id) public payable {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');

		eventAttendees[msg.sender] = false;
		remainingTickets += 1;

		emit RefundedTicket(msg.sender);
	}

	function transferTicket(address _newOwner) public {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');

		eventAttendees[msg.sender] = false;
		eventAttendees[_newOwner] = true;

		emit TransferredTicket(msg.sender, _newOwner);
	}

	function reedemNft(string memory _secretWord) public {
		require(eventAttendees[msg.sender] == true, 'You do not have a ticket');
		require(
			block.timestamp <= eventReedemableTime,
			'You cannot reedem your NFT yet'
		);
		require(
			keccak256(_secretWord) == eventSecretWordHash,
			'Secret word is incorrect'
		);
		require(balanceOf(msg.sender) == 0, '');

		IERC721(nfts).safeMint(msg.sender);
	}
}
