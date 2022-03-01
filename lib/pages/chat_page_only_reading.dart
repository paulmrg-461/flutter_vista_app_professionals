import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/providers/messages_provider.dart';
import 'package:professional_grupo_vista_app/widgets/chat_message.dart';

class ChatPageOnlyReading extends StatefulWidget {
  final MessageModel? messageModel;
  const ChatPageOnlyReading({
    Key? key,
    @required this.messageModel,
  }) : super(key: key);

  @override
  _ChatPagOnlyReadingState createState() => _ChatPagOnlyReadingState();
}

class _ChatPagOnlyReadingState extends State<ChatPageOnlyReading>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Column(
          children: [
            _myAppBar(),
            Flexible(
              child: StreamBuilder<QuerySnapshot<MessageModel>>(
                stream:
                    MessagesProvider.getChatroomMessages(widget.messageModel!),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<MessageModel>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(22)),
                        child: const Text(
                            'Ha ocurrido un error al cargar los mensajes. Por favor intenta nuevamente.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffD6BA5E),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    final List<ChatMessage> messagesList = snapshot.data!.docs
                        .map((DocumentSnapshot<MessageModel> document) {
                      MessageModel msg = document.data()!;
                      return ChatMessage(
                          text: msg.message,
                          isProfessional: msg.isProfessional,
                          date:
                              '${msg.date!.day.toString().padLeft(2, '0')}/${msg.date!.month.toString().padLeft(2, '0')}/${msg.date!.year.toString()} - ${msg.date!.hour.toString().padLeft(2, '0')}:${msg.date!.minute.toString().padLeft(2, '0')}');
                    }).toList();

                    if (messagesList.isEmpty) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 36),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(22)),
                        child:
                            const Text('No hay mensajes disponibles este chat.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    // letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400)),
                      );
                    } else {
                      print(messagesList);
                      return ListView(
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          children: messagesList);
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffD6BA5E),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _myAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              )),
          Container(
            width: 55,
            height: 55,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                color: const Color(0xffD6BA5E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.messageModel!.userPhotoUrl!))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.messageModel!.userName!,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        widget.messageModel!.userEmail!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.8),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Activo ahora',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () => print("More"),
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
    );
  }
}
