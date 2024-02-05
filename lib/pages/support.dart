import 'package:flutter/material.dart';

import 'navigation.dart';
class SupportPage extends StatefulWidget {
  final String userId;
  final String page;
  const SupportPage({super.key, required this.userId, required this.page});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(
        userId: "userId",
        currentPage: "support",
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Support Staff Contacts'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Numbers:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ContactCard(
              name: 'ABC',
              phoneNumber: '+1 123 456 7890',
            ),
            ContactCard(
              name: 'XYZ',
              phoneNumber: '+1 987 654 3210',
            ),
            SizedBox(height: 16),
            Text(
              'Emails:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ContactCard(
              name: 'Support Team',
              email: 'support@example.com',
            ),
            ContactCard(
              name: 'Technical Support',
              email: 'techsupport@example.com',
            ),
            SizedBox(height: 16),
            Text(
              'Websites:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ContactCard(
              name: 'Company Website',
              website: 'https://www.example.com',
            ),
            ContactCard(
              name: 'Support Portal',
              website: 'https://support.example.com',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? website;

  const ContactCard({
    required this.name,
    this.phoneNumber,
    this.email,
    this.website,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (phoneNumber != null)
              Text(
                'Phone: $phoneNumber',
                style: TextStyle(color: Colors.blue),
              ),
            if (email != null)
              Text(
                'Email: $email',
                style: TextStyle(color: Colors.blue),
              ),
            if (website != null)
              Text(
                'Website: $website',
                style: TextStyle(color: Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}

