var TicketSales = artifacts.require("./TicketSales.sol");

contract("TicketSales tests", accounts => {
    it("should be possible to buy a ticket");
    it("should not be possible to buy ticket with incorrect price");
    it("should be possible to close ticket sales");
    it("should not be possible to buy ticket when event status is closed");
});
