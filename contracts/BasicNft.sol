//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.7;

contract BasicNft is ERC721 {

uint256 private s_tokenCounter;
string public constant TOKEN_URI ="ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0; //tokenId
    }
    // function from the ERC721 contract to mint the NFT
    function mintNft () public returns (uint256){
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        return s_tokenCounter;
    }
    //Linking the token ID to its URI
    function tokenURI (uint256 /*tokenId*/) public view override returns (string memory) {
        return TOKEN_URI;
    }
    //getter function
    function getTokenCounter() public view returns (uint256){
        return s_tokenCounter;
    }

}