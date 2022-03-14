import 'package:get/state_manager.dart';

class TokenController {
  RxString username = "".obs;

  void setUsername(String username) {
    this.username.value = username;
  }
}
