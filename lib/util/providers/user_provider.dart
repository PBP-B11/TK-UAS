import 'package:flutter/cupertino.dart';
import 'package:my_panel/app/authentication/models/customer.dart';

class UserManagement with ChangeNotifier {
  Customer? _userLoggedIn;

  void setUser(Customer c) {
    _userLoggedIn = c;
    notifyListeners();
  }

  void removeUser() {
    _userLoggedIn = null;
    notifyListeners();
  }

  Customer? get userLoggedIn => _userLoggedIn;
}