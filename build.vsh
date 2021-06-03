// Clean the docs folder
rmdir_all("docs") or { println("could not remove initial docs folder") }
// Build Docs
execute_or_panic("v doc -all -inline-assets -f html -m .")
// move to the default github docs
mv("_docs", "docs") or { println("could not move docs") }
// copy to index.html so github works
cp("docs/main.html", "docs/index.html") or { println("could not rename html") }

// Test Build
t_result := execute_or_panic("v test .")
println(t_result.output)