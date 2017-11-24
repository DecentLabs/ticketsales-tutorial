var TicketSales = artifacts.require("./TicketSales.sol");

module.exports = function(deployer) {
  deployer.deploy(TicketSales, web3.toWei(1));
};
