import 'package:FlutterTask/providers/auth_provider.dart';
import 'package:FlutterTask/screens/home_screen.dart';
import 'package:FlutterTask/utils/app_routes.dart';
import 'package:FlutterTask/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/pref_keys.dart';
import '../utils/validators.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends ConsumerWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.registerTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInput(
                controller: _nameController,
                hintText: AppStrings.nameHint,
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              CustomInput(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomInput(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                isPassword: true,
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 16),
              CustomInput(
                controller: _confirmPasswordController,
                hintText: AppStrings.confirmPasswordHint,
                isPassword: true,
                validator: (value) =>
                    Validators.validateConfirmPassword(
                      _passwordController.text,
                      value,
                    ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: AppStrings.registerTitle,
                onPressed: () async {
                  final name = _nameController.text.trim();
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final confirmPassword = _confirmPasswordController.text.trim();

                  if (name.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      confirmPassword.isEmpty) {
                    _showMessage(context, AppStrings.allFieldsRequiredError);
                    return;
                  }

                  if (password != confirmPassword) {
                    _showMessage(context, AppStrings.passwordsMismatchError);
                    return;
                  }

                  final prefs = await SharedPreferences.getInstance();
                  final isEmailRegistered =
                      prefs.getString(PrefKeys.userEmail) == email;

                  if (isEmailRegistered) {
                    _showMessage(context, AppStrings.emailAlreadyRegistered);
                    return;
                  }

                  try {
                    await auth.register(name, email, password);

                    await prefs.setString(PrefKeys.userEmail, email);
                    await prefs.setString(PrefKeys.userName, name);

                    _showMessage(context, AppStrings.registrationSuccess);

                    // Clear previous routes and navigate to HomeScreen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                    );
                  } catch (e) {
                    _showMessage(context, AppStrings.registrationFailure);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                child: Text(AppStrings.loginRedirect),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
