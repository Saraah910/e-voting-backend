const networkConfig = {
    31337:{
        name: "hardhat",
        chainId: "31337"
    },

    5:{
        name:"goerli",
        chainId: 5,

    },
    10542: {
        name: "sepolia",
        subscriptionId: "6926",
        gasLane: "0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c", // 30 gwei
        keepersUpdateInterval: "30",
        raffleEntranceFee: ethers.utils.parseEther("0.01"), // 0.01 ETH
        callbackGasLimit: "500000", // 500,000 gas
        vrfCoordinatorV2: "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625",
    },
}

const ElectionCoommissionor = "0x90F79bf6EB2c4f870365E785982E1f101E93b906"
const DevelopmentChain = ["hardhat","goerli","sepolia","polygon_mumbai"]

module.exports = {networkConfig, ElectionCoommissionor,DevelopmentChain}