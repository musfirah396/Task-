// Task 4.1: Condition Variables (Producer-Consumer Queue)
// Concept: Eliminates CPU busy-waiting; threads sleep on wait-queue until signaled.

#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>

std::queue<int> q;
std::mutex mtx;
std::condition_variable cv;
bool finished = false;

void producer() {
    for (int i = 1; i <= 5; ++i) {
        {
            std::unique_lock<std::mutex> lock(mtx);
            q.push(i);
            std::cout << "Producer pushed item: " << i << std::endl;
        }
        cv.notify_one();
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    {
        std::unique_lock<std::mutex> lock(mtx);
        finished = true;
    }
    cv.notify_all();
}

void consumer() {
    while (true) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [] { return !q.empty() || finished; });
        while (!q.empty()) {
            int val = q.front();
            q.pop();
            std::cout << "Consumer popped item: " << val << std::endl;
        }
        if (finished) break;
    }
}

int main() {
    std::cout << "=== Task 4.1: Condition Variables (Producer-Consumer) ===" << std::endl;
    std::thread prod(producer);
    std::thread cons(consumer);

    prod.join();
    cons.join();
    return 0;
}
