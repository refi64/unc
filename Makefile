-include .config.mk

ifeq ($(_CONFIG),)
    ifneq ($(MAKECMDGOALS),configure)
        ifeq ($(findstring configure,$(MAKECMDGOALS)),)
            $(error You must run 'make configure' first)
        else
            $(error configure must be the only target given)
        endif
    endif

    k:=$(shell which $(K) k k2)
    ifeq ($(k),)
        $(error Cannot locate K \(try setting the \$K environment variable\))
    endif
    k:=$(firstword $(k))
endif

.PHONY : all configure test

all : unc

configure :
	@echo "K is at $(k)"
	@echo "_CONFIG=1" > .config.mk
	@echo "k=$(k)" >> .config.mk

unc : unc.rsp util/gen.k
	echo | $(k) util/gen.k > /dev/null

test :
	@echo | $(k) util/test.k

clean :
	rm unc
    rm .config.mk
