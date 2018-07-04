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

    event ticketBought(uint ticketId, address ticketHolder);
    function buyTicket() public payable returns (uint ticketId) {
        require(state == State.Open);
        require(msg.value == ticketPrice);
        Ticket memory ticket = Ticket(msg.sender, ticketPrice); // pointer to memory
        ticketId = tickets.push(ticket) - 1;
        emit ticketBought(ticketId, msg.sender);
    }

    // **************************
    function refund(uint ticketId) public {
        require(state == State.Open);
        Ticket storage ticket = tickets[ticketId]; // reverts if out of bound
        require(ticket.holder == msg.sender);
        require(ticket.paid > 0);
        uint amount = ticket.paid;
        // can you spot the issue below?
        msg.sender.transfer(amount);
        ticket.paid = 0;
    }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^

    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
        owner.transfer(address(this).balance);
    }

}
