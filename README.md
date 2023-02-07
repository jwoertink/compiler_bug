# compiler_bug

This project shows a reproducible bug where JSON content doesn't fully return when the `--release` flag is added.

## Testing this

* `git clone` this repo
* `cd` in to the repo
* `shards`
* `crystal src/start_server.cr`
* open `http://localhost:3000/` in Chrome (it's easier to see here)
* Notice everything is ok.
* `ctrl-C` to stop the server
* `crystal build --release src/start_server.cr`
* `./start_server`
* Refresh the chrome page
* Notice the logs throw Index out of bounds, and the response is cut off

### Bisecting against Crystal

In order to test this against different commits in Crystal, you'll need
to clone the Crystal compiler, and have Docker installed.

* `mkdir sandbox && cd sandbox`
* `git clone https://github.com/crystal-lang/crystal.git lang`
* `git clone https://github.com/jwoertink/compiler_bug.git demo`
* The last good version this worked on was Crystal 1.1.1 (`6d9a1d5`)
* It stopped working in 1.2.0
* `cd lang`
* `git bisect start`
* `git bisect good 6d9a1d5`
* `git bisect bad 9f90efe`
* `cd ..`
* `sudo docker run --rm -it -v $PWD:/app -w /app crystallang/crystal:1.1.1-build bash`
* From here, you're in the Docker container with access to this repo, and Crystal.
* `cd lang`
* `make clean && make`
* `cd ../demo`
* Then `/app/lang/bin/crystal build --release src/start_server.cr` from this repo
* Back on the local machine, you should be able to `./demo/start_server` and boot this up.
