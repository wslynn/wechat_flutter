import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';
import '../discover/index.dart';
import '../friend/index.dart';
import '../message/index.dart';
import '../mine/index.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: buildIndexedStack(),
    );
  }

  Widget buildIndexedStack() {
    return GetBuilder<HomeController>(
        builder: (_) => IndexedStack(
              index: HomeController.to.tabIndex,
              children: [
                MessagePage(),
                FriendPage(),
                DiscoverPage(),
                MinePage(),
              ],
            ));
  }

  Widget buildBottomNavigationBar() {
    return GetBuilder<HomeController>(
        builder: (_) => BottomNavigationBar(
              currentIndex: HomeController.to.tabIndex,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                print(index);
                HomeController.to.setValue(tabIndex: index);
              },
              items: [
                BottomNavigationBarItem(
                  label: "消息",
                  icon: Image.asset(
                    "assets/images/message.png",
                    width: 22,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/message.png",
                    width: 22,
                    color: Colors.green,
                  ),
                  tooltip: "",
                ),
                BottomNavigationBarItem(
                  label: "好友",
                  icon: Image.asset(
                    "assets/images/contact.png",
                    width: 22,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/contact.png",
                    width: 22,
                    color: Colors.green,
                  ),
                  tooltip: "",
                ),
                BottomNavigationBarItem(
                  label: "发现",
                  icon: Image.asset(
                    "assets/images/find.png",
                    width: 22,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/find.png",
                    width: 22,
                    color: Colors.green,
                  ),
                  tooltip: "",
                ),
                BottomNavigationBarItem(
                  label: "我的",
                  icon: Image.asset(
                    "assets/images/mine.png",
                    width: 22,
                  ),
                  activeIcon: Image.asset(
                    "assets/images/mine.png",
                    width: 22,
                    color: Colors.green,
                  ),
                  tooltip: "",
                )
              ],
            ));
  }
}
