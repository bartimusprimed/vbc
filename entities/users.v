module entities

[heap]
pub struct User {
	name string
	identity int
}

pub fn new_user(name string, identity int) &User {
	return &User{
		name: name
		identity: identity
	}
}