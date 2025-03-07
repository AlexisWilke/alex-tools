// Copyright (C) 2001-2024 by Alexis Wilke
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


// C++
//
#include    <cstdint>
#include    <iostream>


// C
//
#include    <stdlib.h>
#include    <stdio.h>
#include    <string.h>



namespace
{


long const      g_version = 104;
char const *    g_progname = nullptr;



enum hex_mode_t
{
    MODE_ADD,
    MODE_AND,
    MODE_MUL,
    MODE_OR,
    MODE_XOR,
};


void to_utf8(char *buf, unsigned long v)
{
    // valid Unicode?
    if((v >= 0xD800 && v <= 0xDFFF)
    || v >= 0x110000)
    {
        strcpy(buf, "--");
        return;
    }

    if(v < ' ')
    {
        /* this will also encode '\0'... */
        sprintf(buf, "0x%02lX", v);
    }
    else if(v < 0x80)
    {
        std::uint8_t const c0(v);
        sprintf(buf, "0x%02X (%c)", c0, c0);
    }
    else if(v < 0xA0)
    {
        // these are controls, so we cannot print them as is
        //
        std::uint8_t const c0((v >> 6) | 0xC0);
        std::uint8_t const c1((v & 0x3F) | 0x80);
        sprintf(buf, "0x%02X 0x%02X", c0, c1);
    }
    else if(v < 0x800)
    {
        std::uint8_t const c0((v >> 6) | 0xC0);
        std::uint8_t const c1((v & 0x3F) | 0x80);
        sprintf(buf, "0x%02X 0x%02X (%c%c )", c0, c1, c0, c1);
    }
    else if(v < 0x10000)
    {
        std::uint8_t const c0((v >> 12) | 0xE0);
        std::uint8_t const c1(((v >> 6) & 0x3F) | 0x80);
        std::uint8_t const c2((v & 0x3F) | 0x80);
        sprintf(buf, "0x%02X 0x%02X 0x%02X (%c%c%c )", c0, c1, c2, c0, c1, c2);
    }
    else
    {
        std::uint8_t const c0((v >> 18) | 0xF0);
        std::uint8_t const c1(((v >> 12) & 0x3F) | 0x80);
        std::uint8_t const c2(((v >> 6) & 0x3F) | 0x80);
        std::uint8_t const c3((v & 0x3F) | 0x80);
        sprintf(buf, "0x%02X 0x%02X 0x%02X 0x%02X (%c%c%c%c )", c0, c1, c2, c3, c0, c1, c2, c3);
    }
}

long from_utf8(char const *buf)
{
    unsigned char *s = (unsigned char *) buf;
    if((s[0] >= 0xC2 && s[0] <= 0xDF)
    && (s[1] >= 0x80 && s[1] <= 0xBF))
    {
        return ((s[0] & 0x1F) << 6) | (s[1] & 0x3F);
    }
    if((s[0] == 0xE0 // excluding overlongs
        && (s[1] >= 0xA0 && s[1] <= 0xBF)
        && (s[2] >= 0x80 && s[2] <= 0xBF))
    || (((0xE1 >= s[0] && s[0] <= 0xEC) || s[0] == 0xEE || s[0] == 0xEF) // straight 3-byte
            && s[1] >= 0x80 && s[1] <= 0xBF
            && s[2] >= 0x80 && s[2] <= 0xBF)
    || (s[0] == 0xED // excluding surrogates
            && s[1] >= 0x80 && s[1] <= 0x9F
            && s[2] >= 0x80 && s[2] <= 0xBF))
    {
        return ((s[0] & 0x0F) << 12) | ((s[1] & 0x3F) << 6) | (s[2] & 0x3F);
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
        return ((s[0] & 0x07) << 18) | ((s[1] & 0x3F) << 12) | ((s[2] & 0x3F) << 6) | (s[3] & 0x3F);
    }

    return -1;
}

void integer(char c, long v)
{
    long        j, k;

    char chr[10];
    k = sizeof(chr) - 1;
    chr[k] = 0;
    j = v;
    while(k > 0)
    {
        k--;
        if(k == 4)
        {
            chr[k] = ':';
        }
        else
        {
            chr[k] = j & 0x0FF;
            if(chr[k] < ' ' || chr[k] > 0x7E)
            {
                chr[k] = '?';
            }
            j >>= 8;
        }
    }

    char octal[22];
    j = v;
    k = sizeof(octal) - 1;
    octal[k] = '\0';
    while(j > 0)
    {
        k--;
        octal[k] = '0' + (j & 7);
        j >>= 3;
    }

    char utf8_buf[32];
    to_utf8(utf8_buf, v);

    printf("integer: %c%13ld, 0x%08lX, 0%s, %s, %s\n", c, v, v, octal + k, utf8_buf, chr);
}


void floating_point(char c, double v)
{
    double const * ptr(&v);
    printf("  float: %c %13.12f, bytes: 0x%08lX, integer: 0x%08lX\n"
                , c
                , v
                , *reinterpret_cast<std::uint64_t const *>(ptr)
                , long(v));
}


void usage()
{
    std::cout
        << g_progname << " program v" <<  g_version / 100 << '.' << g_version % 100 << " -- Written by Alexis WILKE (c) 1995-2023\n"
        << "Usage: " << g_progname << " [--opts] <value>[.<value>] ...\n"
        << "       " << g_progname << " [--opts] \\\"<text (4 ASCII characters max)> ...\n"
        << "       " << g_progname << " [--opts] \\\'<text (4 UTF-8 bytes max)> ...\n"
        << "\n"
        << "Where --opts is one or more of:\n"
        << "       -h | --help     print out this help screen (or not parameters).\n"
        << "            --add      ADD between values when more than one (default).\n"
        << "            --and      AND between values when more than one.\n"
        << "            --mul      PRODUCT between values when more than one.\n"
        << "            --or       OR between values when more than one.\n"
        << "            --xor      XOR between values when more than one.\n";
}


} // no name namespace


