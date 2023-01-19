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
