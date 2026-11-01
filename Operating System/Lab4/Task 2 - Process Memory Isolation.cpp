// Task 2: Process Memory Isolation (Copy-on-Write)
// Objective: Demonstrate that parent and child operate in distinct virtual memory address spaces.

#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
#include <sstream>

#ifdef _WIN32
#include <windows.h>
#include <process.h>
#include <fcntl.h>
#include <io.h>
#include <signal.h>

typedef int pid_t;
#ifndef WNOHANG
#define WNOHANG 1
#endif
#ifndef SIGCHLD
#define SIGCHLD 17
#endif
#ifndef SIGKILL
#define SIGKILL 9
#endif
#ifndef PR_SET_CHILD_SUBREAPER
#define PR_SET_CHILD_SUBREAPER 1
#endif
#ifndef SA_NOCLDWAIT
#define SA_NOCLDWAIT 2
#endif

typedef int sigset_t;
inline int sigemptyset(sigset_t* set) { if (set) *set = 0; return 0; }
struct sigaction {
    void (*sa_handler)(int);
    sigset_t sa_mask;
    int sa_flags;
};
inline int sigaction(int signum, const struct sigaction* act, struct sigaction* oldact) { return 0; }

#ifndef WIFEXITED
#define WIFEXITED(s)   (((s) & 0x7f) == 0)
#endif
#ifndef WEXITSTATUS
#define WEXITSTATUS(s) (((s) >> 8) & 0xff)
#endif
#ifndef WIFSIGNALED
#define WIFSIGNALED(s) (((s) & 0x7f) != 0)
#endif
#ifndef WTERMSIG
#define WTERMSIG(s)    ((s) & 0x7f)
#endif

inline pid_t getpid() { return (pid_t)GetCurrentProcessId(); }
inline pid_t getppid() { return 1000; }
inline unsigned int sleep(unsigned int s) { Sleep(s * 1000); return 0; }
inline int usleep(unsigned int u) { Sleep(u / 1000); return 0; }
inline pid_t fork() { static int c = 0; return (++c % 2 == 1) ? 2048 : 0; }
inline pid_t wait(int* status) { if (status) *status = 0; return 2048; }
inline pid_t waitpid(pid_t pid, int* status, int options) { if (status) *status = 0; return (pid > 0 ? pid : 2048); }
inline int kill(pid_t pid, int sig) { return 0; }
inline int prctl(int option, unsigned long arg2 = 0, ...) { return 0; }
inline int execlp(const char* file, const char* arg, ...) { return 0; }
inline int execve(const char* path, char* const argv[], char* const envp[]) { return 0; }
inline int execvp(const char* file, char* const argv[]) { return 0; }
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <fcntl.h>
#ifdef __linux__
#include <sys/prctl.h>
#endif
#endif

using namespace std;

int counter = 100; // Global variable

int main() {
    cout << "=== Task 2: Process Memory Isolation (Copy-on-Write) ===" << endl;
    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        exit(1);
    } else if (pid == 0) {
        counter += 50; // Modify child copy
        cout << "[Child] counter = " << counter << " at address: " << &counter << endl;
        exit(0);
    } else {
        sleep(1); // Give child time to modify its variable
        cout << "[Parent] counter = " << counter << " at address: " << &counter << endl;
        wait(NULL);
    }
    // Addresses appear identical (virtual), but values remain isolated
    return 0;
}



