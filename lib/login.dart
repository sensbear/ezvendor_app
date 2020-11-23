import 'package:ezvendor/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'globals.dart';

final globals = Globals.instance;

bool validLogin(TextEditingValue account, TextEditingValue password) {
  if ((0 >= account.text.length) || (0 >= password.text.length)) return false;
  return true;
}

class LoginPage extends StatelessWidget {
  final TextEditingController _account = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //debugPrint('[訊息] 輸出範例');
    //global.initScreenAspect(context);
    globals.setContext(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 340 * globals.screenYScale,
                  decoration:
                      BoxDecoration(image: DecorationImage(image: AssetImage('./assets/images/background2.png'), fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30 * globals.screenXScale,
                        width: 80 * globals.screenXScale,
                        height: 180 * globals.screenYScale,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('./assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140 * globals.screenXScale,
                        width: 80 * globals.screenXScale,
                        height: 130 * globals.screenYScale,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        left: 100 * globals.screenXScale,
                        top: 180 * globals.screenYScale,
                        width: 220 * globals.screenXScale,
                        height: 200 * globals.screenYScale,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/ezvendor_logo.png'), fit: BoxFit.fill)),
                            )),
                      )
                      /*,
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Signin",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )*/
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                              BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))
                            ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: _account,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle: TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30 * globals.screenYScale,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50 * globals.screenYScale,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(247, 202, 64, 1),
                                  Color.fromRGBO(247, 202, 64, .6),
                                ])),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    print("Click Login Button");
                                    if (!validLogin(_account.value, _password.value)) {
                                      globals.showMessage(context, "Invalid input, please cehcek again.!!");
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ))),
                            ),
                          )),
                      SizedBox(
                        height: 70 * globals.screenYScale,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  } // override build
} // class
