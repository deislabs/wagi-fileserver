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

You have two options for running in Wagi:

1. Use [hippofactory](https://github.com/deislabs/hippofactory) to build and push a bindle, then use `wagi -b $YOUR_BINDLE`
2. Write a `modules.toml` file and use `wagi -c modules.toml`.

### Using `hippofactory`

Edit the `HIPPOFACTS` file to taste.

To use `hippofactory`, you can just run this command from the repo root:

```console
$ hippofactory -s http://localhost:8080/v1 .
pushed: fileserver/0.1.0-technosophos-2021.06.03.17.25.54.484
```

Then run it in Wagi like this:

```console
$ wagi -b fileserver/0.1.0-technosophos-2021.06.03.17.25.54.484 --bindle-server http://localhost:8080/v1
[2021-06-03T23:26:54Z INFO  wagi] => Starting server on 127.0.0.1:3000
[2021-06-03T23:26:54Z DEBUG wagi::runtime::bindle] loaded 1 modules from the default group (parcels that do not have conditions.memberOf set)
[2021-06-03T23:26:54Z DEBUG wagi::runtime] module cache miss. Loading module parcel:fileserver/0.1.0-technosophos-2021.06.03.17.25.54.484#110f6f54401b80d9d80dae9257969468a5a70248dba8d96ce74b9bc5bc104fdd from remote.
[2021-06-03T23:26:54Z INFO  wagi::runtime] (load_routes) instantiation time for module parcel:fileserver/0.1.0-technosophos-2021.06.03.17.25.54.484#110f6f54401b80d9d80dae9257969468a5a70248dba8d96ce74b9bc5bc104fdd: 107.802106ms
```

### Using `modules.toml`

Here is an example `modules.toml` for [Wagi](https://github.com/deislabs/wagi):

```toml
[[module]]
route = "/static/..."
module = "/path/to/fileserver/fileserver.gr.wasm"
volumes = {"/" = "/path/to/fileserver"}
```

The above configures Wagi to map the path `/static/...` to the `fileserver.gr.wasm` module. Then it serves all of the files in this project.

### Testing the Static Fileserver with `curl`

This step is the same whether you use Bindle or a `modules.toml`.

Assuming you have Wagi running on `http://localhost:3000`, you can then run this command:

```console
$ curl -v localhost:3000/static/LICENSE.txt
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 3000 (#0)
> GET /static/LICENSE.txt HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< content-type: text/plain
< content-length: 1104
< date: Fri, 04 Jun 2021 00:16:14 GMT
<
The MIT License (MIT)

Copyright (c) Microsoft Corporation. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
* Connection #0 to host localhost left intact
* Closing connection 0
```

The fileserver took `/static/filserver.gr`, removed the `/static/` part from the front, and then loaded `fileserver.gr` from the directory mounted in the `modules.toml`. Note that any subdirectories are also served. So `/static/foo/bar` would translate to the path `foo/bar` inside of the WebAssembly module (which in the example above would fully resolve to "/path/to/fileserver/foo/bar").
