import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../Dimension/height_width.dart';
import '../../../TextField/text_box.dart';
import '../../../Widgets/large_font.dart';
import '../food_page.dart';
import 'drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double avatarRadius = Dimensions.heightFor160;
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      avatarRadius =
          isExpanded ? Dimensions.screenWidth / 1.2 : Dimensions.heightFor160;
    });
  }

  String email = '';
  String fName = '';
  String lName = '';
  String pass = '';
  int contact = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('Email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userSnapshot = querySnapshot.docs.first;
          setState(() {
            email = userSnapshot['Email'];
            fName = userSnapshot['First Name'];
            lName = userSnapshot['Last Name'];
            pass = userSnapshot['Password'];
            contact = userSnapshot['Phone Number'];
          });
        } else {
          print('User document not found in Firestore');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User is not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFe8e8e8),
        centerTitle: true,
        title: TextSize(
          text: 'Profile',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          size: Dimensions.font30,
        ),
        toolbarHeight: Dimensions.heightFor60,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black87, // Set the menu icon color here
        ),
        // actions: [],
      ),
      drawer: FoodDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: toggleExpansion,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 10),
                        curve: Curves.easeInOut,
                        width: avatarRadius,
                        height: avatarRadius,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/DrinksImages/Ccaramellatte.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 31, 252, 2),
                thickness: 4,
                indent: Dimensions.widthFor110,
                endIndent: Dimensions.widthFor110,
              ),
              SizedBox(
                height: Dimensions.heightFor20,
              ),
              TextViewBox(
                data: email,
                name: 'Email Address',
              ),
              TextViewBox(
                data: fName,
                name: 'First Name',
              ),
              TextViewBox(
                data: lName,
                name: 'Last Name',
              ),
              TextViewBox(
                data: contact.toString(),
                name: 'Contact Info.',
              ),
              TextViewBox(
                data: pass,
                name: 'Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
