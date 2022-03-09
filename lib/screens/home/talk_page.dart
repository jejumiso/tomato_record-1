import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomato_record/constants/common_size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tomato_record/data/item_model.dart';
import 'package:tomato_record/data/talk_model.dart';
import 'package:tomato_record/repo/item_service.dart';
import 'package:tomato_record/repo/talk_service.dart';
import 'package:tomato_record/widgets/talk_list_widget.dart';

class TalkPage extends StatefulWidget {
  final String userKey;
  const TalkPage({Key? key, required this.userKey}) : super(key: key);

  @override
  State<TalkPage> createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  bool init = false;
  List<TalkModel> items = [];

  @override
  void initState() {
    if (!init) {
      _onRefresh();
      init = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                Size size = MediaQuery.of(context).size;
                final imgSize = size.width / 4;

                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    child: (items.isNotEmpty)
                        ? _listView(imgSize)
                        : _shimmerListView(imgSize));
              },
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async => await _onRefresh2(''),
                  child: Text('전체', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () async => await _onRefresh2('사진'),
                  child: Text('사진', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () async => await _onRefresh2('동네'),
                  child: Text('동네', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('근처', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('내토크', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () => GoRouter.of(context).push('/talkwright'),
                  child: Text('토크쓰기', style: TextStyle(fontSize: 12)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.amber,
                      primary: Colors.white,
                      minimumSize: Size(20, 20))),
              SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );
  }

  Future _onRefresh() async {
    items.clear();
    items.addAll(await TalkService().getItems(0));
    setState(() {});
  }

  Future _onRefresh2(String area) async {
    items.clear();
    if (area != "사진") {
      items.addAll(await TalkService().getItems(0));
    }
    setState(() {});
  }

  Widget _listView(double imgSize) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
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
          TalkModel item = items[index];
          return TalkListWidget(item);
        },
        itemCount: items.length,
      ),
    );
  }

  Widget _shimmerListView(double imgSize) {
    return SafeArea(
      child: Shimmer.fromColors(
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
      ),
    );
  }
}
