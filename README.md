# Ticket Sales Ethereum Tutorial

An example dapp for Intro to Ethereum workshop.

_by_
[![DECENT](http://www.decent.org/images/logo-voronoi_120x33.png)](http://www.decent.org)

## Install

### on \* nix

1. [Ethereum CLI](https://www.ethereum.org/cli)
1. [nodejs](https://nodejs.org/en/download/) (tested with version 8.9.1)
1. node version manager: `npm install -g n`
1. Install node: `n 8.9.1`
1. `npm install -g ethereumjs-testrpc@4.1.3`
1. `npm install -g truffle@4.0.1`
1. `git clone https://github.com/DecentLabs/ticketsales-tutorial.git`
1. `cd ticketsales-tutorial`
1. `npm install`

### on win

1. [Git Bash](https://git-for-windows.github.io/)
1. [Ethereum CLI](https://www.ethereum.org/cli) - including development tools
1. [Node Version Manager(NVM)](https://github.com/coreybutler/nvm-windows/releasesNVM)

   in Git bash:

1. `nvm install 8.9.1`
1. `nvm use 8.9.1`
1. `npm install -g ethereumjs-testrpc@4.1.3`
1. `npm install -g truffle@4.0.1`
1. `npm install`

## Run

1. `./runtestrpc.sh`
1. `truffle migrate` or `truffle migrate --reset` for redeploy
1. `npm run dev`

## Authors

* [szerintedmi](https://github.com/szerintedmi)
* [phraktle](https://github.com/phraktle)

## Licence

This project is licensed under MIT license - see the [LICENSE](LICENSE) file for
details.
