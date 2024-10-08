import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/generated/l10n.dart';
import 'package:serenmind/screens/register/registerController.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController _controller = RegisterController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    String? validationError = _controller.validateFields(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      context: context,
    );

    if (validationError != null) {
      _showSnackbar(validationError);
      return;
    }

    String? error = await _controller.registerWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );

    if (error != null) {
      _showSnackbar(error);
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (GoRouter.of(context).canPop()) {
          context.go('/');
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/zen_register.png',
                    height: 150,
                  ),
                  const SizedBox(height: 30),

                  Text(
                    S.of(context).createAccount,
                    style: AppTextStyles.headline1,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    S.of(context).fillInfo,
                    style: AppTextStyles.bodyText1,
                  ),
                  const SizedBox(height: 40),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      hintText: S.of(context).emailHint,
                      hintStyle: AppTextStyles.bodyText2,
                      prefixIcon: const Icon(Icons.email, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      hintText: S.of(context).passwordHint,
                      hintStyle: AppTextStyles.bodyText2,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      hintText: S.of(context).confirmPassword,
                      hintStyle: AppTextStyles.bodyText2,
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      S.of(context).signUp,
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).alreadyHaveAccount,
                        style: AppTextStyles.bodyText2,
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        child: Text(
                          S.of(context).loginButton,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
}
