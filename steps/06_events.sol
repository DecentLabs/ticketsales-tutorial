pragma solidity ^0.4.24;

contract TicketSales {

    struct Ticket {
        address holder;
        uint paid;
    }

    enum State { Open, Closed }

    address public owner;
    State public state = State.Open;
    uint public ticketPrice;

    Ticket[] public tickets;

    constructor(uint _ticketPrice) public {
        require(_ticketPrice > 0);
        owner = msg.sender;
        ticketPrice = _ticketPrice;
    }

    function getBalance() public view returns(uint balance) {
        return address(this).balance;
    }

    // **************************
    event ticketBought(uint ticketId, address ticketHolder);
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^
    function buyTicket() public payable returns (uint ticketId) {
        require(state == State.Open);
        require(msg.value == ticketPrice);
        var ticket = Ticket(msg.sender, ticketPrice);
        ticketId = tickets.push(ticket) - 1;
        // **************************
        emit ticketBought(ticketId, msg.sender);
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^
    }

    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
        owner.transfer(address(this).balance);
    }

}
