var TicketSales = artifacts.require("./TicketSales.sol");

module.exports = function(deployer) {
  deployer.deploy(TicketSales, 100000000000000000);
};
