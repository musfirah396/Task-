// Task 1.3: Detached Execution (Daemon Threading)
// Concept: Background worker lifecycle decoupled from parent execution; cleans up without explicit join.

#include <iostream>
#include <thread>
#include <chrono>

void logger() {
    for (int i = 1; i <= 3; ++i) {
        std::cout << "[Daemon Logger] Flushed buffer to disk (Heartbeat " << i << ")" << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(200));
    }
}

int main() {
    std::cout << "=== Task 1.3: Detached Execution (Daemon Threading) ===" << std::endl;
    std::thread t(logger);
    t.detach(); // OS manages TCB deallocation upon thread termination

    std::cout << "Parent continuing without blocking on detached thread..." << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(800));
    std::cout << "Parent main exiting." << std::endl;
    return 0;
}
