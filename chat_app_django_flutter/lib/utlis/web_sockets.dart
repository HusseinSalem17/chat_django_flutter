import 'dart:io';
import 'package:chat_app_django_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  late WebSocketChannel _channel;

  WebSocketManager(TokenData? tokens) {
    debugPrint(
        "Connecting to ws://10.0.2.2:8000/chat/?token=${tokens!.accessToken}&origin=ori://127.0.0.1");
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse("ws://10.0.2.2:8000/chat/?token=${tokens.accessToken}"),
      );
      _channel.stream.listen((event) {
        debugPrint("Received message: $event");
      });
    } catch (e) {
      debugPrint('Failed to connect: $e');
    }
  }

  void send(String message) {
    debugPrint("Sending message: $message");
    _channel.sink.add(message);
  }

  void sendThumbnail(File thumbnail) {
    try {
      if (thumbnail.existsSync()) {
        // Read thumbnail file as bytes
        List<int> bytes = thumbnail.readAsBytesSync();
        // Send bytes over WebSocket
        _channel.sink.add(bytes);
        debugPrint("Thumbnail sent");
      } else {
        debugPrint("Thumbnail file not found");
      }
    } catch (e) {
      debugPrint("Failed to send thumbnail: $e");
    }
  }

  Stream<dynamic> getStream() {
    debugPrint("Getting stream");
    return _channel.stream;
  }

  void close() {
    debugPrint("Closing connection");
    _channel.sink.close();
  }
}
