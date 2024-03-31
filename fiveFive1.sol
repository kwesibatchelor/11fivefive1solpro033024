// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
// other necessities
import "@openzeppelin/contracts/access/Ownable.sol"; 
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";


contract MintNFT is ERC1155, Ownable, ERC1155Burnable {
    // Allows us to specify url and the quantity
    constructor(string memory url, uint256[] memory quantities) 
        ERC1155(url)
        Ownable(msg.sender)
    {
        uint256 i;
        uint256 length = quantities.length;
        for (i = 0; i < length; ) {
            _mint(msg.sender, i, quantities[i], "");
            unchecked {
                ++i;
            }
        }
    }

    // Redefined uri function
    function uri(uint256 tokenId) public view override returns (string memory) {
        return (
            string (
                abi.encodePacked(super.uri(tokenId), Strings.toString(tokenId))
            )
        );
    }

    // Allows the owner to change the url of the data or assets 
    function setURI(string memory url) public onlyOwner {
        _setURI(url);
    }
}