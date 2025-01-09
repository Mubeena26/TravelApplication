// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Customer Support",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can we help you?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(thickness: 1, color: Colors.black),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.phone_in_talk_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  "Call Support",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  final Uri url = Uri(scheme: 'tel', path: '7025963877');

                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "can't do the call",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.black));
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  "Email Support",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  final Uri url =
                      Uri(scheme: 'mailto', path: 'mubee160@gmail.com');

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "can't do the sms",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.black));
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.sms_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  "SMS Support",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  final Uri url = Uri(scheme: 'sms', path: '7025963877');

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "can't do the sms",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.black));
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                title: const Text(
                  "Office Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  final Uri url = Uri(
                    scheme: 'geo',
                    path: '11.258260547089058, 75.79156079541575',
                  );

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "can't do the direction",
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.black,
                    ));
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                  thickness: 1,
                  // endIndent: mediaquerywidht(0.25, context),
                  color: Colors.black),
              Expanded(
                child: ListView(
                  children: const [
                    ExpansionTile(
                      title: Text(
                        "How do I contact customer support?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "You can contact customer support by calling our support number, sending an email, or sms message",
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "What is your refund policy?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Our refund policy allows you to request a refund within 30 days of purchase. Please contact customer support by calling our support number, sending an email, or sms message",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
