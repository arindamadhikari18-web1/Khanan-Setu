import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int criticalCount = 3;
  int pendingCount = 9;
  int completedCount = 26;

  String currentStatus = 'OPEN';

  final List<Map<String, String>> criticalCases = [
    {
      'title': 'PPE Compliance Violation',
      'location': 'Mining Zone A',
      'severity': 'CRITICAL',
      'time': 'Today • 10:32 AM',
      'risk': '92%',
      'finding':
          'Workers found without required personal protective equipment.',
      'recommendation':
          'Immediate PPE compliance inspection and corrective action required.',
    },
    {
      'title': 'Machinery Safety Issue',
      'location': 'Workshop Area',
      'severity': 'CRITICAL',
      'time': 'Today • 09:15 AM',
      'risk': '89%',
      'finding':
          'Safety guard issue detected in heavy mining equipment.',
      'recommendation':
          'Stop equipment operation and perform immediate safety verification.',
    },
    {
      'title': 'Emergency Preparedness Issue',
      'location': 'Open Cast Area',
      'severity': 'CRITICAL',
      'time': 'Yesterday • 04:45 PM',
      'risk': '86%',
      'finding':
          'Emergency response equipment requires inspection.',
      'recommendation':
          'Verify emergency equipment and update preparedness checklist.',
    },
  ];

  final List<Map<String, String>> pendingActions = [
    {
      'issue': 'PPE Compliance Violation',
      'location': 'Mining Zone A',
      'assigned': 'Field Officer',
      'deadline': '24 Hours',
      'status': 'ASSIGNED',
    },
    {
      'issue': 'Haul Road Inspection',
      'location': 'Open Cast Area',
      'assigned': 'Field Officer',
      'deadline': '48 Hours',
      'status': 'PENDING',
    },
    {
      'issue': 'Safety Certificate Renewal',
      'location': 'Workshop',
      'assigned': 'Mine Admin',
      'deadline': '5 Days',
      'status': 'PENDING',
    },
  ];

  final List<Map<String, String>> completedActions = [
    {
      'issue': 'PPE Check - Zone B',
      'completedBy': 'Field Officer',
      'date': '25 Sep 2026',
    },
    {
      'issue': 'Fire Safety Inspection',
      'completedBy': 'Safety Team',
      'date': '24 Sep 2026',
    },
    {
      'issue': 'Equipment Maintenance',
      'completedBy': 'Maintenance Team',
      'date': '23 Sep 2026',
    },
  ];

  void showCriticalCases() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CriticalCasesScreen(
          cases: criticalCases,
          onSelect: showCriticalDetails,
        ),
      ),
    );
  }

  void showCriticalDetails(Map<String, String> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.shade50,
                      child: const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Critical Safety Alert',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _detailRow('Problem', item['title']!),
                _detailRow('Location', item['location']!),
                _detailRow('Detected', item['time']!),
                _detailRow('Severity', item['severity']!),
                _detailRow('AI Risk Confidence', item['risk']!),

                const SizedBox(height: 15),

                const Text(
                  'AI Finding',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(item['finding']!),

                const SizedBox(height: 15),

                const Text(
                  'AI Recommendation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(item['recommendation']!),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Current Status: $currentStatus',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showAssignAction(item);
                    },
                    icon: const Icon(Icons.assignment_turned_in),
                    label: const Text('ASSIGN CORRECTIVE ACTION'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAssignAction(Map<String, String> item) {
    String assignee = 'Field Officer';
    String deadline = '24 Hours';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Assign Corrective Action'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    value: assignee,
                    decoration: const InputDecoration(
                      labelText: 'Assign To',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Field Officer',
                        child: Text('Field Officer'),
                      ),
                      DropdownMenuItem(
                        value: 'Safety Team',
                        child: Text('Safety Team'),
                      ),
                      DropdownMenuItem(
                        value: 'Maintenance Team',
                        child: Text('Maintenance Team'),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        assignee = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: deadline,
                    decoration: const InputDecoration(
                      labelText: 'Deadline',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: '24 Hours',
                        child: Text('24 Hours'),
                      ),
                      DropdownMenuItem(
                        value: '48 Hours',
                        child: Text('48 Hours'),
                      ),
                      DropdownMenuItem(
                        value: '5 Days',
                        child: Text('5 Days'),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        deadline = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  const TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Corrective Action',
                      hintText: 'Ensure PPE compliance',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);

                    setState(() {
                      currentStatus = 'ASSIGNED';
                    });

                    showFieldOfficerFix(item);
                  },
                  child: const Text('ASSIGN'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showFieldOfficerFix(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.engineering,
                color: Color(0xFF0B5D3B),
              ),
              SizedBox(width: 8),
              Text('Field Officer Task'),
            ],
          ),
          content: const Text(
            'Corrective action assigned successfully.\n\n'
            'Field Officer must fix the issue and submit photo proof.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showPhotoProof(item);
              },
              child: const Text('VIEW FIX DEMO'),
            ),
          ],
        );
      },
    );
  }

  void showPhotoProof(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Photo Proof Submitted'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_camera,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('Corrective Action Photo'),
                    Text(
                      'PPE compliance restored',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Field Officer has submitted proof that the issue has been fixed.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showVerification(item);
              },
              child: const Text('CONTINUE TO VERIFICATION'),
            ),
          ],
        );
      },
    );
  }

  void showVerification(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.verified,
                color: Colors.green,
              ),
              SizedBox(width: 8),
              Text('Manager Verification'),
            ],
          ),
          content: const Text(
            'Photo proof has been submitted.\n\n'
            'Verify that the corrective action is complete and the safety issue has been resolved.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('REJECT'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  currentStatus = 'CLOSED';
                  criticalCount = criticalCount > 0
                      ? criticalCount - 1
                      : 0;
                  pendingCount = pendingCount > 0
                      ? pendingCount - 1
                      : 0;
                  completedCount++;
                });

                showClosedMessage();
              },
              icon: const Icon(Icons.check),
              label: const Text('VERIFY & CLOSE'),
            ),
          ],
        );
      },
    );
  }

  void showClosedMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Issue Closed ✅'),
          content: const Text(
            'Corrective action verified successfully.\n\n'
            'The safety violation has been marked as CLOSED and dashboard statistics have been updated.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('DONE'),
            ),
          ],
        );
      },
    );
  }

  void showPendingActions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PendingActionsScreen(
          actions: pendingActions,
        ),
      ),
    );
  }

  void showCompletedActions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompletedActionsScreen(
          actions: completedActions,
        ),
      ),
    );
  }

  void showAIAnalysis() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF0B5D3B),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'AI Governance Analysis',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                _aiBox(
                  'Overall Risk',
                  'HIGH',
                  Colors.orange,
                ),

                _aiBox(
                  'Top Risk',
                  'PPE Compliance',
                  Colors.red,
                ),

                _aiBox(
                  'AI Confidence',
                  '92%',
                  Colors.green,
                ),

                const SizedBox(height: 15),

                const Text(
                  'Detected Pattern',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Repeated PPE violations have been detected in Mining Zone A.',
                ),

                const SizedBox(height: 18),

                const Text(
                  'AI Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  'Immediate corrective action is recommended. '
                  'Conduct a follow-up inspection within 24 hours '
                  'and verify compliance using photo evidence.',
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'AI analysis completed successfully.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _aiBox(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
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
          'Mine Manager Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications.'),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                25,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF0B5D3B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning, Manager 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Raniganj Coal Mine • West Bengal',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // COMPLIANCE
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 85,
                      height: 85,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 0.94,
                            strokeWidth: 8,
                            backgroundColor:
                                Colors.grey.shade200,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFF0B5D3B),
                            ),
                          ),
                          const Text(
                            '94%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compliance Score',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Overall mine compliance',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'AI monitored • Updated today',
                          style: TextStyle(
                            color: Color(0xFF0B5D3B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // CLICKABLE STATS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  _statCard(
                    'Critical',
                    criticalCount.toString(),
                    Icons.warning_amber_rounded,
                    Colors.red,
                    showCriticalCases,
                  ),
                  const SizedBox(width: 9),
                  _statCard(
                    'Pending',
                    pendingCount.toString(),
                    Icons.pending_actions,
                    Colors.orange,
                    showPendingActions,
                  ),
                  const SizedBox(width: 9),
                  _statCard(
                    'Completed',
                    completedCount.toString(),
                    Icons.check_circle_outline,
                    Colors.green,
                    showCompletedActions,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // CRITICAL ALERT
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Critical Alerts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  InkWell(
                    onTap: () =>
                        showCriticalDetails(
                      criticalCases[0],
                    ),
                    borderRadius:
                        BorderRadius.circular(15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.red.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Colors.red.shade50,
                            child: const Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PPE Compliance Violation',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Mining Zone A • CRITICAL',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Tap to view full alert details',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // AI ASSISTANT
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: InkWell(
                onTap: showAIAnalysis,
                borderRadius:
                    BorderRadius.circular(18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0B5D3B),
                        Color(0xFF167A50),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Governance Assistant',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tap for AI risk analysis & recommendation',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor:
            const Color(0xFF0B5D3B),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_outlined,
            ),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


// ============================================================
// CRITICAL CASES SCREEN
// ============================================================

class CriticalCasesScreen extends StatelessWidget {
  final List<Map<String, String>> cases;
  final Function(Map<String, String>) onSelect;

  const CriticalCasesScreen({
    super.key,
    required this.cases,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Critical Situations'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final item = cases[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade50,
                child: const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${item['location']}\nRisk: ${item['risk']}',
              ),
              isThreeLine: true,
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => onSelect(item),
            ),
          );
        },
      ),
    );
  }
}


