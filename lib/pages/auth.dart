import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = true;
  callback(){
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignup?  SignupScreen(callback :callback,): LoginScreen(callback :callback,);
  }  
  }
  
  class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.callback }) : super(key: key);
  final Function callback;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(image: AssetImage("assets/images/logo.jpg")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.call_rounded, color: Colors.blue,),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle_rounded, color: Colors.blue,),
                      border: UnderlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.email_rounded, color: Colors.blue,),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border:UnderlineInputBorder(),
                      icon: Icon(Icons.location_on_rounded, color: Colors.blue,),
                      labelText: 'Address',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.lock_rounded, color: Colors.blue,),
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.lock_rounded, color: Colors.blue,),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                    ),
                    
                    onPressed: () {}, 
                    
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),),
                TextButton(
                  onPressed: (){},
                  child: const Text('Forget Password'),
                    ),
                  
                TextButton(
                  onPressed: (){
                    widget.callback();
                  },
                  child: const Text('Already have an account? LogIn'),
                ),
              ],
            )
          )
     
    );
  }
}
  
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.callback }) : super(key: key);
  final Function callback;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(image: AssetImage("assets/images/logo.jpg")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.call_rounded, color: Colors.blue,),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.lock_rounded, color: Colors.blue,),
                      labelText: 'Password',
                    ),
                  ),
                ),
                
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    ),
                    
                    onPressed: () {}, 
                    
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (){},
                  child: const Text('Forgot Password?'),
                ),
                TextButton(
                  onPressed: (){
                    widget.callback();
                  },
                  child: const Text('Does not have account? SignUp'),
                ),
              ],
            )
          )
     
    );
  }
}