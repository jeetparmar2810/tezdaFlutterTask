import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../utils/strings.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    _nameController.text = authState.user?.name ?? "";
    _emailController.text = authState.user?.email ?? "";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Input
            CustomInput(
              controller: _nameController,
              hintText: AppStrings.nameHint,
            ),
            const SizedBox(height: 16),

            // Email Input
            CustomInput(
              controller: _emailController,
              hintText: AppStrings.emailHintReadOnly,
              isReadOnly: true, // Email should not be editable
            ),
            const SizedBox(height: 16),

            // Save Button
            CustomButton(
              text: AppStrings.saveChangesButton,
              onPressed: () {
                final name = _nameController.text.trim();

                if (name.isEmpty) {
                  _showMessage(context, AppStrings.nameEmptyError);
                  return;
                }

                authNotifier.updateProfile(name: name);
                _showMessage(context, AppStrings.profileUpdatedMessage);
              },
            ),
          ],
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
