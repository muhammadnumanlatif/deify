import 'dart:convert';

Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));

String chatsToJson(Chats data) => json.encode(data.toJson());

class Chats {
  Chats({
    this.connections,
    this.totalChats,
    this.totalRead,
    this.totalUnread,
    this.chat,
    this.lastTime,
  });

  List<String>? connections;
  int? totalRead;
  int? totalUnread;
  int? totalChats;
  List<ChatClient>? chat;
  String? lastTime;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
    connections: List<String>.from(json["connections"].map((x) => x)),
    totalChats: json["total_chats"],
    totalRead:json["total_read"],
    totalUnread: json["total_unread"],
    chat: List<ChatClient>.from(json["chat"].map((x) => ChatClient.fromJson(x))),
    lastTime: json["lastTime"],
  );

  Map<String, dynamic> toJson() => {
    "connections": List<dynamic>.from(connections!.map((x) => x)),
    "total_chats": totalChats,
    "total_read": totalRead,
    "total_unread": totalUnread,
    "chat": List<dynamic>.from(chat!.map((x) => x.toJson())),
    "lastTime": lastTime,
  };
}

class ChatClient {
  ChatClient({
    this.sender,
    this.receiver,
    this.message,
    this.time,
    this.isRead,
  });

  String? sender;
  String? receiver;
  String? message;
  String? time;
  bool? isRead;

  factory ChatClient.fromJson(Map<String, dynamic> json) => ChatClient(
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    time: json["time"],
    isRead: json["isRead"],
  );

  Map<String, dynamic> toJson() => {
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "time": time,
    "isRead": isRead,
  };
}
