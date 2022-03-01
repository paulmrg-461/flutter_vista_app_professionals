import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/pages/chat_page.dart';

class ChatListItem extends StatelessWidget {
  final MessageModel? messageModel;
  final ProfessionalModel? professionalModel;
  const ChatListItem(
      {Key? key, @required this.messageModel, @required this.professionalModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                messageModel: messageModel,
                professionalModel: professionalModel,
              ),
            )),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  color: const Color(0xffD6BA5E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(messageModel!.userPhotoUrl!))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageModel!.userName!,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        messageModel!.message!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      '${messageModel!.date!.day.toString().padLeft(2, '0')}/${messageModel!.date!.month.toString().padLeft(2, '0')}/${messageModel!.date!.year.toString()} - ${messageModel!.date!.hour.toString().padLeft(2, '0')}:${messageModel!.date!.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            (messageModel!.receiverId != professionalModel!.email &&
                    !messageModel!.seen!)
                ? Container()
                : Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Color(0xffD6BA5E),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                        child: Text(
                      '1',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}
