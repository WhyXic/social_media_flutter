import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreenSize = 600;
const mobileScreenLayout = 600;

const screens = [
  FeedScreen(),
  Center(child: Text('search')),
  CreatePost(),
  Center(child: Text('activity')),
  Center(child: Text('profile')),
];
