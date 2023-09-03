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
	string eventId;
	MeetdAppEvent eventAddr;
}