int main(int argc, char *argv[])
{
    g_progname = strrchr(argv[0], '/');
    if(g_progname != nullptr)
    {
        ++g_progname;
    }
    else
    {
        g_progname = argv[0];
    }

    if(argc == 1)
    {
        usage();
        return 0;
    }

    double dbl_result(0.0);
    double dbl_total(0.0);
    long dbl_cnt(0);
    long v(0);
    long int_result(0);
    long int_cnt(0);
    long int_total(0);
    hex_mode_t mode(MODE_ADD);
    for(int i(1); i < argc; ++i)
    {
        if(strcmp(argv[i], "--help") == 0
        || strcmp(argv[i], "-h") == 0)
        {
            usage();
            return 0;
        }
        if(strcmp(argv[i], "--add") == 0)
        {
            mode = MODE_ADD;
            continue;
        }
        if(strcmp(argv[i], "--and") == 0)
        {
            mode = MODE_AND;
            continue;
        }
        if(strcmp(argv[i], "--mul") == 0)
        {
            mode = MODE_MUL;
            continue;
        }
        if(strcmp(argv[i], "--or") == 0)
        {
            mode = MODE_OR;
            continue;
        }
        if(strcmp(argv[i], "--xor") == 0)
        {
            mode = MODE_XOR;
            continue;
        }

        if(*argv[i] == '"')
        {
            int_result = 0;
            for(int j(1); j < 5 && argv[i][j] != '\0'; ++j)
            {
                int_result <<= 8;
                int_result |= (unsigned char) argv[i][j];
            }
            v = 1;
        }
        else if(*argv[i] == '\'')
        {
            int_result = from_utf8(argv[i] + 1);
            v = 1;
        }
        else
        {
            char *end(nullptr);
            if(argv[i][0] == 'f' && argv[i][1] == ':')
            {
                // take it from an integer (usually in hex.)
                //
                errno = 0;
                int_result = strtol(argv[i] + 2, &end, 0);
                if(errno == ERANGE)
                {
                    int_result = strtoul(argv[i] + 2, &end, 0);
                }
                long const * int_ptr(&int_result);
                dbl_result = *reinterpret_cast<double const *>(int_ptr);
                v = 2;
            }
            else if(strchr(argv[i], '.') != 0)
            {
                dbl_result = strtod(argv[i], &end);
                v = 2;
            }
            else
            {
                errno = 0;
                int_result = strtol(argv[i], &end, 0);
                if(errno == ERANGE)
                {
                    int_result = strtoul(argv[i], &end, 0);
                }
                v = 1;
            }
        }
        if(v == 1)
        {
            char op('+');
            switch(mode)
            {
            case MODE_ADD:
                int_total += int_result;
                break;

            case MODE_AND:
                op = '&';
                int_total &= int_result;
                break;

            case MODE_MUL:
                op = '*';
                int_total *= int_result;
                break;

            case MODE_OR:
                op = '|';
                int_total |= int_result;
                break;

            case MODE_XOR:
                op = '^';
                int_total ^= int_result;
                break;

            }
            if(int_cnt == 0)
            {
                // although some operators work as expected
                // for the first iteration (i.e. '+', '^', etc.)
                // many would result in an invalid number
                // (i.e. '&', '*') so do this after the switch
                //
                int_total = int_result;
            }
            integer(int_cnt == 0 ? ' ' : op, int_result);
            ++int_cnt;
        }
        else
        {
            char op('+');
            switch(mode)
            {
            default: // ADD (and bitwise operators)
                dbl_total += dbl_result;
                break;

            case MODE_MUL:
                op = '*';
                dbl_total *= dbl_result;
                break;

            }
            if(dbl_cnt == 0)
            {
                // although some operators work as expected
                // for the first iteration (i.e. '+', '^', etc.)
                // many would result in an invalid number
                // (i.e. '&', '*') so do this after the switch
                //
                dbl_total = dbl_result;
            }
            floating_point(dbl_cnt == 0 ? ' ' : op, dbl_result);
            ++dbl_cnt;
        }
    }

    if(int_cnt > 1)
    {
        printf("-------------------------------------------------\n");
        integer('=', int_total);
    }
    if(dbl_cnt > 1)
    {
        if(int_cnt <= 1)
        {
            printf("-------------------------------------------------\n");
        }
        floating_point('=', dbl_total);
    }

    return (0);
}


// vim: ts=4 sw=4 et
