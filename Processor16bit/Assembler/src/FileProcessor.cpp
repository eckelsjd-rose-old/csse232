#include <string>
#include <iostream>
#include <regex>
#include <bitset>
#include <sstream>
#include "FileProcessor.h"
#include "Utils.h"

FileProcessor::FileProcessor(char *filename)
{
    sourceFile = *new std::string(filename);
}

void FileProcessor::execute()
{
    lookupSymbols();
    writeBinary();
}

void FileProcessor::lookupSymbols()
{
    std::ifstream infile(sourceFile);

    int addr = 0x00;
    std::string line, symbol;
    while (getline(infile, line))
    {
        if (!line.empty())
        {
            Utils::trim(line);
            int pos = line.find_first_of(":", 0);
            if (pos != std::string::npos)
            {
                symbol = line.substr(0, pos);
                labelMap[symbol] = addr;
                line = line.substr(pos + 1);
            }
            int i = 0;
            std::stringstream ssin(line);
            while (ssin.good() && i < 4)
            {
                ssin >> instructions[addr][i];
                i++;
            }
            std::string inst = instructions[addr][0];
            std::transform(inst.begin(), inst.end(), inst.begin(), ::tolower);
            addr++;
            if (opMap[inst] < 8)
                addr++;
        }
    }
}

void FileProcessor::writeBinary()
{
    std::ofstream out("baej.out", std::ios::binary);
    int addr = 0x00;
    u_int16_t binary, immediate;
    for (auto inst : instructions)
    {

        if (inst[0].empty())
            continue;
        int op = opMap[inst[0]];
        binary = 0x0000 | op << 12;
        immediate = 0x0000;
        if (op >= 0 && op <= 15 && op != 1 && op != 3 && op != 4)
        {
            if (!inst[1].empty())
                binary |= registerMap[inst[1].substr(1, 2)] << 6;
            if (!inst[2].empty())
                binary |= registerMap[inst[2].substr(1, 2)];
        }
        switch (opMap[inst[0]])
        {
        case 0:
        case 2:
        {
            if (inst[1].empty() || inst[2].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1] << " " << inst[2]
                          << "\nPlease Stop";
                exit(-1);
            }
            immediate = std::stoi(inst[1].substr(4, inst[2].size() - 2));
            out << std::bitset<16>(binary) << '\n'
                << std::bitset<16>(immediate) << '\n';
            break;
        }
        case 1:
        {
            if (inst[1].empty() || inst[2].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1] << " " << inst[2]
                          << "\nPlease Stop";
                exit(-1);
            }
            binary = 0x0000 | op << 12 | registerMap[inst[1].substr(1, 2)];
            immediate = std::stoi(inst[2]);
            out << std::bitset<16>(binary) << '\n'
                << std::bitset<16>(immediate) << '\n';
            break;
        }
        case 3:
        case 4:
        {
            if (inst[1].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1]
                          << "\nPlease Stop";
                exit(-1);
            }
            immediate = labelMap.find(inst[1]) == labelMap.end() ? std::stoi(inst[1]) : labelMap[inst[1]];
            out << std::bitset<16>(binary) << '\n'
                << std::bitset<16>(immediate) << '\n';
            break;
        }
        case 5:
        case 6:
        case 7:
        {
            if (inst[1].empty() || inst[2].empty() || inst[3].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1] << " " << inst[2]
                          << "\nPlease Stop";
                exit(-1);
            }
            immediate = labelMap.find(inst[3]) == labelMap.end() ? std::stoi(inst[3]) : labelMap[inst[3]];
            out << std::bitset<16>(binary) << '\n'
                << std::bitset<16>(immediate) << '\n';
            break;
        }
        case 8:
        case 10:
        {
            if (inst[1].empty() || inst[2].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1] << " " << inst[2]
                          << "\nPlease Stop";
                exit(-1);
            }
            out << std::bitset<16>(binary) << '\n';
            break;
        }
        case 12:
        case 13:
        case 14:
        case 15:
        {
            if (inst[1].empty())
            {
                std::cerr << "ASSEMBLER ERROR: Missing operand for "
                          << inst[0] << " " << inst[1] << " " << inst[2]
                          << "\nPlease Stop";
                exit(-1);
            }
            if (inst[2].empty())
                binary |= 51;

            out << std::bitset<16>(binary) << '\n';
            break;
        }
        default:
            out << std::bitset<16>(binary) << '\n';
            break;
        }
    }
}

std::map<std::string, int> FileProcessor::opMap =
    {{"lda", 0},
     {"ldi", 1},
     {"str", 2},
     {"bop", 3},
     {"cal", 4},
     {"beq", 5},
     {"bne", 6},
     {"sft", 7},
     {"cop", 8},
     {"slt", 10},
     {"ret", 11},
     {"add", 12},
     {"sub", 13},
     {"and", 14},
     {"orr", 15}};

std::map<std::string, int> FileProcessor::registerMap =
    {{"f0", 0},
     {"f1", 1},
     {"f2", 2},
     {"f3", 3},
     {"f4", 4},
     {"f5", 5},
     {"f6", 6},
     {"f7", 7},
     {"f8", 8},
     {"f9", 9},
     {"f10", 10},
     {"f11", 11},
     {"f12", 12},
     {"f13", 13},
     {"f14", 14},
     {"ip", 15},
     {"op", 16},
     {"t0", 17},
     {"t1", 18},
     {"t2", 19},
     {"t3", 20},
     {"t4", 21},
     {"t5", 22},
     {"t6", 23},
     {"t7", 24},
     {"t8", 25},
     {"t9", 26},
     {"t10", 27},
     {"t11", 28},
     {"t12", 29},
     {"t13", 30},
     {"t14", 31},
     {"t15", 32},
     {"t16", 33},
     {"t17", 34},
     {"t18", 35},
     {"t19", 36},
     {"t20", 37},
     {"t21", 38},
     {"t22", 39},
     {"t23", 40},
     {"t24", 41},
     {"t25", 42},
     {"t26", 43},
     {"t27", 44},
     {"a0", 45},
     {"a1", 46},
     {"a2", 47},
     {"a3", 48},
     {"a4", 49},
     {"a5", 50},
     {"m0", 51},
     {"m1", 52},
     {"m2", 53},
     {"m3", 54},
     {"m4", 55},
     {"m5", 56},
     {"cr", 57},
     {"v0", 58},
     {"v1", 59},
     {"v2", 60},
     {"v3", 61},
     {"sp", 62},
     {"z0", 63}};