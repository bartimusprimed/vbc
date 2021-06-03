module entities
// The entities module will eventually hold things not related to the chain itself
// right now only users exists, but I will probably add machine structures to track
// if a user has multiple machines.

// User is very simple right now, probably needs a hash and other stuff so the blockchain
// can keep them private.
[heap]
pub struct User {
	name string
	identity int
}

// new_user is a simple function that returns a User.
pub fn new_user(name string, identity int) &User {
	return &User{
		name: name
		identity: identity
	}
}