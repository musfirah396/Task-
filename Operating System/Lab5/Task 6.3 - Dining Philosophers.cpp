// Task 6.3: Dining Philosophers (Resource Hierarchy)
// Concept: Eliminating symmetric deadlock by enforcing a strict global partial ordering on lock acquisitions.

#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
#include <algorithm>

const int NUM_PHILOSOPHERS = 3;
std::mutex forks[NUM_PHILOSOPHERS];

void dine(int id) {
    int left_id = id;
    int right_id = (id + 1) % NUM_PHILOSOPHERS;

    // Enforce lock acquisition order based on resource IDs:
    int first = std::min(left_id, right_id);
    int second = std::max(left_id, right_id);

    std::unique_lock<std::mutex> l1(forks[first]);
    std::unique_lock<std::mutex> l2(forks[second]);

    std::cout << "Philosopher " << id << " acquired fork " << first << " and " << second << ", eating!" << std::endl;
}

int main() {
    std::cout << "=== Task 6.3: Dining Philosophers (Resource Hierarchy) ===" << std::endl;
    std::vector<std::thread> philosophers;
    for (int i = 0; i < NUM_PHILOSOPHERS; ++i) {
        philosophers.emplace_back(dine, i);
    }
    for (auto& p : philosophers) p.join();
    std::cout << "All philosophers dined without deadlock." << std::endl;
    return 0;
}
