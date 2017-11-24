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
    mapping(address => uint) public affiliates; // affiliate address ==> total affiliate fee

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
        require(msg.value == ticketPrice);

        if (affiliate != 0) {
            uint fee = msg.value / 100; // 1% affiliate fee.
            affiliates[msg.sender] += fee; //  overflow check not needed
            totalAffiliateFees += fee; //  overflow check not needed
        }

        Ticket memory ticket = Ticket(msg.sender, ticketPrice);
        ticketId = tickets.push(ticket) - 1;
        ticketBought(ticketId, msg.sender);
    }

    function refund(uint ticketId) public  {
        require(state == State.Open);
        Ticket storage ticket = tickets[ticketId]; // reverts if out of bound
        require(ticket.holder == msg.sender);
        require(ticket.paid > 0);
        var amount = ticket.paid;
        ticket.paid = 0;
        msg.sender.transfer(amount);
    }

    function closeSales() public {
        require(msg.sender == owner);
        require(state == State.Open);
        state = State.Closed;
        uint amount = this.balance - totalAffiliateFees;
        owner.transfer(amount);
    }

}
