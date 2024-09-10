import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ErrorReport extends StatefulWidget {
  const ErrorReport({super.key});

  @override
  State<ErrorReport> createState() => _ErrorReportState();
}

class _ErrorReportState extends State<ErrorReport> {
  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['visionwill3322@gmail.com'],
    cc: ['cc@example.com'],
    bcc: ['bcc@example.com'],
    attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('a'),
              TextButton(
                  onPressed: () async {
                    try {
                      await FlutterEmailSender.send(email);
                    } catch (e) {
                      print('e : ${e}');
                    }
                  },
                  child: Text('aa')),
            ],
          ),
        ),
      ),
    );
  }
}
