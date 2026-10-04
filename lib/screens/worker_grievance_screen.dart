import 'package:flutter/material.dart';

class WorkerGrievanceScreen extends StatefulWidget {
  const WorkerGrievanceScreen({super.key});

  @override
  State<WorkerGrievanceScreen> createState() =>
      _WorkerGrievanceScreenState();
}

class _WorkerGrievanceScreenState extends State<WorkerGrievanceScreen> {
  String category = 'Workplace Issue';

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grievance'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submit Grievance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Submit your concern to the mine management.',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Workplace Issue',
                  child: Text('Workplace Issue'),
                ),
                DropdownMenuItem(
                  value: 'Safety Concern',
                  child: Text('Safety Concern'),
                ),
                DropdownMenuItem(
                  value: 'Attendance',
                  child: Text('Attendance'),
                ),
                DropdownMenuItem(
                  value: 'Facilities',
                  child: Text('Facilities'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Subject',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                hintText: 'Enter grievance subject',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Describe your grievance...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (subjectController.text.isEmpty ||
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
                      title: const Text('Grievance Submitted'),
                      content: const Text(
                        'Your grievance has been submitted successfully.',
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
                label: const Text('SUBMIT GRIEVANCE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}