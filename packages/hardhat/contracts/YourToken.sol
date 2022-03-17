pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {
    constructor() ERC20("Love", "LV") {
        _mint(0xa7341724c1d8371808E1f084Ec39b0ab51BB6ABf, 1000 * 10 ** 18);
    }
}
