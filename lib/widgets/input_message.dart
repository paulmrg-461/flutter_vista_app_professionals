import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:professional_grupo_vista_app/models/message_model.dart';
import 'package:professional_grupo_vista_app/models/professional_model.dart';
import 'package:professional_grupo_vista_app/providers/messages_provider.dart';
import 'package:record/record.dart';

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
  Record record = Record();
  bool _isLoading = false;
  bool _isWriting = false;
  bool _isChoosing = false;
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    MessagesProvider.updateSeenMessage(
        widget.messageModel!.userEmail!, widget.professionalModel!.email!);
    return SafeArea(
        child: _isChoosing
            ? Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20, top: 8),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.75),
                          offset: const Offset(5, 7),
                          blurRadius: 20.0)
                    ],
                    color: const Color(0xff312923),
                    borderRadius: BorderRadius.circular(22)),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      setState(() => _isChoosing = false),
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Cancelar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _takePicture('Imagen tomada'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Cámara',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _uploadAttachment(['jpg'], 'Imagen'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.photoVideo,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Galería',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => _uploadAttachment(
                                      ['pdf', 'doc'], 'Documento'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.file,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Documento',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: _isRecording ? 2 : 10),
                                child: GestureDetector(
                                    onLongPress: () => _recordAudio(),
                                    onLongPressUp: () =>
                                        _stopRecording('Audio'),
                                    child: FaIcon(
                                      FontAwesomeIcons.microphone,
                                      color: _isRecording
                                          ? Colors.red
                                          : Colors.white70,
                                      size: _isRecording ? 54 : 34,
                                    )),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(_isRecording ? 'Grabando' : 'Grabar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: const Color(0xff312923),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 5),
                          blurRadius: 5)
                    ]),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20, top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: IconTheme(
                        data: const IconThemeData(color: Colors.white),
                        child: IconButton(
                            icon: Icon(
                              Icons.attachment_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () =>
                                setState(() => _isChoosing = true)),
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
                                    ? () => _handleSubmit(
                                        _textController.text.trim())
                                    : null)
                            : IconTheme(
                                data: const IconThemeData(
                                    color: Color(0xffD6BA5E)),
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
                                        ? () => _handleSubmit(
                                            _textController.text.trim())
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

    MessageModel messageModel = _createMessageModel(text, '');
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

  Future<void> _uploadAttachment(List<String> fileTypes, String message) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: fileTypes,
    );

    setState(() => _isLoading = true);

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileExtension = result.files.single.extension!;

      final String downloadUrl = await MessagesProvider.uploadFile(file,
          'messages/${widget.professionalModel!.email}/${DateTime.now()}.$fileExtension');

      MessageModel messageModel = _createMessageModel(message, downloadUrl);
      MessagesProvider.sendNewMessage(messageModel);
      setState(() {
        _isLoading = false;
        _isChoosing = false;
      });
    } else {
      // User canceled the picker
      setState(() {
        _isChoosing = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _takePicture(String message) async {
    setState(() => _isLoading = true);
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedImage = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 75,
          maxWidth: 1280,
          maxHeight: 720);
      File file = File(pickedImage!.path);
      final String downloadUrl = await MessagesProvider.uploadFile(file,
          'messages/${widget.professionalModel!.email}/${DateTime.now()}.jpg');

      MessageModel messageModel = _createMessageModel(message, downloadUrl);
      MessagesProvider.sendNewMessage(messageModel);
      setState(() {
        _isLoading = false;
        _isChoosing = false;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> _recordAudio() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    bool result = await record.hasPermission();

    if (result) {
      setState(() => _isRecording = true);
      await record.start(
        path: '$tempPath/myFile.m4a', // required
        encoder: AudioEncoder.AAC, // by default
        bitRate: 128000, // by default
      );
    } else
      setState(() => _isRecording = true);
  }

  Future<void> _stopRecording(String message) async {
    setState(() => _isLoading = true);
    if (_isRecording) {
      final String? path = await record.stop();
      File file = File(path!);
      final String downloadUrl = await MessagesProvider.uploadFile(file,
          'messages/${widget.professionalModel!.email}/${DateTime.now()}.m4a');

      MessageModel messageModel = _createMessageModel(message, downloadUrl);
      MessagesProvider.sendNewMessage(messageModel);
      setState(() {
        _isRecording = false;
        _isLoading = false;
      });
    }
  }

  MessageModel _createMessageModel(String message, String downloadUrl) =>
      MessageModel(
          userName: widget.messageModel!.userName,
          professionalName: widget.messageModel!.professionalName,
          userEmail: widget.messageModel!.userEmail,
          professionalEmail: widget.messageModel!.professionalEmail,
          userPhotoUrl: widget.messageModel!.userPhotoUrl,
          professionalPhotoUrl: widget.messageModel!.professionalPhotoUrl,
          message: message,
          downloadUrl: downloadUrl,
          isProfessional: true,
          seen: false,
          type: widget.messageModel!.type,
          senderId: widget.professionalModel!.email,
          date: DateTime.now(),
          receiverId: widget.messageModel!.userEmail);

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }
}
