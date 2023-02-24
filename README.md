# customtoken-contract
your own custom token. Your contract should implement the below public API:
● owner: a public payable address that defines the contract’s “owner”, that is the user that deploys the contract
● Transfer(address indexed from, address indexed to, uint256 value)
● Mint(address indexed to, uint256 value)
● Sell(address indexed from, uint256 value)
● totalSupply(): a view function that returns a uint256 of the total amount of minted tokens
● balanceOf(address _account): a view function returns a uint256 of the amount of tokens
an address owns
● getName(): a view function that returns a string with the token’s name
● getSymbol(): a view function that returns a string with the token’s symbol
● getPrice(): a view function that returns a uint128 with the token’s price (at which users can
redeem their tokens)
● transfer(address to, uint256 value): a function that transfers value amount of tokens
between the caller’s address and the address to; if the transfer completes successfully, the function emits an event Transfer with the sender’s and receiver’s addresses and the amount of transferred tokens and returns a boolean value (true)
● mint(address to, uint256 value): a function that enables only the owner to create value new tokens and give them to address to; if the operation completes successfully, the function emits an event Mint with the receiver’s address and the amount of minted tokens and returns a boolean value (true)
● sell(uint256 value): a function that enables a user to sell tokens for wei at a price of 600 wei per token; if the operation completes successfully, the sold tokens are removed from the circulating supply, and the function emits an event Sell with the seller’s address and the amount of sold tokens and returns a boolean value (true)
● close(): a function that enables only the owner to destroy the contract; the contract’s balance in wei, at the moment of destruction, should be transferred to the owner address
● fallback functions that enable anyone to send Ether to the contract’s account
● constructor function that initializes the contract as needed
  
You should implement the smart contract and deploy it on Ethereum’s testnet, Goerli. Your contract should be as secure and gas efficient as possible. After deploying your contract, you should buy, transfer, and sell a token in the contract.
