// Task 1.2: Thread Argument Passing (Memory Model: Value vs. Reference)
// Concept: Parameter semantics determine whether arguments land in private stack copies or refer to caller's frame.

#include <iostream>
#include <thread>
#include <functional>

void worker(int val, int& ref) {
    val += 10;
    ref += 10;
    std::cout << "[Inside Thread] val = " << val << ", ref = " << ref << std::endl;
}

int main() {
    std::cout << "=== Task 1.2: Thread Argument Passing ===" << std::endl;
    int local_x = 5;
    int local_y = 5;

    std::cout << "[Before] local_x (value) = " << local_x << ", local_y (ref) = " << local_y << std::endl;
    std::thread t(worker, local_x, std::ref(local_y));
    t.join();

    std::cout << "[After]  local_x (unchanged) = " << local_x << ", local_y (modified) = " << local_y << std::endl;
    return 0;
}
