import 'package:flutter/material.dart';

class WorkerTasksScreen extends StatelessWidget {
  const WorkerTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _taskCard(
            context,
            'PPE Compliance Check',
            'Mining Zone A',
            'High Priority',
            Icons.health_and_safety,
          ),
          _taskCard(
            context,
            'Equipment Safety Check',
            'Workshop Area',
            'Medium Priority',
            Icons.build_outlined,
          ),
          _taskCard(
            context,
            'Safety Training',
            'Training Center',
            'Pending',
            Icons.school_outlined,
          ),
        ],
      ),
    );
  }

  Widget _taskCard(
    BuildContext context,
    String title,
    String location,
    String status,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFFE8F5E9),
              child: Icon(
                icon,
                color: const Color(0xFF0B5D3B),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    status,
                    style: const TextStyle(
                      color: Color(0xFF0B5D3B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}