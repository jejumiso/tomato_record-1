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
  late String imgUrl2;
  late bool allowTheUseImgUrl2;
  late String nickname;
  late String gender;
  late int age;
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
      required this.imgUrl2,
      required this.allowTheUseImgUrl2,
      required this.nickname,
      required this.gender,
      required this.age,
      required this.state,
      required this.isBackgroundReceive,
      required this.createdDate,
      this.reference});

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference)
      : phoneNumber = json[DOC_PHONENUMBER],
        address = json[DOC_ADDRESS],
        agreement = json[DOC_AGREEMENT],
        geoFirePoint = GeoFirePoint(
            (json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).latitude,
            (json[DOC_GEOFIREPOINT][DOC_GEOPOINT]).longitude),
        createdDate = json[DOC_CREATEDDATE] == null
            ? DateTime.now().toUtc()
            : (json[DOC_CREATEDDATE] as Timestamp).toDate();

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[DOC_PHONENUMBER] = phoneNumber;
    map[DOC_AGREEMENT] = agreement;
    map[DOC_ADDRESS] = address;
    map[DOC_GEOFIREPOINT] = geoFirePoint.data;
    map[DOC_CREATEDDATE] = createdDate;
    return map;
  }
}
