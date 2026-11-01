// Task 2.1: The Unsynchronized Data Race
// Concept: Non-atomic read-modify-write interleaved by preemptive scheduling causes lost updates.

#include <iostream>
#include <thread>
#include <vector>

int counter = 0;

void increment_routine(int N) {
    for (int i = 0; i < N; ++i) {
        // Race condition occurs here across concurrent threads
        counter++;
    }
}

int main() {
    std::cout << "=== Task 2.1: The Unsynchronized Data Race ===" << std::endl;
    const int N = 100000;
    std::thread t1(increment_routine, N);
    std::thread t2(increment_routine, N);

    t1.join();
    t2.join();

    std::cout << "Expected Counter = " << 2 * N << std::endl;
    std::cout << "Observed Counter = " << counter << " (Lost updates due to data race!)" << std::endl;
    return 0;
}
