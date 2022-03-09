import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/talk_model.dart';
import 'package:tomato_record/repo/item_service.dart';
import 'package:tomato_record/repo/talk_service.dart';
import 'package:tomato_record/states/user_notifier.dart';

class TalkWrightScreen extends StatefulWidget {
  @override
  State<TalkWrightScreen> createState() => _TalkWrightScreenState();
}

class _TalkWrightScreenState extends State<TalkWrightScreen> {
  String userbasicImgUrl = "https://randomuser.me/api/portraits/women/11.jpg";

  TextEditingController _detailController = TextEditingController();

  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 15),
          TextFormField(
            minLines: 10,
            controller: _detailController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: '올릴 게시글 내용을 작성해주세요.',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: common_padding),
                border: _border,
                enabledBorder: _border,
                focusedBorder: _border),
          ),
          Center(
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: InkWell(
                      onTap: () async {},
                      child: ExtendedImage.network(userbasicImgUrl)))),
          TextButton(
              onPressed: () {
                newMethod();
              },
              child: Text("저장"))
        ],
      ),
    );
  }

  void newMethod() async {
    UserNotifier userNotifier = context.read<UserNotifier>();
    String userKey = userNotifier.user!.uid;
    String nickName = userNotifier.userModel!.nickname;
    String userImgUrl = userNotifier.userModel!.imgUrl;
    String msg = _detailController.text;
    String imgUrl = "";
    String talkKey = TalkModel.generateTalkKey(userKey);
    TalkModel talkModel = TalkModel(
        talkKey: talkKey,
        userKey: userKey,
        msg: msg,
        userImgUrl: userImgUrl,
        nickName: nickName,
        imgUrl: imgUrl,
        createdDate: DateTime.now().toUtc());

    await TalkService().createNewTalk(talkModel, talkKey, userKey);
    GoRouter.of(context).pop();
  }
}
