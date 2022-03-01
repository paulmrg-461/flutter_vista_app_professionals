import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/providers/messages_provider.dart';
import 'package:professional_grupo_vista_app/widgets/all_chats_list_item.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 2),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            tooltip: 'Regresar',
                            icon: Icon(
                              Icons.arrow_back,
                              size: 36,
                              color: Colors.white,
                            )),
                      ),
                      const Text(
                        'Historial',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.message_outlined,
                    size: 34,
                    color: Color(0xffD6BA5E),
                  ),
                ],
              ),
              const SizedBox(
                height: 22.0,
              ),
              FutureBuilder<Iterable<Stream<QuerySnapshot<MessageModel>>>>(
                future: MessagesProvider.getAllLastMessages(),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.hasError) {
                    return const Scaffold(
                      body: Center(
                        child: Text(
                          'Ha ocurrido un error al cargar datos, por favor intente nuevamente.',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  }
                  if (futureSnapshot.hasData) {
                    final Iterable<Stream<QuerySnapshot<MessageModel>>>
                        streamList = futureSnapshot.data
                            as Iterable<Stream<QuerySnapshot<MessageModel>>>;
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            children: streamList
                                .map(
                                  (stream) => StreamBuilder<
                                      QuerySnapshot<MessageModel>>(
                                    stream: stream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                QuerySnapshot<MessageModel>>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 22),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: Colors.white10,
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            child: const Text(
                                                'Ha ocurrido un error al cargar las solicitudes de servicio. Por favor intenta nuevamente.',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    // letterSpacing: 0.4,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        );
                                      }

                                      if (snapshot.hasData) {
                                        final List<AllChatListItem>
                                            messagesList =
                                            snapshot.data!.docs.map(
                                                (DocumentSnapshot<MessageModel>
                                                    document) {
                                          MessageModel messageModel =
                                              document.data()!;
                                          return AllChatListItem(
                                            messageModel: messageModel,
                                          );
                                        }).toList();

                                        if (messagesList.isEmpty) {
                                          return Container();
                                        } else {
                                          return SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Column(
                                                  children: messagesList));
                                        }
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xffD6BA5E),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
