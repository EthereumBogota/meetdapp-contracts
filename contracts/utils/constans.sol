// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import '../event/MeetdAppEvent.sol';

enum consVarInt {
	startDate,
	endDate,
	capacity
}

enum consVarStr {
	eventId,
	eventName,
	eventDescription,
	eventLocation,
	nftName,
	nftSymbol,
	nftUri
}

enum consVarAdr {
	owner,
	nfts
}

struct dataEvent {
	bool active;
	uint256 eventNum;
	string eventId;
	MeetdAppEvent eventAddr;
	bytes32 hashId;
}
