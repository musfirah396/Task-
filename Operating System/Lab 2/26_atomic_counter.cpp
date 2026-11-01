#include <iostream>
#include <thread>
#include <vector>
#include <atomic>
using namespace std;
atomic<long> sharedCounter{0};
void increment()
{
    for (int i = 0; i < 100000; ++i)
        sharedCounter.fetch_add(1, memory_order_relaxed);
}
int main()
{
    vector<thread> workers;
    for (int i = 0; i < 4; ++i)
        workers.emplace_back(increment);
    for (auto &t : workers)
        t.join();
    cout << "Final Atomic Counter: " << sharedCounter << "\n";
}
