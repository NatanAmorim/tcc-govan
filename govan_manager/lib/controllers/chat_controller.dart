import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChatController {
  final channel = IOWebSocketChannel.connect('ws://10.0.2.2:3337');

  List<String> messages = [];
  final TextEditingController textController = TextEditingController();
}
