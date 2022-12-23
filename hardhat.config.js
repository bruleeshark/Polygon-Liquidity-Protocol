module.exports = {
  // Set the default network to use when running tasks
  defaultNetwork: "localhost",

  // Configuration for the local blockchain network
  networks: {
    localhost: {
      // Use a hardcoded mnemonic to generate the same addresses every time
      mnemonic: "your mnemonic here",
      // Use the hardhat-deploy plugin to deploy contracts
      deploy: {
        PLPToken: {
          constructorArgs: ["Polygon Liquidity Protocol", "PLP", 18, 7000000 * (10 ** 18)]
        },
        PLPBondDistributor: {
          constructorArgs: [multisigAddress, treasuryAddress]
        }
      }
    }
  },

  // Use the hardhat-deploy plugin to manage contract deployments
  plugins: ["hardhat-deploy"]
};