// ============================================================
// PENDING ACTIONS SCREEN
// ============================================================

class PendingActionsScreen extends StatelessWidget {
  final List<Map<String, String>> actions;

  const PendingActionsScreen({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pending Corrective Actions',
        ),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final item = actions[index];

          return Card(
            margin:
                const EdgeInsets.only(bottom: 14),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor:
                    Colors.orange.shade50,
                child: const Icon(
                  Icons.pending_actions,
                  color: Colors.orange,
                ),
              ),
              title: Text(
                item['issue']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Location: ${item['location']}\n'
                'Assigned: ${item['assigned']}\n'
                'Deadline: ${item['deadline']}',
              ),
              isThreeLine: true,
              trailing: Text(
                item['status']!,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


// ============================================================
// COMPLETED ACTIONS SCREEN
// ============================================================

class CompletedActionsScreen extends StatelessWidget {
  final List<Map<String, String>> actions;

  const CompletedActionsScreen({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Completed Actions',
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final item = actions[index];

          return Card(
            margin:
                const EdgeInsets.only(bottom: 14),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor:
                    Colors.green.shade50,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              title: Text(
                item['issue']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Completed by: ${item['completedBy']}\n'
                'Date: ${item['date']}',
              ),
              isThreeLine: true,
              trailing: const Text(
                'CLOSED',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}