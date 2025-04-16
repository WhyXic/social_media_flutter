import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

const webScreenSize = 600;
const mobileScreenLayout = 600;

const screens = [
  FeedScreen(),
  SearchScreen(),
  CreatePost(),
  Center(child: Text('activity')),
  ProfileScreen(),
];
