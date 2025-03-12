import 'package:cloud_firestore/cloud_firestore.dart';

class Massage{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String msg;
  final Timestamp time;

  Massage({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.msg,
    required this.time
  });

  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'msg': msg,
      'time': time
    };
  }

}