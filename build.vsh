// Build Docs
result := exec("v doc -all -f html -m .") ?
if result.exit_code != 0 {
	println(result.output)
}