import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_record/constants/shared_pref_keys.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/repo/user_service.dart';
import 'package:tomato_record/utils/logger.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier() {
    initUser();
  }

  User? _user;
  UserModel? _userModel;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null && _userModel == null) {
        await _createNewUser(user);
      } else if (user != null && _userModel != null) {
        //update
      } else {
        // if (user == null) {
        _user = null;
        _userModel = null;
      }
      notifyListeners();
    });
  }

  Future _createNewUser(User? user) async {
    _user = user;
    if (user != null && user.phoneNumber != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber!;
      String userKey = user.uid;

      UserModel userModel = UserModel(
          userKey: "",
          phoneNumber: phoneNumber,
          company: "mcvc",
          address: address,
          agreement: false,
          geoFirePoint: GeoFirePoint(lat, lon),
          imgUrl: "",
          allowTheUseImgUrl: false,
          imgUrl2: "",
          allowTheUseImgUrl2: false,
          nickname: "",
          gender: "M", //M=남자, F=  여자
          age: 30,
          state: "Online",
          isBackgroundReceive: false,
          createdDate: DateTime.now().toUtc());

      await UserService().createNewUser(userModel.toJson(), userKey);
      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson().toString());
    }
  }

  Future updateAggrement(String userKey, bool isAgreement) async {
    await UserService().updateAggrement(userKey, isAgreement);
    _userModel!.agreement = isAgreement;
    notifyListeners();
  }

  Future updateProfile(String userKey, bool isAgreement) async {
    // await UserService().updateAggrement(userKey, isAgreement);
    // _userModel!.agreement = isAgreement;
    notifyListeners();
  }

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool islogin() => _user != null;
  bool isaggrement() => _userModel != null && _userModel!.agreement;
}
