// Task 4.3: Cyclic Barrier (Phase Synchronization)
// Concept: Co-ordinating N worker threads so none can proceed to phase k+1 before all reach phase k.

#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <vector>

class Barrier {
    int threshold;
    int count;
    int generation;
    std::mutex mtx;
    std::condition_variable cv;
public:
    explicit Barrier(int n) : threshold(n), count(n), generation(0) {}

    void arrive_and_wait() {
        std::unique_lock<std::mutex> lock(mtx);
        int gen = generation;
        if (--count == 0) {
            generation++;
            count = threshold;
            cv.notify_all();
        } else {
            cv.wait(lock, [this, gen] { return gen != generation; });
        }
    }
};

Barrier sync_point(3);

void worker(int id) {
    std::cout << "Thread " << id << " completed Phase 1." << std::endl;
    sync_point.arrive_and_wait(); // Wait for all participants

    std::cout << "Thread " << id << " proceeding to Phase 2." << std::endl;
}

int main() {
    std::cout << "=== Task 4.3: Cyclic Barrier (Phase Synchronization) ===" << std::endl;
    std::thread t1(worker, 1);
    std::thread t2(worker, 2);
    std::thread t3(worker, 3);

    t1.join(); t2.join(); t3.join();
    return 0;
}
