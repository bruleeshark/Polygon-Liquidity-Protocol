const ethers = require("ethers");

// Set the contract addresses
const plpTokenAddress = "0x123...";
const plpBondDistributorAddress = "0x456...";

// Connect to the PLPToken contract
const plpToken = new ethers.Contract(plpTokenAddress, plpTokenABI, provider);

// Connect to the PLPBondDistributor contract
const plpBondDistributor = new ethers.Contract(
  plpBondDistributorAddress,
  plpBondDistributorABI,
  provider
);

// Set the DOM elements that we will update
const balancePLPEl = document.getElementById("balance-plp");
const balanceLPEl = document.getElementById("balance-lp");
const tvlEl = document.getElementById("tvl");
const pricePLPEl = document.getElementById("price-plp");
const priceLPEl = document.getElementById("price-lp");
const ratioPLPLPEl = document.getElementById("ratio-plp-lp");
const ratioPLPTreasuryEl = document.getElementById("ratio-plp-treasury");
const treasuryUSDEl = document.getElementById("treasury-usd");
const multisigUSDEl = document.getElementById("multisig-usd");

// Update the balance of PLP
const balancePLP = await plpToken.balanceOf(address);
balancePLPEl.innerText = `${balancePLP} PLP`;

// Update the balance of LP
const balanceLP = await plpBondDistributor.balanceOf(address);
balanceLPEl.innerText = `${balanceLP} LP`;

// Update the TVL
const tvl = await plpBondDistributor.tvl();
tvlEl.innerText = `${tvl} ETH`;

// Update the price of PLP
const pricePLP = await plpToken.price();
pricePLPEl.innerText = `${pricePLP} ETH`;

// Update the price of LP
const priceLP = await plpBondDistributor.price();
priceLPEl.innerText = `${priceLP} ETH`;

// Update the ratio of PLP:LP
ratioPLPLPEl.innerText = `${(pricePLP / priceLP).toFixed(2)}`;

// Update the ratio of PLP:Total Treasury
const totalTreasury = await plpBondDistributor.totalTreasury();
ratioPLPTreasuryEl.innerText = `${(pricePLP / totalTreasury).toFixed(2)}`;

// Update the total USD in the treasury
const treasuryUSD = await getUSDValue(totalTreasury);
treasuryUSDEl.innerText = `${treasuryUSD} USD`;

// Update the total USD in the multisig
const multisigUSD = await getUSDValue(await plpBondDistributor.multisig());
multisigUSDEl.innerText = `${multisigUSD} USD`;

// Set up the connect button
const connectButton = document.getElementById("connect-button");
connectButton.addEventListener("click", async () => {
  // Request the user's wallet provider
  const walletProvider = new ethers.providers.Web3Provider(web3.currentProvider);

  // Get the user's address
  const address = await walletProvider.getAddress();

  // Update the wallet provider for the contract instances
  plpToken.connect(walletProvider);
  plpBondDistributor.connect(walletProvider);

  // Enable the bond buttons
  document.getElementById("bond-lp-button").disabled = false;
  document.getElementById("bond-plp-button").disabled = false;
});

// Set up the bond LP for PLP button
const bondLPButton = document.getElementById("bond-lp-button");
bondLPButton.addEventListener("click", async () => {
  // Get the amount of LP to bond
  const amount = document.getElementById("bond-lp-input").value;

  // Call the bondLP function
  await plpBondDistributor.bondLP(amount);
});

// Set up the bond PLP for LP button
const bondPLPButton = document.getElementById("bond-plp-button");
bondPLPButton.addEventListener("click", async () => {
  // Get the amount of PLP to bond
  const amount = document.getElementById("bond-plp-input").value;

  // Call the bondPLP function
  await plpBondDistributor.bondPLP(amount);
});
