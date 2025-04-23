import 'package:firebase_auth/firebase_auth.dart'; // importing the firebase authentication module
import 'package:firebase_core/firebase_core.dart'; // importing the firebase database module
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:provider/provider.dart'; // importing the state management module

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // make sure that all widgets are initialized. 
  if (kIsWeb) { // the web platform requires diffrent api keys, as the pub modules do not interact with the web properly. 
    Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: ''. // database key
          appId: '', // app id from firebase
          messagingSenderId: '',
          projectId: '',
          storageBucket: ''), // firebase storage bucket
    );
  } else {
    await Firebase.initializeApp(); // if it is not web, initalize the firebase modules. 
  }

  runApp(const MyApp()); // runs the MyApp widget.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( // multiprovide widget, which notifies if the user state is changed to child widgets. aka if user logs out, app is rebuit.
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // turn of the ugly ass debug tag.
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith( // override the background color on scaffold to be black.
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),

        home: StreamBuilder( // Stream builder widget listens to a stream from firebase (real-time updates) and builds ui on to of that.
          stream: FirebaseAuth.instance.authStateChanges(), // the stream is from firebase, which listens to authStateChanges. 
          builder: (context, snapshot) { // build ontop of the current context, where the data provided is the snapshot (data provided by the stream). 
            if (snapshot.connectionState == ConnectionState.waiting) { // if connection is not established, we display a circular progress indicator. 
              return const Center(
                child: CircularProgressIndicator.adaptive(), 
              );
            } else if (snapshot.connectionState == ConnectionState.active) { // if the stream is connected, and snapshot has data, then build the Resposive layout.
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(), // if screen > 600 px, then build web otherwise build mobile screen layout. 
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'), // if there is an error then return the error.
                );
              }
            }

            return const LoginScreen(); // if there is no login state for user, then build the login screen to allow user to login. 
          },
        ),
      ),
    );
  }
}
