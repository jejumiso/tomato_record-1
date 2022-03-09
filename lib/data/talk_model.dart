import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomato_record/constants/data_keys.dart';

/// chatKey : ""
/// msg : ""
/// createdDate : ""
/// userKey : ""
/// reference : ""

class TalkModel {
  late String talkKey;
  late String userKey;
  late String nickName;
  late String userImgUrl;
  late String msg;
  late String imgUrl;
  late DateTime createdDate;
  DocumentReference? reference;

  TalkModel(
      {required this.talkKey,
      required this.userKey,
      required this.nickName,
      required this.userImgUrl,
      required this.msg,
      required this.imgUrl,
      required this.createdDate,
      this.reference});

  TalkModel.fromJson(Map<String, dynamic> json, this.talkKey, this.reference) {
    msg = json[DOC_MSG] ?? "";
    nickName = json[DOC_NICKNAME] ?? "";
    userImgUrl = json[DOC_USERIMGURL] ?? "";
    imgUrl = json[DOC_IMGURL] ?? "";
    createdDate = json[DOC_CREATEDDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_CREATEDDATE] as Timestamp).toDate();
    userKey = json[DOC_USERKEY] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[DOC_MSG] = msg;
    map[DOC_NICKNAME] = nickName;
    map[DOC_USERIMGURL] = userImgUrl;
    map[DOC_IMGURL] = imgUrl;
    map[DOC_CREATEDDATE] = createdDate;
    map[DOC_USERKEY] = userKey;
    return map;
  }

  Map<String, dynamic> toMinJson() {
    var map = <String, dynamic>{};
    map[DOC_IMGURL] = imgUrl;
    map[DOC_MSG] = msg;
    return map;
  }

  TalkModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  TalkModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  static String generateTalkKey(String uid) {
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
