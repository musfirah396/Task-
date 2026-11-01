// Task 1.4: Automatic Lifecycle via RAII (Joining Thread Wrapper / std::jthread)
// Concept: Preventing zombie/unterminated threads on abnormal returns or unwound stack frames.

#include <iostream>
#include <thread>

// RAII Thread wrapper compatible with all C++17/20 compilers
class JoiningThread {
    std::thread t;
public:
    template<typename Callable, typename... Args>
    explicit JoiningThread(Callable&& f, Args&&... args)
        : t(std::forward<Callable>(f), std::forward<Args>(args)...) {}

    ~JoiningThread() {
        if (t.joinable()) {
            std::cout << "[RAII Destructor] Automatically joining thread before destruction..." << std::endl;
            t.join();
        }
    }
};

void worker_fn() {
    std::cout << "Worker executing in auto-joining scope." << std::endl;
}

int main() {
    std::cout << "=== Task 1.4: Automatic Lifecycle via RAII ===" << std::endl;
    {
        JoiningThread jt(worker_fn);
        std::cout << "Leaving scope now..." << std::endl;
    }
    std::cout << "Scope exited safely; thread joined automatically." << std::endl;
    return 0;
}
