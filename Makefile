CC=gcc
CFLAGS=-I. -Ic-query
DEPS = main.h\
			string_extensions/string_extensions.h\
			ical/ical.h\
			dtype_helpers/dtype_helpers.h\
			c-query/lib/attribute_lib/attribute.h\
			c-query/lib/attribute_lib/attribute_parse.h\
			c-query/lib/attribute_lib/attribute_print.h
			
OBJ = obj/main.o\
			obj/lib/string_split.o obj/lib/string_filtering.o\
			obj/ical_main.o obj/ical_parsing.o\
			obj/lib/dyn_arr.o\
			obj/lib/c-query.lib
ODIR = obj

TARGET=c-ics

$(TARGET): $(OBJ)
	$(CC) -g -o $@ $^ $(CFLAGS)

obj/%.o: %.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/%.o: ical/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/lib/%.o: dtype_helpers/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/lib/c-query.lib: $(DEPS)
	cd c-query && make library
	cp c-query/c-query.lib $@

obj/lib/%.o: string_extensions/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

.PHONY: clean

clean:
	rm -rf $(ODIR)
	rm -f $(TARGET)
	cd c-query && make clean
	# You can now run 'make init'

init:
	mkdir obj
	mkdir obj/lib
	cd c-query && make init
	# You can now run 'make' or 'make clean'