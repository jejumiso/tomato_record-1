import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Radius chatBorder = Radius.circular(25);

class Chat extends StatelessWidget {
  final Size size;
  const Chat({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExtendedImage.network(
          'https://randomuser.me/api/portraits/women/28.jpg',
          shape: BoxShape.circle,
          width: size.width / 10,
          height: size.width / 10,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: chatBorder,
                    bottomLeft: chatBorder,
                    bottomRight: chatBorder,
                  ),
                  color: Colors.redAccent),
              child: Text(';lkjasldkjf'),
            ),
          ),
        ),
      ],
    );
  }
}