// Task 2.3: Lock-Free Atomic Instructions
// Concept: Direct hardware bus-locking / fetch-and-add primitives without OS mutex overhead.

#include <iostream>
#include <thread>
#include <atomic>
#include <vector>

std::atomic<int> atomic_counter{0};

void atomic_worker(int N) {
    for (int i = 0; i < N; ++i) {
        atomic_counter.fetch_add(1, std::memory_order_relaxed);
    }
}

int main() {
    std::cout << "=== Task 2.3: Lock-Free Atomic Instructions ===" << std::endl;
    const int N = 100000;
    std::thread t1(atomic_worker, N);
    std::thread t2(atomic_worker, N);

    t1.join();
    t2.join();

    std::cout << "Atomic Counter = " << atomic_counter.load() << " (Lock-free thread-safe!)" << std::endl;
    return 0;
}
