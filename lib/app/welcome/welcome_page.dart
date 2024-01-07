import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/home_page.dart';
import 'welcome_view_model.dart';

class WelcomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final viewModel = ref.watch(welcomeViewModelProvider);
    return ProgressHUD(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Color(0xFF202124),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Image.asset(
                    'assets/images/logomain.png',
                    width: screenWidth / 1,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,

                    elevation: 3,
                    minimumSize: Size(110, 37), //////// HERE
                  ),
                  onPressed: () async {
                    final progress = ProgressHUD.of(context);
                    progress!.show();
                    await viewModel.signUp();
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    progress.dismiss();
                  },
                  child: Text('Get Started'),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _launchURL(
                        'https://www.privacypolicies.com/live/08ba4ed6-16f0-4327-b25a-3c4b2ba463fa');
                  },
                  child: const Text(
                    'By Tapping Get Started \nyou are agreeing to the Terms and Conditions.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
