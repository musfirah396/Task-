#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>
using namespace std;
mutex mutexOne, mutexTwo;
void A()
{
    mutexOne.lock();
    cout << "Thread A locked Mutex 1, waiting for Mutex 2...\n";
    this_thread::sleep_for(chrono::milliseconds(50));
    mutexTwo.lock();
    mutexTwo.unlock();
    mutexOne.unlock();
}
void B()
{
    mutexTwo.lock();
    cout << "Thread B locked Mutex 2, waiting for Mutex 1...\n";
    this_thread::sleep_for(chrono::milliseconds(50));
    mutexOne.lock();
    mutexOne.unlock();
    mutexTwo.unlock();
}
int main()
{
    thread threadOne(A), threadTwo(B);
    threadOne.join();
    threadTwo.join();
}
