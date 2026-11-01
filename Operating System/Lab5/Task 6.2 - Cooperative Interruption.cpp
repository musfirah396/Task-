// Task 6.2: Cooperative Interruption (Cancellation via Atomic Flag)
// Concept: Graceful, cooperative thread termination using an atomic boolean cancellation token.

#include <iostream>
#include <thread>
#include <atomic>
#include <chrono>

std::atomic<bool> stop_requested(false);

void cancellable_worker() {
    int iterations = 0;
    while (!stop_requested.load()) {
        std::cout << "[Worker] Performing work cycle " << ++iterations << "..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    std::cout << "[Worker] Cancellation request received. Cleaning up resources before exit." << std::endl;
}

int main() {
    std::cout << "=== Task 6.2: Cooperative Interruption ===" << std::endl;

    std::thread worker(cancellable_worker);

    // Let the worker run for a brief period
    std::this_thread::sleep_for(std::chrono::milliseconds(350));

    std::cout << "[Main] Dispatched stop signal to worker..." << std::endl;
    stop_requested.store(true);

    worker.join();
    std::cout << "[Main] Worker thread joined cleanly after cooperative shutdown." << std::endl;

    return 0;
}
