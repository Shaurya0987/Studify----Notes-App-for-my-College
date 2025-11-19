import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  // OPEN URL FUNCTION
  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          height: 550,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                offset: Offset(0, 8),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 50),

                // PROFILE IMAGE
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.blue.shade800,
                  ),
                ),

                const SizedBox(height: 30),

                // NAME
                Text(
                  "Shaurya Thakur",
                  style: TextStyle(
                    fontFamily: 'Stack',
                    fontSize: 34,
                    color: const Color(0xFF034896),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Developer",
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),

                const SizedBox(height: 30),

                // CONTACT BUTTON
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "CONTACT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialCircle(
                      FontAwesomeIcons.github,
                      "https://github.com/Shaurya0987",
                    ),
                    socialCircle(
                      FontAwesomeIcons.linkedin,
                      "https://www.linkedin.com/in/shauryathakur001/",
                    ),
                    socialCircle(
                      FontAwesomeIcons.instagram,
                      "https://instagram.com/sherry_18__/",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SOCIAL ICON BUTTON
  Widget socialCircle(IconData icon, String url) {
    return InkWell(
      onTap: () {
        openLink(url);
      },
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.blue.shade800,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
