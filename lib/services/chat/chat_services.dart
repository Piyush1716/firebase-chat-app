import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:temp/moduls/massage.dart';
import 'package:temp/services/auth/auth_services.dart';

class ChatServices {
  // instance of firestore, authenticaion
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Authentication _auth = Authentication();
  // get user stream

  /*
  <List<Map<String,dynamic>>
  means a list of maps where each map has a key of type string and value of type dynamic
      string  : dynamic
  [
    { 'email' : test@gmail.com
      'id : ....
    },

    { 'email' : user1@gmail.com
      'id : ....
    }
  ]
  */ 

  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection('users').snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return doc.data();
      }).toList();
    });

  }

  // send msg
  Future<void> sendMsg(String receiverId, msg) async{
    // get cur user
    final curUserId = _auth.getCurrentUser()!.uid;
    final curUserEmail = _auth.getCurrentUser()!.email!;
    final Timestamp time = Timestamp.now();

    // create new msg
    Massage newmsg = Massage(
        senderId: curUserId,
        senderEmail: curUserEmail,
        receiverId: receiverId,
        msg: msg,
        time: time);

    // create chatroom for 2 users to make uniqueness
    List<String> users = [curUserId, receiverId];
    users.sort(); // sort to make it unique and both user will have same roomId
    String roomId = users.join('_');   // to make list to back to string

    // add msg to database
    await _firestore.collection('chats').doc(roomId).collection('massages').add(newmsg.toMap());

  }

  // get msgs
  Stream<QuerySnapshot> getMessages(String curUserId, otherUserId){
    List<String> users = [curUserId, otherUserId];
    users.sort();
    String roomId = users.join('_');

    return _firestore.collection('chats').doc(roomId).collection('massages').orderBy('time', descending: false).snapshots();
  }

}