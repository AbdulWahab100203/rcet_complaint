import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Frequently Asked Questions',
              [
                _buildFAQItem(
                  'How do I submit a complaint?',
                  'To submit a complaint, go to the home screen and tap on the "Add Complaint" button. Fill in the required details and submit.',
                ),
                _buildFAQItem(
                  'How can I track my complaint?',
                  'You can track your complaint status from the "My Complaints" section. Each complaint will show its current status.',
                ),
                _buildFAQItem(
                  'What should I do if my complaint is not resolved?',
                  'If your complaint is not resolved within the expected timeframe, you can escalate it using the "Escalate" button on your complaint details.',
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildSection(
              'Contact Support',
              [
                _buildContactItem(
                  Icons.email,
                  'Email',
                  'support@rcet.edu.in',
                ),
                _buildContactItem(
                  Icons.phone,
                  'Phone',
                  '+91 XXX XXX XXXX',
                ),
                _buildContactItem(
                  Icons.location_on,
                  'Location',
                  'RCET Administrative Office',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        const SizedBox(height: 15),
        ...children,
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String detail) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(detail),
      ),
    );
  }
}
