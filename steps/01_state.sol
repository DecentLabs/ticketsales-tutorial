pragma solidity ^0.4.24;

contract TicketSales {
    address public owner;

    function TicketSales() public {
        owner = msg.sender;
    }

}
