# LLAnalysisDemo
iOS中无痕数据埋点的一点小实践

实现思路参考这篇文章： http://www.cocoachina.com/ios/20181207/25739.html

1.数据埋点：
        通过 hook  UIViewController、UIControl、UITableView（UICollectionView）、UIGestureRecognizer 中的方法，
来实现数据的采集

2.数据的本地化存储和上传：
        数据本地化存储通过创建本地数据库的方式进行存储，用户每启动一次app创建一个数据表，并会对上一次的数据表进行异步上传，
上传成功后对旧表删除



### 技术要点：

1. runtime 给方法、代理方法 添加切面

2.事件定位，如何给事件添加唯一标识

3.FMDB的使用，以及数据上传的处理



###优点：

1.无入侵，保持原有代码的整洁性

2.可以动态下发埋点配置文件，便于修改

###缺点：

1.事件对应的方法名改变后配置文件也需要相应随着改变

2.如果业务代码更替比较多，不同版本可能需要下发不同的埋点配置文件


###注意细节：

1.hook方法尽量用+initialize ， 少用+load ，+load是在main方法之前执行，一定程度上对启动还是会有影响的

2.使用 FMDatabaseQueue 需要注意，FMDatabaseQueue 执行的block是在同步串行队列中执行的，在读取表数据时，
如果数据量较大，会影响主线程




