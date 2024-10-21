//SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployCaducusToken} from "../script/DeployCaducusToken.s.sol";
import {CaducusToken} from "../src/CaducusToken.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/CaducusToken.sol";

contract CaducusTokenTest is Test {
    CaducusToken token;
    address public constant USER = address(0x123);
    uint256 public constant INITIAL_SUPPLY = 1000 * 10 ** 18; // Adjusted for 18 decimals

    function setUp() public {
        token = new CaducusToken(INITIAL_SUPPLY);
    }

    function testInitialSupply() public view {
        // Total supply matches initial supply with 18 decimals
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
    }

    function testTransfer() public {
        token.transfer(USER, 100 * 10 ** 18); // Transfer 100 tokens
        assertEq(token.balanceOf(USER), 100 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY - 100 * 10 ** 18);
    }

    function testTransferFailInsufficientBalance() public {
        // Expect the ERC20InsufficientBalance error with correct arguments
        vm.expectRevert();
        token.transfer(USER, INITIAL_SUPPLY + 1);
    }

    function testApproveAndTransferFrom() public {
        // Approve USER to spend tokens
        token.approve(USER, 200 * 10 ** 18);
        vm.prank(USER); // Make the next transaction from USER
        token.transferFrom(address(this), USER, 200 * 10 ** 18);

        assertEq(token.balanceOf(USER), 200 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY - 200 * 10 ** 18);
    }

    function testAllowance() public {
        // Check that allowance is set correctly
        token.approve(USER, 300 * 10 ** 18);
        assertEq(token.allowance(address(this), USER), 300 * 10 ** 18);
    }
}

// contract CaducusTokenTest is Test {
//     CaducusToken public token;
//     DeployCaducusToken public caducusToken;

//     address public USER = makeAddr("user");

//     uint256 public constant INITIAL_SUPPLY = 1000 * 10 ** 18;
//     uint256 public constant STARTING_BALANCE = 100 ether;

//     function setUp() public {
//         caducusToken = new DeployCaducusToken();
//         token = caducusToken.run();
//     }

//     function testInitialSupply() public {
//         // Check that the initial supply was assigned to the deployer
//         assertEq(token.totalSupply(), INITIAL_SUPPLY);
//         assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
//     }

//     function testTransfer() public {
//         // Transfer some tokens to another address
//         token.transfer(USER, 100 * 10 ** 18);
//         assertEq(token.balanceOf(USER), 100 * 10 ** 18);
//         assertEq(
//             token.balanceOf(address(this)),
//             INITIAL_SUPPLY - 100 * 10 ** 18
//         );
//     }

//     function testTransferFailInsufficientBalance() public {
//         // Expect a revert when trying to transfer more than the balance
//         vm.expectRevert("ERC20: transfer amount exceeds balance");
//         token.transfer(USER, INITIAL_SUPPLY + 1);
//     }

//     function testApproveAndTransferFrom() public {
//         // Approve USER to spend 200 tokens on behalf of the deployer
//         token.approve(USER, 200 * 10 ** 18);
//         vm.prank(USER); // Make the next transaction from USER
//         token.transferFrom(address(this), USER, 200 * 10 ** 18);
//         assertEq(token.balanceOf(USER), 200 * 10 ** 18);
//         assertEq(
//             token.balanceOf(address(this)),
//             INITIAL_SUPPLY - 200 * 10 ** 18
//         );
//     }

//     function testAllowance() public {
//         // Approve USER and check allowance
//         token.approve(USER, 300 * 10 ** 18);
//         assertEq(token.allowance(address(this), USER), 300 * 10 ** 18);
//     }
// }
