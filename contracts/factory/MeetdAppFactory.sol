// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '../event/MeetdAppEvent.sol';

enum consVarInt {
	startDate,
	endDate,
	capacity
}

struct dataEvent {
	bool active;
	bytes32 eventId;
	MeetdAppEvent eventAddr;
}

/// @title MeetdApp Factory
/// @notice Create and config New Events
/// @dev This contract is the standard way to create a new event
/// @author LE0xUL
contract MeetdAppFactory {
	/// @notice Store the number of created events
	uint256 public numEvents;

	/// @notice Relation between eventId (hash nanoId) and eventAddr
	mapping(bytes32 => MeetdAppEvent) public mapIdEvent;

	/// @notice Mapping to store all the created houses numEvent -> dataEvent
	mapping(uint256 => dataEvent) public mapEventNum;

	event newEvent(string _eventId);

	function CreateEvent(
		string calldata _eventId,
		string calldata _name,
		string calldata _description,
		string calldata _location,
		uint256[3] memory _varInt
	) external {
		require(
			_varInt[consVarInt.startDate] >= block.timestamp,
			'Invalid start Date'
		);
		require(
			_varInt[consVarInt.endDate] > _varInt[consVarInt.startDate],
			'Invalid end Date'
		);
		require(_varInt[consVarInt.capacity] > 0, 'Invalid capacity');

		MeetdAppEvent eventNew = new MeetdAppEvent(
			msg.sender,
			_eventId,
			_name,
			_description,
			_location,
			_varInt
		);

		numEvents++;

		mapEventNum[numEvents] = dataEvent({
			active: true,
			eventId: _eventId,
			eventAddr: address(eventNew)
		});

		mapIdEvent[keccak256(abi.encodePacked(_eventId))] = MeetdAppEvent(
			address(eventNew)
		);

		emit newEvent(_eventId);
	}
}
