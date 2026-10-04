import 'package:flutter/material.dart';

import 'app_data.dart';

class RegistrationScreen extends StatefulWidget {
  final String selectedRole;

  const RegistrationScreen({
    super.key,
    required this.selectedRole,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final departmentController = TextEditingController();
  final mineController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    mobileController.dispose();
    emailController.dispose();
    departmentController.dispose();
    mineController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // UPDATED: now async so profile is permanently saved
  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final id = idController.text.trim();
    final mobile = mobileController.text.trim();
    final email = emailController.text.trim();
    final department = departmentController.text.trim();
    final mine = mineController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        id.isEmpty ||
        mobile.isEmpty ||
        email.isEmpty ||
        department.isEmpty ||
        mine.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showError('Please fill all details');
      return;
    }

    if (password != confirmPassword) {
      showError('Passwords do not match');
      return;
    }

    if (AppData.userExists(id)) {
      showError('This User ID is already registered');
      return;
    }

    final user = UserProfile(
      fullName: name,
      userId: id,
      password: password,
      mobile: mobile,
      email: email,
      department: department,
      mine: mine,
      role: widget.selectedRole,
    );

    // Save permanently using SharedPreferences
    await AppData.saveUser(user);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text('Account Created'),
            ],
          ),
          content: Text(
            'Profile created successfully for ${widget.selectedRole}.\n\n'
            'User ID: $id\n\n'
            'You can now login using your User ID and Password.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('GO TO LOGIN'),
            ),
          ],
        );
      },
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget inputField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: onTogglePassword == null
                ? null
                : IconButton(
                    onPressed: onTogglePassword,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        title: const Text(
          'Create Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    size: 38,
                    color: Color(0xFF0B5D3B),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: Text(
                  'Create ${widget.selectedRole} Profile',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B5D3B),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Center(
                child: Text(
                  'Enter your details for first-time registration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              inputField(
                'Full Name',
                'Enter your full name',
                nameController,
                Icons.person_outline,
              ),

              inputField(
                'User ID',
                'Create your User ID',
                idController,
                Icons.badge_outlined,
              ),

              inputField(
                'Mobile Number',
                'Enter mobile number',
                mobileController,
                Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              inputField(
                'Email',
                'Enter email address',
                emailController,
                Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              inputField(
                'Department',
                'Example: Safety & Compliance',
                departmentController,
                Icons.account_tree_outlined,
              ),

              inputField(
                'Mine / Organization',
                'Enter mine or organization',
                mineController,
                Icons.factory_outlined,
              ),

              inputField(
                'Password',
                'Create password',
                passwordController,
                Icons.lock_outline,
                obscureText: obscurePassword,
                onTogglePassword: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),

              inputField(
                'Confirm Password',
                'Enter password again',
                confirmPasswordController,
                Icons.lock_reset_outlined,
                obscureText: obscureConfirmPassword,
                onTogglePassword: () {
                  setState(() {
                    obscureConfirmPassword =
                        !obscureConfirmPassword;
                  });
                },
              ),

              const SizedBox(height: 5),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B5D3B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  'Your profile is stored locally for this demo.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}