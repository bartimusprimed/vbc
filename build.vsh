// Build Docs
execute_or_panic("v doc -all -f html -o ./docs -m .")
// Test Build
t_result := execute_or_panic("v test .")
println(t_result.output)