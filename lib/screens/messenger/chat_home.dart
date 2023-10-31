import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/components/my_bottom_nav_bar.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/messenger/chat_page.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      // Appbar section
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text(
          'Messenger',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.52,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      // body section
      body: _buildCompanyList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BotHome(),
          //   ),
          // );
        },
        backgroundColor: yellow,
        child: Image.asset(
          'images/bot.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // build a list of companies
  Widget _buildCompanyList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('company')
          .orderBy('c_name')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // return Padding(
          //   padding: const EdgeInsets.only(top: 10.0, left: 10.0),
          //   child: const Text('loading.....'),
          // );
          return Center(
            child: CircularProgressIndicator(
              color: yellow,
              semanticsLabel: 'Loading...',
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildCompanyListItem(doc))
              .toList(),
        );
      },
    );
  }

  // build individual company list item
  Widget _buildCompanyListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Get the first letter of the company's name
    String agentName = data['c_name'];
    String firstLetter = agentName[0].toUpperCase();

    // Define the image container
    Container imageContainer = Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: yellow,
        // color: darkBlue,
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          color: darkBlue,
          // color: Colors.black45,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // Return the entire company list item with image to the left
    return InkWell(
      onTap: () {
        // Navigate to the chat section
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              agentEmail: data['c_email'],
              agentId: data['cid'],
              agentName: data['c_name'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Color(0xFFC1DFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(
            top: 10.0,
            bottom: 0,
            left: 20.0,
            right: 20.0), // Add margin for spacing between agents
        padding: EdgeInsets.all(10), // Add padding inside the container
        child: Row(
          children: [
            // Display the image container to the left
            imageContainer,

            SizedBox(width: 20), // Add spacing between the image and text
            // Display company name & email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['c_name'],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  data['c_email'],
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
