# CoredataDemo  Coredata单线程、多线程使用方法demo

##单线程模式  
   Coredata和UITableView的搭配是非常完美的组合，很方便的实现数据查询，修改和UITableView的cell同步。  
   
##Coredata多线程模式分为两种：  
   
   1、一个PersistentStoreCoordinator，一个主线程Parent Context（NSMainQueueConcurrencyType ）负责与UI相关的数据处理；  
   一个后台线程Child Context（NSPrivateQueueConcurrencyType）负责大数据读写等耗时操作。  
   
   2、一个PersistentStoreCoordinator，一个主线程Context（NSMainQueueConcurrencyType ）负责与UI相关的数据处理；  
   一个后台线程Context（NSPrivateQueueConcurrencyType）负责大数据读写等耗时操作，这两个Context是相互独立的，他们共享同一个  
   PersistentStoreCoordinator，当一个Context发生变化的时候，发出通知，另外一个Context合并这个变化即可。
   
   
##备注：  
   Coredata的Context是线程不安全的，PersistentStoreCoordinator是线程安全的。  
   Coredata在多线程操作中，需要用Apple提供的Block进行操作，performBlock或者performBlockAndWait，保证线程安全，  
   不能自己顺便开一个线程就叫多线程。这两个函数的区别是performBlock不会阻塞运行的线程，相当于异步操作，  
   performBlockAndWait会阻塞运行线程，相当于同步操作。

##关于多线程两种模式选择
   关于Child Contexts的争论很多，并不建议在多线程中使用它。如果在非主线程中创建了一个Context作为main Context的Child  
   Context，在这些非主线程中执行保存操作还是会阻塞主线程。反过来，要是将main Context设置为其他非主线程Context的Child  
   Context，其效果与传统的创建两个有依赖关系的Contexts类似，还是需要手动的将其他线程的Context变化和main  
   Context做合并。事实证明，除非有更好的选择，否则设置一个Persistent store coordinator和两个独立的Contexts才是对Core  
   Data多线程操作的合理方式。

