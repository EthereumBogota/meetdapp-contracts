// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import '../event/MeetdAppEvent.sol';
import '../utils/constans.sol';
import '../NFT/MeetdAppNFT.sol';


/// @title MeetdApp Factory
/// @notice Create and config New Events
/// @dev This contract is the standard way to create a new event
/// @author LE0xUL
contract MeetdAppFactory {
	/// @notice Store the number of created events
	uint256 public numEvents;

/// @notice Mapping to store all the created houses numEvents -> dataEvent
	mapping(uint256 => dataEvent) public mapNumEvent;
	
	/// @notice Relation between eventId (hash nanoId) and dataEvent
	mapping(bytes32 => dataEvent) public mapIdEvent;

	/// @notice Relation between eventId (hash nanoId) and numEvents
	mapping(bytes32 => uint256) public mapIdEventNum;

	/// @notice Relation between event Address and numEvents
	mapping(address => uint256) public mapAddrEventNum;


	event createdEvent(
		uint256 numEvents,
		string eventId,
		bytes32 hashEventId,
		address eventAddr
	);

	function CreateEvent(
		string[] memory _varStr,
		uint256[] memory _varInt
	) external {
		require(
			_varInt[uint256(consVarInt.startDate)] >= block.timestamp,
			'Invalid start Date'
		);
		require(
			_varInt[uint256(consVarInt.endDate)] > _varInt[uint256(consVarInt.startDate)],
			'Invalid end Date'
		);
		require(_varInt[uint256(consVarInt.capacity)] > 0, 'Invalid capacity');

		MeetdAppNFT eventNFT = new MeetdAppNFT(
			_varStr[uint256(consVarStr.nftName)],
			_varStr[uint256(consVarStr.nftSymbol)],
			_varStr[uint256(consVarStr.nftUri)]
		);
		
		address[] memory varAdr = new address[] (2);
		varAdr[uint256(consVarAdr.owner)] = msg.sender;
		varAdr[uint256(consVarAdr.nfts)] = address(eventNFT);

		MeetdAppEvent eventNew = new MeetdAppEvent(
			varAdr,
			_varStr,
			_varInt
		);

		eventNFT.transferOwnership(address(eventNew));

		numEvents++;
		bytes32 hashEventId = keccak256(abi.encodePacked(_varStr[uint256(consVarStr.eventId)]));

		mapNumEvent[numEvents] = dataEvent({
			active: true,
			eventNum: numEvents,
			eventId: _varStr[uint256(consVarStr.eventId)],
			eventAddr: eventNew,
			hashId: hashEventId
		});


		mapIdEvent[hashEventId] = MeetdAppEvent(address(eventNew));

		emit createdEvent(
			numEvents,
			_varStr[uint256(consVarStr.eventId)],
			hashEventId,
			address(eventNew)
		);
	}
}
