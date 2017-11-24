import 'babel-polyfill';
var TicketSales = artifacts.require("./TicketSales.sol");
var ticketSales, ticketPrice;
var balBuyerBefore, balAffiliateBefore, fee;

before(async function() {
    ticketSales = TicketSales.at(TicketSales.address);
    ticketPrice = await ticketSales.ticketPrice();
    fee = ticketPrice * 0.01;
    balBuyerBefore = await web3.eth.getBalance(web3.eth.accounts[1]);
    balAffiliateBefore = await web3.eth.getBalance(web3.eth.accounts[1]);
});

contract("TicketSales tests", accounts => {
    const buyers = Math.floor(accounts.length * 0.2);
    const affiliates = accounts.length - buyers;
    const tickets = 100;
    it("should buy x ticket, 90% with affiliate", async function() {
        for (let i = 0;  i < tickets; i++) {
            let buyer = accounts[i % buyers];
            let affiliate = i % 10 == 0
                ? 0
                : accounts[buyers + (i % affiliates)];
            let tx = await ticketSales.buyTicket(affiliate, {value: ticketPrice, from: buyer});
            let ticketId = tx.logs[0].args.ticketId.toNumber();
            assert.equal(
                ticketId,
                i,
                "ticketId should be set"
            );

        }
        assert.equal(
            (await web3.eth.getBalance(ticketSales.address)).toString(),
            ticketPrice.mul(tickets).toString(),
            "contract should get ticketPrice"
        );
    });

    it("only owner should close a ticketsales");

    it("should be possible to close ticket sales", async function () {
        let oldBalance = await web3.eth.getBalance(accounts[0]);
        let tx = await ticketSales.closeSales(
            { gas: 100000, /* leave this gas limit as is:
                            the cost of closeSales() must not depend on number
                            of tickets/affiliates */
             gasPrice: web3.eth.gasPrice
            }
        );
        let newBalance = await web3.eth.getBalance(accounts[0]);
        let gasCost = web3.eth.gasPrice.mul(tx.receipt.gasUsed);
        let actual = newBalance.minus(oldBalance);
        let expected = ticketPrice.mul(tickets).minus(fee*tickets*0.9).minus(gasCost); 
        assert.equal(
            actual.toString(),
            expected.toString(),
            "owner should get paid (less affilate fees & tx gas cost)"
        );
    });

    it("should not be possible to buy ticket with incorrect price");
    it("should be possible to refund a ticket");
    it("should not be possible to refund a ticket which is already refunded");
    it("should not be possible to refund an invalid ticket");
    it("should not be possible to buy ticket when event status is closed");
});
