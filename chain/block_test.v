module chain
import entities
import crypto.md5

fn test_new_block() {
	// Create Blockchain
	mut bc := create_new_blockchain("abcd")
	mut correct_hash_1 := ""
	mut correct_hash_2 := ""
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
	mut created_hash := false

	// Check to see if the hashing works
	for precomputed_hash_proof_1 in 0..1000000 {
		b, i_res := bc.check_block_proof(trans_chain, "$precomputed_hash_proof_1")
		created_hash = i_res
		if i_res {
			correct_hash_1 = md5.hexhash("$b")
			// We pass in a mutable transaction chain, so we can flush it.
			bc.commit_block(mut trans_chain, "$precomputed_hash_proof_1")
			break
		}
	}

	// Same as above, just checking some other characters
	str_transact1 := chain.new_transaction(to_user, from_user, "string1")
	str_transact2 := chain.new_transaction(to_user, from_user, "string2")
	str_transact3 := chain.new_transaction(to_user, from_user, "string3")

	// Push these into the chain
	trans_chain.transactions << str_transact1
	trans_chain.transactions << str_transact2
	trans_chain.transactions << str_transact3

	// reset the flag so assert works
	created_hash = false

	for precomputed_hash_proof_2 in 0..1000000 {
		// Check to see if the hashing works, should pass
		p, p_res := bc.check_block_proof(trans_chain, "$precomputed_hash_proof_2")
		created_hash = p_res
		if p_res {
			correct_hash_2 = md5.hexhash("$p")
			// We pass in a mutable transaction chain, so we can flush it.
			bc.commit_block(mut trans_chain, "$precomputed_hash_proof_2")
			break
		}
	}

	// Ensure you can validate a hash
	assert bc.validate_block(correct_hash_1) != "Block hash not found"
	assert bc.validate_block(correct_hash_2) != "Block hash not found"
}