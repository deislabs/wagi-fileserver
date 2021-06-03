# These are for both `run` (implicit) and `test` (explicit)
PATH_INFO ?= /static/fileserver.gr
X_MATCHED_ROUTE ?= /static/...

.PHONY: run
run:
	PATH_INFO=${PATH_INFO} X_MATCHED_ROUTE=${X_MATCHED_ROUTE} \
	grain fileserver.gr

.PHONY: build
build:
	grain compile fileserver.gr

.PHONY: test
test:build
test:
	wasmtime --dir . --env PATH_INFO=${PATH_INFO} \
	--env X_MATCHED_ROUTE=${X_MATCHED_ROUTE} \
	fileserver.gr.wasm