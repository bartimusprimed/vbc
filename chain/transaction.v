module chain 
import entities
import time
// Transaction is a very simple structure, it consists of `to` and `from` of type `&entities.User`
// the transaction contains an `item` of type `string`. I originally had this item as a generic
// but I was running into issues with heap structures being generic, when attempting to hash them
// might revisit this when generics are more seasoned.
[heap]
pub struct Transaction {
	to &entities.User
	from &entities.User
	item string
	time time.Time
}


// Transaction_Chain holds a list of transactions that are not applied to the `Block_Chain`.
// When commited the blockchain the transaction chain gets wiped.
[heap]
pub struct Transaction_Chain {
pub mut:
	transactions []&Transaction
}

// flushed_transaction_chain resets the list to empty. Should only be called after a successful commit.
pub fn (mut tc Transaction_Chain) flush_transaction_chain() {
	tc.transactions = []&Transaction{}
}

// new_transaction needs a `to` and `from` `&entities.User` as well as an item that is being tracked.
// and returns a transaction structure that can be applied to the transaction chain.
pub fn new_transaction(to &entities.User, from &entities.User, item string) &Transaction {
	return &Transaction{to: to, from: from, item: item, time: time.now()}
}

// new_transaction_chain creates a new list of transactions, I was going to join this into the blockchain
// structure, but wanted to keep the option open of having multiple transaction chains that can be queued
pub fn new_transaction_chain() &Transaction_Chain {
	return &Transaction_Chain {}
}

// to_string converts the `Transaction_Chain` to a string, used for hashing.
pub fn (tc Transaction_Chain) to_string() string {
	return "$tc"
}