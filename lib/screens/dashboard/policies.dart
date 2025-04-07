import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policies & Guidelines'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicySection(
              'Complaint Guidelines',
              [
                'All complaints must be submitted with accurate information',
                'Complaints should be specific and include relevant details',
                'Avoid using offensive or inappropriate language',
                'Attach supporting documents when necessary',
                'Follow up on your complaint within the specified timeframe',
              ],
            ),
            const SizedBox(height: 15),
            _buildPolicySection(
              'Privacy Policy',
              [
                'Your personal information is kept confidential',
                'Complaint details are only shared with relevant authorities',
                'Data is stored securely and protected',
                'You can request to view your data at any time',
                'Your data will be retained as per institutional policy',
              ],
            ),
            const SizedBox(height: 15),
            _buildPolicySection(
              'Resolution Timeline',
              [
                'Initial response within 24 hours',
                'Basic complaints resolved within 3-5 working days',
                'Complex issues may take up to 14 working days',
                'Updates will be provided regularly',
                'Escalation available after specified timeline',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...points.map((point) => _buildPolicyPoint(point)),
      ],
    );
  }

  Widget _buildPolicyPoint(String point) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 8),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              point,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
