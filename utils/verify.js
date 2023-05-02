const {run} = require("hardhat")

async function verify(contractAddress, args){
    console.log("Verifying the contract.....")

    try{
        await run("verify:verify",{
            address: contractAddress,
            constructorArguments: args
        })
    }catch(error){
        if(error.message.toLowerCase().includes("already verified")){
            console.log("Contract is verified already.")
        }
        else{
            console.log(error)
        }
    }
    
}

module.exports = {verify}