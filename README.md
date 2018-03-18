## 项目简介
- 一个生日管理APP, UI风格仿照的系统闹钟, 可以添加, 编辑, 删除生日以及本地推送提醒, 系统最低要求是iOS 9.0.
- 整体采用MVC架构实现, 核心数据是一个BirthdayCellModel类型的可变数组birthdayInfo, 作为主控制器的属性, 为了实现数据读取与存储, 还有一个与它保持数据同步的可变数组externBirthdayInfo, 它主要用来在启动app时读取数据传入birthdayInfo, 然后在app进入后台时存储数据到本地, 采用的是NSUserDefaults.



## 项目截图
![](./images/add.PNG) ![](./images/home.PNG) ![](./images/label.PNG)
