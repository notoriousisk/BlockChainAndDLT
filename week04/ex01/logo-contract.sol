// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ThousandLogos is ERC721 {
    uint256 private constant MAX_TOKENS = 1000;
    uint256 private constant TOKEN_PRICE = 0.001 ether;
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Token {
        string title;
        string image;
    }

    mapping(uint256 => Token) private _tokens;
    mapping(address => uint256[]) private _userTokens;

    constructor() ERC721("Thousand Logo Page", "TLP") {}

    function buyToken() external payable {
        require(_tokenIds.current() < MAX_TOKENS, "1000 Logos amount reached");
        require(msg.value >= TOKEN_PRICE, "Insufficient value sent");

        uint256 newTokenId = _tokenIds.current();
        _safeMint(msg.sender, newTokenId);
        _tokens[newTokenId] = Token("ON SALE", "");
        _tokenIds.increment();
    }

    function modifyTokenContent(uint256 tokenId, string memory title, string memory image) external {
        require(_exists(tokenId), "Token does not exist");
        require(ownerOf(tokenId) == msg.sender, "Not the owner of the token");

        _tokens[tokenId].title = title;
        _tokens[tokenId].image = image;
    }

    function transferToken(uint256 tokenId, address to) external {
        require(_exists(tokenId), "Token does not exist");
        require(ownerOf(tokenId) == msg.sender, "Not the owner of the token");

        _transfer(msg.sender, to, tokenId);
    }

    function getUserTokens(address user) external view returns (uint256[] memory) {
        return _userTokens[user];
    }

    function getTokenContent(uint256 tokenId) external view returns (string memory title, string memory image) {
        require(_exists(tokenId), "Token does not exist");

        return (_tokens[tokenId].title, _tokens[tokenId].image);
    }
}

