module entities

fn test_new_user() {
	t_new_user := new_user("sam", 0)
	assert t_new_user.name == "sam"
	assert t_new_user.identity == 0
}