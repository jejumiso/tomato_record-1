import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/talk_model.dart';

class TalkListWidget extends StatefulWidget {
  final TalkModel item;

  TalkListWidget(this.item, {Key? key}) : super(key: key);

  @override
  State<TalkListWidget> createState() => _TalkListWidgetState();
}

class _TalkListWidgetState extends State<TalkListWidget> {
  late double imgSize;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    imgSize = size.width / 5;
    String userbasicImgUrl = "https://randomuser.me/api/portraits/women/11.jpg";
    return InkWell(
      onTap: () {
        // BeamState beamState = Beamer.of(context).currentConfiguration!;
        // String currentPath = beamState.uri.toString();
        // String newPath = (currentPath == '/')? '/$LOCATION_ITEM/${widget.item.itemKey}': '$currentPath/${widget.item.itemKey}';
        // logger.d('newPath - $newPath');
        // context.beamToNamed(newPath);
      },
      child: SizedBox(
        height: imgSize,
        child: Row(
          children: [
            SizedBox(
                height: imgSize,
                width: imgSize,
                child: ExtendedImage.network(
                  widget.item.imgUrl != ""
                      ? widget.item.imgUrl
                      : userbasicImgUrl,
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
            TextButton(onPressed: () {}, child: Text('쪽지')),
            SizedBox(
              width: common_sm_padding,
            ),
            TextButton(onPressed: () {}, child: Text('통화'))
          ],
        ),
      ),
    );
  }
}
