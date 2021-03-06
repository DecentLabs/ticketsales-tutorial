pragma solidity ^0.4.24;

contract TicketSales {

    enum State { Open, Closed }

    address public owner;
    State public state = State.Open;

    // **************************
    uint public ticketPrice;

    constructor(uint _ticketPrice) public {
        require(_ticketPrice > 0);
        owner = msg.sender;
        ticketPrice = _ticketPrice;
    }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^

    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
    }

}
