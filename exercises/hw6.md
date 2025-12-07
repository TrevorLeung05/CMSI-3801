1. Concurrency is about managing multiple tasks at once whereas parallelism is about executing multiple tasks at the same time.

2. A thread is the actual worker that runs code whereass a task is the unit of work yuou want executed by a thread.

3. If you invoke a method on a terminated threada in Java, the thread will still remain dead, the calls will still work but the thread can not be restarted. If you call an entry on a terminated task in Adaa, the call will not be completed dand will raise the Tasking_Error exception because it can not accept entries anymore.

4. In Java the program terminates only when all user threads have finished execution. If the main thread ends but other user threads are still running the JVM continues. In Ada the program terminates when the main environment task and all of its dependent child tasks have finished. In Go the program terminates immediately when the main goroutine returns. It does not wait for other goroutines to complete so explicit synchronization is required to prevent premature exit.

5. An unbuffered channel has no capacity and requires both the sender and receiver to be ready at the same time. You use this when you need strict synchronization or to guarantee a signal has been received. A buffered channel has a fixed capacity allowing the sender to queue items without blocking until the buffer is full. You use this to decouple the sender and receiver such as when handling bursts of requests where the producer may temporarily work faster than the consumer.

6. A standard Mutex acts as a global lock that allows only one goroutine to access a critical section at a time regardless of whether it is reading or writing. A RWMutex or Read Write Mutex is more specialized. It allows multiple goroutines to hold a read lock simultaneously but ensures that a write lock is exclusive blocking all other readers and writers. You should choose RWMutex when you have a data structure that is read frequently but written to rarely as it significantly improves performance by allowing concurrent reads.

7. In Go, if you try to write to a closed channel, it will always cause panic: send on closed channel. If you read from a closed channel, you will get the zero-value immediately, and the read is non-blocking. Even with buffered values, after draining, the next reads return the zero value.

8. The select statement in Go lets goroutine wait on multiple channel operations at once. It differs from switch as switch chooses from a branch based on the value of an expression, while select chooses a branch based on which channel operation is ready, or can proceed without blocking.