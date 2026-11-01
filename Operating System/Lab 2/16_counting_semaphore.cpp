#include <iostream>
#include <thread>
#include <vector>
#include <windows.h>
using namespace std;
HANDLE resourceSlots;
void worker(int id)
{
    WaitForSingleObject(resourceSlots, INFINITE);
    cout << "Thread " << id << " acquired resource.\n";
    Sleep(1000);
    cout << "Thread " << id << " releasing resource.\n";
    ReleaseSemaphore(resourceSlots, 1, nullptr);
}
int main()
{
    resourceSlots = CreateSemaphoreA(nullptr, 2, 2, nullptr);
    vector<thread> ts;
    for (int i = 1; i <= 4; ++i)
        ts.emplace_back(worker, i);
    for (auto &t : ts)
        t.join();
    CloseHandle(resourceSlots);
}
