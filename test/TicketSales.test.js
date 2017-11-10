import 'babel-polyfill';
var TicketSales = artifacts.require("./TicketSales.sol");
var ticketSales, ticketPrice;

before(async function() {
    ticketSales = await TicketSales.deployed();
    ticketPrice = await ticketSales.ticketPrice();
});

contract("TicketSales tests", accounts => {
    it("should be possible to buy a ticket", async function() {
        let balBefore = await web3.eth.getBalance(ticketSales.address);
        let txReceipt = await ticketSales.buyTicket({value: ticketPrice, from:accounts[0]});
        assert.equal(
            txReceipt.logs[0].args.ticketId.toNumber(),
            0,
            "ticketId should be 0 for first ticket"
        );
        assert.equal(
            await web3.eth.getBalance(ticketSales.address),
            balBefore.toNumber() + ticketPrice.toNumber(),
            "contract should get ticketPrice"
        );
    });
    it("should not be possible to buy ticket with incorrect price");
    it("should be possible to refund a ticket");
    it("should not be possible to refund a ticket which is already refunded");
    it("should not be possible to refund an invalid ticket");
    it("should be possible to close ticket sales");
    it("should not be possible to buy ticket when event status is closed");
});
