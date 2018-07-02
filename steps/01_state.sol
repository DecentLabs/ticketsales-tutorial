pragma solidity ^0.4.24;

contract TicketSales {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

}
