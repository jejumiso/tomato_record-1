import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/data/user_model.dart';
import 'package:tomato_record/router/locations.dart';
import 'package:tomato_record/states/user_notifier.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({Key? key}) : super(key: key);

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = context.read<UserNotifier>().userModel;
    return Container(
      color: Colors.amber,
      child: TextButton(
        onPressed: () {
          (context.read<UserNotifier>()).updateAggrement(userModel, true);
          if (true) {
            context.beamToNamed('/$LOCATION_HOME');
          }
        },
        child: Text('약관동의 및 본문으로 이동 ${userModel!.agreement}'),
      ),
    );
  }
}
