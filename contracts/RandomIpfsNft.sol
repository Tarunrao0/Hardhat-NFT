//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "hardhat/console.sol";

error RandomIpfsNft__RangeOutOfBounds();
error RandomIpfsNft__NeedMoreETHSent();
error RandomIpfsNft__TransferFailed();

contract RandomIpfsNft is VRFConsumerBaseV2, ERC721URIStorage, Ownable {

    //enum
    enum Breed {
        PUG,
        SHIBA_INU,
        ST_BERNARD
    }
    // variables for requestRandomWords() args
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit ;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1; 

    //NFT Variables
    uint256 public s_tokenCounter;
    uint256 internal constant MAX_CHANCE_VALUE = 100;
    string[] internal s_dogTokenUris;
    uint256 internal immutable i_mintFee;

    //events

    event NftRequested ( uint256 indexed requestId, address requester );
    event NftMinted (Breed dogBreed, address minter);

    mapping (uint256 => address ) public s_requestIdToSender;

    constructor (
        address vrfCoordinatorV2,
        uint64 subscriptionId, 
        bytes32 gasLane,
        uint32 callbackGasLimit,
        string[3] memory dogTokenUris,
        uint256 mintFee
    ) VRFConsumerBaseV2 (vrfCoordinatorV2) 
      ERC721 ("Dogie", "DOG"){
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_subscriptionId = subscriptionId;
        i_gasLane = gasLane;
        i_callbackGasLimit = callbackGasLimit;
        s_dogTokenUris = dogTokenUris;
        i_mintFee = mintFee;
    }

    function requestNft () public payable returns (uint256 requestId) {
        if (msg.value < i_mintFee) {
            revert RandomIpfsNft__NeedMoreETHSent();
        }
        requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        s_requestIdToSender[requestId] = msg.sender;
        emit NftRequested (requestId, msg.sender);
    }

    function fulfillRandomWords ( uint256 requestId, uint256[] memory randomWords) internal override {
        address dogOwner = s_requestIdToSender[requestId];
        uint256 newTokenId = s_tokenCounter;
        //What does this token look like?
        uint256 moddedRng = randomWords[0] % MAX_CHANCE_VALUE;
        /**
         * Gives us a random value 0-99
         * so 7 would be a Pug NFT
         * 12 -> Shiba Inu
         * 88 -> St. Bernard
         */
        Breed dogBreed = getBreedFromModdedRng(moddedRng);
        _safeMint(dogOwner, newTokenId);
        _setTokenURI( newTokenId,s_dogTokenUris[uint256(dogBreed)] ); 
        emit NftMinted(dogBreed, dogOwner);

    }

    /** OK so theres going to be three diff NFTs in here
     * 1) Pug : super rare
     * 2) Shiba Inu : fairly rare
     * 3) St. Bernard : common NFT
     * 
     * To set the rarities on these NFTs we're going to be using an array with the percentage of chance of getting a specfic NFT
     * Let array = [10, 40, 100]
     * Here the chance of getting Pug would be 10%
     * Shiba Inu : 30 % [40 - (10% of getting Pug)]
     * and similarly 60% chance of getting a St.bernard NFT
     */

    function getBreedFromModdedRng (uint256 moddedRng) public pure returns (Breed) {
        uint256 cumulitiveSum = 0;
        uint256[3] memory chanceArray = getChanceArray();

        for(uint256 i = 0; i < chanceArray.length; i++){
            if (moddedRng >= cumulitiveSum && moddedRng < cumulitiveSum + chanceArray[i]) {
                return Breed(i);
            }
            cumulitiveSum += chanceArray[i];
        }
        revert RandomIpfsNft__RangeOutOfBounds();
    }

    function getChanceArray() public pure returns (uint256[3] memory) { 
        return [10, 40, MAX_CHANCE_VALUE];
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) {
            revert RandomIpfsNft__TransferFailed();
        }
    }

    //view functions

     function getMintFee() public view returns (uint256) {
        return i_mintFee;
    }

    function getDogTokenUris(uint256 index) public view returns (string memory) {
        return s_dogTokenUris[index];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}