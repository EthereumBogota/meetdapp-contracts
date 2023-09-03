// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MeetdAppNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string baseURI;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _URI
    ) 
        ERC721(_name, _symbol)
    {
        baseURI = _URI;
    }


    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return baseURI;
    }

    function safeMint(address to) external onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function approve(
        address,
        uint256
    ) public override pure {
        revert( "Approve isn't allowed" );
    }

    function setApprovalForAll(
        address,
        bool
    ) public override pure {
        revert( "setApprovalForAll isn't allowed" );
    }

    function transferFrom(
        address,
        address,
        uint256
    ) public override pure {
        revert( "transferFrom isn't allowed" );
    }

    function safeTransferFrom(
        address,
        address,
        uint256,
        bytes calldata
    ) public override pure {
        revert( "safeTransferFrom isn't allowed" );
    }
}
