import 'package:flutter/material.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tomato_record/data/item_model.dart';
import 'package:tomato_record/repo/item_service.dart';
import 'package:tomato_record/widgets/item_list_widget.dart';

class CallPage extends StatefulWidget {
  final String userKey;
  const CallPage({Key? key, required this.userKey}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool init = false;
  List<ItemModel> items = [];

  @override
  void initState() {
    if (!init) {
      _onRefresh('');
      init = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              Size size = MediaQuery.of(context).size;
              final imgSize = size.width / 4;

              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: (items.isNotEmpty)
                      ? _listView(imgSize)
                      : _shimmerListView(imgSize));
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async => await _onRefresh(''),
                child: Text('랭킹순', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    primary: Colors.white,
                    minimumSize: Size(60, 20))),
            TextButton(
                onPressed: () async => await _onRefresh(''),
                child: Text('접속순', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    primary: Colors.white,
                    minimumSize: Size(60, 20))),
            SizedBox(
              width: 35,
            ),
            TextButton(
                onPressed: () async => await _onRefresh('남자'),
                child: Text('남자', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    primary: Colors.white,
                    minimumSize: Size(60, 10))),
            TextButton(
                onPressed: () async => await _onRefresh('여자'),
                child: Text('여자', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    primary: Colors.white,
                    minimumSize: Size(60, 10))),
            SizedBox(
              width: 5,
            ),
          ],
        )
      ],
    );
  }

  Future _onRefresh(String searchKey) async {
    items.clear();
    items.addAll(await ItemService().getItems(widget.userKey));
    setState(() {});
  }

  Widget _listView(double imgSize) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(''),
      child: ListView.separated(
        padding: EdgeInsets.all(common_padding),
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2 + 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: common_sm_padding,
            endIndent: common_sm_padding,
          );
        },
        itemBuilder: (context, index) {
          ItemModel item = items[index];
          return ItemListWidget(item);
        },
        itemCount: items.length,
      ),
    );
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.all(common_padding),
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2 + 1,
            thickness: 1,
            color: Colors.grey[200],
            indent: common_sm_padding,
            endIndent: common_sm_padding,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: imgSize,
            child: Row(
              children: [
                Container(
                    height: imgSize,
                    width: imgSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    )),
                SizedBox(
                  width: common_sm_padding,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 14,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        height: 12,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        height: 14,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        )),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            )),
                      ],
                    )
                  ],
                ))
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
