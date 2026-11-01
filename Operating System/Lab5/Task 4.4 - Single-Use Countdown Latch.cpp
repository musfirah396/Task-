// Task 4.4: Single-Use Countdown Latch (std::latch)
// Concept: A one-way gate decrementing to zero, after which all waiting threads are unblocked.

#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <vector>

class CountdownLatch {
    int count;
    std::mutex mtx;
    std::condition_variable cv;
public:
    explicit CountdownLatch(int c) : count(c) {}

    void wait() {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return count <= 0; });
    }

    void count_down() {
        std::unique_lock<std::mutex> lock(mtx);
        if (--count <= 0) {
            cv.notify_all();
        }
    }
};

CountdownLatch start_flag(1);

void worker(int id) {
    std::cout << "Worker " << id << " waiting for start signal..." << std::endl;
    start_flag.wait();
    std::cout << "Worker " << id << " running benchmarks!" << std::endl;
}

int main() {
    std::cout << "=== Task 4.4: Single-Use Countdown Latch ===" << std::endl;
    std::vector<std::thread> workers;
    for (int i = 1; i <= 3; ++i) workers.emplace_back(worker, i);

    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    std::cout << "Coordinator: releasing all workers now!" << std::endl;
    start_flag.count_down(); // Unblocks all workers simultaneously

    for (auto& w : workers) w.join();
    return 0;
}
