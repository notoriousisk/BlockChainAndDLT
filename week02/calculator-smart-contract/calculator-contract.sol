// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0 <0.9.0;

contract Calculator{
    uint public result;

    function add(uint x, uint y) public {
        result = x + y;
    }

    function subtract(uint x, uint y) public {
        result = x - y;
    }

    function multiply(uint x, uint y) public {
        result = x * y;
    }

    function divide(uint x, uint y) public {
        require(y != 0, "Division by zero is not allowed.");
        result = x / y;
    }
}
