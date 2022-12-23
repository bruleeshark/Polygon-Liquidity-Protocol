https://docs.balancer.fi/ecosystem/vebal-and-gauges/gauges/how-gauges-work#multi-token-liquidity-mining

will have to apply for the above rights to distribute our tokens to Liquidity Providers in our protocol-incentivized pools.

$PLP = erc20 governance token of this protocol

TLDR of this project is that it is basically $CVX + $OHM, built on top of Balancer.fi pools.

This protocol will swap LP tokens for ERC20 governance token or swap governance for LP tokens
resulting output is not fully claimable for 30 days, creating mechanisme for 30d weighted speculation on either PLP or underlying LiquidityPool token price
if you are bullish PLP in the next 30d, bond LP tokens for gov tokens.
if you are bullish LPtokenPrice in the next 30d, bond PLP for LP tokens.
reverse operations for bearish outlook.

But why is PLP useful or desirable? and why is the underlying LiquidityPool token desireable?

We incentivize 1 pool which contains 3 other pools, in this way 4 pools are incentivized.
They are:

- PLP+BAL+stMATIC+MATICX+ am-bb-usd / (plpStableFarm) / (plpBlueFarm) / (plpGovFarm)
  * (plpStableFarm) = PLP+BAL+stMATIC+MATICX+ MAI/DAI/FRAX/am-bb-usd (staked matic + usd stablecoins) 
  * (plpBlueFarm) = PLP+BAL+stMATIC+MATICX+ WETH/WBTC/WMATIC/DPI (staked matic + risk-on blue-chips)
  * (plpGovFarm) = PLP+BAL+stMATIC+MATICX+ QI/AAVE/TETU/INDEX (staked matic + Polygon Governance Tokens)

But why is PLP useful or desirable?
answer: it is constantly being market made by users and the balancer protocol, and since it primarily trades against other assets common to users' portfolio's, the PLP token should possess a Beta which gives it a positive market movement when the general market is down, allowing it utility as a contrarian or conservative trade.

But why is the underlying LiquidityPool token desirable?
the main liquidity pool will recieve yield in the form of :
staked MATIC (2 forms)
am-bb-usd boosted yield
fees from the other 3 underlying pools

therefore the LP token, once claimed, can be redeemed for a diversified basket of erc20 tokens native to Polygon, therefore if you expect PLP to perform less than the market in general, you can bond your PLP tokens and recieve LP tokens over the next 30 days, instead. Furthermore, the LP token should generate fees for Balancer protocol as well as other associated protocols (qi/mai, FRAX, etc) thereby also maintaining its usefulness as a place users of Balancer protocol can park capital and earn yield.

Together, PLP and underlyingLiquidityPool can be utilized as a market pair themselves, and you can take a stance on the direction of the wider market without making many individual trades, simply by either holding or swapping between PLP and underlyingLiquidityPool, which can be done through vesting or through selling your PLP tokens into the liquidity pool.
