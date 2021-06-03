// Vars for docs
// Build Docs
// execute_or_panic("v doc -all -inline-assets -f html -o docs -m .")

// execute_or_panic("move ./docs/_docs/* ./docs/")
// Test Build
t_result := execute_or_panic("v test .")
println(t_result.output)