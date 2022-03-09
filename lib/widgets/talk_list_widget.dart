import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/chat_model.dart';
import 'package:tomato_record/data/chatroom_model.dart';
import 'package:tomato_record/data/talk_model.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/repo/chat_service.dart';
import 'package:tomato_record/states/chat_notifier.dart';
import 'package:tomato_record/states/user_notifier.dart';

class TalkListWidget extends StatefulWidget {
  final TalkModel item;

  TalkListWidget(this.item, {Key? key}) : super(key: key);

  @override
  State<TalkListWidget> createState() => _TalkListWidgetState();
}

TextEditingController _nickController = TextEditingController();
var _border =
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
String userbasicImgUrl2 = "https://randomuser.me/api/portraits/women/11.jpg";

void _showRequestCall(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: Container(
          height: 200,
          child: Column(
            children: [ExtendedImage.network(userbasicImgUrl2)],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              new TextButton(
                child: new Text("영상통화"),
                onPressed: () => Navigator.pop(context),
              ),
              new TextButton(
                child: new Text("음성통화"),
                onPressed: () => Navigator.pop(context),
              ),
              new TextButton(
                child: new Text("닫기"),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      );
    },
  );
}

void _showRequestMsg(BuildContext context, String receive_userKey) {
  UserModel userModel = context.read<UserNotifier>().userModel!;
  _nickController.text = "";
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        // title: new Text("Alert Dialog title"),
        content: Container(
          height: 185,
          child: Column(
            children: [
              SizedBox(height: 8),
              SizedBox(
                  height: 80,
                  width: 80,
                  child: ExtendedImage.network(userbasicImgUrl2)),
              SizedBox(height: 16),
              TextFormField(
                  controller: _nickController,
                  decoration: InputDecoration(
                      hintText: '내용을 입력해주세요..',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: common_padding),
                      border: _border,
                      enabledBorder: _border,
                      focusedBorder: _border)),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              new TextButton(
                child: new Text("보내기"),
                onPressed: () async {
                  //[1] 챗룸 생성...
                  //챗룸 생성 여부 확인하고 챗룸 생성..
                  //무조건 1개만 생성 할 것인가...음.. YES
                  //무조건 1:1채팅만 할것인가... YES ...
                  String chatroomKey = ChatroomModel.generateChatRoomKey(
                      userModel.userKey, receive_userKey);

                  ChatroomModel _chatroomModel = ChatroomModel(
                      lastMsgTime: DateTime.now(),
                      itemImage: "nnn",
                      itemTitle: "nnn",
                      itemKey: "nnn",
                      itemAddress: "nnn",
                      itemPrice: 0,
                      sellerKey: receive_userKey,
                      buyerKey: userModel.userKey,
                      chatroomKey: chatroomKey);

                  await ChatService().createNewChatroom(_chatroomModel);

                  ChatModel chatModel = ChatModel(
                      userKey: userModel.userKey,
                      msg: _nickController.text,
                      type: "msg",
                      createdDate: DateTime.now());

                  await ChatService().createNewChat(chatroomKey, chatModel);
                  Navigator.pop(context);
                },
              ),
              new TextButton(
                child: new Text("닫기"),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      );
    },
  );
}

class _TalkListWidgetState extends State<TalkListWidget> {
  late double imgSize;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    imgSize = size.width / 5;
    String userbasicImgUrl = "https://randomuser.me/api/portraits/women/11.jpg";

    return SizedBox(
      height: imgSize,
      child: Row(
        children: [
          SizedBox(
              height: imgSize,
              width: imgSize,
              child: ExtendedImage.network(
                widget.item.imgUrl != "" ? widget.item.imgUrl : userbasicImgUrl,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              )),
          SizedBox(
            width: common_sm_padding,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.msg,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 14,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_2,
                            color: Colors.grey,
                          ),
                          Text(
                            '111',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Icon(
                            CupertinoIcons.heart,
                            color: Colors.grey,
                          ),
                          Text(
                            '111',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
          TextButton(
              onPressed: () => _showRequestMsg(context, widget.item.userKey),
              child: Text('쪽지')),
          SizedBox(
            width: common_sm_padding,
          ),
          TextButton(
              onPressed: () => _showRequestCall(context), child: Text('통화'))
        ],
      ),
    );
  }
}
