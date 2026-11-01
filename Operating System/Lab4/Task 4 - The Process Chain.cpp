// Task 4: The Process Chain (Linear Hierarchy)
// Objective: Build a 3-tier linear hierarchy (P1 -> P2 -> P3) with bottom-up synchronization.

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

int main() {
    cout << "=== Task 4: The Process Chain (Linear Hierarchy) ===" << endl;

    pid_t p2 = fork();
    if (p2 == 0) {
        // Child 1 context (P2)
        pid_t p3 = fork();
        if (p3 == 0) {
            // Grandchild context (P3)
            cout << "[Grandchild] PID: " << getpid() << " | Parent: " << getppid() << endl;
            exit(0);
        }
        wait(NULL); // Child 1 waits for Grandchild
        cout << "[Child 1] PID: " << getpid() << " | Parent: " << getppid() << endl;
        exit(0);
    }

    wait(NULL); // Parent waits for Child 1
    cout << "[Parent] All descendants have completed." << endl;
    return 0;
}


