import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroPage3Permission extends StatefulWidget {
  IntroPage3Permission({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroPage3Permission> createState() => _IntroPage3PermissionState();
}

Future<bool> _requestPermission() async {
  //여러개
  Map<Permission, PermissionStatus> statues =
      await [Permission.storage, Permission.camera, Permission.sms].request();

  print(statues[Permission.storage]);

  if (statues[Permission.storage] == PermissionStatus.granted &&
      statues[Permission.camera] == PermissionStatus.granted &&
      statues[Permission.sms] == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

class _IntroPage3PermissionState extends State<IntroPage3Permission> {
  bool _storagePermission = false;
  bool _cameraPermission = false;
  bool _photosPermission = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Size size = MediaQuery.of(context).size;

        // final imgSize = size.width - 32;
        // final sizeOfPosImg = imgSize * 0.1;

        _checkPermission() async {
          _storagePermission = await Permission.storage.status.isGranted;
          _cameraPermission = await Permission.camera.status.isGranted;
          _photosPermission = await Permission.photos.status.isGranted;
          return true;
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: common_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '토마토마켓',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  '스토리지 - $_storagePermission',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  '카메라 - $_cameraPermission',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  '포토 - $_photosPermission',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _checkPermission();
                      setState(() {});
                    },
                    child: Text("권한확인")),
                ElevatedButton(
                    onPressed: () async {
                      var result = await _requestPermission();
                      if (result) {
                        context.read<PageController>().animateToPage(3,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      }
                    },
                    child: Text("권한요청"))
              ],
            ),
          ),
        );
      },
    );
  }
}
