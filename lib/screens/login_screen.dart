import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController;
    _passwordController;
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signInUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void goToSignUp() {
    Navigator.of(context).pushNamed('/signup');
  }

  /// Asynchronously opens the image picker to select an image from the gallery
  /// and assigns the selected image to the _image variable.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 1, child: Container()),
                // svg image
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 64,
                ),

                const SizedBox(height: 64),
                // text field for email
                TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController),
                // text field for password
                const SizedBox(height: 8),

                TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.visiblePassword,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(height: 8),
                // login button
                GestureDetector(
                  onTap: () {
                    loginUser();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: blueColor,
                    ),
                    child: _isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: const Text('Log In'),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      'don\'t have an account?',
                      style: TextStyle(),
                    )),
                    GestureDetector(
                      onTap: goToSignUp,
                      child: Container(
                          child: Text(
                        '   sign up',
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ],
                ),
                Flexible(flex: 1, child: Container()),

                // forgot password?
                //sign up
              ],
            )),
      ),
    );
  }
}
