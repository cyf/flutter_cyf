
class User {
  List<UserInfo> _userInfo = List<UserInfo>();

  void initData(int size) {
    for (int i = 0; i < size; i++) {
      _userInfo.add(UserInfo(
        name: "User_$i",
        status: i % 3 == 0,
        phone: '+001 9999 9999',
        registerDate: '2020-04-21',
        terminationDate: '2020-04-21',
      ));
    }
  }

  List<UserInfo> get userInfo => _userInfo;

  set userInfo(List<UserInfo> value) {
    _userInfo = value;
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    _userInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', ''));
      int bId = int.tryParse(b.name.replaceFirst('User_', ''));
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    _userInfo.sort((a, b) {
      if (a.status == b.status) {
        int aId = int.tryParse(a.name.replaceFirst('User_', ''));
        int bId = int.tryParse(b.name.replaceFirst('User_', ''));
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }
}

class UserInfo {
  final String name;
  final bool status;
  final String phone;
  final String registerDate;
  final String terminationDate;

  UserInfo({this.name, this.status, this.phone, this.registerDate,
    this.terminationDate});
}