#include <iostream>
#include <cstring>
#include <windows.h>
using namespace std;
int main()
{
    HANDLE h = CreateFileMappingA(INVALID_HANDLE_VALUE, nullptr, PAGE_READWRITE, 0, 256, "Local\\MySharedMem");
    if (!h)
        return 1;
    char *sharedText = (char *)MapViewOfFile(h, FILE_MAP_ALL_ACCESS, 0, 0, 256);
    if (!sharedText)
    {
        CloseHandle(h);
        return 1;
    }
    strcpy_s(sharedText, 256, "Shared memory payload");
    cout << "Data in shared region: " << sharedText << "\n";
    UnmapViewOfFile(sharedText);
    CloseHandle(h);
}
