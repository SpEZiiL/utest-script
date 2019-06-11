# How To Contribute to Unit Test Script #

Thanks for taking the time to contribute to this project!

In this short document you're going to read how to report bugs or errors,
request new features or other changes and how to contribute to the source code!

## Reports and Requests ##

If you want to submit a bug or other error report or want to suggest a new
feature or some other change, then you can do so by [creating a new issue][new_issue].

But before you do, make sure that...

* There isn't already a issue open for this specific (or similiar)
  problem/request
* The bug can be reliable recreated
* The feature you want to request is appropriate for this software

If all of those points apply to your report/request, then please open a new
issue and help improve **utest-script**!

[new_issue]: https://github.com/SpEZiiL/utest-script/issues/new/choose "Create new Issue"

## Code Contributions ##

If you don't wanna wait for someone to fix the problem you have, or to implement
the new feature, you can just do it yourself!

First, though, go through this list of important bullet points:

* Take your time to learn the code and how it works (or the part that is
  important for you)
* Write clean and readable code  
  It's better to write more code that is easier to understand, than it is to
  write less, compact code that is hard to figure out what it's supposed to do
* Know more than just the basics of the programming language
* The main and only language this project uses is English, be sure that you can
  properly communicate with other people
* Agree and follow our [Code of Conduct](CODE_OF_CONDUCT.md)

This project strictly adheres to [Semantic Versioning][semver].

After your done with editing the code, add your change to the
[CHANGELOG.md](CHANGELOG.md) file and add your name to the `AUTHOTS` variable in
the [src/consts/consts.sh](src/consts/consts.sh#L10) file (line 10).  
All names in this array will be displayed when passing the `--version` option to
the script.

[semver]: https://semver.org/spec/v2.0.0.html "Semantic Versioning v2.0.0"
