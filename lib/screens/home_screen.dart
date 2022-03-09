import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/screens/chat/chat_list_page.dart';
import 'package:tomato_record/screens/home/call_page.dart';
import 'package:tomato_record/screens/home/map_page.dart';
import 'package:tomato_record/screens/home/talk_page.dart';
import 'package:tomato_record/screens/others/other_screen.dart';
import 'package:tomato_record/states/user_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserNotifier>().userModel;
    return Scaffold(
      body: (userModel == null)
          ? Container()
          : IndexedStack(
              index: _bottomSelectedIndex,
              children: [
                TalkPage(userKey: userModel.userKey),
                CallPage(userKey: userModel.userKey),
                MapPage(userModel),
                ChatListPage(userKey: userModel.userKey),
                OtherScreen(),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0
                  ? 'assets/imgs/selected_home_1.png'
                  : 'assets/imgs/home_1.png')),
              label: '토크'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 1
                  ? 'assets/imgs/selected_home_1.png'
                  : 'assets/imgs/home_1.png')),
              label: '통화'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 2
                  ? 'assets/imgs/selected_placeholder.png'
                  : 'assets/imgs/placeholder.png')),
              label: '내 근처'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 3
                  ? 'assets/imgs/selected_smartphone_10.png'
                  : 'assets/imgs/smartphone_10.png')),
              label: '대화'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(_bottomSelectedIndex == 4
                  ? 'assets/imgs/selected_user_3.png'
                  : 'assets/imgs/user_3.png')),
              label: '더보기'),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
