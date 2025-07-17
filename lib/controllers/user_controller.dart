import 'package:get/get.dart';

class UserController extends GetxController {

  var initialUsername = ''.obs;
  var name = ''.obs;
  var email = ''.obs;
  var avatar = ''.obs;


  void setUser(String newName, String newEmail, String newAvatar) {
    this.name.value = newName;
    this.email.value = newEmail;
    this.avatar.value = newAvatar;
  }
}