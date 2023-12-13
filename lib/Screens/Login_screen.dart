import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/components/Const.dart';
import 'package:chat_app/components/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailControler = TextEditingController();

  var passwordControler = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isLoading = false;

  IconData eye = Icons.remove_red_eye_rounded;
  IconData eyeRe = Icons.keyboard_hide_rounded;

  bool IsHide = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset('assets/images/scholar.png'),
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            Text(
                              'Sign in'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultTextField(
                          suffixIcon: Icon((Icons.email)),
                          validet: (value) {
                            if (value!.isEmpty) {
                              return 'emile address must not be empty';
                            }
                          },
                          controler: emailControler,
                          hintText: 'email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defultTextField(
                          hideText: IsHide,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {});
                                IsHide = !IsHide;
                              },
                              icon: !IsHide
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          validet: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                          },
                          controler: passwordControler,
                          hintText: 'password',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                await SignInUsingEmailAndPAssword();
                                //navigatTo(context, screen: ChatScreen());
                                navigatAndRemove(
                                    context,
                                    chatScreen(
                                      email: emailControler.text,
                                    ));
                              } on FirebaseAuthException catch (e) {
                                print(e);
                                if (e.code == 'user-not-found') {
                                  ShowSnackBar(context,
                                      'user not found , try diffrent account ');
                                } else if (e.code == 'wrong-password') {
                                  ShowSnackBar(context, 'wrong password');
                                }
                              } catch (ex) {
                                print(ex);
                              }
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          TextInput: 'Login',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'RegisterScreen');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SignInUsingEmailAndPAssword() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailControler.text, password: passwordControler.text);
  }
}
