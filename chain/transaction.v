module chain
import entities

[heap]
pub struct Transaction {
	to &entities.User
	from &entities.User
	item string
}

[heap]
pub struct Transaction_Chain {
pub mut:
	transactions []&Transaction
}

pub fn (mut tc Transaction_Chain) flush_transaction_chain() {
	tc.transactions = []&Transaction{}
}

pub fn new_transaction(to &entities.User, from &entities.User, item string) &Transaction {
	return &Transaction{to: to, from: from, item: item}
}

pub fn new_transaction_chain() &Transaction_Chain {
	return &Transaction_Chain {}
}

pub fn (tc Transaction_Chain) to_string() string {
	return "$tc"
}