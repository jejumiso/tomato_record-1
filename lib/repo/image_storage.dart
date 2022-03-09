import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tomato_record/utils/logger.dart';

class ImageStorage {
  static Future<List<String>> uploadImages(
      List<Uint8List> images, String itemKey) async {
    var metaData = SettableMetadata(contentType: 'image/jpeg');

    List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      Reference ref = FirebaseStorage.instance.ref('images/$itemKey/$i.jpg');
      if (images.isNotEmpty) {
        await ref.putData(images[i], metaData).catchError((onError) {
          logger.e(onError.toString());
        });

        downloadUrls.add(await ref.getDownloadURL());
      }
    }

    return downloadUrls;
  }

  static Future<String> uploadUserImage(Uint8List image, String userKey) async {
    var metaData = SettableMetadata(contentType: 'image/jpeg');

    String downloadUrls = "";

    Reference ref = FirebaseStorage.instance.ref('images_user/$userKey/1.jpg');
    if (image.isNotEmpty) {
      await ref.putData(image, metaData).catchError((onError) {
        logger.e(onError.toString());
      });

      downloadUrls = await ref.getDownloadURL();
    }

    return downloadUrls;
  }
}
