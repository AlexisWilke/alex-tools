// Copyright (C) 2001-2021 by Alexis Wilke
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#include	<stdlib.h>
#include	<stdio.h>
#include	<string.h>


char *progname;

int
usage()
{
	fprintf(stderr, "Usage: %s [-opts] <filename>\n", progname);
	fprintf(stderr, "where -opts can be:\n");
	fprintf(stderr, "  -o <value>     offset\n");
	fprintf(stderr, "  -v <value>     byte value to poke\n");
	exit(1);
}

int
main(int argc, char *argv[])
{
	unsigned char	v;
	int		i, offset, value, quiet;

	progname = strrchr(argv[0], '/');
	if(progname == NULL) {
		progname = argv[0];
	}
	else {
		++progname;
	}

	offset = -1;
	value = 0;
	quiet = 0;

	i = 1;
	while(i < argc) {

//printf("Argv [%d] = '%s'\n", i, argv[i]);

		if(strcmp(argv[i], "-o") == 0) {
			i++;
			if(i >= argc) {
				fprintf(stderr, "error: offset missing.\n");
				usage();
				return 1;
			}
			offset = strtol(argv[i], NULL, 0);
			if(offset < 0) {
				fprintf(stderr, "error: offset must be positive or null; %d is invalid.\n", offset);
				usage();
				return 1;
			}
		}
		else if(strcmp(argv[i], "-v") == 0) {
			i++;
			if(i >= argc) {
				fprintf(stderr, "error: offset missing.\n");
				usage();
				return 1;
			}
			value = strtol(argv[i], NULL, 0);
			if(value < -128 || value > 255) {
				fprintf(stderr, "error: value must fit one byte; %d is invalid.\n", value);
				usage();
				return 1;
			}
		}
		else if(strcmp(argv[i], "-q") == 0) {
			quiet = 1;
		}
		else if(strcmp(argv[i], "-h") == 0) {
			usage();
			return 1;
		}
		else if(argv[i][0] == '-') {
			fprintf(stderr, "error: unknown option '%s'\n", argv[i]);
			usage();
			return 1;
		}
		else {
			char *filename = argv[i];
			FILE *f = fopen(filename, "r+");
			if(f == NULL) {
				fprintf(stderr, "error: cannot open file \"%s\" for update.\n", filename);
			}
			else {
				fseek(f, offset, SEEK_SET);
				if(offset != ftell(f)) {
					fprintf(stderr, "error: cannot seek to offset %d in \"%s\".\n", offset, filename);
				}
				else {
					v = value;
					if(fwrite(&v, 1, 1, f) != 1) {
						fprintf(stderr, "error: could not write value %d successfully at offset %d in \"%s\".\n", value, offset, filename);
					}
					else if(quiet != 0) {
						printf("info: wrote %d (0x%02X) at offset %d (0x%08X) in \"%s\".\n",
								value, (unsigned char) value,
								offset, offset,
								filename);
					}
				}
				fclose(f);
			}
		}
		i++;
	}

	return 0;
}
