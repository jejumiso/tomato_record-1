import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/repo/image_storage.dart';
import 'package:tomato_record/repo/user_service.dart';
import 'package:tomato_record/states/user_notifier.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final inputBorder =
    OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

class _ProfileScreenState extends State<ProfileScreen> {
  bool saving = false;

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  TextEditingController _nickController = TextEditingController();
  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  bool? receiveMsg;
  bool? alramMsg;
  bool? receiveCall;
  bool? alramCall;

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserNotifier>().userModel;
    String userbasicImgUrl = "https://randomuser.me/api/portraits/women/11.jpg";
    if (userModel != null) {}
    // final userNotifier = UserNotifier();
    int _age = userModel!.age;
    String _gender = userModel.gender;
    receiveMsg = receiveMsg == null ? userModel.receiveMsg : receiveMsg;
    alramMsg = alramMsg == null ? userModel.alramMsg : alramMsg;
    receiveCall = receiveCall == null ? userModel.receiveCall : receiveCall;
    alramCall = alramCall == null ? userModel.alramCall : alramCall;
    _nickController.text = userModel.nickname;
    void attemptCreateItem(
        Uint8List? image,
        String nickname,
        String _gender,
        int age,
        bool receiveMsg,
        bool alramMsg,
        bool receiveCall,
        bool alramCall) async {
      final String userKey = FirebaseAuth.instance.currentUser!.uid;

      String imgUrl = image == null
          ? ""
          : await ImageStorage.uploadUserImage(image, userKey);

      UserProfileModel userProfileModel = UserProfileModel(
          userKey: userKey,
          imgUrl: imgUrl,
          age: _age,
          receiveMsg: receiveMsg,
          alramMsg: alramMsg,
          receiveCall: receiveCall,
          alramCall: alramCall,
          nickname: nickname,
          gender: _gender,
          allowTheUseImgUrl: false);

      await UserService().updateUserProfile(userProfileModel);
      userModel.age = _age;
      userModel.imgUrl = imgUrl != "" ? imgUrl : userModel.imgUrl;
      userModel.nickname = nickname;
      userModel.gender = _gender;
      userModel.allowTheUseImgUrl =
          imgUrl != "" ? false : userModel.allowTheUseImgUrl;
      userModel.receiveMsg = receiveMsg;
      userModel.alramMsg = alramMsg;
      userModel.receiveCall = receiveCall;
      userModel.alramCall = alramCall;
      GoRouter.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 45),
      body: Material(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: InkWell(
                          onTap: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                          },
                          child: userModel.imgUrl == ""
                              ? ExtendedImage.network(userbasicImgUrl)
                              : ExtendedImage.network(userModel.imgUrl)))),
              Row(children: [
                Text('닉네임'),
                SizedBox(width: 22),
                Flexible(
                    child: TextFormField(
                        controller: _nickController,
                        decoration: InputDecoration(
                            hintText: '닉네임 2자이 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: common_padding),
                            border: _border,
                            enabledBorder: _border,
                            focusedBorder: _border)))
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
                  value: _gender,
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
                  value: _age.toString(),
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
                    '41',
                    '42',
                    '43',
                    '44',
                    '45',
                    '46',
                    '47',
                    '48',
                    '49',
                    '50'
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
                  // Text('친구와의 거리 계산은 핸드폰 위치로 실계산 합니다.')
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
                Switch(
                    value: receiveMsg!,
                    onChanged: (value) {
                      setState(() {
                        receiveMsg = value;
                      });
                    }),
                SizedBox(width: 22),
                receiveMsg! ? Text('쪽지알림') : Container(),
                receiveMsg!
                    ? Switch(
                        value: alramMsg!,
                        onChanged: (value) {
                          setState(() {});
                          alramMsg = value;
                        })
                    : Container(),
                SizedBox(width: 22),
                Text(receiveMsg! ? "" : '토크목록에 노출되지 않아요~')
              ]),
              Row(children: [
                Text('통화'),
                Switch(
                    value: receiveCall!,
                    onChanged: (value) {
                      receiveCall = value;
                      setState(() {});
                    }),
                SizedBox(width: 22),
                receiveCall! ? Text('전화알림') : Container(),
                receiveCall!
                    ? Switch(
                        value: alramCall!,
                        onChanged: (value) {
                          setState(() {});
                          alramCall = value;
                        })
                    : Container(),
                SizedBox(width: 22),
                Text(receiveCall! ? '' : '통화목록 노출되지 않아요~'),
              ]),
              // Row(children: [
              //   Text('동맹 앱 등록'),
              //   Switch(value: false, onChanged: (value) {}),
              //   SizedBox(width: 22),
              //   Text('활동이 많아야 노출 많아짐.'),
              // ]),
              TextButton(
                  onPressed: () async {
                    if (saving == false) {
                      setState(() {});
                      saving = true;
                      //[1]image
                      //image ,_gender ,_age  <=값 반영 되어 있을 것임...
                      String nickname = _nickController.text;
                      if (nickname.length < 2) {
                        saving = false;
                        setState(() {});
                        SnackBar snackbar =
                            SnackBar(content: Text('닉네임은 2글자 이상 입력해주세요.'));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);

                        return;
                      }
                      File? file = image != null ? File(image!.path) : null;
                      attemptCreateItem(
                          (image != null ? file!.readAsBytesSync() : null),
                          nickname,
                          _gender,
                          _age,
                          receiveMsg!,
                          alramMsg!,
                          receiveCall!,
                          alramCall!);
                    } else {
                      return;
                    }
                  },
                  child: Text(saving ? '저장중' : '프로필저장')),
            ],
          ),
        )),
      ),
    );
  }
}
