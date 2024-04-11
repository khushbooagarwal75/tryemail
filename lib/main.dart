import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // _launchEmail();

            var connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.none) {
              // No internet connection
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('No Internet Connection'),
                  content: Text('Please check your internet connection.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            } else {
              _launchEmail();
            }
          },
          child: Text('Send Email'),
        ),
      ),

    );

  }
}

void _launchEmail() async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'khushbooagarwal7777@gmail.com', // Replace with recipient email
    queryParameters: {
      'subject': 'Hello', // Email subject
      'body': 'This is a test email sent from my Flutter app.', // Email body
    },
  );

  try {
      await launch(_emailLaunchUri.toString());
    }
   catch (e) {
    print('Error launching email: $e');
  }
}

