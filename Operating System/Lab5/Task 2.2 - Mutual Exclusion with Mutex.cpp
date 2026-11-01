// Task 2.2: Mutual Exclusion with Mutex
// Concept: Enforcing mutual exclusion across the critical section; only one thread holds lock.

#include <iostream>
#include <thread>
#include <mutex>
#include <vector>

std::mutex mtx;
int safe_counter = 0;

void safe_increment(int N) {
    for (int i = 0; i < N; ++i) {
        std::lock_guard<std::mutex> lock(mtx);
        safe_counter++;
    }
}

int main() {
    std::cout << "=== Task 2.2: Mutual Exclusion with Mutex ===" << std::endl;
    const int N = 100000;
    std::thread t1(safe_increment, N);
    std::thread t2(safe_increment, N);

    t1.join();
    t2.join();

    std::cout << "Safe Counter = " << safe_counter << " (Exactly matches " << 2 * N << ")" << std::endl;
    return 0;
}
