#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    char *protectedPage = (char *)VirtualAlloc(nullptr, 4096, MEM_COMMIT, PAGE_READWRITE);
    if (!protectedPage)
        return 1;
    protectedPage[0] = 'A';
    DWORD previousProtection;
    if (!VirtualProtect(protectedPage, 4096, PAGE_READONLY, &previousProtection))
    {
        VirtualFree(protectedPage, 0, MEM_RELEASE);
        return 1;
    }
    __try
    {
        protectedPage[0] = 'B';
    }
    __except (EXCEPTION_EXECUTE_HANDLER)
    {
        cout << "Hardware memory protection trap caught!\n";
    }
    VirtualFree(protectedPage, 0, MEM_RELEASE);
}
