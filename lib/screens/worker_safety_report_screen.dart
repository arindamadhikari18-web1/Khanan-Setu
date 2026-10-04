import 'package:flutter/material.dart';

class WorkerSafetyReportScreen extends StatefulWidget {
  const WorkerSafetyReportScreen({super.key});

  @override
  State<WorkerSafetyReportScreen> createState() =>
      _WorkerSafetyReportScreenState();
}

class _WorkerSafetyReportScreenState
    extends State<WorkerSafetyReportScreen> {
  String issueType = 'Select Issue Type';
  String severity = 'Medium';

  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Safety Issue'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Safety Issue Report',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Report any unsafe condition or safety concern.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),

            const Text('Issue Type',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: issueType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Select Issue Type',
                  child: Text('Select Issue Type'),
                ),
                DropdownMenuItem(
                  value: 'PPE Violation',
                  child: Text('PPE Violation'),
                ),
                DropdownMenuItem(
                  value: 'Unsafe Machinery',
                  child: Text('Unsafe Machinery'),
                ),
                DropdownMenuItem(
                  value: 'Unsafe Road',
                  child: Text('Unsafe Road'),
                ),
                DropdownMenuItem(
                  value: 'Environmental Hazard',
                  child: Text('Environmental Hazard'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  issueType = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text('Location',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: 'e.g. Mining Zone A',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Description',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Describe the safety issue...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Severity',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: severity,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Low', child: Text('Low')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'High', child: Text('High')),
                DropdownMenuItem(value: 'Critical', child: Text('Critical')),
              ],
              onChanged: (value) {
                setState(() {
                  severity = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.camera_alt_outlined, size: 35),
                  SizedBox(height: 8),
                  Text('Photo Evidence'),
                  SizedBox(height: 4),
                  Text(
                    'Tap to capture or upload photo',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (issueType == 'Select Issue Type' ||
                      locationController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields.'),
                      ),
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Report Submitted'),
                      content: const Text(
                        'Safety issue has been successfully reported to the Field Officer.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('SUBMIT REPORT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}