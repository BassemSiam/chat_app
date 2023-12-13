import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/components/Const.dart';
import 'package:chat_app/components/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                            'register'.toUpperCase(),
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
                        controler: emailControler,
                        hintText: 'email',
                        validet: (value) {
                          if (value!.isEmpty) {
                            return 'emile address must not be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defultTextField(
                          
                         suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_red_eye_rounded)),
                        controler: passwordControler,
                        hintText: 'password',
                        validet: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          } else if (value.startsWith(RegExp(r'[a-z]'))) {
                            return 'password must begin with capteal character';
                          }
                        },
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
                              await CreateUserUsingEmailAndPassword();
                              navigatAndRemove(
                                  context,
                                  chatScreen(
                                    email: emailControler.text,
                                  ));
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              if (e.code == 'email-already-in-use')
                                ShowSnackBar(
                                    context, 'Email address already use');
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        },
                        TextInput: 'Register',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
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
    );
  }

  Future<void> CreateUserUsingEmailAndPassword() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailControler.text, password: passwordControler.text);
  }
}
