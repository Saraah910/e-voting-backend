/** @type import('hardhat/config').HardhatUserConfig */
require("dotenv").config()
require("hardhat-deploy")
require("@nomicfoundation/hardhat-chai-matchers")
require("@nomicfoundation/hardhat-toolbox")
require("@nomiclabs/hardhat-etherscan")

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL
const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL
const PRIVATE_KEY = process.env.PRIVATE_KEY
const ETHERSCAN_API_KEY = process.env.PRIVATE_KEY
const COINMARKETCAP = process.env.COINMARKETCAP

module.exports = {
  solidity: {
    compilers : [
      {
        version: "0.8.8"
      },
      {
        version: "0.8.11"
      }
    ]
  },
  networks:{
    goerli:{
      url: GOERLI_RPC_URL,
      chainId: 5,
      accounts: [PRIVATE_KEY],
      blockConfirmations: 6
    },
    sepolia:{
      url:SEPOLIA_RPC_URL,
      chainId: 11155111,
      accounts: [PRIVATE_KEY],
      blockConfirmations: 6
    },
    polygon_mumbai:{
      url:MUMBAI_RPC_URL,
      chainId:80001,
      accounts:[PRIVATE_KEY],
      blockConfirmations: 6
    }
  },
  etherscan:{
    apiKey: ETHERSCAN_API_KEY
  },
  gasReporter:{
    enabled: true,
    currency: "USD",
    outputFile: "gas-report.txt",
    noColors: true,
    coinmarketcap: COINMARKETCAP,
  },
  namedAccounts:{
    deployer:{
      default:0
    }
  }
};
