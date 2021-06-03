# Fileserver-gr

A [Wagi](https://github.com/deislabs/wagi) static fileserver written in Grain.

> DeisLabs is experimenting with many WASM technologies right now.
> This is one of a multitude of projects designed to test the limits
> of WebAssembly as a cloud-based runtime. This code is not stable or
> production ready.

## Building and Running Locally

You will need the [Grain](https://grain-lang.org) toolkit to work with this repo.

To run:

```console
$ make run 
```

To compile:

```console
$ make build
```

To run test (Wasmtime required):

```
$ make test
```

## Running in Wagi

Here is an example `modules.toml` for [Wagi](https://github.com/deislabs/wagi):

```toml
[[module]]
route = "/static/..."
module = "/path/to/fileserver/fileserver.gr.wasm"
volumes = {"/" = "/path/to/fileserver"}
```

The above configures Wagi to map the path `/static/...` to the `fileserver.gr.wasm` module. Then it serves all of the files in this project.

Assuming you have Wagi running on `http://localhost:3000`, you can then run this command:

```console
$ curl -v localhost:3000/static/fileserver.gr
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 3000 (#0)
> GET /static/fileserver.gr HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.64.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< content-type: text/plain
< content-length: 1522
< date: Thu, 03 Jun 2021 16:44:05 GMT
< 
// This is a simple Wagi static file server.

import Env from "./env"
import Map from "map"
// The rest of the source of fileserver.gr
```

The fileserver took `/static/filserver.gr`, removed the `/static/` part from the front, and then loaded `fileserver.gr` from the directory mounted in the `modules.toml`. Note that any subdirectories are also served. So `/static/foo/bar` would translate to the path `foo/bar` inside of the WebAssembly module (which in the example above would fully resolve to "/path/to/fileserver/foo/bar").
