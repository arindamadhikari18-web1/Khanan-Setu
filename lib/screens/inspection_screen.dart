import 'package:flutter/material.dart';

import 'ai_analysis_screen.dart';
import 'document_camera_screen.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  String inspectionType = 'Safety Inspection';
  String mineArea = 'Select Mine Area';
  String severity = 'Medium';

  bool ppeCheck = false;
  bool haulRoadCheck = false;
  bool machineryCheck = false;
  bool emergencyCheck = false;

  final TextEditingController observationController =
      TextEditingController();

  @override
  void dispose() {
    observationController.dispose();
    super.dispose();
  }

  void _submitInspection() {
    if (mineArea == 'Select Mine Area') {
      _showMessage('Please select a mine area.');
      return;
    }

    if (observationController.text.trim().isEmpty) {
      _showMessage('Please enter an observation.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AIAnalysisScreen(),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
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
          'New Inspection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            const Text(
              'Field Inspection',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Record field observations and submit for AI risk analysis.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            // MINE
            _sectionTitle('Mine'),
            const SizedBox(height: 10),

            _dropdownCard(
              icon: Icons.factory_outlined,
              title: 'Mine',
              value: 'Raniganj Coal Mine',
              items: const [
                'Raniganj Coal Mine',
              ],
              onChanged: (_) {},
            ),

            const SizedBox(height: 20),

            // INSPECTION TYPE
            _sectionTitle('Inspection Type'),
            const SizedBox(height: 10),

            _dropdownCard(
              icon: Icons.assignment_outlined,
              title: 'Type',
              value: inspectionType,
              items: const [
                'Safety Inspection',
                'Environment Inspection',
                'Equipment Inspection',
                'General Compliance',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    inspectionType = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // MINE AREA
            _sectionTitle('Inspection Area'),
            const SizedBox(height: 10),

            _dropdownCard(
              icon: Icons.location_on_outlined,
              title: 'Area',
              value: mineArea,
              items: const [
                'Select Mine Area',
                'Open Cast Area',
                'Mining Zone A',
                'Mining Zone B',
                'Haul Road',
                'Workshop',
                'Storage Area',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    mineArea = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // GPS
            _sectionTitle('Location'),
            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.gps_fixed,
                    color: Color(0xFF0B5D3B),
                    size: 28,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GPS Location Captured',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Raniganj Coal Mine • Location available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // OBSERVATION
            _sectionTitle('Field Observation'),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: observationController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'Describe what you observed in the mine...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 8,
                      top: 15,
                    ),
                    child: Icon(
                      Icons.edit_note,
                      color: Color(0xFF0B5D3B),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SEVERITY
            _sectionTitle('Severity'),
            const SizedBox(height: 10),

            Row(
              children: [
                _severityButton('Low'),
                const SizedBox(width: 10),
                _severityButton('Medium'),
                const SizedBox(width: 10),
                _severityButton('High'),
                const SizedBox(width: 10),
                _severityButton('Critical'),
              ],
            ),

            const SizedBox(height: 25),

            // PHOTO EVIDENCE
            _sectionTitle('Photo Evidence'),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DocumentCameraScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF0B5D3B),
                      size: 38,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Capture / Upload Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Add visual evidence of the observation',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // SAFETY CHECKLIST
            _sectionTitle('Compliance Checklist'),
            const SizedBox(height: 10),

            _checkCard(
              title: 'PPE Compliance',
              subtitle: 'Helmet, safety shoes, reflective jacket',
              value: ppeCheck,
              onChanged: (value) {
                setState(() {
                  ppeCheck = value ?? false;
                });
              },
            ),

            _checkCard(
              title: 'Haul Road Safety',
              subtitle: 'Road condition and safety barriers',
              value: haulRoadCheck,
              onChanged: (value) {
                setState(() {
                  haulRoadCheck = value ?? false;
                });
              },
            ),

            _checkCard(
              title: 'Machinery Safety',
              subtitle: 'Equipment condition and guarding',
              value: machineryCheck,
              onChanged: (value) {
                setState(() {
                  machineryCheck = value ?? false;
                });
              },
            ),

            _checkCard(
              title: 'Emergency Preparedness',
              subtitle: 'Emergency equipment and access',
              value: emergencyCheck,
              onChanged: (value) {
                setState(() {
                  emergencyCheck = value ?? false;
                });
              },
            ),

            const SizedBox(height: 30),

            // SUBMIT
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _submitInspection,
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  'SUBMIT & ANALYSE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B5D3B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Center(
              child: Text(
                'Inspection data will be analysed by the AI decision-support system.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _dropdownCard({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF0B5D3B),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _severityButton(String value) {
    final bool selected = severity == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            severity = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF0B5D3B)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF0B5D3B)
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF0B5D3B),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}