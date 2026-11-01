#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    volatile long iterations = 0;
    for (long i = 0; i < 200000000; ++i)
        iterations += i;
    FILETIME c, e, k, u;
    GetProcessTimes(GetCurrentProcess(), &c, &e, &k, &u);
    ULARGE_INTEGER kernelTicks{}, userTicks{};
    kernelTicks.LowPart = k.dwLowDateTime;
    kernelTicks.HighPart = k.dwHighDateTime;
    userTicks.LowPart = u.dwLowDateTime;
    userTicks.HighPart = u.dwHighDateTime;
    cout << "Kernel Time (Ring 0): " << kernelTicks.QuadPart / 10000 << " ms\n"
         << "User Time (Ring 3): " << userTicks.QuadPart / 10000 << " ms\n";
}
