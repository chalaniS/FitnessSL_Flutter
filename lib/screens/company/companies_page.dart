import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../components/my_bottom_nav_bar.dart';
import '../../constants.dart';
import 'company_details_page.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      // Appbar section
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text(
          'Gyms in Sri Lanka',
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
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // build a list of companies (in alphabetical order)
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
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          // color: Colors.white,
          color: Colors.black54,
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
            builder: (context) => CompanyDetailsPage(
              companyId: data['cid'],
              companyName: data['c_name'],
              companyEmail: data['c_email'],
              companyAddress: data['c_address'],
              companyPhone: data['c_contactNo'],
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
                  data['c_address'],
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
