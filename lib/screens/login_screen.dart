import 'package:FlutterTask/providers/auth_provider.dart';
import 'package:FlutterTask/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/app_routes.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../utils/strings.dart';

class LoginScreen extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      });
    }

    final auth = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Input
            CustomInput(
              controller: _emailController,
              hintText: AppStrings.emailHint,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 16),
            // Password Input
            CustomInput(
              controller: _passwordController,
              hintText: AppStrings.passwordHint,
              isPassword: true,
              validator: Validators.validatePassword,
            ),
            const SizedBox(height: 16),
            // Login Button
            CustomButton(
              text: AppStrings.loginButton,
              onPressed: () {
                final emailError = Validators.validateEmail(_emailController.text.trim());
                final passwordError = Validators.validatePassword(_passwordController.text.trim());

                if (emailError != null || passwordError != null) {
                  final errorMessage = emailError ?? passwordError;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage!)),
                  );
                  return;
                }

                auth.login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (ref.watch(authProvider).isAuthenticated) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppStrings.loginFailed)),
                    );
                  }
                });
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.register);
              },
              child: Text(AppStrings.registerRedirect),
            ),
          ],
        ),
      ),
    );
  }
}
