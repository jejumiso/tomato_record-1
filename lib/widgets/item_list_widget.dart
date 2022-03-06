import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:tomato_record/data/item_model.dart';
import 'package:tomato_record/router/locations.dart';
import 'package:tomato_record/utils/logger.dart';

class ItemListWidget extends StatefulWidget {
  final ItemModel item;

  ItemListWidget(this.item, {Key? key}) : super(key: key);

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  late double imgSize;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    imgSize = size.width / 4;

    return InkWell(
      onTap: () {
        BeamState beamState = Beamer.of(context).currentConfiguration!;
        String currentPath = beamState.uri.toString();
        String newPath = (currentPath == '/')
            ? '/$LOCATION_ITEM/${widget.item.itemKey}'
            : '$currentPath/${widget.item.itemKey}';

        logger.d('newPath - $newPath');
        context.beamToNamed(newPath);
      },
      child: SizedBox(
        height: imgSize,
        child: Row(
          children: [
            SizedBox(
                height: imgSize,
                width: imgSize,
                child: ExtendedImage.network(
                  widget.item.imageDownloadUrls[0],
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
                  widget.item.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  '53일전',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text('${widget.item.price.toString()}원'),
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
                              '23',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              CupertinoIcons.heart,
                              color: Colors.grey,
                            ),
                            Text(
                              '30',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
