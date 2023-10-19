# c_ics

[![CI build](https://github.com/mk5med/c-ics/actions/workflows/build.yml/badge.svg)](https://github.com/mk5med/c-ics/actions/workflows/build.yml)

This project aims to provide an easy API for parsing ics files according to the [rfc5545](https://www.rfc-editor.org/rfc/rfc5545) iCalendar specification.

## CLI

```
./c-ics -q'cal(...)'
```

## API

| API                                                                             | Description                                                                                                                                  |
| ------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| int init_ical(struct ical_s *ical, FILE *instream);                             | Initialises a `ical_s` struct for use in the next API's.                                                                                     |
| int consume\_\_next_icalprop(struct ical_s \*ical, - char **key, char **value); | Given an initialised `ical_s` struct, read the `.ics` file and return the next property in a key-value pair. Line unfolding is handled here. |
| long consume\_\_next_icalevent(struct ical_s *ical, struct VEVENT_s *event);    | Given an initialised `ical_s` struct, read the `.ics` file and return the next event.                                                        |
| void free_VEVENT_s(struct VEVENT_s \*event);                                    | Cleanup method for `VEVENT_s` in order to avoid memory leaks.                                                                                |

## Dev instructions
This project uses MAKEFILES.

```
make clean # Cleans the repository if you have old build files
make init # Initialised the repository for building
make # Builds the binary
```
