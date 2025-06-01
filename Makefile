OPENRESTY_PREFIX=/usr/local/openresty

LUA_LIB_DIR ?=     $(OPENRESTY_PREFIX)/lualib
INSTALL ?= install

.PHONY: all test install

all: ;

install: all
	$(INSTALL) -d $(LUA_LIB_DIR)/resty/nsq
	$(INSTALL) lib/resty/nsq/*.lua $(LUA_LIB_DIR)/resty/nsq/

test: all
	PATH=$(OPENRESTY_PREFIX)/nginx/sbin:$$PATH prove -I../test-nginx/lib -r t

