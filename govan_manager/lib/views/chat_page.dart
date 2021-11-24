import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:govan/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.username,
  }) : super(key: key);
  final String username;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = ChatController();

  @override
  void initState() {
    super.initState();
    controller.channel.sink.add('Conectado!');
  }

  @override
  void dispose() {
    controller.channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    if (controller.textController.text.isNotEmpty) {
      controller.channel.sink
          .add(widget.username + ': ' + controller.textController.text);
      controller.textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE7E7E7),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height - 140,
              child: StreamBuilder(
                stream: controller.channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    controller.messages.add('${snapshot.data}');
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var message in controller.messages)
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.00),
                                  child: Text(
                                    message,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: TextField(
                      controller: controller.textController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        hintText: 'Escreva algo',
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
