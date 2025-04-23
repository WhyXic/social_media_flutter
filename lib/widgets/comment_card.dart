import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart'; // import the user provider made in the app. 
import 'package:instagram_clone/models/user.dart';
import 'package:intl/intl.dart'; // importing the interationalization package to convert time to other user readable format.
import 'package:provider/provider.dart'; // import the provider package. 

class CommentCard extends StatefulWidget {  // Make comment card a stateful widget. 
  const CommentCard({super.key, required this.snap});
  final snap;
  @override
  State<CommentCard> createState() => _CommentCardState(); // the state of CommentCard is _CommentCardSate();
}

class _CommentCardState extends State<CommentCard> { // make the commentcardstate an class that inherits the state with the type of that state being comment card.
  @override // override default state build method.
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser; // get the current state of user from the provider.
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16), // padding to make it pretty.
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']), // displaying the profile picture from firebase storage.
            radius: 18,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${widget.snap['name']}', // display the name
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '   ${widget.snap['text']}',
                          style: const TextStyle()) // display the comment. 
                    ])),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()) // dispaly the datepublished. 
                            .toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*
          Not implemented the replies to comments and likes as it was similar to linking a post, where if the user has liked it, add user to the liked list, display the length - 1 
          for the no of likes, if uid is present in the list, then just remove it if interacted again.
          */
          Container(
            padding: EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline),
              iconSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
