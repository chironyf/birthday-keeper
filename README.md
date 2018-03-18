## 项目简介
- 一个生日管理APP, 这几天正好没事, 拿来练练手, UI风格仿照的系统闹钟, 可以添加, 编辑, 删除生日以及本地推送提醒, 系统最低要求是iOS 9.0.
- 整体采用MVC架构实现, 核心数据是一个BirthdayCellModel类型的可变数组birthdayInfo, 作为主控制器的属性, 为了实现数据读取与存储, 还有一个与它保持数据同步的可变数组externBirthdayInfo, 它主要用来在启动app时读取数据传入birthdayInfo, 然后在app进入后台时存储数据到本地, 采用的是NSUserDefaults.
- 本地通知用的是UILocalNotification, 在添加推送的时候, userInfo字典的值用的是生日的标签, 如果有两个相同的标签, 那么在取消其中一个推送的时候也会把另一个一起取消掉, 暂时还没有想到更好的办法作为通知的标识.
- 有一个坑点需要注意, 用普通的方式是无法对可变数组添加观察者的, 需要调用一个KVC方法, 如下例子所示
```
//需要调用这个方法 mutableArrayValueForKeyPath:
[[self mutableArrayValueForKeyPath:@"birthdayInfo"] insertObject:[_tempCellModel copy] atIndex:0];
```


## 项目截图
### 主界面, 展示添加过的生日列表, 右侧的switch可以控制是否推送通知
![](./images/home.PNG)

### 添加生日界面
![](./images/add.PNG)

### 编辑提示标签
![](./images/label.PNG)

## 联系
由于个人水平有限, 项目中还有很多不足的地方, 如果您对于项目有什么好的建议或者意见, 欢迎随时和我联系
QQ: 604399798
邮箱: chiron.yf@gmail.com
