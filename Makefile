CC=gcc
CFLAGS=-I. -Ic-query
DEPS = main.h\
			c-query/attribute_lib/attribute.h\
			c-query/attribute_lib/attribute_parse.h c-query/attribute_lib/attribute_print.h\
			string_extensions/string_extensions.h\
			ical/ical.h\
			dtype_helpers/dtype_helpers.h
OBJ = obj/main.o\
			obj/lib/printAttributeTree.o obj/lib/attribute.o\
			obj/lib/createSubAttributeChain.o obj/lib/readToken.o\
			obj/lib/string_split.o obj/lib/string_filtering.o\
			obj/ical_main.o obj/ical_parsing.o\
			obj/lib/dyn_arr.o
ODIR = obj

obj/%.o: %.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/%.o: ical/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/lib/%.o: dtype_helpers/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/lib/%.o: c-query/attribute_lib/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

obj/lib/%.o: string_extensions/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)

c-ics: $(OBJ)
	$(CC) -g -o $@ $^ $(CFLAGS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o

init:
	mkdir obj
	mkdir obj/lib