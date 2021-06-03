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
	
	// Check to see if the hashing works <- 121420 precomputed, should pass
	b, i_res := bc.check_block_proof(trans_chain, "121420")
	assert i_res == true
	if i_res {
		block_hash := md5.hexhash("$b")
		// 121420 computed through should be this hash
		assert block_hash == "abcd5aaace3db9a295a6b18cbc89e067"
		// We pass in a mutable transaction chain, so we can flush it.
		bc.commit_block(mut trans_chain, b)
	}

	// Same as above, just checking some other characters
	str_transact1 := chain.new_transaction(to_user, from_user, "string1")
	str_transact2 := chain.new_transaction(to_user, from_user, "string2")
	str_transact3 := chain.new_transaction(to_user, from_user, "string3")

	// Push these into the chain
	trans_chain.transactions << str_transact1
	trans_chain.transactions << str_transact2
	trans_chain.transactions << str_transact3

	// Check to see if the hashing works <- 98164 precomputed, should pass
	p, p_res := bc.check_block_proof(trans_chain, "98164")
	assert p_res == true
	if p_res {
		block_hash := md5.hexhash("$p")
		// 98164 computed through should be this hash
		assert block_hash == "abcd3dad16cdc0924f200fcdfef5a536"
		// We pass in a mutable transaction chain, so we can flush it.
		bc.commit_block(mut trans_chain, p)
	}
	// println(bc.blocks)
}