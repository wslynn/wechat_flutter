import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class LoginController extends GetxController {
  LoginController();

  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';

  String? emailValidator(String? value) {
    if (value!.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  void LoginSubmit() {
    final isValid = formKey.currentState!.validate();
    print("isValid:$isValid");
    Get.focusScope!.unfocus();

    if (isValid) {
      formKey.currentState!.save();
      print(userEmail);
      print(userPassword);
      // User those values to send our auth request

    }
  }

  void RegisterSubmit() {
    final isValid = formKey.currentState!.validate();
    print("isValid:$isValid");
    Get.focusScope!.unfocus();

    if (isValid) {
      formKey.currentState!.save();
      print(userEmail);
      print(userPassword);
      // User those values to send our auth request

    }
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}