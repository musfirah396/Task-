#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    void *reservedBase = VirtualAlloc(nullptr, 1024 * 1024, MEM_RESERVE, PAGE_NOACCESS);
    if (!reservedBase)
        return 1;
    cout << "Reserved 1 MB address space at: " << reservedBase << "\n";
    int *committedPage = (int *)VirtualAlloc(reservedBase, 4096, MEM_COMMIT, PAGE_READWRITE);
    if (!committedPage)
    {
        VirtualFree(reservedBase, 0, MEM_RELEASE);
        return 1;
    }
    committedPage[0] = 42;
    cout << "Committed memory value: " << committedPage[0] << "\n";
    VirtualFree(reservedBase, 0, MEM_RELEASE);
}
