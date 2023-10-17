const {ethers} = require ("hardhat");

async function main() {
const name = "GroceryShop";
const contract = await ethers.deployContract(name, []);
 await contract.waitForDeployment();

 console.log(`GroceryShop deployed at ${contract.target}`);
}
 
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
