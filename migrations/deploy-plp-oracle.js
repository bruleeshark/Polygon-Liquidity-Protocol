const fs = require("fs");
const path = require("path");

const PlpOracle = artifacts.require("plpOracle");

module.exports = async function(deployer) {
  // Read in the address of the Balancer pool from the .env file
  const balancerPoolAddress = fs.readFileSync(path.join(__dirname, ".env"), "utf-8").trim();

  // Deploy the plpOracle contract, passing in the address of the Balancer pool
  await deployer.deploy(PlpOracle, balancerPoolAddress);
};
