
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/components/chat_bubble.dart';
import 'package:temp/components/text_fields.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({
    super.key,
    required this.receiverEmail, 
    required this.receiverId
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgcnt = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final Authentication _authServices = Authentication();
  final ScrollController _scrollController = ScrollController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listener to focusNode to scroll down when keyboard opens
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrolldown());
      }
    });

    // Scroll down when the page is loaded
    Future.delayed(Duration(milliseconds: 500), () => scrolldown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _msgcnt.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrolldown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void sendmsg() async {
    if (_msgcnt.text.isNotEmpty) {
      await _chatServices.sendMsg(widget.receiverId, _msgcnt.text);
      _msgcnt.clear();
    }
    scrolldown(); // Ensure scrolling after sending message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.receiverEmail),
      ),
      body: Column(children: [
        // display all the massages
        Expanded(child: _buildmsgList()),

        // textfield to send msg
        _buildmsgSender(context),
      ],)
    );
  }

  Widget _buildmsgList() {
    String senderId = _authServices.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatServices.getMessages(senderId, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error loading messages'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No messages found'));
        }

        // Scroll to the bottom when messages are updated
        WidgetsBinding.instance.addPostFrameCallback((_) => scrolldown());

        return ListView.builder(
          reverse: false, // Shows latest messages at the bottom
          controller: _scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildmsgItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  Widget _buildmsgItem(DocumentSnapshot doc) {
    Map<String, dynamic> msg = doc.data() as Map<String, dynamic>;
    bool curUser = msg['senderId'] == _authServices.getCurrentUser()!.uid;
    var alignment = curUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        isCurrentUser: curUser,
        message: msg['msg'],
        timestamp: msg.containsKey('time')
            ? formatTimestamp(msg['time'])
            : null,
      ),
    );
    // msg['msg]  because msg is a map and we want to get the value of key 'msg'

    /*
    Massage newmsg = Massage(
        senderId: curUserId,
        senderEmail: curUserEmail,
        receiverId: receiverId,
        msg: msg,
        time: time);
     */ 
  }

  String formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('hh:mm a').format(dateTime); // Example: "10:45 PM"
    }
    return "";
  }    
  

  Widget _buildmsgSender(context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFields(hinttxt: 'Message...', controller: _msgcnt, focusNode: myFocusNode,),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary
            ),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.white,
              onPressed: sendmsg,
            ),
          )
        ],
      ),
    );
  }
}
