// Task 1.1: Basic Thread Forking and Joining
// Concept: The OS splits execution flow into an independent schedulable unit; the parent synchronizes with join().

#include <iostream>
#include <thread>

void child_routine() {
    std::cout << "Child executing with unique thread ID: " << std::this_thread::get_id() << std::endl;
}

int main() {
    std::cout << "=== Task 1.1: Basic Thread Forking and Joining ===" << std::endl;
    std::thread t(child_routine);
    t.join(); // Blocks calling thread until 't' finishes
    std::cout << "Parent resumed after thread join." << std::endl;
    return 0;
}
