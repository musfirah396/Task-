// Task 5.3: Thread-Local Storage (TLS)
// Concept: Variables allocated inside thread-private storage instead of process-wide heap.

#include <iostream>
#include <thread>

thread_local int txn_id = 0; // Each thread has its own distinct copy

void run(int id) {
    txn_id += id;
    std::cout << "Thread " << id << " has private txn_id = " << txn_id << " at address: " << &txn_id << std::endl;
}

int main() {
    std::cout << "=== Task 5.3: Thread-Local Storage (TLS) ===" << std::endl;
    std::thread t1(run, 100);
    std::thread t2(run, 200);

    t1.join();
    t2.join();
    return 0;
}
