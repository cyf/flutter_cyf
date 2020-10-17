class AppManager {
  double kBottomNavigationBarHeight;
  bool isProd;

  // 单例公开访问点
  factory AppManager() => _flutterDemoManager();

  // 静态私有成员，没有初始化
  static AppManager _instance;

  // 私有构造函数
  AppManager._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static AppManager _flutterDemoManager() {
    if (_instance == null) {
      _instance = AppManager._();
    }
    return _instance;
  }

}