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

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<locale.h>


char		version[] = "1.01";



long		start, end, length, width, ascii, clike, shvarlike, simple, similar, verbose, value, skip;
long		oneline, wassimilar, signedvalues;
unsigned char	buf[1024], old[1024];



void output(long max, long offset)
{
	long		i;
	char		*sp;

	if(clike == 1) {
		if(verbose) {
			printf("/* %08lX- */ ", offset);
		}
		else {
			printf("   ");
		}
		if(signedvalues == 0) {
			for(i = 0; i < max; i++) {
				printf("%3d, ", buf[i] & 0x0FF);
			}
			sp = "     ";
		}
		else {
			for(i = 0; i < max; i++) {
				printf("%4d ", (signed char) buf[i] & 0x0FF);
			}
			sp = "      ";
		}
		if(verbose > 1) {
			for(; i < width; i++) {
				printf("%s", sp);
			}
			printf(" /* \"");
			for(i = 0; i < max; i++) {
				printf("%c", (buf[i] >= ' ' && buf[i] < 0x7F) || buf[i] > 0xA0 ? buf[i] : '.');
			}
			printf("\" */");
		}
		printf("\n");
	}
	else if(shvarlike == 1) {
		if(signedvalues == 0) {
			for(i = 0; i < max; i++) {
				printf("%3d ", buf[i] & 0x0FF);
			}
		}
		else {
			for(i = 0; i < max; i++) {
				printf("%4d ", (signed char) (buf[i] & 0x0FF));
			}
		}
		printf("\\\n");
	}
	else if(simple == 1) {
		if(signedvalues == 0) {
			for(i = 0; i < max; i++) {
				printf("%3d ", buf[i] & 0x0FF);
			}
		}
		else {
			for(i = 0; i < max; i++) {
				printf("%4d ", (signed char) (buf[i] & 0x0FF));
			}
		}
		printf("\n");
	}
	else {
		if(similar == 1 && oneline == 0) {		/* check similar lines? */
			if(memcmp(buf, old, max) == 0) {
				if(wassimilar == 0) {
					wassimilar = 1;
					printf("*\n");
				}
				return;
			}
		}
		wassimilar = 0;
		if(oneline == 0) {
			printf("%08lX-  ", offset);
		}
		for(i = 0; i < max; i++) {
			printf("%02X ", buf[i] & 0x0FF);
		}
		if(ascii != 0) {
			for(; i < width; i++) {
				printf("   ");
			}
			for(i = 0; i < max; i++) {
				printf("%C", (buf[i] >= ' ' && buf[i] < 0x7F) || buf[i] > 0xA0 ? buf[i] : '.');
			}
		}
		if(oneline == 0) {
			printf("\n");
		}
	}

	return;
}





