// Task 5.1: Future-Promise Channels
// Concept: Inter-thread communication channel for one-time return values and exception forwarding.

#include <iostream>
#include <thread>
#include <future>

void worker(std::promise<int>&& prom) {
    std::cout << "[Worker] Computing heavy result..." << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(150));
    prom.set_value(42);
}

int main() {
    std::cout << "=== Task 5.1: Future-Promise Channels ===" << std::endl;
    std::promise<int> prom;
    std::future<int> fut = prom.get_future();

    std::thread t(worker, std::move(prom));

    std::cout << "[Master] Waiting on future..." << std::endl;
    int result = fut.get(); // Blocks until value is delivered
    std::cout << "[Master] Received result: " << result << std::endl;

    t.join();
    return 0;
}
