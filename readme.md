https://docs.balancer.fi/ecosystem/vebal-and-gauges/gauges/how-gauges-work#multi-token-liquidity-mining

will have to apply for the above rights to distribute our tokens to Liquidity Providers in our protocol-incentivized pools.

TLDR of this project is that it is basically $CVX + $OHM, built on top of Balancer.fi pools.
This protocol will swap LP tokens for ERC20 governance token or swap governance for LP tokens
resulting output is not fully claimable for 30 days, creating mechanisme for 30d weighted speculation on either ERC20govToken or underlying LiquidityPool token price
if you are bullish erc20govToken in the next 30d, bond LP tokens for gov tokens.
if you are bullish LPtokenPrice in the next 30d, bond erc20govToken for LP tokens.
reverse operations for bearish outlook.

But why is erc20govtoken useful or desirable? and why is the underlying LiquidityPool token desireable?

We incentivize 1 pool which contains 3 other pools, in this way 4 pools are incentivized.
They are:

- PLP+BAL+stMATIC+MATICX+ am-bb-usd / (plpStableFarm) / (plpBlueFarm) / (plpGovFarm)
  * (plpStableFarm) = PLP+BAL+stMATIC+MATICX+ MAI/DAI/FRAX/am-bb-usd (staked matic + usd stablecoins) 
  * (plpBlueFarm) = PLP+BAL+stMATIC+MATICX+ WETH/WBTC/WMATIC/DPI (staked matic + risk-on blue-chips)
  * (plpGovFarm) = PLP+BAL+stMATIC+MATICX+ QI/AAVE/TETU/INDEX (staked matic + Polygon Governance Tokens)
