import 'package:cycle_resale_app/pages/gallery_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class InfoPage extends StatefulWidget {
  final String imageUrl;

  InfoPage({required this.imageUrl});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('userSubmissions');

  List<Map<String, dynamic>> _userSubmissions = [];

  @override
  void initState() {
    super.initState();
    _getUserSubmissions();
  }

  void _getUserSubmissions() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>? ?? {};

        List<Map<String, dynamic>> submissions = [];

        values.entries.forEach((entry) {
          submissions.add(Map<String, dynamic>.from(entry.value));
        });

        setState(() {
          _userSubmissions = submissions;
        });

        print('Data received: $_userSubmissions');
      }
    }, onError: (Object error) {
      print('Error getting submissions: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD67BFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD67BFF),
        title: Text('User Submissions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _userSubmissions.isEmpty
            ? Center(
          child: Text('No submissions available.'),
        )
            : ListView.builder(
          itemCount: _userSubmissions.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> submission = _userSubmissions[index];
            return ListTile(
              title:
              Text('Organization Name: ${submission['organizationName']}'),
              subtitle: Text(
                  'Contact Person: ${submission['contactPersonName']}'),
              leading: Image.network(submission['imageUrl']), // Add this line
              // Add more fields as needed
            );
          },
        ),
      ),
    );
  }
}