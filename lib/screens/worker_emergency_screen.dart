import 'package:flutter/material.dart';

class WorkerEmergencyScreen extends StatelessWidget {
  const WorkerEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Icon(
              Icons.emergency,
              size: 90,
              color: Colors.red.shade700,
            ),
            const SizedBox(height: 20),
            const Text(
              'Emergency Assistance',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Use emergency assistance when immediate help is required.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Emergency Alert'),
                      content: const Text(
                        'Emergency alert sent to Mine Control Room and Field Officer.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.warning),
                label: const Text('SEND EMERGENCY ALERT'),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mine Control Room: +91 1800-XXX-XXXX'),
                    ),
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('CALL CONTROL ROOM'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}