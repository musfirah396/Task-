// Task 3.2: Deadlock-Free Multi-Locking (std::scoped_lock)
// Concept: Deadlock avoidance via simultaneous atomic resource allocation (eliminates hold-and-wait).

#include <iostream>
#include <thread>
#include <mutex>

std::mutex mtxA;
std::mutex mtxB;

void transfer_funds(int id) {
    // std::scoped_lock acquires all mutexes deadlock-free using deadlock avoidance algorithms
    std::scoped_lock lock(mtxA, mtxB);
    std::cout << "Thread " << id << " safely acquired both locks without deadlock!" << std::endl;
}

int main() {
    std::cout << "=== Task 3.2: Deadlock-Free Multi-Locking (std::scoped_lock) ===" << std::endl;
    std::thread t1(transfer_funds, 1);
    std::thread t2(transfer_funds, 2);

    t1.join();
    t2.join();
    std::cout << "Transaction completed successfully." << std::endl;
    return 0;
}
