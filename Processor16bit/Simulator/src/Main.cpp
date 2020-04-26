#include <iostream>
#include <fstream>
#include <string.h>
#include "Simulator.h"

void error(std::string);

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        error("Assembler takes one argument. Missing argument <filename>");
    }
    else
    {
        Simulator(argv[1], std::stoi(argv[2])).execute();
    }
}

void error(std::string cause)
{
    std::cerr << "ERROR: " << cause;
    exit(-1);
}