// Task 5.2: Task-Based Async Launch (std::async)
// Concept: Runtime abstraction where scheduler decides between spinning a thread or task pooling.

#include <iostream>
#include <future>
#include <thread>
#include <chrono>

int heavy_calc(int arg) {
    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    return arg * 10;
}

int main() {
    std::cout << "=== Task 5.2: Task-Based Async Launch ===" << std::endl;
    std::future<int> fut = std::async(std::launch::async, heavy_calc, 7);

    std::cout << "Main continuing concurrent work..." << std::endl;
    int res = fut.get();
    std::cout << "Final async result: " << res << std::endl;
    return 0;
}
