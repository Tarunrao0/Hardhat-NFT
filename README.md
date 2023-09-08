<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
</div>
</br>

# About the project

This project aims at learning all about NFTs

## What is an NFT? What does NFT stand for?
Non-fungible token.

That doesn’t make it any clearer.

Right, sorry. “Non-fungible” more or less means that it’s unique and can’t be replaced with something else. For example, a bitcoin is fungible — trade one for another bitcoin, and you’ll have exactly the same thing.

A one-of-a-kind trading card, however, is non-fungible. If you traded it for a different card, you’d have something completely different.

## What does an NFT look like?

Something like this?

![299ffe8c885c907a134b3cc7697d2613](https://github.com/Tarunrao0/Hardhat-NFT/assets/122633325/4abfb69c-3551-460e-8c66-9a1c3ebaf254)

Maybe even like this

![unnamed](https://github.com/Tarunrao0/Hardhat-NFT/assets/122633325/140ea2b7-871d-403c-adf3-023c53bf4301)

# Project Contents
 ## Ⓐ Basic NFT : 
 A normal NFT / ERC721 token that can be minted and get its tokenURI

 ## Ⓑ Random IPFS NFT :

 An NFT smart contract that mints tokens but also adds randomness to what rarity of NFT you may get 

 ### PUG

 In this contract there's 10% chance of getting a PUG token . Now he is SUPER RARE to get 

 ![pug](https://github.com/Tarunrao0/Hardhat-NFT/assets/122633325/f0213b2f-fa12-4a1c-b412-7f17a4f4bbf2)

 ### SHIBA INU

 Next up is the Shiba Inu with a 30% chance of getting . You could say he is kinda RARE

 ![shiba-inu](https://github.com/Tarunrao0/Hardhat-NFT/assets/122633325/64476336-7992-4ef6-ae6e-b1cdd0e0c982)

 ### ST BERNARD

 Now Bernie is the most common NFT youd be getting with a 60% chance of getting. He is pretty COMMON but he is still cute

 ![st-bernard](https://github.com/Tarunrao0/Hardhat-NFT/assets/122633325/fee9d43a-f1e0-46b1-b7fd-7b510f358120)

 ## Ⓒ Dynamic SVG NFT :

 This is an Interactive NFT that changes its mood based on the ETH prices 
 Also SVG files have been used instead of PNGs

 ### When ETH prices are low 📉 :
 

  <br/>
 <img src="./images/dynamicNft/happy.svg" width="225" alt="NFT Frown">
 </br>

 ### When ETH prices go up 📈 :

 

 <br/>
 <img src="./images/dynamicNft/sad.svg" width="225" alt="NFT Frown">
 </br>

# Usage

Deploy:

```
yarn hardhat deploy
```

## Testing

```
yarn hardhat test
```

### Test Coverage

```
yarn hardhat coverage
```



# Deployment to a testnet or mainnet

1. Setup environment variabltes

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some tesnet ETH & LINK. You should see the ETH and LINK show up in your metamask. [You can read more on setting up your wallet with LINK.](https://docs.chain.link/docs/deploy-your-first-contract/#install-and-fund-your-metamask-wallet)

3. Setup a Chainlink VRF Subscription ID

Head over to [vrf.chain.link](https://vrf.chain.link/) and setup a new subscription, and get a subscriptionId. You can reuse an old subscription if you already have one. 

[You can follow the instructions](https://docs.chain.link/docs/get-a-random-number/) if you get lost. You should leave this step with:

1. A subscription ID
2. Your subscription should be funded with LINK

3. Deploy

In your `helper-hardhat-config.ts` add your `subscriptionId` under the section of the chainId you're using (aka, if you're deploying to sepolia, add your `subscriptionId` in the `subscriptionId` field under the `11155111` section.)

Then run:
```
yarn hardhat deploy --network sepolia --tags main
```

We only deploy the `main` tags, since we need to add our `RandomIpfsNft` contract as a consumer. 

4. Add your contract address as a Chainlink VRF Consumer

Go back to [vrf.chain.link](https://vrf.chain.link) and under your subscription add `Add consumer` and add your contract address. You should also fund the contract with a minimum of 1 LINK. 

5. Mint NFTs

Then run:

```
yarn hardhat deploy --network sepolia --tags mint
```


### Estimate gas cost in USD

To get a USD estimation of gas cost, you'll need a `COINMARKETCAP_API_KEY` environment variable. You can get one for free from [CoinMarketCap](https://pro.coinmarketcap.com/signup). 

Then, uncomment the line `coinmarketcap: COINMARKETCAP_API_KEY,` in `hardhat.config.ts` to get the USD estimation. Just note, everytime you run your tests it will use an API call, so it might make sense to have using coinmarketcap disabled until you need it. You can disable it by just commenting the line back out. 



## Verify on etherscan

If you deploy to a testnet or mainnet, you can verify it if you get an [API Key](https://etherscan.io/myapikey) from Etherscan and set it as an environemnt variable named `ETHERSCAN_API_KEY`. You can pop it into your `.env` file as seen in the `.env.example`.

In it's current state, if you have your api key set, it will auto verify sepolia contracts!

However, you can manual verify with:

```
yarn hardhat verify --constructor-args arguments.ts DEPLOYED_CONTRACT_ADDRESS
```

# Socials 🔗 :
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/tarun-rao-b42995280)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/TarunRao00)

 

 
  
