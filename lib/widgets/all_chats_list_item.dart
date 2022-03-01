import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/pages/chat_page_only_reading.dart';

class AllChatListItem extends StatelessWidget {
  final MessageModel? messageModel;
  const AllChatListItem({Key? key, @required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPageOnlyReading(
                messageModel: messageModel,
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
                      image:
                          NetworkImage(messageModel!.professionalPhotoUrl!))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profesional: ${messageModel!.professionalName!}',
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Usuario: ${messageModel!.userName!}',
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
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
                      'Categoría ${messageModel!.type!}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
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
          ],
        ),
      ),
    );
  }
}
