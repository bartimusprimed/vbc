# vbc

A simple blockchain written in pure V. Very early in its lifecycle. I started writing it because I was learning more about blockchains.

Documentation [https://bartimus-primed.github.io/vbc/index.html]

## Changelog
**0.0.2**
- Added in the timestamp to the transactions.
- Changed some test cases (I was wanting to use precomputed hashes but since I added in time to the transactions, I needed to change the test cases to use proof. You can still create a blockchain without a proof parameter "" and it still works)


**0.0.1**
- Initial project


## Specs

- Currently supports a bare blockchain without needed any proof
- Currently supports the ability to require proof to commit to the chain
- Uses MD5, not secure at all but can be switched to any of V's other builtins with a couple lines

### FAQ

**Why?**
- The best way of learning is to build, so building from scratch seemed worth it.

**MD5?**
- I know its not secure enough for any sort of public blockchain, but I am more interested in using this for logging. Will probably end up using SHA1 later.

**What about Coins?**
- This is just a blockchain, no coins or tokens, though it has a very simple proof check function.
- Technically you could write a miner and give rewards based on block completion, but that is not my objective. 
- This also has no way to distribute the chain or anything like that.

**What else?**
- I might eventually write a cryptocurrency that uses this chain underneath, but that takes additional time.
