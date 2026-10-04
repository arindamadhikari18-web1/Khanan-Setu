import 'package:flutter/material.dart';
import 'login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int? selectedRole;

  final List<Map<String, dynamic>> roles = [
    {
      'title': 'Field Officer',
      'subtitle': 'Inspections & field reports',
      'icon': Icons.engineering_outlined,
    },
    {
      'title': 'Worker',
      'subtitle': 'Attendance & safety reporting',
      'icon': Icons.person_outline,
    },
    {
      'title': 'Mine Manager',
      'subtitle': 'Mine operations & compliance',
      'icon': Icons.manage_accounts_outlined,
    },
    {
      'title': 'Corporate Admin',
      'subtitle': 'Multi-mine governance & analytics',
      'icon': Icons.business_outlined,
    },
    {
      'title': 'Regulatory Authority',
      'subtitle': 'Regulatory oversight & verification',
      'icon': Icons.verified_user_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 10),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B5D3B),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Select Your Role',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17352A),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Choose your role to access the right tools\n'
                    'and governance functions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF718078),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  final role = roles[index];
                  final isSelected = selectedRole == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRole = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(bottom: 13),
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0B5D3B)
                              : const Color(0xFFE5EBE7),
                          width: isSelected ? 1.8 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isSelected ? 0.08 : 0.035,
                            ),
                            blurRadius: isSelected ? 15 : 9,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0B5D3B)
                                  : const Color(0xFFEAF4EF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              role['icon'],
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF0B5D3B),
                              size: 27,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  role['title'],
                                  style: const TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF26352F),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  role['subtitle'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF7A8580),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFF0B5D3B)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF0B5D3B)
                                    : const Color(0xFFB8C4BE),
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedRole == null
                      ? null
                      : () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(
                                selectedRole:
                                    roles[selectedRole!]['title'],
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B5D3B),
                    disabledBackgroundColor: const Color(0xFFD5DDD8),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 9),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}