int main(int argc, char *argv[])
{
	long		i, j, len, c, pos, out, cnt, insert;
	FILE		*f;

/* count the number of files */
	end = 0xFFFFFFFF;
	length = 0xFFFFFFFF;
	width = 16;
	ascii = 1;			/* true by default */
	similar = 1;			/* true by default */

	if(setlocale(LC_ALL, "") == NULL) {
		perror("cannot set locale");
	}

	out = 0;
	i = 1;
	while(i < argc) {
		if(argv[i][0] == '-') {
			len = strlen(argv[i]);
			j = 1;
			while(j < len) {
				switch(c = argv[i][j]) {
				case 'c':
					clike = 1;
					shvarlike = 0;
					simple = 0;
					break;

				case 'r':
					shvarlike = 1;
					clike = 0;
					simple = 0;
					break;

				case 'S':
					simple = 1;
					shvarlike = 0;
					clike = 0;
					break;

				case 'O':
					oneline = 1;
					similar = 0;
					ascii = 0;
					break;

				case 'o':
					similar = 0;
					if(argv[i][j + 1] == 'y' || argv[i][j + 1] == 'Y') {
						j++;
					}
					else if(argv[i][j + 1] == 'n' || argv[i][j + 1] == 'N') {
						j++;
						similar = 1;
					}
					break;

				case 'h':
					goto help;

				case 'a':
					ascii = 0;
					if(argv[i][j + 1] == 'y' || argv[i][j + 1] == 'Y') {
						j++;
						ascii = 1;
					}
					else if(argv[i][j + 1] == 'n' || argv[i][j + 1] == 'N') {
						j++;
					}
					break;

				case 'w':
				case 's':
				case 'l':
				case 'e':
				case 'E':
					j++;
					if(argv[i][j] == '\0') {
						i++;
						if(i >= argc) {
							fprintf(stderr, "ERROR: %s: invalid usage of -s option\n", argv[0]);
							exit(1);
						}
						value = strtol(argv[i], NULL, 0);
						*argv[i] = '-';
					}
					else {
						value = strtol(argv[i] + j, NULL, 0);
					}
					switch(c) {
					case 'w':
						width = value;
						break;

					case 's':
						start = value;
						break;

					case 'l':
						length = value;
						break;

					case 'e':
						end = value;
						break;

					case 'E':
						skip = value;
						break;

					}
					j = len;
					break;

				case 'n':
					signedvalues = 1;
					break;

				case 'v':
					verbose++;
					break;

				case 'V':
					printf("%s\n", version);
					exit(0);

				default:
					fprintf(stderr, "WARNING: %s: flag '%c' not supported\n", argv[0], argv[i][j]);
					break;

				}
				j++;
			}
		}
		else {
			out++;
		}
		i++;
	}

	if(width > 1024) {
		width = 1024;
	}
	else if(width < 1) {
		width = 1;
	}

	i = 1;
	while(i < argc) {
		if(argv[i][0] != '-') {
			if(clike == 1) {
				if(verbose) {
					printf("/* input file \"%s\" */\n", argv[i]);
				}
			}
			else {
				if(out > 1) {
					printf("File: %s.\n", argv[i]);
				}
			}
			f = fopen(argv[i], "rb");
			if(f == NULL) {
				fprintf(stderr, "WARNING: %s: can't open \"%s\", skip.\n", argv[0], argv[i]);
			}
			else {
				fseek(f, start, SEEK_SET);
				if(length == 0xFFFFFFFF) {
					len = end - start;
				}
				else {
					len = length;
				}
				*old = fgetc(f) ^ 0xFF;		/* ensure the old buffer if different the first time */
				fseek(f, -1, SEEK_CUR);
				pos = 0;
				cnt = 0;
				insert = 0;
				while((c = fgetc(f)) != EOF && len != 0) {
					if(insert == 0) {
						insert = skip;
						buf[cnt] = c;
						cnt++;
						if(cnt == width) {
							output(cnt, pos + start);
							memcpy(old, buf, width);
							pos += cnt;
							cnt = 0;
						}
					}
					else {
						insert--;
					}
					len--;
				}
				if(cnt != 0) {
					output(cnt, pos + start);
				}
				if(out > 1) {		/* space each file */
					printf("\n");
				}
				fclose(f);
			}
		}
		i++;
	}

	if(oneline == 1) {
		printf("\n");
	}

/* print out the help if no file are specified */
	if(out == 0) {
help:
		printf("%s V%s -- written by Alexis WILKE (c) 1997-2006\n", argv[0], version);
		printf("Usage: %s [-opts] file ...\n", argv[0]);
		printf("where -opts is one or more of the following:\n");
		printf("    -h          print out this help screen\n");
		printf("    -v          includes comments for C like output\n");
		printf("    -V          print out the version\n");
		printf("    -c          output so it can be compile with a C compiler\n");
		printf("    -r          output so it can be set into a shell variable\n");
		printf("    -n          write signed values (use -r or -c also)\n");
		printf("    -S          very simple output\n");
		printf("    -O          output a single line\n");
		printf("    -a[y|n]     suppress the ASCII output (-an or -a)\n");
		printf("    -o[y|n]     don't write the same line twice (-o or -oy)\n");
		printf("    -w <value>  number of characters per line\n");
		printf("    -s <value>  startup position to print out\n");
		printf("    -l <value>  length to print out (should not be used with -e)\n");
		printf("    -e <value>  end position to print out\n");
		printf("    -E <value>  escape <value> bytes between each bytes\n");
		exit(1);
	}

	exit(0);
}

