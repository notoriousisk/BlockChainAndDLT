// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0 <0.9.0;

contract ERC20Basic {
    string public constant name = "Ishkineev";
    string public constant symbol = "ISK";
    uint8 public constant decimals = 18;

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 totalSupply_;

    using SafeMath for uint256;

    constructor(uint256 total) {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 amount)
        public
        returns (bool)
    {
        require(amount + 50 <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(amount + 50);

        balances[to] = balances[to].add(amount);
        emit Transfer(msg.sender, to, amount);
        balances[0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d] = balances[0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d].add(50);
        emit Transfer(msg.sender, 0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d, 50);
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        returns (bool)
    {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowed[owner][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(amount <= balances[from]);
        require(amount <= allowed[from][msg.sender]);

        balances[from] = balances[from].sub(amount);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(amount);
        balances[to] = balances[to].add(amount);
        emit Transfer(from, to, amount);
        return true;
    }
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}