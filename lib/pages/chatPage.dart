
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/components/chat_bubble.dart';
import 'package:temp/components/text_fields.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiveremail;
  final String receiverId;
  ChatPage({
    super.key,
    required this.receiveremail, 
    required this.receiverId
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgcnt = TextEditingController();

  final ChatServices _chatServices = ChatServices();

  final Authentication _authServices = Authentication(); 

  FocusNode myFocusNode = FocusNode();

  void initState(){
    super.initState();

    // add listner to focusnode
    myFocusNode.addListener((){
      // add delay so that keyboard has time to show up
      // then the amount of remaining space in the listview is calculated
      //then scroll to the end of the list 
      if(myFocusNode.hasFocus){
        Future.delayed(
          Duration(milliseconds: 500),
          () => scrolldown(),
        );
      }
    });

    Future.delayed(Duration(milliseconds: 500), () => scrolldown());  
  }


  void dispose(){
    myFocusNode.dispose();
    _msgcnt.dispose();
    super.dispose();
  }

  //  scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrolldown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  // send message
  void sendmsg() async{
    if(_msgcnt.text.isNotEmpty){
      await _chatServices.sendMsg(widget.receiverId, _msgcnt.text);

      // after sending msg clear the textfield
      _msgcnt.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.receiveremail),
      ),
      body: Column(children: [
        // display all the massages
        Expanded(child: _buildmsgList()),

        // textfield to send msg
        _buildmsgSender(context),
      ],)
    );
  }

  Widget _buildmsgList(){
    String senderId = _authServices.getCureUser()!.uid;

    return StreamBuilder(
      stream: _chatServices.getMassaeges(senderId, widget.receiverId), 
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(child: Text('Error loading massages'));
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

        if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return Center(child: Text('No massages found'));
        }

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map<Widget>((msg) => _buildmsgItem(msg)).toList()
        );
      }
    );
  }

  Widget _buildmsgItem(DocumentSnapshot doc) {
    Map<String, dynamic> msg = doc.data() as Map<String, dynamic>;
    bool curUser = msg['senderId'] == _authServices.getCureUser()!.uid;
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