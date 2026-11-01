#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    int sampleValue = 10;
    MEMORY_BASIC_INFORMATION memoryInfo{};
    if (VirtualQuery(&sampleValue, &memoryInfo, sizeof(memoryInfo)))
    {
        cout << "Address: " << memoryInfo.BaseAddress << "\n"
             << "Region Size: " << memoryInfo.RegionSize << " bytes\n"
             << "State: " << (memoryInfo.State == MEM_COMMIT ? "MEM_COMMIT" : "OTHER") << "\n";
    }
}
