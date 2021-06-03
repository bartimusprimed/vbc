module chain
// This file contains the Block and Block_Chain structures
// It is pretty simple, a lot of functions that just return the structures
import crypto.md5


// Block is the basic structure.
// It contains a list of transactions, the proof used to check them, and the previous hash
[heap]
pub struct Block {
	transactions string
	previous_hash string
}

// Hash_Block simply keeps a block and it's hash together, making it easier to look up a transaction
[heap]
pub struct Hash_Block {
	hash string
	proof string
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

// commit_block takes in the mutable transaction chain and the proof.
// It will check the proof and chain hash results in the satisfaction pattern.
// Call the function with an empty string if no satisfaction pattern is required.
pub fn (mut bc Block_Chain) commit_block(mut transactions Transaction_Chain, proof string) {
	b, res := bc.check_block_proof(transactions, proof)
	if res {
		bc.blocks <<  create_hash_block(b, proof)
		transactions.flush_transaction_chain()
	} else {
		// This panics, but if you would like it to fail gracefully, just change it to a println or comment out
		panic("\n=============\nFailed to commit block to chain: The proof given did not result in: $bc.satisfaction_pattern\n================\n")
	}
}

fn create_hash_block(block &Block, proof string) &Hash_Block {
	return &Hash_Block{
		hash: md5.hexhash("$block")
		proof: proof
		block: block
	}
}

fn (mut bc Block_Chain) init_genesis() {
	genesis_block := &Block{
		transactions: "GENESIS",
		previous_hash: "GENESIS"
	}
	hash_block := &Hash_Block{
		hash: md5.hexhash("$genesis_block")
		proof: "GENESIS"
		block: genesis_block
	}
	bc.blocks << hash_block
}

pub fn (bc Block_Chain) check_block_proof(transactions Transaction_Chain, proof string) (&Block, bool) {
	block := bc.create_new_block(transactions.to_string())
	total_to_hash := "$block" + "$proof"
	b_hash := md5.hexhash(total_to_hash)
	if bc.satisfaction_pattern != "" {
		if b_hash[0..4] != bc.satisfaction_pattern {
			return block, false
		}
	}
	return block, true
}

pub fn (bc Block_Chain) validate_block(block_hash string) string {
	for hash_block in bc.blocks {
		if hash_block.hash == block_hash {
			return "Found block with hash: $hash_block.hash, proof assigned: $hash_block.proof"
		}
	}
	return "Block hash not found"
}

pub fn (bc Block_Chain) create_new_block(transactions string) &Block {
	return &Block{
		transactions: transactions
		previous_hash: bc.blocks[bc.blocks.len - 1].hash
	}
}

pub fn (b Block) to_string() string {
	return "$b"
}