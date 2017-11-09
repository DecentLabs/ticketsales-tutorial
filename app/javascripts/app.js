// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3 } from "web3";
import { default as contract } from "truffle-contract";

// web3 is going to be set on load event
var web3;

// Import our contract artifacts and turn them into usable abstractions.
import ticketSalesArtifacts from "../../build/contracts/TicketSales.json";
var TicketSales = contract(ticketSalesArtifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;

window.App = {
    start: function() {
        let self = this;

        // Bootstrap the MetaCoin abstraction for Use.
        TicketSales.setProvider(web3.currentProvider);

        // Get the initial account balance so it can be displayed.
        web3.eth.getAccounts(function(err, accs) {
            if (err != null) {
                alert("There was an error fetching your accounts.");
                return;
            }

            if (accs.length == 0) {
                alert(
                    "Couldn't get any accounts! Make sure your Ethereum client is configured correctly."
                );
                return;
            }

            accounts = accs;
            account = accounts[0];

            self.refresh();
        });
    },

    setStatus: function(message) {
        var status = document.getElementById("status");
        status.innerHTML = message;
    },

    refresh: async function() {
        let self = this;
        try {
            let instance = await TicketSales.deployed();
            let balance = web3.utils.fromWei(
                await web3.eth.getBalance(account)
            );
            let ticketCount = await instance.getTicketCount();
            let ticketPrice = web3.utils.fromWei(await instance.ticketPrice());
            let eventState = (await instance.state()).toNumber();
            eventState = eventState === 0 ? "Open" : "Closed";
            document.getElementById("account").innerHTML = account;
            document.getElementById("balance").innerHTML = balance;
            document.getElementById("ticketCount").innerHTML = ticketCount;
            document.getElementById("ticketPrice").innerHTML = ticketPrice;
            document.getElementById("eventState").innerHTML = eventState;
        } catch (e) {
            console.log("Error refreshing info", e);
            self.setStatus("Error refreshing info; see log.");
        }
    },

    buyTicket: async function() {
        let self = this;
        try {
            this.setStatus("Initiating transaction... (please wait)");
            alert("todo");
            //let instance = TicketSales.deployed();
        } catch (e) {
            console.log(e);
            self.setStatus("Error buying ticket coin; see log.");
        }
    }
};

window.addEventListener("load", function() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof window.web3 !== "undefined") {
        console.debug("Using web3 detected from external source.");
        web3 = new Web3(window.web3.currentProvider);
    } else {
        // throw new Error("No web3 detected.");
        // set the provider you want from Web3.providers
        console.debug(
            "No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask"
        );
        web3 = new Web3(
            new Web3.providers.HttpProvider("http://localhost:8545")
        );
    }

    window.App.start();
});
