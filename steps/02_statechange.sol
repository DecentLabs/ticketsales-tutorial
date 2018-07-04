pragma solidity ^0.4.24;

contract TicketSales {

    // **************************
    enum State { Open, Closed }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^

    address public owner;
    // **************************
    State public state = State.Open;
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^

    constructor() public {
        owner = msg.sender;
    }

    // **************************
    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
    }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^

}
