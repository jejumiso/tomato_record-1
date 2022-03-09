import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:tomato_record/constants/data_keys.dart';

class UserModel {
  late String userKey;
  late String phoneNumber;
  late String company;
  late String address;
  late bool agreement;
  late GeoFirePoint geoFirePoint;
  late String imgUrl;
  late bool allowTheUseImgUrl;
  // late String imgUrl2;
  // late bool allowTheUseImgUrl2;
  late String nickname;
  late String gender;
  late int age;
  late bool receiveMsg;
  late bool alramMsg;
  late bool receiveCall;
  late bool alramCall;
  late String state; //online,offline,calling,standby
  late bool isBackgroundReceive;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel(
      {required this.userKey,
      required this.phoneNumber,
      required this.company,
      required this.address,
      required this.agreement,
      required this.geoFirePoint,
      required this.imgUrl,
      required this.allowTheUseImgUrl,
      // required this.imgUrl2,
      // required this.allowTheUseImgUrl2,
      required this.nickname,
      required this.gender,
      required this.age,
      required this.receiveMsg,
      required this.alramMsg,
      required this.receiveCall,
      required this.alramCall,
      required this.state,
      required this.isBackgroundReceive,
      required this.createdDate,
      this.reference});

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference)
      : phoneNumber = json[DOC_PHONENUMBER],
        company = json[DOC_COMPANY],
        address = json[DOC_ADDRESS],
        agreement = json[DOC_AGREEMENT],
        geoFirePoint = GeoFirePoint(
            (json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).latitude,
            (json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).longitude),
        imgUrl = json[DOC_IMGURL],
        allowTheUseImgUrl = json[DOC_ALLOWTHEUSEIMGURL],
        nickname = json[DOC_NICKNAME],
        gender = json[DOC_GENDER],
        age = json[DOC_AGE],
        receiveMsg = json[DOC_RECEIVEMSG],
        alramMsg = json[DOC_ALRAMMSG],
        receiveCall = json[DOC_RECEIVECALL],
        alramCall = json[DOC_ALRAMCALL],
        state = json[DOC_STATE],
        isBackgroundReceive = json[DOC_ISBACKGROUNDRECEIVE],
        createdDate = json[DOC_CREATEDDATE] == null
            ? DateTime.now().toUtc()
            : (json[DOC_CREATEDDATE] as Timestamp).toDate();

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[DOC_PHONENUMBER] = phoneNumber;
    map[DOC_COMPANY] = company;
    map[DOC_ADDRESS] = address;
    map[DOC_AGREEMENT] = agreement;
    map[DOC_GEOFIREPOINT] = geoFirePoint.data;
    map[DOC_IMGURL] = imgUrl;
    map[DOC_ALLOWTHEUSEIMGURL] = allowTheUseImgUrl;

    map[DOC_NICKNAME] = nickname;
    map[DOC_GENDER] = gender;
    map[DOC_AGE] = age;
    map[DOC_RECEIVEMSG] = receiveMsg;
    map[DOC_ALRAMMSG] = alramMsg;
    map[DOC_RECEIVECALL] = receiveCall;
    map[DOC_ALRAMCALL] = alramCall;

    map[DOC_STATE] = state;
    map[DOC_ISBACKGROUNDRECEIVE] = isBackgroundReceive;
    map[DOC_CREATEDDATE] = createdDate;
    return map;
  }
}

class UserProfileModel {
  late String userKey;
  late String imgUrl;
  late bool allowTheUseImgUrl;
  late String nickname;
  late String gender;
  late int age;
  late bool receiveMsg;
  late bool alramMsg;
  late bool receiveCall;
  late bool alramCall;

  UserProfileModel({
    required this.userKey,
    required this.imgUrl,
    required this.allowTheUseImgUrl,
    required this.nickname,
    required this.gender,
    required this.age,
    required this.receiveMsg,
    required this.alramMsg,
    required this.receiveCall,
    required this.alramCall,
  });
}
