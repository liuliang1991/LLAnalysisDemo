# LLAnalysisDemo
iOS中无痕数据埋点的一点小实践

实现思路参考这篇文章： http://www.cocoachina.com/ios/20181207/25739.html

1.数据埋点：
        通过 hook  UIViewController、UIControl、UITableView（UICollectionView）、UIGestureRecognizer 中的方法，
来实现数据的采集

2.数据的本地化存储和上传：
        数据本地化存储通过创建本地数据库的方式进行存储，用户每启动一次app创建一个数据表，并会对上一次的数据表进行异步上传，
上传成功后对旧表删除



技术要点：
1. runtime 给方法、代理方法 添加切面
2.事件定位，如何给事件添加唯一标识
3.FMDB的使用，以及数据上传的处理








