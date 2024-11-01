// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenSale.sol";

contract TokenSaleTest is Test {
    TokenSale public tokenSale;
    ExploitContract public exploitContract;
    uint256 constant PRICE_PER_TOKEN = 1 ether;

    function setUp() public {
        // Deploy contracts
        tokenSale = (new TokenSale){value: 1 ether}();
        exploitContract = new ExploitContract(tokenSale);
        vm.deal(address(exploitContract), 4 ether);
    }

    // Use the instance of tokenSale and exploitContract
    function testIncrement() public {
        // Put your solution here

        // uint256 total = 0;
        // uint256 numTokens;
        // for (uint i = 1; i < type(uint256).max; i++) {
        //     numTokens = type(uint256).max / 1 ether + i;
        //     unchecked {
        //         total += numTokens * PRICE_PER_TOKEN;
        //     }
        //     if (1.16 ether == total) {
        //         console.log(numTokens);
        //         break;
        //     }
        // }
        // console.log(numTokens);
        exploitContract.exploit();
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenSale.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}
