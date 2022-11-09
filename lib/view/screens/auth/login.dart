import 'package:flutter/material.dart';
import 'package:flutter_package1/navigation.dart';
import 'package:ows_bigcareer/view/screens/auth/forget_password.dart';
import 'package:ows_bigcareer/view/screens/auth/register.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FocusNode text1, text2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text1 = FocusNode();
    text2 = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    text1.dispose();
    text2.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;
  double textForm1height = 45.0;
  double textForm2height = 45.0;
  double cardHeight = 300;
  bool obscureTextF = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  height: MediaQuery.of(context).size.width * .20,
                  child: Center(child: Image.asset('assets/logo.png'))),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Center(
                child: SizedBox(
                  height: cardHeight,
                  width: MediaQuery.of(context).size.width * .85,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.indigo,
                          ),
                          width: size.width * .9,
                          height: 50,
                          child: const Center(
                            child: Text(
                              'Sign in',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: SizedBox(
                            height: textForm1height,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                  primarySwatch: Colors.indigo),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _controllerMobile,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                  setHeight(1, 65);
                                    return 'Enter Your Mobile';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  if (value!.length > 10) {
                                    setHeight(1, 65);
                                    return 'Number Max length 10';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  if (value!.length < 10) {
                                    setHeight(1, 65);
                                    return 'Number Min length 10';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    tryRegistration = false;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.indigo)),
                                  labelText: 'Enter Mobile Number',
                                  labelStyle: TextStyle(fontSize: 13),
                                  prefixText: ' ',
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: Colors.indigo,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: SizedBox(
                            height: textForm2height,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                  primarySwatch: Colors.indigo),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _controllerPassword,
                                obscureText: obscureTextF,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setHeight(2, 65);
                                    return 'Enter Your Password';
                                  } else {
                                    setHeight(2, 45);
                                  }
                                  if (value!.length > 8) {
                                    setHeight(2, 65);
                                    return 'Password Max length 8';
                                  } else {
                                    setHeight(2, 45);
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    tryRegistration = false;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal)),
                                    labelText: 'Enter Your Password',
                                    labelStyle: TextStyle(fontSize: 13),
                                    prefixText: ' ',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.indigo,
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // !obscureTextF;
                                          obscureTextF = !obscureTextF;
                                        });
                                      },
                                      icon: obscureTextF
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: Colors.indigo,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.indigo,
                                              size: 20,
                                            ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 18.0, top: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  navigateAndFinsh(context, ForgetPassword());
                                },
                                child: Text(
                                  "Forget password?",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.indigo),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: SizedBox(
                              height: 40,
                              width: size.width * .6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.indigo),
                                  onPressed: () {
                                    _verifyUser(context);
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    navigateAndFinsh(context, const RegistrationScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Do not have an account?",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        " Register",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(BuildContext context) async {
    setState(() {
      cardHeight = 340;
    });
    if (formKey.currentState!.validate()) {
      setState(() {
        cardHeight = 300;
      });
      if (mounted) {
        setState(() {
          tryRegistration = true;
        });
      }
      navigateAndFinsh(context, BottomNavBar());
    }
  }

  void setHeight(int field, double height) {
    if (field == 1) {
      setState(() {
        textForm1height = height;
      });
    } else {
      setState(() {
        textForm2height = height;
      });
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
