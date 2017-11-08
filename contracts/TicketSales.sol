pragma solidity ^0.4.18;

contract TicketSales {

    struct Ticket {
        address ticketHolder;
        bool used;
    }

    enum State { Open, Closed }

    address owner;
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

    function getTicketCount() external view returns(uint ticketCount) {
        return tickets.length;
    }

    event ticketBought(uint ticketId, address ticketHolder);
    function buyTicket() external payable returns (uint ticketId) {
        require(state == State.Open);
        require(msg.value == ticketPrice);
        var ticket = Ticket(msg.sender, false);
        ticketId = tickets.push(ticket) - 1;
        ticketBought(ticketId, msg.sender);
        return ticketId;
    }

    event ticketValidated(uint ticketId, address ticketHolder);
    function validateTicket(uint ticketId, address ticketHolder) external returns (bool valid) {
        // This is a naiv implementation because tickets array is visible on blockchain
        //  and check is not feasible at event entry because tx confirmation times
        require(msg.sender == owner);
        require(ticketId < tickets.length);
        Ticket storage ticket = tickets[ticketId];
        if( ticket.ticketHolder == ticketHolder && !ticket.used) {
            ticket.used = true;
            ticketValidated(ticketId, ticketHolder);
            return true;
        } else {
            return false;
        }
    }

    function closeSales() external {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
        owner.transfer(this.balance);
    }

}
