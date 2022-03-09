import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/states/user_notifier.dart';

class PointChargeScreen extends StatefulWidget {
  const PointChargeScreen({Key? key}) : super(key: key);

  @override
  State<PointChargeScreen> createState() => _PointChargeScreenState();
}

final inputBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

class _PointChargeScreenState extends State<PointChargeScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  TextEditingController _nickController = TextEditingController();
  late String _gender;
  late int _age;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserNotifier>().userModel;
    String userImgUrl = "assets/imgs/carrot_intro.png";
    if (userModel != null) {}
    final userNotifier = UserNotifier();
    return ChangeNotifierProvider<UserNotifier>.value(
        value: userNotifier,
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 45),
          body: Material(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text('충전'),
                  Row(children: [
                    Text('닉네임'),
                    SizedBox(width: 22),
                    Flexible(
                        child: TextFormField(
                      controller: _nickController,
                    ))
                  ]),
                  Row(children: [
                    Text('성별'),
                    SizedBox(width: 22),
                    Flexible(
                        child: DropdownButtonFormField<String?>(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 13, color: Color(0xffcfcfcf)),
                      ),
                      onChanged: (String? newValue) {
                        _gender = newValue!;
                      },
                      value: '남자',
                      items: ['남자', '여자'].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    )),
                  ]),
                  Row(children: [
                    Text('나이'),
                    SizedBox(width: 22),
                    Flexible(
                        child: DropdownButtonFormField<String?>(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 13, color: Color(0xffcfcfcf)),
                      ),
                      onChanged: (String? newValue) {
                        _age = int.parse(newValue!);
                        print(newValue);
                      },
                      value: '30',
                      items: [
                        '21',
                        '22',
                        '23',
                        '24',
                        '25',
                        '26',
                        '27',
                        '28',
                        '29',
                        '30',
                        '31',
                        '32',
                        '33',
                        '34',
                        '35',
                        '36',
                        '37',
                        '38',
                        '39',
                        '40',
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    )),
                  ]),
                  Row(children: [
                    Text('지역'),
                    SizedBox(width: 22),
                    Flexible(
                        child: Column(children: [
                      DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontSize: 13, color: Color(0xffcfcfcf)),
                        ),
                        onChanged: (String? newValue) {
                          print(newValue);
                        },
                        value: '서울',
                        items: [
                          '서울',
                          '부산',
                          '대구',
                          '울산',
                        ].map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                      ),
                      Text('친구와의 거리 계산은 핸드폰 위치를 참조 합니다.')
                    ])),
                  ]),
                  Row(children: [
                    Text('주제'),
                    SizedBox(width: 22),
                    Flexible(
                        child: DropdownButtonFormField<String?>(
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 13, color: Color(0xffcfcfcf)),
                      ),
                      onChanged: (String? newValue) {
                        print(newValue);
                      },
                      value: '말동무해요~',
                      items: [
                        '말동무해요~',
                        '드라이브 gogo',
                        '친구 사귀기',
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                    )),
                  ]),
                  Row(children: [
                    Text('쪽지'),
                    Switch(value: false, onChanged: (value) {}),
                    SizedBox(width: 22),
                    Text('쪽지알림'),
                    Switch(value: false, onChanged: (value) {}),
                    SizedBox(width: 22),
                    Text('토그목록 노출X')
                  ]),
                  Row(children: [
                    Text('통화'),
                    Switch(value: false, onChanged: (value) {}),
                    SizedBox(width: 22),
                    Text('전화알림'),
                    Switch(value: false, onChanged: (value) {}),
                    SizedBox(width: 22),
                    Text('통화목록 노출X'),
                  ]),
                  Row(children: [
                    Text('동맹 앱'),
                    Switch(value: false, onChanged: (value) {}),
                    SizedBox(width: 22),
                    Text('활동이 많아야 노출 많아짐.'),
                  ]),
                  TextButton(
                      onPressed: () {
                        //[1]image
                        //image ,_gender ,_age  <=값 반영 되어 있을 것임...
                        String nickname = _nickController.text == ""
                            ? "홍길동"
                            : _nickController.text;
                      },
                      child: Text('프로필저장')),
                ],
              ),
            )),
          ),
        ));
  }
}
