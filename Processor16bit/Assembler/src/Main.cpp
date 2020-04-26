#include <iostream>
#include <fstream>
#include <string.h>
#include "FileProcessor.h"
#include "Utils.h"

void error(std::string);

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        error("Assembler takes one argument. Missing argument <filename>");
    }
    else if (strstr(argv[1], ".baej") == NULL)
    {
        error("Assembler takes .baej file as only argument. Missing argument <filename>");
    }
    else
    {
        FileProcessor(argv[1]).execute();
    }
}

void error(std::string cause)
{
    std::cerr << "ERROR: " << cause;
    exit(-1);
}

std::string &Utils::ltrim(std::string &str, const std::string &chars)
{
    str.erase(0, str.find_first_not_of(chars));
    return str;
}

std::string &Utils::rtrim(std::string &str, const std::string &chars)
{
    str.erase(str.find_last_not_of(chars) + 1);
    return str;
}

std::string &Utils::trim(std::string &str, const std::string &chars)
{
    return ltrim(rtrim(str, chars), chars);
}
