1. Concurrency is about managing multiple tasks at once whereas parallelism is about executing multiple tasks at the same time.

2. A thread is the actual worker that runs code whereass a task is the unit of work yuou want executed by a thread.

3. If you invoke a method on a terminated threada in Java, the thread will still remain dead, the calls will still work but the thread can not be restarted. If you call an entry on a terminated task in Adaa, the call will not be completed dand will raise the Tasking_Error exception because it can not accept entries anymore.
