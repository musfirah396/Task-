// Task 4.2: Counting Semaphores (Resource Throttling)
// Concept: Maintaining a shared permit counter allowing up to N concurrent execution paths.

#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <vector>

// Semaphore implementation for broad C++17/20 compatibility
class CountingSemaphore {
    int permits;
    std::mutex m;
    std::condition_variable cv;
public:
    explicit CountingSemaphore(int count) : permits(count) {}

    void acquire() {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this] { return permits > 0; });
        --permits;
    }

    void release() {
        std::unique_lock<std::mutex> lock(m);
        ++permits;
        cv.notify_one();
    }
};

CountingSemaphore sem(3); // 3 permits max

void worker(int id) {
    sem.acquire();
    std::cout << "Thread " << id << " acquired permit. Working..." << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    std::cout << "Thread " << id << " releasing permit." << std::endl;
    sem.release();
}

int main() {
    std::cout << "=== Task 4.2: Counting Semaphores (3 Permits Max) ===" << std::endl;
    std::vector<std::thread> threads;
    for (int i = 1; i <= 6; ++i) {
        threads.emplace_back(worker, i);
    }
    for (auto& t : threads) t.join();
    return 0;
}
