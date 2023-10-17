const {expect} = require("chai");

describe("contract", ()=> {
    let owner;
    let buyer;

    beforeEach( async ()=> {
        [owner, buyer] = await ethers.getSigners();

        const name = "GroceryShop";
        contract = await ethers.deployContract(name, []);
         await contract.waitForDeployment();
        
         console.log(`contract deployed at ${contract.target}`);
    });

    it("should add items to the inventory", async () => {
        await contract.connect(owner).addItems("sugar",10,50);

       const item = await contract.items(1);
       if(item) {
       expect(item.name).to.equal("sugar");
       expect(item.price).to.equal(10);
       expect(item.stock).to.equal(50);
       expect(item.sold).to.equal(false);
       } else {
         console.error("Item is undefined");
       }
  });
      
  it("should alllow the owner to withdraw funds", async () => {
    await contract.addItems("Apples", 20, 100);

    await expect(
      contract.connect(buyer).purchaseEvent(1, 5, { value: 100 })
    ).to.changeEtherBalance(buyer, -100);

    await expect(contract.connect(owner).withdraw(100)).to.changeEtherBalance(
      owner,
      100
    );
  });
      
    
})