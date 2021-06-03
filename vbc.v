/* 
// VBC is a blockchain written in pure V (Uses proof of work, might implement proof of stake)
// I am not an expert on blockchain, just tinkering and thought it would be cool to do in V.
// I'll probably implement mining later on. It is using MD5 which is obviously not secure
// due to collision possibilities, but swapping out the hashing algorithm will take a couple
// lines of code. Use it at your own risk.
*/
module main
import chain
import entities
fn main() {
	// Create a blockchain, pass in the satisfaction string that the proof should generate
	// if you use empty "" then a blockchain will be formed without hash verification
	mut bc := chain.create_new_blockchain("abcd")

	// Create users that act on the block chain
	to_user := entities.new_user("jane", 0)
	from_user := entities.new_user("jack", 1)

	// Create some transactions
	str_transact1 := chain.new_transaction(to_user, from_user, "string1")
	str_transact2 := chain.new_transaction(to_user, from_user, "string2")
	str_transact3 := chain.new_transaction(to_user, from_user, "string3")

	// Create a transaction chain
	mut trans_chain := chain.new_transaction_chain()

	// Add transactions to the chain
	trans_chain.transactions << str_transact1
	trans_chain.transactions << str_transact2
	trans_chain.transactions << str_transact3


	// PASS CASE
	pass_test_proof_str := "105448"

	_, p_res := bc.check_block_proof(trans_chain, pass_test_proof_str)
	// r returns true if the pattern matched
	if p_res {
		// b contains the block that you can then commit to the chain
		// println(p)
		bc.commit_block(mut trans_chain, pass_test_proof_str)
	}
	
	// FAIL CASE
	fail_test_proof_str := "904901"
	// Check block proof
	_, f_res := bc.check_block_proof(trans_chain, fail_test_proof_str)
	// r returns true if the pattern matched
	if f_res {
		// This should never happen as this fails
		// println(f)
		bc.commit_block(mut trans_chain, pass_test_proof_str)
	}
	println(bc)

	// Search for a block's hash to see if it's in the chain.
	println(bc.validate_block("95da0fc3eaf399df39e7201e4adc7ebd"))
}