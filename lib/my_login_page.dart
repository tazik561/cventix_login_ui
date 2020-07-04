import 'package:cventix_login_ui/common/fadu_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'categories_page.dart';
import 'common/validator_extension.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focus_email = FocusNode();
  FocusNode _focus_pass = FocusNode();
  bool _focus_email_flag = false;
  bool _focus_pass_flag = false;
  var style_un_focus =
      TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold);
  var style_focus = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    _focus_email.addListener(_onEmailFocusChange);
    _focus_pass.addListener(_onPassFocusChange);
  }

  void _onEmailFocusChange() {
    setState(() {
      _focus_email_flag = !_focus_email_flag;
    });
  }

  void _onPassFocusChange() {
    setState(() {
      _focus_pass_flag = !_focus_pass_flag;
    });
  }

  void _loginAction() {
    var valid = _formKey.currentState.validate();
    if (valid != true) return;
    //todo do stuff things
    Navigator.pushReplacement(context, FadeRoute(page: CategoriesPage()));
  }

  @override
  void dispose() {
    _focus_email.dispose();
    _focus_pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(width * 0.1),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: height * 0.05,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Login to your account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                TextFormField(
                  focusNode: _focus_email,
                  validator: (input) =>
                      input.isValidEmail() ? null : "Check your email",
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        !_focus_email_flag ? style_un_focus : style_focus,
                    contentPadding: EdgeInsets.only(
                        left: 15.0, top: 5.0, right: 5.0, bottom: 4.0),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                TextField(
                  focusNode: _focus_pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle:
                        !_focus_pass_flag ? style_un_focus : style_focus,
                    contentPadding: EdgeInsets.only(
                        left: 15.0, top: 5.0, right: 5.0, bottom: 4.0),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Your Password?",
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    )),
                SizedBox(
                  height: height * .05,
                ),
                MaterialButton(
                  onPressed: _loginAction,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.green[600])),
                  color: Colors.green[600],
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                MaterialButton(
                  onPressed: () {},
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.green[100])),
                  color: Colors.green[100],
                  child: Center(
                    child: Text(
                      "Don't have an account yet?",
                      style:
                          TextStyle(color: Colors.green[800], fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Text.rich(
                  TextSpan(
                      text: "By continuing, you agree to Eatiquette's\n",
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      children: [
                        TextSpan(
                          text: "Terms of Use ",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "and ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
