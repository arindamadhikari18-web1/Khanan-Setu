import 'package:flutter/material.dart';

import 'app_data.dart';
import 'registration_screen.dart';
import 'home_screen.dart';
import 'field_officer_dashboard.dart';
import 'worker_dashboard.dart';
import 'corporate_admin_dashboard.dart';
import 'regulatory_authority_dashboard.dart';

class LoginScreen extends StatefulWidget {
  final String selectedRole;

  const LoginScreen({
    super.key,
    required this.selectedRole,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void login() {
    final id = idController.text.trim();
    final password = passwordController.text;

    if (id.isEmpty || password.isEmpty) {
      showError('Please enter User ID and Password');
      return;
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      final user = AppData.getUser(id);

      // USER NOT FOUND
      if (user == null) {
        showError(
          'Account not found. Please create your profile first.',
        );
        return;
      }

      // ROLE CHECK
      if (user.role != widget.selectedRole) {
        showError(
          'This account belongs to ${user.role}.',
        );
        return;
      }

      // PASSWORD CHECK
      if (user.password != password) {
        showError('Incorrect password');
        return;
      }

      // FIELD OFFICER
      if (widget.selectedRole == 'Field Officer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const FieldOfficerDashboardScreen(),
          ),
        );
      }

      // WORKER
      else if (widget.selectedRole == 'Worker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WorkerDashboardScreen(),
          ),
        );
      }

      // MINE MANAGER
      else if (widget.selectedRole == 'Mine Manager') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }

      // CORPORATE ADMIN
      else if (widget.selectedRole == 'Corporate Admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const CorporateAdminDashboardScreen(),
          ),
        );
      }

      // REGULATORY AUTHORITY
      else if (widget.selectedRole == 'Regulatory Authority') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const RegulatoryAuthorityDashboardScreen(),
          ),
        );
      }
    });
  }

  void openRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationScreen(
          selectedRole: widget.selectedRole,
        ),
      ),
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
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ICON
              Center(
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 46,
                    color: Color(0xFF0B5D3B),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Center(
                child: Text(
                  widget.selectedRole,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B5D3B),
                  ),
                ),
              ),

              const SizedBox(height: 7),

              Center(
                child: Text(
                  'Login to Khanan Setu',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // USER ID
              const Text(
                'User ID',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: idController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter your User ID',
                  prefixIcon: const Icon(
                    Icons.person_outline,
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

              const SizedBox(height: 20),

              // PASSWORD
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                onSubmitted: (_) => login(),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
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

              const SizedBox(height: 28),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B5D3B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 23,
                          width: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // DIVIDER
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // CREATE PROFILE
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: openRegistration,
                  icon: const Icon(
                    Icons.person_add_alt_1,
                  ),
                  label: const Text(
                    'CREATE NEW PROFILE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0B5D3B),
                    side: const BorderSide(
                      color: Color(0xFF0B5D3B),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Center(
                child: Text(
                  'First time user? Create your profile above.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}