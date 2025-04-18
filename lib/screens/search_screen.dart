import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUser = false;
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
              label: Text('Search for user'),
              fillColor: blueColor,
              iconColor: blueColor,
              hoverColor: blueColor,
              focusColor: blueColor),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where('username',
                  isGreaterThanOrEqualTo: textEditingController.text)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return isShowUser
                ? ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data as dynamic).docs[index]
                                  ['photoUrl']),
                        ),
                        title: Text(
                            (snapshot.data as dynamic).docs[index]['username']),
                      );
                    },
                  )
                : FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('posts').get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return Container(
                        padding: EdgeInsets.only(top: 16),
                        child: MasonryGridView.count(
                          crossAxisCount: 3,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) => Image.network(
                            (snapshot.data! as dynamic).docs[index]['postUrl'],
                            fit: BoxFit.cover,
                          ),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
