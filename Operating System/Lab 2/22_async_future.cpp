#include <iostream>
#include <future>
#include <chrono>
#include <thread>
using namespace std;
int main()
{
    auto resultFuture = async(launch::async, []
                              {this_thread::sleep_for(chrono::seconds(1));return 3.14159; });
    cout << "Main thread continues work while async resultFuture computes...\n";
    cout << "Result received: " << resultFuture.get() << "\n";
}
