import 'package:flutter/material.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignupLoginPage();
  }
}
class SignupLoginPage extends StatefulWidget {
  const SignupLoginPage({Key? key}) : super(key: key);

  @override
  State<SignupLoginPage> createState() => _SignupLoginPageState();
}

class _SignupLoginPageState extends State<SignupLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
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
                  ),),
                TextButton(
                  onPressed: (){},
                  child: const Text('Forgot Password?'),
                ),
                TextButton(
                  onPressed: (){},
                  child: const Text('Does not have account? SignUp'),
                ),
              ],
            )
          )
     
    );
  }
}

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
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
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                  onPressed: (){},
                  child: const Text('Already have an account? LogIn'),
                ),
              ],
            )
          )
     
    );
  }
}