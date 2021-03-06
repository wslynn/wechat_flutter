import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wechat_flutter/common/style/colors.dart';
import 'package:wechat_flutter/common/style/menus.dart';

import 'user_avatar.dart';

class ChatContentView extends StatelessWidget {
  bool isSelf; //false 代表对方 ， true代表自己
  String text; //聊天内容
  String avatar; //头像url
  String username; //昵称
  int type; //聊天类型 1单聊 2群聊
  ChatContentView(
      {Key? key,
      required this.isSelf,
      required this.text,
      required this.avatar,
      required this.username,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tapPos;
    //头像组件
    Widget userAvatar = UserAvatar(
        width: 40,
        height: 40,
        image: avatar,
        onPressed: () {
          print('点击头像');
        });

    Widget userNameWidget = Container(
      margin: EdgeInsets.only(
          left: isSelf == false ? 14 : 0,
          bottom: 5,
          right: isSelf == false ? 0 : 14),
      child: Text(
        username,
        style: TextStyle(
            color: Color(AppColors.ChatTime),
            fontSize: 12.0),
      ),
    );

    _showMenu(BuildContext context, Offset tapPos) {
      RenderBox overlay = context.findRenderObject()! as RenderBox;
      final RelativeRect position = RelativeRect.fromLTRB(
          tapPos.dx, tapPos.dy, -tapPos.dx, overlay.size.height - tapPos.dy);
      showMenu<String>(
          context: context,
          position: position,
          items: <PopupMenuItem<String>>[
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_COPY_VALUE),
              value: MessageDetailSelects.MENU_COPY,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_SHARE_FRIENDS_VALUE),
              value: MessageDetailSelects.MENU_SHARE_FRIENDS,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_FAVORIITE_VALUE),
              value: MessageDetailSelects.MENU_FAVORIITE,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_REMIND_VALUE),
              value: MessageDetailSelects.MENU_REMIND,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_TRANSLATE_VALUE),
              value: MessageDetailSelects.MENU_TRANSLATE,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_DELATE_VALUE),
              value: MessageDetailSelects.MENU_DELATE,
            ),
            PopupMenuItem(
              child: Text(MessageDetailSelects.MENU_MULTIPE_CHOICE_VALUE),
              value: MessageDetailSelects.MENU_MULTIPE_CHOICE,
            ),
          ]).then<void>((String? selected) {
        print('当前选中的是：$selected');
      });
    }

    Widget messageTextWidget = InkWell(
      onTapDown: (TapDownDetails details) {
        tapPos = details.globalPosition;
      },
      onLongPress: () {
        _showMenu(context, tapPos);
        print('弹出会话菜单');
      },
      child: Container(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14.0,
              color: Color(AppColors.TextBobule),
              height: 1.2),
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: isSelf == false
              ? Color(AppColors.TextBobuleLeft)
              : Color(AppColors.TextBobuleRight),
        ),
      ),
    );

    final List<Widget> nameAndText = [userNameWidget, messageTextWidget];
    final List<Widget> onlyText = [SizedBox(height: 5), messageTextWidget];
    textBubble() {
      return Expanded(
          child: Column(
        crossAxisAlignment:
            isSelf == false ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: type == 2 && isSelf == false ? nameAndText : onlyText,
      ));
    }

    return Container(
      margin: EdgeInsets.only(
          bottom: 6,
          top: 6),
      child: isSelf == false
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                userAvatar,
                SizedBox(width: 10),
                textBubble(),
                SizedBox(width: 50),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 50),
                textBubble(),
                SizedBox(width: 10),
                userAvatar,
                SizedBox(width: 10),
              ],
            ),
    );
  }
}
