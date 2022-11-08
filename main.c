#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "string_extensions/string_extensions.h"
#include "ical/ical.h"
#include <unistd.h>
#include "c-query/attribute_lib/attribute_parse.h"
#include "c-query/attribute_lib/attribute_print.h"

char *getQueryFromOption(int argc, char **argv)
{
  int option;
  while ((option = getopt(argc, argv, "q:")) != -1)
  {
    switch (option)
    {
    case 'q':
      return optarg;
      break;
    }
  }

  return "cal(event(attendees))";
}

VEVENT_s* applyQuery_event(attribute_s *query, VEVENT_s *event)
{
  if (m_strneq((char *) query->type, "event"))
  {
    printf("Error applyQuery_event: Query string should have with the 'event(' attribute.\n");
    exit(1);
  }

  if (query->sub_attribute == NULL) {
    return event;
  }
  return NULL;
}

void test_ics(int argc, char **argv) {

  char *query = getQueryFromOption(argc, argv);
  printf("Query: %s\n", query);
  attribute_s *node;
  readToken(query, &node);
  if (strncmp((char *)node->type, "cal", 3) != 0)
  {
    printf("Error i-cal: Query string should start with the 'cal(' attribute.\n");
    exit(1);
  }
  
  node = node->sub_attribute;
  // Open a file to read
  FILE *file = fopen("sample.ics", "r");

  // Initialise the ical struct
  struct ical_s ical;
  init_ical(&ical, file);

  VEVENT_s event;
  // Iterate through each event
  while (1)
  {
    long errCode = consume__next_icalevent(&ical, &event);
    applyQuery_event(node, &event);
    int i = 0;

    while (event.attendee[i])
    {
      if (i == 0)
        printf("Attendees:\n");
      printf("\tAttendee information: %s\n", event.attendee[i]);
      i++;
    }
    free_VEVENT_s(&event);
    if (errCode == EOF)
      break;
  }
}

int main(int argc, char **argv)
{
  test_ics(argc, argv);
  return 0;
}