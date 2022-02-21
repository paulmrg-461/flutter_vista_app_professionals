import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String? text;
  final bool? isProfessional;
  final String? date;
  const ChatMessage(
      {Key? key,
      @required this.text,
      @required this.isProfessional,
      @required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isProfessional! ? _myMessage() : _notMyChatMessage(),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:
            const EdgeInsets.only(right: 22.0, left: 48, top: 2.0, bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color(0xff997124),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              date!,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notMyChatMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:
            const EdgeInsets.only(right: 48.0, left: 22, top: 2.0, bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color(0xff312923),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            )),
        child: Text(
          text!,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
