import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButtons extends StatelessWidget {
  final String? phoneNumber;
  final String? website;

  const ActionButtons({
    Key? key,
    this.phoneNumber,
    this.website,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context,
            Icons.call,
            'Call',
            phoneNumber != null && phoneNumber!.isNotEmpty,
            () async {
              if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                final Uri uri = Uri.parse('tel:$phoneNumber');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch phone call')),
                  );
                }
              }
            },
          ),
          _buildActionButton(
            context,
            Icons.directions,
            'Directions',
            true,
            () async {
              // final Uri uri = Uri.parse(
              //   'https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent('${context.findAncestorWidgetOfExactType<DetailScreen>()?.placeId ?? ''}')}',
              // );
              // if (await canLaunchUrl(uri)) {
              //   await launchUrl(uri, mode: LaunchMode.externalApplication);
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('Could not launch directions')),
              //   );
              // }
            },
          ),
          _buildActionButton(
            context,
            Icons.web,
            'Website',
            website != null && website!.isNotEmpty,
            () async {
              if (website != null && website!.isNotEmpty) {
                final Uri uri = Uri.parse(website!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch website')),
                  );
                }
              }
            },
          ),
          _buildActionButton(
            context,
            Icons.share,
            'Share',
            true,
            () {
              // Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Share functionality to be implemented')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    bool isEnabled,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
