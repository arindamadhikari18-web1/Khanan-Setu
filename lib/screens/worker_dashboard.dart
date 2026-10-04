import 'package:flutter/material.dart';

import 'worker_safety_report_screen.dart';
import 'worker_emergency_screen.dart';
import 'worker_tasks_screen.dart';
import 'worker_grievance_screen.dart';
import 'arrow_button.dart';
class WorkerDashboardScreen extends StatelessWidget {
  const WorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const ArrowButton(),
        title: const Text('Worker Dashboard'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning, Worker 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Worker ID: WK001',
              style: TextStyle(color: Colors.grey),
            ),

            const Text(
              'Raniganj Coal Mine • West Bengal',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Attendance
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 35,
                ),
                title: const Text(
                  'Attendance',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Today • Not marked yet'),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Attendance marked successfully.'),
                      ),
                    );
                  },
                  child: const Text('MARK'),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // 1 Report Safety Issue
            _actionCard(
              context,
              Icons.report_problem_outlined,
              'Report Safety Issue',
              'Report unsafe conditions',
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const WorkerSafetyReportScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // 2 Emergency Help
            _actionCard(
              context,
              Icons.emergency_outlined,
              'Emergency Help',
              'Get immediate assistance',
              Colors.red,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const WorkerEmergencyScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // 3 My Tasks
            _actionCard(
              context,
              Icons.task_alt_outlined,
              'My Tasks',
              'View assigned tasks',
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const WorkerTasksScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // 4 Grievance
            _actionCard(
              context,
              Icons.feedback_outlined,
              'Grievance',
              'Submit your concern',
              Colors.purple,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const WorkerGrievanceScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // Safety Reminder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    color: Colors.orange,
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Always wear required PPE before entering the mining area.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}