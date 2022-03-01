import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/providers/messages_provider.dart';

class InputMessage extends StatefulWidget {
  final ProfessionalModel? professionalModel;
  final MessageModel? messageModel;
  const InputMessage({
    Key? key,
    @required this.professionalModel,
    @required this.messageModel,
  }) : super(key: key);

  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage>
    with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    MessagesProvider.updateSeenMessage(
        widget.messageModel!.userEmail!, widget.professionalModel!.email!);
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          color: const Color(0xff312923),
          borderRadius: BorderRadius.circular(36),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      margin:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: IconButton(
                  icon: Icon(
                    Icons.attachment_rounded,
                    color: _isWriting
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 28,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _isWriting
                      ? () => _handleSubmit(_textController.text.trim())
                      : null),
            ),
          ),
          Flexible(
              child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            controller: _textController,
            onSubmitted: _handleSubmit,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String text) {
              setState(() {
                _isWriting = (text.trim().isNotEmpty) ? true : false;
              });
            },
            decoration: const InputDecoration.collapsed(
                hintText: 'Enviar mensaje...',
                hintStyle: TextStyle(color: Colors.white54)),
            focusNode: _focusNode,
          )),

          //Send button
          Container(
              margin: const EdgeInsets.only(left: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Enviar'),
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null)
                  : IconTheme(
                      data: const IconThemeData(color: Color(0xffD6BA5E)),
                      child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: _isWriting
                                ? const Color(0xffD6BA5E)
                                : Colors.white.withOpacity(0.3),
                            size: 26,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    MessageModel messageModel = MessageModel(
        userName: widget.messageModel!.userName,
        professionalName: widget.messageModel!.professionalName,
        userEmail: widget.messageModel!.userEmail,
        professionalEmail: widget.messageModel!.professionalEmail,
        userPhotoUrl: widget.messageModel!.userPhotoUrl,
        professionalPhotoUrl: widget.messageModel!.professionalPhotoUrl,
        message: text,
        isProfessional: true,
        seen: false,
        type: widget.messageModel!.type,
        senderId: widget.professionalModel!.email,
        date: DateTime.now(),
        receiverId: widget.messageModel!.userEmail);
    MessagesProvider.sendNewMessage(messageModel);

    MessagesProvider.updateSeenMessage(
        widget.messageModel!.userEmail!, widget.professionalModel!.email!);
    // final newMessage = ChatMessage(
    //   uid: '123',
    //   text: text,
    //   animationController: AnimationController(
    //       vsync: this, duration: const Duration(milliseconds: 300)),
    // );
    // _messages.insert(0, newMessage);
    // newMessage.animationController!.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
