#include <string>
#include <iostream>
#include <iomanip>
#include <regex>
#include <bitset>
#include <sstream>
#include "Simulator.h"

Simulator::Simulator(char *filename, int input)
{
    sourceFile = *new std::string(filename);
    regFile[15] = input;
    pc = 0;
    clockRate = 87.596f;
}

void Simulator::execute()
{
    readProg();
    execProg();
    printMetrics();
}

void Simulator::readProg()
{
    std::ifstream source(sourceFile);
    std::string line;
    int i = 0;
    while (getline(source, line))
    {
        mem[i] = line;
        i++;
    }
    bytesInMem = i * 2;
}

void Simulator::execProg()
{
    int op, rs, rd, im;
    while (!mem[pc].empty())
    {
        op = std::stoi(mem[pc].substr(0, 4), nullptr, 2);
        rs = std::stoi(mem[pc].substr(4, 6), nullptr, 2);
        rd = std::stoi(mem[pc].substr(10, 6), nullptr, 2);
        im = mem[pc + 1].empty() ? 0 : std::stoi(mem[pc + 1], nullptr, 2);
        regFile[63] = 0;

        switch (op)
        {
        case 0:
        {
            regFile[rd] = std::stoi(mem[rs + im], nullptr, 2);
            pc += 2;
            bytesFromMem += 2;
            break;
        }
        case 1:
        {
            regFile[rd] = im;
            pc += 2;
            break;
        }
        case 2:
        {
            mem[rs + im] = std::bitset<16>(regFile[rd]).to_string();
            pc += 2;
            bytesToMem += 2;
            break;
        }
        case 3:
        {
            if (im == pc)
                return;
            pc = im;
            break;
        }
        case 4:
        {
            ra.push(pc + 2);
            backup();
            pc = im;
            break;
        }
        case 5:
        {
            if (regFile[rs] == regFile[rd])
                pc = im;
            else
                pc += 2;
            break;
        }
        case 6:
        {
            if (regFile[rs] != regFile[rd])
                pc = im;
            else
                pc += 2;
            break;
        }
        case 7:
        {
            if (im > 0)
                regFile[rd] = regFile[rs] << im;
            else
            {
                unsigned int l = -1;
                im ^= l;
                im += 1;
                regFile[rd] = regFile[rs] >> im;
            }
            pc += 2;
            break;
        }
        case 8:
        {
            regFile[rd] = regFile[rs];
            pc += 1;
            break;
        }
        case 10:
        {
            regFile[57] = regFile[rs] < regFile[rd] ? 1 : 0;
            pc += 1;
            break;
        }
        case 11:
        {
            pc = ra.top();
            ra.pop();
            restore();
            break;
        }
        case 12:
        {
            regFile[rd] += regFile[rs];
            pc += 1;
            break;
        }
        case 13:
        {
            regFile[rd] -= regFile[rs];
            pc += 1;
            break;
        }
        case 14:
        {
            regFile[rd] &= regFile[rs];
            pc += 1;
            break;
        }
        case 15:
        {
            regFile[rd] |= regFile[rs];
            pc += 1;
            break;
        }
        default:
            break;
        }
        bytesFromMem += 4;
        instructions[op]++;
    }
}

void Simulator::backup()
{
    for (int i = 0; i < 15; i++)
        cache.push(regFile[i]);
}

void Simulator::restore()
{
    for (int i = 14; i >= 0; i--)
    {
        regFile[i] = cache.top();
        cache.pop();
    }
}

void Simulator::printMetrics()
{
    int itypes = 0, gtypes = 0;
    int cycles = 0, instCount = 0;
    for (int i = 0; i < 16; i++)
    {
        instCount += instructions[i];
        if (i < 8)
            itypes += instructions[i];
        else
            gtypes += instructions[i];

        switch (i)
        {
        case 3:
        case 4:
        case 11:
        {
            cycles += 2 * instructions[i];
            break;
        }
        case 1:
        case 5:
        case 6:
        case 8:
        {
            cycles += 3 * instructions[i];
            break;
        }
        case 2:
        case 7:
        case 10:
        case 12:
        case 13:
        case 14:
        case 15:
        {
            cycles += 4 * instructions[i];
            break;
        }
        case 0:
        {
            cycles += 5 * instructions[i];
            break;
        }
        default:
        {
            break;
        }
        }
    }
    float cyclePerInst = cycles / (float)instCount;
    float execTime = cycles / (clockRate * 1000);

    std::cout << std::fixed;
    std::cout << std::setprecision(2);
    std::cout << "=====================================================\n"
              << "                       METRICS                       \n"
              << "=====================================================\n"
              << "                                                     \n"
              << "Latency:                                             \n"
              << "    Transferred from memory (bytes):  " << bytesFromMem << "\n"
              << "    Transferred to memory   (bytes):  " << bytesToMem << "\n"
              << "    Program size in memory (bytes):  " << bytesInMem << "\n"
              << "                                                     \n"
              << "Performance:                                         \n"
              << "    Total instructions executed   :  " << instCount << "\n"
              << "    Total cycles executed         :  " << cycles << "\n"
              << "    Average cycles per instruction:  " << cyclePerInst << "\n"
              << "    Simulation clock rate    (MHz):  " << clockRate << "\n"
              << "    Execution time            (ms):  " << execTime << "\n"
              << "                                                     \n"
              << "Output:    " << regFile[16] << "\n\n";
}