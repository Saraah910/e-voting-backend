//SPDX-License-Identifier:MIT
pragma solidity ^0.8.11;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract GenerateRandomNumber is VRFConsumerBaseV2 {

    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint256 private immutable i_entranceFees;
    bytes32 private immutable i_keyHash;
    uint64 private immutable i_subscriptionId;
    uint16 private constant i_confirmations = 3;
    uint32 private immutable i_callBackGasLimit;
    uint32 private constant numWords = 1;
    uint256 public index;
    uint256[4] public array = [123,456,789,102];

    constructor(
        address vrfCoordinator, 
        uint256 entranceFees,
        bytes32 keyHash,
        uint64 subscriptioiniId,
        uint32 callBackGasLimit

        ) VRFConsumerBaseV2(vrfCoordinator){
        i_entranceFees = entranceFees;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_keyHash = keyHash;
        i_subscriptionId = subscriptioiniId;
        i_callBackGasLimit = callBackGasLimit;

    }

    function requestRandomWinner()external returns(uint256){
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_keyHash,
            i_subscriptionId,
            i_confirmations,
            i_callBackGasLimit,
            numWords
        );
        return requestId;
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override{
        index = randomWords[0] % array.length;
    }

    function showRandomNumber() public view returns(uint256){
        return array[index];
    }


}


