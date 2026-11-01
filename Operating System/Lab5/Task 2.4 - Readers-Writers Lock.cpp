// Task 2.4: Readers-Writers Lock (std::shared_mutex)
// Concept: Concurrent readers (shared lock) with solitary writers (exclusive lock).

#include <iostream>
#include <thread>
#include <shared_mutex>
#include <mutex>
#include <vector>
#include <chrono>

std::shared_mutex rw_mtx;
int shared_data = 100;

void reader(int id) {
    std::shared_lock<std::shared_mutex> r_lock(rw_mtx);
    std::cout << "Reader " << id << " read data = " << shared_data << std::endl;
}

void writer(int id, int val) {
    std::unique_lock<std::shared_mutex> w_lock(rw_mtx);
    shared_data = val;
    std::cout << "Writer " << id << " updated data = " << shared_data << std::endl;
}

int main() {
    std::cout << "=== Task 2.4: Readers-Writers Lock ===" << std::endl;
    std::thread r1(reader, 1);
    std::thread r2(reader, 2);
    std::thread w1(writer, 1, 250);
    std::thread r3(reader, 3);

    r1.join(); r2.join(); w1.join(); r3.join();
    return 0;
}
