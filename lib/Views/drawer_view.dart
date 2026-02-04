import 'package:chat_with_me_now/Views/settings_view.dart';
import 'package:chat_with_me_now/helper/consts.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: Column(
          children: [
            SizedBox(height: 40),

            Center(child: Image.asset(kAppIcon)),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('H O M E'),
                leading: Icon(Icons.home),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsView();
                    },
                  ),
                );
              },
              child: ListTile(
                title: Text('S E T T I N G S'),
                leading: Icon(Icons.settings),
              ),
            ),
            Spacer(flex: 1),
            GestureDetector(
              onTap: () {
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },

              child: ListTile(
                title: Text('L O G O U T'),
                leading: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
