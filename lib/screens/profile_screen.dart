import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
  static MaterialPage page(User user) {
    return MaterialPage(
      name: FoodiesTogether.profilePath,
      key: ValueKey(FoodiesTogether.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // 1
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            // 2
            Provider.of<AppStateManager>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        const CircleAvatar(
          child: Text('H', ),
    radius: 32,
          ),
        const SizedBox(height: 16.0),
        const Text(
          'Padsala Harshil',
          style: const TextStyle(fontSize: 21),
        ),
        const Text('Flutter Developer'),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}