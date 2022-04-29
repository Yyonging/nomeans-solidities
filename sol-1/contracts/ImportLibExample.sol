pragma solidity ^0.8.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract DeployExample is Ownable{
    using SafeMath for uint;

    mapping(address => uint) public balances;
    uint public totalDeposited;

    event Deposited(address indexed _who, uint amount);

    event Withdraw(address indexed _who, uint amount);

    fallback() external payable {
        depositEther();
    }

    function depositEther() public payable {
        require(msg.value > 0);
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        totalDeposited.add(msg.value);
        emit Deposited(msg.sender, msg.value);
    }

    function addToBalances(uint amount) public payable {
        require(msg.value > 0);
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        totalDeposited.add(msg.value);
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount);
        balances[msg.sender] = balances[msg.sender].sub(amount);
        totalDeposited = totalDeposited.sub(amount);
        emit Withdraw(msg.sender, amount);
    }

    function kill() public payable onlyOwner {
        selfdestruct(payable(owner()));
    }
}