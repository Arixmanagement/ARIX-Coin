# ERC20 Token
ERC20 is a protocol standard that defines certain rules and standards for issuing tokens on Ethereum’s network.

In ‘ERC20’, ERC stands for Ethereum Request For Comments and 20 stands for a unique ID number to distinguish this standard from others.

This project was generated using the ERC20 standard token.

## Token Description :
 Name   : ARIX COIN  
 Symbol : ARIX

 There a few core contracts that implement the behavior specified in the ARIX Coin: ARIX, Interest, ERC20, ERC20Detailed, Ownable, SafeMath.

## Build, Compile and migration

Run `truffle compile` to compile the project. The configration details of network mentioned in the `truffle-config.js` file.  
Paste the private Key in `.secret` file in project root.  
Replace `infuraKey` in `truffle-config.js`.
```
$ npm i -g truffle  
$ npm i @truffle/hdwallet-provider  
$ rm -rf build/  
$ truffle compile  
$ truffle deploy --network mainnet  
```   

## ARIX Coin PROJECT

The project uses:
1. Ethereum blockchain as a base of infrastructure
2. Truffle version 5.1.31
3. Solidity version: "0.6.0"
3. OpenZeppelin version 2.0.0

### ARIX coin summary
1. ARIX coin address: `0xCc84b805d620fb55ea21FEF809052720c5Eae2Ab`
2. ARIX symbol: ARIX
3. ARIX decimals: 3

### Project summary
The project consists of ERC20 token contract.

`contracts/ARIX.sol` Contains ARIX coin smart contract. This contract has the ERC20, distribution, totalsupply and transferOwnership. 

There are some important function in ARIX.sol :

 1. `transferOwnership` : you can change the ownership , eg. The current owner is Account 1 , input   the new owner , as the transaction sucessfull. You can check on the Owner() , it shows the current owner.

 After transfering ownership to other address, the total token also get transfer to the new owner.

 2. `contracts/ERC20.sol` Contains the general functionality of the ERC20 token like balanceOf, transfer, increaseAllowance, decreaseAllowance, _mint, _burn, _approve, transferFrom.

 3. `contracts/Ownable.sol` Contains the Authentication of ERC20 Owner token Address and can change the ownership of owner.

 4. `contracts/ERC20Detailed.sol` Contain the details of name, symbol, decimal of the coin. The decimals are only for visualization purposes. All the operations are done using the smallest and indivisible token unit, just as on Ethereum all the operations are done in wei.

 5. `contracts/Interest.sol` Interest calculation logics are defined in this file.


**IMPORTANT: Use the** `openzeppelin library` **In order to add default method while creation token**

