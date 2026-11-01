#include <iostream>
#include <thread>
#include <windows.h>
using namespace std;
void coreZeroWorker()
{
    if (SetThreadAffinityMask(GetCurrentThread(), 1))
        cout << "Thread successfully bound to Core 0.\n";
}
int main()
{
    cout << "Available hardware cores: " << thread::hardware_concurrency() << "\n";
    thread workerThread(coreZeroWorker);
    workerThread.join();
}
