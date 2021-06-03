module chain
// This file contains the Block and Block_Chain structures
// It is pretty simple, a lot of functions that just return the structures
import crypto.md5


// Block is the basic structure.
// It contains a list of transactions, the proof used to check them, and the previous hash
[heap]
pub struct Block {
	transactions string
	proof string
	previous_hash string
}

// Hash_Block simply keeps a block and it's hash together, making it easier to look up a transaction
[heap]
pub struct Hash_Block {
	hash string
	block Block
}

// Block_Chain holds an array of Hash_Block structures which hold Block structures.
// the satisfaction pattern is used when checking for work.
[heap]
pub struct Block_Chain {
	satisfaction_pattern string
mut:
	blocks []Hash_Block
}

// create_new_blockchain takes a single argument which is the satisifaction pattern needed
// ex: if the calculated hash needs to start with aaaa then you would call create_new_blockchain("aaaa") 
// this returns a blockchain that when commited to, will enforce the pattern
// Theoretically if you are using this for secure system logging, you could
// get rid of this pattern so no proof of work is required.
pub fn create_new_blockchain(satisfaction_pattern string) &Block_Chain{
	mut bc := &Block_Chain{
		satisfaction_pattern: satisfaction_pattern
	}
	bc.init_genesis()
	return bc
}

pub fn (mut bc Block_Chain) commit_block(mut transactions Transaction_Chain, block &Block) {
	bc.blocks <<  create_hash_block(block)
	transactions.flush_transaction_chain()
}

fn create_hash_block(block &Block) &Hash_Block {
	return &Hash_Block{
		hash: md5.hexhash("$block")
		block: block
	}
}

fn (mut bc Block_Chain) init_genesis() {
	genesis_block := &Block{
		transactions: "GENESIS",
		proof: "GENESIS",
		previous_hash: "GENESIS"
	}
	hash_block := &Hash_Block{
		hash: md5.hexhash("$genesis_block")
		block: genesis_block
	}
	bc.blocks << hash_block
}

pub fn (bc Block_Chain) check_block_proof(transactions Transaction_Chain, proof string) (&Block, bool) {
	block := bc.create_new_block(transactions.to_string(), proof)
	b_hash := md5.hexhash("$block")
	if b_hash[0..4] == bc.satisfaction_pattern {
		return block, true
	}
	else {
		return block, false
	}
}

pub fn (bc Block_Chain) create_new_block(transactions string, proof string) &Block {
	return &Block{
		transactions: transactions
		proof: proof
		previous_hash: bc.blocks[bc.blocks.len - 1].hash
	}
}

pub fn (b Block) to_string() string {
	return "$b"
}