CC = gcc

INCDIR = inc
LIBDIR = lib
LORADIR = libloragw/inc

default: libparson.a libloragw.a libinterface_lora.a
	rm interface_lora.o
	#python setup.py build_ext --inplace && rm -f lorthon.c && rm -Rf build
	python3 setup.py build_ext --inplace && rm -f lorthon.c && rm -Rf build
	mkdir -p output
	mv lorthon.cpython*.so tst/lorthon.so
	cp tst/lorthon.so output/lorthon.so
	#sh postBuild.sh

libloragw.a:
	$(MAKE) -C libloragw

libparson.a:
	$(MAKE) -C parson

libinterface_lora.a: interface_lora.o
	ar rcs $@ $^
	mv libinterface_lora.a $(LIBDIR)/libinterface_lora.a

interface_lora.o: src/interface_lora.c inc/interface_lora.h
	$(CC) -c $< -I$(INCDIR) -I$(LORADIR) -L. $(LIBDIR)/libparson.a $(LIBDIR)/libloragw.a

clean:
	rm -f $(LIBDIR)/libinterface_lora.a
	rm -f $(LIBDIR)/libparson.a
	rm -f $(LIBDIR)/libloragw.a
	rm -f output/lorthon.so
	rm -f tst/lorthon.so
	rm -f interface_lora.o
	rm -f lorthon.so
	rm -f parson/testcpp
	cd libloragw && $(MAKE) clean
	cd parson && $(MAKE) clean
