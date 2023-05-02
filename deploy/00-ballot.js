const {network} = require("hardhat")
const {ElectionCoommissionor, DevelopmentChain} = require("../helper-hardhat-config")
const {verify} = require("../utils/verify")

module.exports = async function({getNamedAccounts, deployments}){
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()

    const args = [ElectionCoommissionor]

    const ballot = await deploy("vote",{
        from: deployer,
        log : true,
        args: args,
        waitConfirmations: network.config.blockConfirmations || 1
    })
    log("----------------------------------------------")
    console.log(`Contract deployed at ${ballot.address}`)

    if(!DevelopmentChain.includes(network.name) || process.env.ETHERSCAN_API_KEY){
        await verify(ballot.address, args);
    }
    console.log("Contract verified successfully")
}

module.exports.tags = ["all"]

