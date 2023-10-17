// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
import "hardhat/console.sol";

contract GroceryShop {
    address payable public owner;

   uint256 public totalItems;

   struct Item{
      string name;
      uint256 price;
      uint256 stock;
      bool sold;
   }

   mapping(uint=>Item) public items;

   event itemAdded(string name, uint256 price, uint256 quantity);
   event itemSold(address buyer, uint256 price, uint256 quantity, bool sold);

   modifier onlyOwner() {
     require(msg.sender == owner, "you are not owner");
     _;
   }

   constructor() {
    owner = payable(msg.sender);
    totalItems = 1;
   }

   function addItems(string memory _name, uint256 _price, uint256 _quantity) public onlyOwner {
    require(_quantity > 0, "this item is currently out of stock");
    items[totalItems] = Item(_name, _price,_quantity, false);
    totalItems++;
}

   function purchaseEvent(uint256 _itemId, uint256 _quantity) external payable {
   //   console.log(items[_itemId].name);
      Item storage item = items[_itemId];
      require(item.stock >= _quantity,"this item is currently out of stock");
      require(_quantity > 0,"please enter quantity");
      require(_itemId <= totalItems && _itemId > 0, "invalid item Id");
      
      uint256 totalPrice = _quantity * item.price;
      // payable(owner).transfer(totalPrice);

     emit itemSold(msg.sender, item.price, _quantity, true);
   }
  
  function withdraw(uint256 _amount) public onlyOwner{
   console.log(address(this).balance);
     payable(msg.sender).transfer(_amount);
  }
}


