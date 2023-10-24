import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';
import 'loginPage.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  Map<String, dynamic> userData = {};
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = _auth.currentUser;
    final String? userId = user?.uid;

    DatabaseEvent snapshot =
        await _database.child('users').child(userId!).once();

    Map<dynamic, dynamic>? snapshotValue =
        snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (snapshotValue != null) {
      setState(() {
        userData = Map<String, dynamic>.from(snapshotValue);

        profileImageUrl = userData['profileImageUrl'];
      });
    }
  }

  Future<String?> _fetchNIC() async {
    final User? user = _auth.currentUser;
    final String? userId = user?.uid;

    DatabaseEvent snapshot =
        await _database.child('users').child(userId!).child('nic').once();

    return snapshot.snapshot.value as String?;
  }

  Future<String?> _fetchEmail() async {
    final User? user = _auth.currentUser;
    final String? userId = user?.uid;

    DatabaseEvent snapshot =
        await _database.child('users').child(userId!).child('email').once();

    return snapshot.snapshot.value as String?;
  }

  Future<void> _deleteProfileAndLogout() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final bool? deleteConfirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (deleteConfirmed == true) {
        try {
          await _database.child('users').child(user.uid).remove();
          await user.delete();
          await _auth.signOut();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyLogin(),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting profile: $e'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(
            left: 60,
          ),
          child: Text(
            "Personal Data",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: NetworkImage(profileImageUrl!),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    Card(
                      color: Colors.grey,
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: FutureBuilder<String?>(
                          future: _fetchNIC(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                'Full Name Loading...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            } else if (snapshot.hasError || !snapshot.hasData) {
                              return const Text(
                                'Name Error',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Text(
                                ' ${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    Card(
                      color: Colors.grey,
                      margin: const EdgeInsets.only(
                        top: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: FutureBuilder<String?>(
                          future: _fetchEmail(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                'Email address Loading...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            } else if (snapshot.hasError || !snapshot.hasData) {
                              return const Text(
                                'Email address: Error',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            } else {
                              return Text(
                                '${snapshot.data}',
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        Text(
                          "65kg",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Weight",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        Text(
                          "160cm",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Height",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 5,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        Text(
                          "20yo",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Age",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _deleteProfileAndLogout,
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 17, 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(userData: userData),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 225, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 55,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
