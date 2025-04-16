import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 32,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1669411162387-0415e1d0dc7d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw1fHx8ZW58MHx8fHx8'),
                ),
                Spacer(),
                Text('username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                Spacer(),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Spacer(),
                Text('Followers: 0'),
                Spacer(),
                Text('Following: 0'),
                Spacer(),
                Text('Posts: 0'),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {},
                        child: Text(
                          'Message',
                        ))),
                SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: blueColor,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {},
                        child: Text(
                          'Follow',
                        ))),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
