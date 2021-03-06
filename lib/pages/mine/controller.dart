import 'package:get/get.dart';
import 'package:wechat_flutter/common/entities/index.dart';
import 'package:wechat_flutter/common/apis/user.dart';
import 'package:wechat_flutter/common/store/user.dart';
import 'package:wechat_flutter/common/xresp/xresp.dart';
import 'package:wechat_flutter/pages/frame/login/view.dart';

class MineController extends GetxController {
  static MineController get to => Get.find();

  var loaded = false;
  var userId = 0;
  var nickName = "";
  var email = "";
  var gender = 0;
  var avatarUrl = "";

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    // 发送请求 获取个人信息
    var data = PersonalInfoRequest();
    UserAPI.personalInfo(data: data).then((personalResp) {
      userId = personalResp.userId;
      email = personalResp.email;
      nickName = personalResp.nickName;
      gender = personalResp.gender;
      avatarUrl = personalResp.avatarUrl;
      loaded = true;
      update();
      print("获取个人信息成功: $userId $avatarUrl");
    }).catchError((err) {
      var errInfo = "$err";
      if (err.runtimeType == RespBody) {
        errInfo = "${err.code} ${err.msg}";
      }
      // 显示弹窗
      Get.snackbar("personal_err_title".tr, errInfo);
      // 删除token
      UserStore.to.rmToken();
      // 跳转到登录页面
      Get.offAll(() => LoginPage(), transition: Transition.fadeIn);
    });
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
