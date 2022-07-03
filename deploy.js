const { ethers, run, network } = require("hardhat")

// const solc = require("solc")
const fs = require("fs-extra")
const { Contract } = require("ethers")
// require("dotenv").config()

async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )

    console.log("Deploying Simple Storage...")
    const SimpleStorage = await SimpleStorageFactory.deploy()
    await SimpleStorage.deployed()
    console.log(`SimpleStorage deployed address:${SimpleStorage.address}`)
    console.log(network.config)
    // if(network.config.chainId===4 && process.env.PRIVATE_KEY){
    //     await SimpleStorage.deployTransaction.wait(6);
    //     await verify(SimpleStorage.address,[]);
    // }

    const currentVal = await SimpleStorage.retrieve()
    console.log("Current Value:", currentVal)
    const transactionRes = await SimpleStorage.store(4)
    await transactionRes.wait(1)
    const newVal = await SimpleStorage.retrieve()
    console.log("New Value:", newVal)
}

async function verify(contractAddress, args) {
    console.log("Verifying contract...")
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        })
    } catch (error) {
        if (error.toLowerCase().includes("already verified")) {
            console.log("Already Verified!") //so that script won't break the code
        } else {
            console.log("Error verifying contract: " + error)
        }
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
