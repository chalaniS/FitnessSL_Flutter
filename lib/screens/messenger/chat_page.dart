import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/messenger/chat_home.dart';
import 'package:fitness/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String agentEmail;
  final String agentId;
  final String agentName;
  const ChatPage({
    super.key,
    required this.agentEmail,
    required this.agentId,
    required this.agentName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if there's something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.agentId, _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the first letter of the agent's name
    String agentName = widget.agentName;
    String firstLetter = agentName[0].toUpperCase();

    // Define the image container
    Container imageContainer = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // image container color
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatHome(),
              ),
            );
          },
        ),
        // title: Row(
        //   children: [
        //     // imageContainer,
        //     // SizedBox(width: 15),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           widget.agentName,
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24.0,
        //             fontWeight: FontWeight.w500,
        //             letterSpacing: -0.48,
        //           ),
        //         ),
        //         // Row(
        //         //   children: [
        //         //     Icon(
        //         //       Icons.circle,
        //         //       color: Colors.green,
        //         //       size: 10,
        //         //     ),
        //         //     SizedBox(width: 5),
        //         //     Text(
        //         //       'Online',
        //         //       style: TextStyle(
        //         //         color: Color(0XFF323232),
        //         //         fontSize: 12,
        //         //       ),
        //         //     ),
        //         //   ],
        //         // )
        //       ],
        //     )
        //   ],
        // ),
        title: Text(
          widget.agentName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.48,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF323232)),
        elevation: 0,
      ),
      body: Container(
        color: darkBlue,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(30),
        //     topRight: Radius.circular(30),
        //   ),
        // ),
        child: Column(
          children: [
            // messages
            Expanded(
              child: _buildMessageList(),
            ),

            // user input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.agentId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // return const Text('Loading....');
          return Center(
            child: CircularProgressIndicator(
              color: yellow,
              semanticsLabel: 'Loading...',
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Extract the timestamp from the message data
    Timestamp timestamp = data['timestamp'] as Timestamp;

    // Convert the timestamp to a DateTime object
    DateTime messageTime = timestamp.toDate();

    // Format the DateTime to display date, time in hours and minutes, and AM/PM
    String formattedDateTime =
        DateFormat('yyyy-MM-dd | hh:mm a').format(messageTime);

    // Determine if the message was sent by the current user
    bool isSentMessage = (data['senderId'] == _firebaseAuth.currentUser!.uid);

    // Define colors for sent and received messages
    Color sentMessageColor = Color(0xFFC1DFFF);
    Color receivedMessageColor = Color(0xFFFBB731);

    // Determine the background color for the message container
    Color messageBackgroundColor =
        isSentMessage ? sentMessageColor : receivedMessageColor;

    return Container(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment:
              isSentMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              formattedDateTime,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: messageBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft:
                      isSentMessage ? Radius.circular(20) : Radius.circular(0),
                  bottomRight:
                      isSentMessage ? Radius.circular(0) : Radius.circular(20),
                ),
              ),
              // child: ChatBubble(message: data['message']),
            ),
          ],
        ),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 20.0, right: 20.0, left: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type your message here...",
                    hintStyle: TextStyle(color: Color(0xFF5C5C5C)),
                  ),
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send),
                iconSize: 28,
                color: Color.fromARGB(255, 97, 95, 95),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
