import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';

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
        onTap: () => print('mira mama me aplastaron'),
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ChatPage(
        //         title: title,
        //         icon: icon,
        //         receiverEmail: 'nestor.botina@grupovista.co',
        //         userModel: professionalModel,
        //       ),
        //     )),
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
                      image: NetworkImage(messageModel!.photoUrl!))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageModel!.title!,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        messageModel!.body!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      '${messageModel!.date!}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            messageModel!.seen!
                ? Container()
                : Container(
                    width: 30,
                    height: 30,
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
