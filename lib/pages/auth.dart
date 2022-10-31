import 'package:cabavenue/helpers/snackbar.dart';
import 'package:cabavenue/services/auth/auth_service.dart';
import 'package:cabavenue/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = false;
  callback() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isSignup
              ? SignupScreen(callback: callback)
              : LoginScreen(callback: callback),
        ),
      ),
    );
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
    return Form(
      key: _signupFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const Text(
              'Cabavenue',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            const Text('Start of a new journey'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(image: AssetImage("assets/images/logo.jpg")),
              ],
            ),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Phone number',
              icon: Iconsax.call,
              keyboardType: TextInputType.number,
              validations: const ['specific-length'],
              length: 10,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: 'Full Name',
              icon: Iconsax.user,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              icon: Iconsax.sms,
              keyboardType: TextInputType.emailAddress,
              validations: const ['email'],
            ),
            CustomTextField(
              controller: _addressController,
              hintText: 'Address',
              icon: Iconsax.location,
              keyboardType: TextInputType.streetAddress,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
              icon: Iconsax.lock_1,
              isSecuredText: true,
              validations: const ['length', 'secure'],
            ),
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              icon: Iconsax.lock,
              isSecuredText: true,
              validations: const ['length', 'secure'],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 50.0,
                  ),
                ),
                onPressed: () {
                  if (_signupFormKey.currentState!.validate()) {
                    signUpUser();
                  }
                },
                child: const Text("SignUp"),
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
        ),
      ),
    );
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
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          children: <Widget>[
            const Text(
              'Cabavenue',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
            ),
            const Text('Welcome back'),
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
            CustomTextField(
              controller: _phoneController,
              hintText: 'Phone Number',
              icon: Iconsax.call,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Password',
              icon: Iconsax.password_check,
              isSecuredText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 80.0,
                  ),
                ),
                onPressed: () {
                  if (_loginFormKey.currentState!.validate()) {
                    loginUser();
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.callback();
              },
              child: const Text('Does not have account? SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}
