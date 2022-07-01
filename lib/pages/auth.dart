import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/auth/auth_service.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = true;
  callback() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignup
        ? SignupScreen(callback: callback)
        : LoginScreen(callback: callback);
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.callback}) : super(key: key);
  final Function callback;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _confirmPasswordController.dispose();
  }

  void signUpUser() {
    if (_passwordController.text == _confirmPasswordController.text) {
      authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
      );
    } else {
      showSnackBar(context, 'Password not matched', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _signupFormKey,
          child: Padding(
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
                    child: CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone number',
                      icon: Icons.call_rounded,
                      borderType: 'underline',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      icon: Icons.account_circle_rounded,
                      borderType: 'underline',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      borderType: 'underline',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _addressController,
                      hintText: 'Address',
                      icon: Icons.location_on_rounded,
                      keyboardType: TextInputType.streetAddress,
                      borderType: 'underline',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock_rounded,
                      borderType: 'underline',
                      isSecuredText: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.lock_rounded,
                      borderType: 'underline',
                      isSecuredText: true,
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
                      onPressed: () {
                        if (_signupFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forget Password'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.callback();
                    },
                    child: const Text('Already have an account? LogIn'),
                  ),
                ],
              )),
        ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.callback}) : super(key: key);
  final Function callback;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
  }

  void loginUser() {
    authService.loginUser(
      context: context,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _loginFormKey,
          child: Padding(
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
                    child: CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      icon: Icons.call_rounded,
                      borderType: 'underline',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock_rounded,
                      isSecuredText: true,
                      borderType: 'underline',
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
                      onPressed: () {
                        if (_loginFormKey.currentState!.validate()) {
                          loginUser();
                        }
                      },
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
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.callback();
                    },
                    child: const Text('Does not have account? SignUp'),
                  ),
                ],
              )),
        ));
  }
}
