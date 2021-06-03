module chain
import entities
import crypto.md5

fn test_new_block() {
	// Create Blockchain
	mut bc := create_new_blockchain("abcd")

	// Create users
	to_user := entities.new_user("sam", 0)
	from_user := entities.new_user("jack", 1)

	// Create transaction chain
	mut trans_chain := chain.new_transaction_chain()
	
	// Create transactions
	int_transact1 := chain.new_transaction(to_user, from_user, "0")
	int_transact2 := chain.new_transaction(to_user, from_user, "1")
	int_transact3 := chain.new_transaction(to_user, from_user, "2")


	// Append transactions to the chain
	trans_chain.transactions << int_transact1
	trans_chain.transactions << int_transact2
	trans_chain.transactions << int_transact3
	
	precomputed_hash_proof_1 := "19260"
	precomputed_hash_1 := "f068653a95624bd22c8243bf43e161b2"

	// Check to see if the hashing works <- 121420 precomputed, should pass

	b, i_res := bc.check_block_proof(trans_chain, precomputed_hash_proof_1)
	assert i_res == true
	if i_res {
		block_hash := md5.hexhash("$b")
		// 121420 computed through should be this hash
		assert block_hash == precomputed_hash_1
		// We pass in a mutable transaction chain, so we can flush it.
		bc.commit_block(mut trans_chain, precomputed_hash_proof_1)
	}

	// Same as above, just checking some other characters
	str_transact1 := chain.new_transaction(to_user, from_user, "string1")
	str_transact2 := chain.new_transaction(to_user, from_user, "string2")
	str_transact3 := chain.new_transaction(to_user, from_user, "string3")

	// Push these into the chain
	trans_chain.transactions << str_transact1
	trans_chain.transactions << str_transact2
	trans_chain.transactions << str_transact3

	precomputed_hash_proof_2 := "35757"
	precomputed_hash_2 := "28bda904d18aef9c20a723743cdffbed"

	// Check to see if the hashing works <- 98164 precomputed, should pass
	p, p_res := bc.check_block_proof(trans_chain, precomputed_hash_proof_2)
	assert p_res == true
	if p_res {
		block_hash := md5.hexhash("$p")
		// 98164 computed through should be this hash
		assert block_hash == precomputed_hash_2
		// We pass in a mutable transaction chain, so we can flush it.
		bc.commit_block(mut trans_chain, precomputed_hash_proof_2)
	}

	// Ensure you can validate a hash
	assert bc.validate_block(precomputed_hash_1) != "Block hash not found"
	assert bc.validate_block(precomputed_hash_2) != "Block hash not found"
}