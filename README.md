# vbc

A simple blockchain written in pure V. Very early in its lifecycle. I started writing it because I was learning more about blockchains.

## Specs

- Currently supports a bare blockchain without needed any proof
- Currently supports the ability to require proof to commit to the chain
- Uses MD5, not secure at all but can be switched to any of V's other builtins with a couple lines

### FAQ

- Why?
The best way of learning is to build, so building from scratch seemed worth it.
- MD5?
I know its not secure enough for any sort of public blockchain, but I am more interested in using this for logging. Will probably end up using SHA1 later.
- What about Coins?
This is just a blockchain, no coins or tokens, though it has a very simple proof check function.
Technically you could write a miner and give rewards based on block completion, but that is not my objective. 
This also has no way to distribute the chain or anything like that.
- What else?
I might eventually write a cryptocurrency that uses this chain underneath, but that takes additional time.
