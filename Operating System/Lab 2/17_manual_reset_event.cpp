#include <iostream>
#include <thread>
#include <vector>
#include <windows.h>
using namespace std;
HANDLE goEvent;
void worker(int id)
{
    WaitForSingleObject(goEvent, INFINITE);
    cout << "Worker " << id << " triggered!\n";
}
int main()
{
    goEvent = CreateEventA(nullptr, TRUE, FALSE, nullptr);
    vector<thread> ts;
    for (int i = 1; i <= 3; ++i)
        ts.emplace_back(worker, i);
    cout << "Waiting 1 second before broadcasting start signal...\n";
    Sleep(1000);
    SetEvent(goEvent);
    for (auto &t : ts)
        t.join();
    CloseHandle(goEvent);
}
