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
#include	<unistd.h>

int main(int argc, char *argv[])
{
	long		c, i, do_ctrl, do_rename, quiet, ctrl;
	FILE		*f, *d;
	char		buf[256], bak[256];

	if(argc == 1) {
		fprintf(stderr, "Usage: %s [-q] <filename> ...\n", argv[0]);
		exit(1);
	}

	quiet = 0;
	ctrl = 0;
	for(i = 1; i < argc; i++) {
		if(strcmp(argv[i], "-q") == 0) {
			quiet = 1;
			continue;
		}
		if(strcmp(argv[i], "-v") == 0) {
			quiet = 0;
			continue;
		}
		if(strcmp(argv[i], "-c") == 0) {
			ctrl = 1;
			continue;
		}
		if(strcmp(argv[i], "-n") == 0) {
			ctrl = 0;
			continue;
		}
		f = fopen(argv[i], "rb+");
		if(f == NULL) {
			fprintf(stderr, "ERROR: can't open file \"%s\".\n", argv[i]);
			exit(1);
		}
		snprintf(buf, sizeof(buf), "/tmp/clearc%d.tmp", getpid());
		d = fopen(buf, "wb");
		if(d == NULL) {
			fprintf(stderr, "ERROR: can't open file \"%s\".\n", buf);
			exit(1);
		}
		do_rename = 0;
		do_ctrl = 0;
		c = fgetc(f);
		while(c != EOF) {
			/* transform some controls */
			if(ctrl) {
				/* PC controls which can be transformed */
				switch(c) {
				case 0x92:
					c = '\'';
					do_ctrl = 1;
					break;

				case 0x96:
					c = '-';
					do_ctrl = 1;
					break;


				case 0x85:
					/* this is actually ... */
					c = '.';
					do_ctrl = 1;
					break;

				}
			}
			if(c != '\r') {
				fprintf(d, "%c", (int) c);
			}
			else {
				do_rename = 1;
			}
			c = fgetc(f);
		}
		fclose(f);
		fclose(d);
		if(do_rename == 1 || do_ctrl == 1) {
			sprintf(bak, "%s.bak", argv[i]);
			remove(bak);
			rename(argv[i], bak);
			sprintf(bak, "mv \"%s\" \"%s\"", buf, argv[i]);
			system(bak);
		}
		else {
			remove(buf);	/* remove the temp */
			if(quiet == 0) {
printf("File \"%s\" had no carriage return%s. It was not modified.\n", argv[i], ctrl ? " nor any control" : "");
			}
		}
	}

	exit(0);
}


