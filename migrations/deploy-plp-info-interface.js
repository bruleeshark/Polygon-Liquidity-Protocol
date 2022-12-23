// ./projectfolder/scripts/deploy-plp-info-interface.js

// Import the Hardhat runtime environment
const { use, task } = require("hardhat");

// Import the `deploy` function from the `hardhat-deploy` plugin
const { deploy } = require("hardhat-deploy");

// Import the contract artifacts
const PLPInfoInterface = require("../build/PLPInfoInterface.json");

// Configure the task to deploy the PLPInfoInterface contract
task("deploy-plp-info-interface", "Deploy the PLP Info Interface contract")
  .setAction(async () => {
    // Deploy the PLPInfoInterface contract
    const contract = await deploy(PLPInfoInterface);

    // Print the deployed contract address
    console.log(`PLP Info Interface contract deployed at: ${contract.address}`);
  });

// Use the Hardhat NomicLabs fork of Ethereum
use("@nomiclabs/hardhat-ethereum-fork");

// Use the mainnet network configuration
use("hardhat-network-mainnet");
