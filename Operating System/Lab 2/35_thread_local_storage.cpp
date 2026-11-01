#include <iostream>
#include <thread>
using namespace std;
thread_local int threadValue = 0;
void run(int n)
{
    threadValue += n;
    cout << "Thread ID: " << this_thread::get_id() << " | threadValue = " << threadValue << "\n";
}
int main()
{
    thread firstThread(run, 10), secondThread(run, 20), thirdThread(run, 30);
    firstThread.join();
    secondThread.join();
    thirdThread.join();
}
