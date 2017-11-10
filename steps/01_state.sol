pragma solidity ^0.4.18;

contract TicketSales {
    address public owner;

    function TicketSales() public {
        owner = msg.sender;
    }

}
