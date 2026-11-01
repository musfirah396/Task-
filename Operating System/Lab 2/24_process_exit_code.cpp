#include <iostream>
#include <windows.h>
using namespace std;
int main()
{
    STARTUPINFOA si{};
    PROCESS_INFORMATION childInfo{};
    si.cb = sizeof(si);
    char commandLine[] = "commandLine.exe /C exit 42";
    if (!CreateProcessA(nullptr, commandLine, nullptr, nullptr, FALSE, 0, nullptr, nullptr, &si, &childInfo))
        return 1;
    WaitForSingleObject(childInfo.hProcess, INFINITE);
    DWORD childExitCode = 0;
    GetExitCodeProcess(childInfo.hProcess, &childExitCode);
    cout << "Child process exited with childExitCode: " << childExitCode << "\n";
    CloseHandle(childInfo.hThread);
    CloseHandle(childInfo.hProcess);
}
