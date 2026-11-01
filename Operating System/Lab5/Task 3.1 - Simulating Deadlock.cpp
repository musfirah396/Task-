// Task 3.1: Simulating Deadlock (Circular Wait)
// Concept: Violating Coffman conditions by acquiring resources in opposite order.

#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>

std::mutex mtxA;
std::mutex mtxB;

void thread1_func() {
    std::cout << "Thread 1: Acquiring mtxA..." << std::endl;
    mtxA.lock();
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    std::cout << "Thread 1: Waiting for mtxB..." << std::endl;
    mtxB.lock();
    std::cout << "Thread 1: Finished." << std::endl;
    mtxB.unlock();
    mtxA.unlock();
}

void thread2_func() {
    std::cout << "Thread 2: Acquiring mtxB..." << std::endl;
    mtxB.lock();
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    std::cout << "Thread 2: Waiting for mtxA..." << std::endl;
    mtxA.lock();
    std::cout << "Thread 2: Finished." << std::endl;
    mtxA.unlock();
    mtxB.unlock();
}

int main() {
    std::cout << "=== Task 3.1: Simulating Deadlock (Demonstration) ===" << std::endl;
    std::cout << "Note: T1 acquires A then B. T2 acquires B then A -> Circular dependency!" << std::endl;
    std::thread t1(thread1_func);
    std::thread t2(thread2_func);

    // Give them a moment to demonstrate deadlock condition
    std::this_thread::sleep_for(std::chrono::milliseconds(300));
    std::cout << "[Detector] Deadlock reached: Thread 1 waits on T2, Thread 2 waits on T1." << std::endl;

    t1.detach();
    t2.detach();
    return 0;
}
