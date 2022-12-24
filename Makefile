LIBGEN_BIN=bin/libgen
LIB_CONF=lib.yml

generate_lib: $(LIBGEN_BIN) $(LIB_CONF)
	rm -rf src/lib_secp256k1
	$(LIBGEN_BIN) $(LIB_CONF)