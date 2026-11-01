// Task 6.1: Worker Thread Pool
// Concept: Mitigating OS thread creation/destruction overhead by reusing pre-allocated threads against a FIFO queue.

#include <iostream>
#include <thread>
#include <vector>
#include <queue>
#include <functional>
#include <mutex>
#include <condition_variable>

class ThreadPool {
    std::vector<std::thread> workers;
    std::queue<std::function<void()>> tasks;
    std::mutex queue_mtx;
    std::condition_variable cv;
    bool stop = false;
public:
    explicit ThreadPool(size_t threads) {
        for (size_t i = 0; i < threads; ++i) {
            workers.emplace_back([this] {
                while (true) {
                    std::function<void()> task;
                    {
                        std::unique_lock<std::mutex> lock(queue_mtx);
                        cv.wait(lock, [this] { return stop || !tasks.empty(); });
                        if (stop && tasks.empty()) return;
                        task = std::move(tasks.front());
                        tasks.pop();
                    }
                    task();
                }
            });
        }
    }

    void enqueue(std::function<void()> task) {
        {
            std::unique_lock<std::mutex> lock(queue_mtx);
            tasks.push(task);
        }
        cv.notify_one();
    }

    ~ThreadPool() {
        {
            std::unique_lock<std::mutex> lock(queue_mtx);
            stop = true;
        }
        cv.notify_all();
        for (auto& w : workers) w.join();
    }
};

int main() {
    std::cout << "=== Task 6.1: Worker Thread Pool ===" << std::endl;
    {
        ThreadPool pool(3);
        for (int i = 1; i <= 5; ++i) {
            pool.enqueue([i] {
                std::cout << "Executing task " << i << " on thread ID: " << std::this_thread::get_id() << std::endl;
            });
        }
    }
    std::cout << "All tasks in pool completed." << std::endl;
    return 0;
}
