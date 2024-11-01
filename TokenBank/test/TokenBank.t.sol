// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenBank.sol";

contract TankBankTest is Test {
    TokenBankChallenge public tokenBankChallenge;
    TokenBankAttacker public tokenBankAttacker;
    address player = address(1234);

    function setUp() public {
        
    }

    function testExploit() public {
        tokenBankChallenge = new TokenBankChallenge(player);
        tokenBankAttacker = new TokenBankAttacker(address(tokenBankChallenge));

        // Put your solution here
        vm.startPrank(player);
        // tokenBankChallenge.token().transferFrom(player, address(tokenBankAttacker), 5000000);
        // tokenBankChallenge.token().approve(address(tokenBankAttacker), 5000000);
        
        // tokenBankAttacker.delegatecall(abi.encodePacked(exploit());
        uint amount = 5e23;
        tokenBankAttacker.exploit(amount);
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenBankChallenge.isComplete(), "Challenge Incomplete");
    }
}
