const { ethers, waffle }  = require("hardhat");
const { expect } = require("chai");
const { BigNumber, utils } = require("ethers");

describe("Attack", function(){
    it("Should be able to guess the exact same number", async function(){
        //Deploy the Game contracts.
        const Game = await ethers.getContractFactory("Game");
        const game = await Game.deploy({ value : utils.parseEther("0.1")});
        await game.deployed();

        console.log("Game contract address", game.address);

        //Deploy the Attack contract.
        const Attack = await ethers.getContractFactory("Attack");
        const attack = await Attack.deploy(game.address);
        await attack.deployed();

        console.log("Attack contracts address",attack.address);
    
         const tx = await attack.attack();
         await tx.wait();

         const balanceGame = await game.getBalance();
         console.log(balanceGame, "BalanceGame");
         expect(balanceGame).to.equal(BigNumber.from("0"));
    });

})