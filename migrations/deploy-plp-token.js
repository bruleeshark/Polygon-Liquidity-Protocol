// ./projectfolder/scripts/deploy-plp-token.js

// Import the Hardhat runtime environment
const { use, task } = require("hardhat");

// Import the `deploy` function from the `hardhat-deploy` plugin
const { deploy } = require("hardhat-deploy");

// Import the contract artifacts
const PLPToken = require("../build/PLPToken.json");

// Configure the task to deploy the PLPToken contract
task("deploy-plp-token", "Deploy the PLP Token contract")
  .addParam("name", "The name of the token")
  .addParam("symbol", "The symbol of the token")
  .addParam("decimals", "The number of decimals for the token")
  .addParam("totalSupply", "The total supply of the token")
  .setAction(async ({ name, symbol, decimals, totalSupply }) => {
    // Deploy the PLPToken contract
    const contract = await deploy(PLPToken, [name, symbol, decimals, totalSupply]);

    // Print the deployed contract address
    console.log(`PLP Token contract deployed at: ${contract.address}`);
  });

// Use the Hardhat NomicLabs fork of Ethereum
use("@nomiclabs/hardhat-ethereum-fork");

// Use the mainnet network configuration
use("hardhat-network-mainnet");
