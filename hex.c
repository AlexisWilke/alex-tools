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

long	version = 103;

void to_utf8(char *buf, unsigned long v)
{
	// valid Unicode?
	if(v < 0
	|| (v >= 0xD800 && v <= 0xDFFF)
	|| v >= 0x110000)
	{
		strcpy(buf, "--");
		return;
	}

	if(v < 0x80)
	{
		/* this will also encode '\0'... */
		sprintf(buf, "0x%02lX", v);
	}
	else if(v < 0x800)
	{
		sprintf(buf, "0x%02lX 0x%02lX", (v >> 6) | 0xC0, (v & 0x3F) | 0x80);
	}
	else if(v < 0x10000)
	{
		sprintf(buf, "0x%02lX 0x%02lX 0x%02lX", (v >> 12) | 0xE0, ((v >> 6) & 0x3F) | 0x80, (v & 0x3F) | 0x80);
	}
	else
	{
		sprintf(buf, "0x%02lX 0x%02lX 0x%02lX 0x%02lX", (v >> 18) | 0xF0, ((v >> 12) & 0x3F) | 0x80, ((v >> 6) & 0x3F) | 0x80, (v & 0x3F) | 0x80);
	}
}

long from_utf8(char const *buf)
{
	unsigned char *s = (unsigned char *) buf;
	if((s[0] >= 0xC2 && s[0] <= 0xDF)
	&& (s[1] >= 0x80 && s[1] <= 0xBF))
	{
		return ((s[0] & 0x3F) << 6) | (s[1] & 0x3F);
	}
	if((s[0] == 0xE0 // excluding overlongs
		&& (s[1] >= 0xA0 && s[1] <= 0xBF)
		&& (s[2] >= 0x80 && s[2] <= 0xBF))
	|| (((0xE1 <= s[0] && s[0] <= 0xEC) || s[0] == 0xEE || s[0] == 0xEF) // straight 3-byte
        	&& s[1] >= 0x80 && s[1] <= 0xBF
        	&& s[2] >= 0x80 && s[2] <= 0xBF)
	|| (s[0] == 0xED // excluding surrogates
        	&& s[1] >= 0x80 && s[1] <= 0x9F
        	&& s[2] >= 0x80 && s[2] <= 0xBF))
	{
		return ((s[0] & 0x3F) << 12) | ((s[1] & 0x3F) << 6) | (s[2] & 0x3F);
	}
	if((s[0] == 0xF0 // planes 1-3
		&& s[1] >= 0x90 && s[1] <= 0xBF
		&& s[2] >= 0x80 && s[2] <= 0xBF
		&& s[3] >= 0x80 && s[3] <= 0xBF)
	|| (s[0] >= 0xF1 && s[0] <= 0xF3 // planes 4-15
		&& s[1] >= 0x80 && s[1] <= 0xBF
		&& s[2] >= 0x80 && s[2] <= 0xBF
		&& s[3] >= 0x80 && s[3] <= 0xBF)
	|| (s[0] == 0xF4 // plane 16
             && s[1] >= 0x80 && s[1] <= 0x8F
             && s[2] >= 0x80 && s[2] <= 0xBF
             && s[3] >= 0x80 && s[3] <= 0xBF))
	{
		return ((s[0] & 0x3F) << 18) | ((s[1] & 0x3F) << 12) | ((s[2] & 0x3F) << 6) | (s[3] & 0x3F);
	}

	return -1;
}

void integer(char c, long v)
{
	long		j, k;
	char		buf[13], chr[5], utf8_buf[32];

	k = 4;
	chr[k] = 0;
	j = v;
	while(k > 0) {
		k--;
		if((j & 0x0FF) >= ' ' && (j & 0x0FF) <= 0x7E /*|| (j & 0x0FF) > 0x0A0*/) {
			chr[k] = j & 0x0FF;
		}
		else {
			chr[k] = '?';
		}
		j >>= 8;
	}
	j = v;
	k = 12;
	buf[k] = '\0';
	while(j > 0) {
		k--;
		buf[k] = '0' + (j & 7);
		j >>= 3;
	}
	to_utf8(utf8_buf, v);
	printf("integer: %c%13ld, 0x%08lX, 0%s, %s, %s\n", c, v, v, buf + k, utf8_buf, chr);

	return;
}


int main(int argc, char *argv[])
{
	long		i, j, v, int_result, total, cnt;
	char		tp, *s;
	double		dbl_result;

	if(argc == 1)
	{
		printf("%s program V%.02f -- Written by Alexis WILKE (c) 1995\n", argv[0], (double) version / 100);
		printf("Usage: %s <value>[.<value>] | \\\"<text (4 characters max)>\n", argv[0]);
		return (0);
	}

	cnt = 0;
	total = 0;
	i = 1;
	while(i < argc)
	{
		if(*argv[i] == '"')
		{
			j = 1;
			int_result = 0;
			while(j < 5 && argv[i][j] != '\0')
			{
				int_result <<= 8;
				int_result |= (unsigned char) argv[i][j];
				j++;
			}
			v = 1;
		}
		else if(*argv[i] == '\'')
		{
			int_result = from_utf8(argv[i] + 1);
			v = 1;
		}
		else {
			if(strchr(argv[i], '.') != 0)
			{
				dbl_result = strtod(argv[i], &s);
				v = 2;
			}
			else
			{
				int_result = strtol(argv[i], &s, 0);
				v = 1;
			}
		}
		if(v == 1)
		{
			integer(i == 1 ? ' ' : '+', int_result);
			total += int_result;
			cnt++;
		}
		else
		{
			printf("  float: %13.12f\n", dbl_result);
		}
		i++;
	}

	if(cnt > 1)
	{
		printf("-------------------------------------------------\n");
		integer('=', total);
	}

	return (0);
}
