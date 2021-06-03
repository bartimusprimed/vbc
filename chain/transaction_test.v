module chain
import entities
const(
	to_user = entities.new_user("sam", 0)
	from_user = entities.new_user("jack", 1)
	int_transact1 = new_transaction(to_user, from_user, "0")
	int_transact2 = new_transaction(to_user, from_user, "1")
	int_transact3 = new_transaction(to_user, from_user, "2")
	str_transact1 = new_transaction(to_user, from_user, "string1")
	str_transact2 = new_transaction(to_user, from_user, "string2")
	str_transact3 = new_transaction(to_user, from_user, "string3")
	bool_transact1 = new_transaction(to_user, from_user, "true")
	bool_transact2 = new_transaction(to_user, from_user, "false")
	bool_transact3 = new_transaction(to_user, from_user, "true")
)

fn test_new_transaction() {

	assert int_transact1.to == to_user
	assert int_transact1.from == from_user
	assert int_transact1.item == "0"
	assert typeof(int_transact1).name == "&chain.Transaction"
	assert str_transact1.item == "string1"
	assert typeof(str_transact2).name == "&chain.Transaction"
	assert bool_transact1.item == "true"
	assert typeof(bool_transact3).name == "&chain.Transaction"
}

fn test_new_transaction_chain() {
	mut int_trans_chain := new_transaction_chain()
	int_trans_chain.transactions << int_transact1
	int_trans_chain.transactions << int_transact2
	int_trans_chain.transactions << int_transact3
	assert int_trans_chain.transactions[1].item == "1"
	mut str_trans_chain := new_transaction_chain()
	str_trans_chain.transactions << str_transact1
	str_trans_chain.transactions << str_transact2
	str_trans_chain.transactions << str_transact3
	assert str_trans_chain.transactions[1].item == "string2"
	mut bool_trans_chain := new_transaction_chain()
	bool_trans_chain.transactions << bool_transact1
	bool_trans_chain.transactions << bool_transact2
	bool_trans_chain.transactions << bool_transact3
	assert bool_trans_chain.transactions[1].item == "false"
}