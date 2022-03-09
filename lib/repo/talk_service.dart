import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tomato_record/constants/data_keys.dart';
import 'package:tomato_record/data/talk_model.dart';

class TalkService {
  static final TalkService _itemService = TalkService._internal();
  factory TalkService() => _itemService;
  TalkService._internal();

  Future createNewTalk(
      TalkModel talkModel, String talkKey, String userKey) async {
    DocumentReference<Map<String, dynamic>> itemDocReference =
        FirebaseFirestore.instance.collection(COL_TALKS).doc(talkKey);

    DocumentReference<Map<String, dynamic>> userItemDocReference =
        FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(COL_USER_TALKS)
            .doc(talkKey);
    final DocumentSnapshot documentSnapshot = await itemDocReference.get();

    if (!documentSnapshot.exists) {
      // await itemDocReference.set(talkModel.toJson());
      // await userItemDocReference.set(talkModel.toMinJson());

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(itemDocReference, talkModel.toJson());
        transaction.set(userItemDocReference, talkModel.toMinJson());
      });
    }
  }

  Future<List<TalkModel>> getItems(int page) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(COL_TALKS);
    QuerySnapshot<Map<String, dynamic>> snapshots =
        await collectionReference.limit((page + 1) * 10).get();

    List<TalkModel> items = [];

    for (int i = 0; i < snapshots.size; i++) {
      TalkModel talkModel = TalkModel.fromQuerySnapshot(snapshots.docs[i]);
      items.add(talkModel);
    }

    return items;
  }
}
