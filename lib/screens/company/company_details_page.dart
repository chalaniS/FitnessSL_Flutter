import 'package:fitness/components/my_bottom_nav_bar.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/company/companies_page.dart';
import 'package:fitness/screens/messenger/chat_page.dart';
import 'package:flutter/material.dart';

class CompanyDetailsPage extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String companyEmail;
  final String companyAddress;
  final String companyPhone;
  const CompanyDetailsPage({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.companyEmail,
    required this.companyAddress,
    required this.companyPhone,
  });

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      // Appbar section
      appBar: AppBar(
        backgroundColor: darkBlue,
        // company name
        title: Text(
          widget.companyName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.48,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompaniesPage(),
              ),
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),

      // body section
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            // gym image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/gym.jpg'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),

            SizedBox(height: 50),

            // information section
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // address
                Row(
                  children: [
                    Icon(
                      Icons.business_outlined,
                      color: yellow,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.companyAddress,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // phone
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: yellow,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.companyPhone,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // email
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: yellow,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.companyEmail,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 80),

            // 3 icon buttons section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // events button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 78,
                    width: 78,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.event_note_rounded,
                      color: Colors.black54,
                      size: 42,
                    ),
                  ),
                ),
                // location button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 78,
                    width: 78,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.black54,
                      size: 44,
                    ),
                  ),
                ),
                // messenger button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          agentId: widget.companyId,
                          agentEmail: widget.companyEmail,
                          agentName: widget.companyName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 78,
                    width: 78,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.forum_rounded,
                      color: Colors.black54,
                      size: 42,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
