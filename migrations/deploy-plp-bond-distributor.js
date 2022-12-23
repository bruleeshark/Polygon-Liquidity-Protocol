// ./projectfolder/scripts/deploy-plp-bond-distributor.js

const dotenv = require("dotenv");

dotenv.config();

const privateKey = process.env.PRIVATE_KEY;

// Import the Hardhat runtime environment
const { use, task } = require("hardhat");

// Import the `deploy` function from the `hardhat-deploy` plugin
const { deploy } = require("hardhat-deploy");

// Import the contract artifacts
const PLPBondDistributor = require("../build/PLPBondDistributor.json");

// Configure the task to deploy the PLPBondDistributor contract
task("deploy-plp-bond-distributor", "Deploy the PLP Bond Distributor contract")
  .addParam("multisig", "The address of the multisig contract")
  .addParam("treasury", "The address of the treasury contract")
  .setAction(async ({ multisig, treasury }) => {
    // Deploy the PLPBondDistributor contract
    const contract = await deploy(PLPBondDistributor, [multisig, treasury]);

    // Print the deployed contract address
    console.log(`PLP Bond Distributor contract deployed at: ${contract.address}`);
  });

// Use the Hardhat NomicLabs fork of Ethereum
use("@nomiclabs/hardhat-ethereum-fork");

// Use the mainnet network configuration
use("hardhat-network-mainnet");
