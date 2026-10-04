import 'package:flutter/material.dart';

class RegulatoryAuthorityDashboardScreen extends StatefulWidget {
  const RegulatoryAuthorityDashboardScreen({super.key});

  @override
  State<RegulatoryAuthorityDashboardScreen> createState() =>
      _RegulatoryAuthorityDashboardScreenState();
}

class _RegulatoryAuthorityDashboardScreenState
    extends State<RegulatoryAuthorityDashboardScreen> {
  final List<Map<String, dynamic>> mines = [
    {
      'name': 'Raniganj Coal Mine',
      'location': 'West Bengal',
      'score': 94,
      'status': 'Verified',
      'violations': 2,
    },
    {
      'name': 'Jharia Coal Mine',
      'location': 'Jharkhand',
      'score': 87,
      'status': 'Under Review',
      'violations': 5,
    },
    {
      'name': 'Korba Coal Mine',
      'location': 'Chhattisgarh',
      'score': 72,
      'status': 'Action Required',
      'violations': 9,
    },
    {
      'name': 'Singrauli Coal Mine',
      'location': 'Madhya Pradesh',
      'score': 61,
      'status': 'Critical',
      'violations': 14,
    },
  ];

  Color statusColor(String status) {
    if (status == 'Verified') return Colors.green;
    if (status == 'Under Review') return Colors.orange;
    if (status == 'Action Required') return Colors.deepOrange;
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
              const SizedBox(height: 10),
              Text('Compliance Score: ${mine['score']}%'),
              const SizedBox(height: 10),
              Text('Violations: ${mine['violations']}'),
              const SizedBox(height: 10),
              Text('Status: ${mine['status']}'),
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

  void showViolations() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
                  'Active Violations',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '30 violations across monitored mines',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 18),
                violationItem(
                  'PPE Compliance Violation',
                  'Singrauli Coal Mine',
                  'Critical',
                ),
                violationItem(
                  'Machinery Safety Issue',
                  'Korba Coal Mine',
                  'High',
                ),
                violationItem(
                  'Environmental Compliance',
                  'Jharia Coal Mine',
                  'Medium',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget violationItem(
    String title,
    String mine,
    String severity,
  ) {
    final color = severity == 'Critical'
        ? Colors.red
        : severity == 'High'
            ? Colors.deepOrange
            : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: const Icon(
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
                  '$severity Risk',
                  style: TextStyle(
                    color: color,
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

  void showVerification() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.verified_outlined,
                color: Color(0xFF0B5D3B),
              ),
              SizedBox(width: 10),
              Text('Regulatory Verification'),
            ],
          ),
          content: const Text(
            'Digital verification completed successfully.\n\n'
            'Mine: Raniganj Coal Mine\n'
            'Compliance Score: 94%\n'
            'Documents: Verified\n'
            'Inspection Records: Verified\n'
            'Corrective Actions: Verified\n\n'
            'Verification Status: VALID',
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

  void showInspectionStatus() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                  'Inspection Status',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                inspectionItem(
                  'Raniganj Coal Mine',
                  'Inspection Completed',
                  Colors.green,
                ),
                inspectionItem(
                  'Jharia Coal Mine',
                  'Inspection Under Review',
                  Colors.orange,
                ),
                inspectionItem(
                  'Korba Coal Mine',
                  'Inspection Scheduled',
                  Colors.blue,
                ),
                inspectionItem(
                  'Singrauli Coal Mine',
                  'Urgent Inspection Required',
                  Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget inspectionItem(
    String mine,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assignment_outlined,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mine,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAuditStatus() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Digital Audit Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('✓ Inspection Records Verified'),
              SizedBox(height: 10),
              Text('✓ Compliance Documents Verified'),
              SizedBox(height: 10),
              Text('✓ Corrective Actions Tracked'),
              SizedBox(height: 10),
              Text('✓ Digital Audit Trail Available'),
              SizedBox(height: 10),
              Text('✓ Time & Location Records Available'),
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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
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
    final color = statusColor(mine['status']);

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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                    color: color,
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  mine['status'],
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
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
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Regulatory Authority',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showViolations,
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Evening, Regulatory Authority 👋',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Regulatory oversight & compliance verification',
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
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.75,
                children: [
                  statCard(
                    'Mines Monitored',
                    '12',
                    Icons.factory_outlined,
                    Colors.blue,
                  ),
                  statCard(
                    'Verified',
                    '8',
                    Icons.verified_outlined,
                    Colors.green,
                  ),
                  statCard(
                    'Under Review',
                    '3',
                    Icons.fact_check_outlined,
                    Colors.orange,
                  ),
                  statCard(
                    'Violations',
                    '30',
                    Icons.warning_amber_rounded,
                    Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // INSPECTION STATUS
              GestureDetector(
                onTap: showInspectionStatus,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Color(0xFF0B5D3B),
                        child: Icon(
                          Icons.assignment_outlined,
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
                              'Inspection Monitoring',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'View inspection status across mines',
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

              const SizedBox(height: 18),

              // MINE COMPLIANCE
              const Text(
                'Mine Compliance Overview',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...mines.map(mineCard),

              const SizedBox(height: 8),

              // VIOLATIONS
              GestureDetector(
                onTap: showViolations,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius:
                        BorderRadius.circular(18),
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
                              'Active Violations',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Review violations and regulatory actions',
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

              // REGULATORY VERIFICATION
              GestureDetector(
                onTap: showVerification,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius:
                        BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Color(0xFF0B5D3B),
                        child: Icon(
                          Icons.verified_user_outlined,
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
                              'Regulatory Verification',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Verify compliance documents and actions',
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

              // DIGITAL AUDIT
              GestureDetector(
                onTap: showAuditStatus,
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius:
                        BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.history_edu_outlined,
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
                              'Digital Audit Trail',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'View verified digital compliance records',
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