# These are for both `run` (implicit) and `test` (explicit)
PATH_INFO ?= /fileserver.gr
X_MATCHED_ROUTE ?= /static/...
BINDLE_SERVER_URL ?= http://localhost:8080/v1

.PHONY: run
run:
	PATH_INFO=${PATH_INFO} X_MATCHED_ROUTE=${X_MATCHED_ROUTE} \
	grain fileserver.gr

.PHONY: build
build:
	grain compile fileserver.gr

.PHONY: test-unit
test-unit:
	grain tests.gr

.PHONY: test
test:build
test: test-unit
test:
	@echo EXPECT: Loading file fileserver.gr
	wasmtime --dir . --env PATH_INFO=${PATH_INFO} \
	--env X_MATCHED_ROUTE=${X_MATCHED_ROUTE} \
	fileserver.gr.wasm > /dev/null

.PHONY: push
push:
	hippofactory -s ${BINDLE_SERVER_URL} .

doc: lib/*.gr
	grain doc lib/env.gr -o lib/env.md
	grain doc lib/mediatype.gr -o lib/mediatype.md
	grain doc lib/stringutil.gr -o lib/stringutil.md

fmt: fileserver.gr lib/*.gr
	grain format fileserver.gr --in-place
	grain format lib/env.gr --in-place
	grain format lib/mediatype.gr --in-place
	grain format lib/stringutil.gr --in-place
