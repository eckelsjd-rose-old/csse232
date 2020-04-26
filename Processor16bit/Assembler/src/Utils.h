#ifndef __UTILS__
#define __UTILS__

#include <string>

namespace Utils
{
std::string &ltrim(std::string &, const std::string &chars = "\t\n\v\f\r ");

std::string &rtrim(std::string &, const std::string &chars = "\t\n\v\f\r ");

std::string &trim(std::string &, const std::string &chars = "\t\n\v\f\r ");
} // namespace Utils

#endif