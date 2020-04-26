#ifndef __SIMULATOR__
#define __SIMULATOR__

#include <map>
#include <fstream>
#include <vector>
#include <stack>
#include <string>

class Simulator
{
private:
  int regFile[64];
  unsigned long long instructions[16];
  int pc, bytesFromMem, bytesToMem, bytesInMem;
  float clockRate;
  std::stack<int> ra;
  std::stack<int> cache;
  std::string mem[1024];
  std::string sourceFile;
  void readProg();
  void execProg();
  void backup();
  void restore();
  void printMetrics();

public:
  Simulator(char *, int);
  void execute();
};

#endif