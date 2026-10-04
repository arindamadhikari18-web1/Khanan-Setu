import 'package:flutter/material.dart';
import 'arrow_button.dart';
class CorporateAdminDashboardScreen extends StatefulWidget {
  const CorporateAdminDashboardScreen({super.key});

  @override
  State<CorporateAdminDashboardScreen> createState() =>
      _CorporateAdminDashboardScreenState();
}

class _CorporateAdminDashboardScreenState
    extends State<CorporateAdminDashboardScreen> {
  final List<Map<String, dynamic>> mines = [
    {
      'name': 'Raniganj Coal Mine',
      'location': 'West Bengal',
      'score': 94,
      'status': 'Compliant',
      'risk': 'Low',
    },
    {
      'name': 'Jharia Coal Mine',
      'location': 'Jharkhand',
      'score': 87,
      'status': 'Attention',
      'risk': 'Medium',
    },
    {
      'name': 'Korba Coal Mine',
      'location': 'Chhattisgarh',
      'score': 72,
      'status': 'Attention',
      'risk': 'High',
    },
    {
      'name': 'Singrauli Coal Mine',
      'location': 'Madhya Pradesh',
      'score': 61,
      'status': 'Critical',
      'risk': 'Critical',
    },
  ];

  Color statusColor(String status) {
    if (status == 'Compliant') return Colors.green;
    if (status == 'Attention') return Colors.orange;
    return Colors.red;
  }

  Color riskColor(String risk) {
    if (risk == 'Low') return Colors.green;
    if (risk == 'Medium') return Colors.orange;
    if (risk == 'High') return Colors.deepOrange;
    return Colors.red;
  }

  void showMineDetails(Map<String, dynamic> mine) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            mine['name'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location: ${mine['location']}'),
              const SizedBox(height: 12),
              Text('Compliance Score: ${mine['score']}%'),
              const SizedBox(height: 12),
              Text('Status: ${mine['status']}'),
              const SizedBox(height: 12),
              Text('Risk Level: ${mine['risk']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  void showCriticalAlerts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Critical Alerts',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '7 active governance alerts',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                alertItem(
                  'PPE Compliance Violation',
                  'Singrauli Coal Mine',
                  'Critical Risk • AI 94%',
                ),
                alertItem(
                  'Machinery Safety Issue',
                  'Korba Coal Mine',
                  'High Risk • AI 89%',
                ),
                alertItem(
                  'Environmental Compliance',
                  'Jharia Coal Mine',
                  'High Risk • AI 86%',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget alertItem(
    String title,
    String mine,
    String risk,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(mine),
                const SizedBox(height: 4),
                Text(
                  risk,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAIInsight() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF0B5D3B),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'AI Corporate Risk Insight',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  'Overall Governance Risk',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 3),
                const Text(
                  'HIGH',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'AI Confidence',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 3),
                const Text(
                  '93%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Highest Risk Mine',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Singrauli Coal Mine',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'AI Recommendation:\n\n'
                    'Prioritize critical mines for immediate inspection. '
                    'Review recurring PPE and machinery safety violations '
                    'and verify corrective actions within 24 hours.',
                    style: TextStyle(height: 1.5),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B5D3B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                    child: const Text('CLOSE'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void generateReport() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Governance Report',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Corporate governance report generated successfully.\n\n'
            'Total Mines: 12\n'
            'Compliant Mines: 8\n'
            'Attention Required: 3\n'
            'Critical Mines: 1\n'
            'Critical Alerts: 7',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 27,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mineCard(Map<String, dynamic> mine) {
    final Color risk = riskColor(mine['risk']);

    return GestureDetector(
      onTap: () => showMineDetails(mine),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(
                    Icons.factory_outlined,
                    color: Color(0xFF0B5D3B),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mine['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        mine['location'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${mine['score']}%',
                  style: TextStyle(
                    color: risk,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: mine['score'] / 100,
                      minHeight: 7,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(risk),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  mine['status'],
                  style: TextStyle(
                    color: statusColor(mine['status']),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
          leading: const ArrowButton(),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Corporate Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showCriticalAlerts,
            icon: const Icon(
              Icons.notifications_outlined,
              size: 29,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Evening, Corporate Admin 👋',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Multi-mine governance & compliance overview',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              // SUMMARY
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.75,
                children: [
                  statCard(
                    'Total Mines',
                    '12',
                    Icons.factory_outlined,
                    Colors.blue,
                  ),
                  statCard(
                    'Compliant',
                    '8',
                    Icons.verified_outlined,
                    Colors.green,
                  ),
                  statCard(
                    'Attention',
                    '3',
                    Icons.warning_amber_rounded,
                    Colors.orange,
                  ),
                  statCard(
                    'Critical',
                    '1',
                    Icons.dangerous_outlined,
                    Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // MINE-WISE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Mine-wise Compliance',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: generateReport,
                    child: const Text(
                      'REPORT',
                      style: TextStyle(
                        color: Color(0xFF0B5D3B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ...mines.map(mineCard),

              const SizedBox(height: 8),

              // CRITICAL ALERT
              GestureDetector(
                onTap: showCriticalAlerts,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.red.shade100,
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.warning_amber_rounded,
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
                              'Critical Alerts',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '7 active governance alerts require attention',
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // AI INSIGHT
              GestureDetector(
                onTap: showAIInsight,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF0B5D3B),
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
                              'AI Corporate Risk Insight',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'AI detected high governance risk across mines',
                            ),
                          ],
                        ),
                      ),
                      Icon(
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
      ),
    );
  }
}