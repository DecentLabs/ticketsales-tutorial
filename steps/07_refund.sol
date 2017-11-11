pragma solidity ^0.4.18;

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

    function TicketSales(uint _ticketPrice) public {
        require(_ticketPrice > 0);
        owner = msg.sender;
        ticketPrice = _ticketPrice;
    }

    function getBalance() external view returns(uint balance) {
        return this.balance;
    }

    event ticketBought(uint ticketId, address ticketHolder);
    function buyTicket() public payable returns (uint ticketId) {
        require(state == State.Open);
        require( msg.value == ticketPrice);
        var ticket = Ticket(msg.sender, ticketPrice);
        ticketId = tickets.push(ticket) - 1;
        ticketBought(ticketId, msg.sender);
    }

    function refund(uint ticketId) public  {
        require(state == State.Open);
        Ticket storage ticket = tickets[ticketId]; // reverts if out of bound
        require(ticket.holder == msg.sender);
        require(ticket.paid > 0);
        var amount = ticket.paid;
        msg.sender.transfer(amount); // what's the problem?
        ticket.paid = 0;
    }

    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
        owner.transfer(this.balance);
    }

}
