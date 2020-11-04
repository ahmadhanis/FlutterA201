import 'package:flutter/material.dart';
import 'package:food_ninja/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _pscontroller = TextEditingController();
  final TextEditingController _phcontroller = TextEditingController();

  String _email = "";
  String _pass = "";
  String _name = "";
  String _phone = "";
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/foodninjared.png',
                      scale: 2,
                    ),
                    TextField(
                        controller: _namecontroller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: 'Name', icon: Icon(Icons.person))),
                    TextField(
                        controller: _emcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email))),
                    TextField(
                        controller: _phcontroller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Mobile', icon: Icon(Icons.phone))),
                    TextField(
                      controller: _pscontroller,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variablegithu
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: _passwordVisible,
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Register'),
                      color: Colors.black,
                      textColor: Colors.white,
                      elevation: 15,
                      onPressed: _onRegister,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                        onTap: _onLogin,
                        child: Text('Already register',
                            style: TextStyle(fontSize: 16))),
                  ],
                ),
              ))),
    );
  }

  Future<void> _onRegister() async {
    _name = _namecontroller.text;
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    _phone = _phcontroller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Registration...");
    await pr.show();

    http.post("https://slumberjer.com/foodninjav2/php/register_user.php",
        body: {
          "name": _name,
          "email": _email,
          "password": _pass,
          "phone": _phone,
        }).then((res) {
      if (res.body == "success") {
        Toast.show(
          "Registration success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      } else {
        Toast.show(
          "Registration failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}
