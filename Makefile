ifneq ($(KERNELRELEASE),)
obj-m := crypt.o
else

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
KCAPI_SO := /usr/lib/x86_64-linux-gnu/libkcapi.so


.PHONY: all clean test

all: crypt.ko a.out

crypt.ko: crypt.c
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

a.out: test.c
	gcc -Wall test.c $(KCAPI_SO)

test:
	sudo rmmod crypt.ko && sudo insmod crypt.ko

clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
	rm -r a.out

endif
