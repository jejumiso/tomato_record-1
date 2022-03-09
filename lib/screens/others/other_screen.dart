import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width / 4;
    _width = _width - (5 + 2) * 2; //margin+borer *2
    return SafeArea(
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: _width,
                    height: _width,
                    margin: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: InkWell(
                      onTap: () => GoRouter.of(context).push('/pointCharge'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money),
                          Text('충전하기',
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                        ],
                      ),
                    )),
                  ),
                  Container(
                    width: _width,
                    height: _width,
                    margin: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: InkWell(
                      onTap: () => GoRouter.of(context).push('/profile'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.money),
                          Text('프로필',
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                        ],
                      ),
                    )),
                  ),
                  Container(
                    width: _width,
                    height: _width,
                    margin: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money),
                        Text('이용안내',
                            style: TextStyle(
                              color: Colors.black54,
                            )),
                      ],
                    )),
                  ),
                  Container(
                    width: _width,
                    height: _width,
                    margin: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money),
                        Text('불법경로',
                            style: TextStyle(
                              color: Colors.black54,
                            )),
                      ],
                    )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('CYBER1388 청소년상담센터'),
              SizedBox(height: 10),
              Text('관리자에게 쪽지 보내기'),
              TextButton(
                  onPressed: () async => await FirebaseAuth.instance.signOut(),
                  child: Text('로그아웃'))
            ],
          ),
        ),
      ),
    );
  }
}
