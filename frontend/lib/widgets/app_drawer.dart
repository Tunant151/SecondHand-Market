import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'Second Hand Market',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search Products'),
            onTap: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Sell Item'),
            onTap: () {
              Navigator.pushNamed(context, '/sell-item');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('My Cart'),
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('My Listings'),
            onTap: () {
              Navigator.pushNamed(context, '/my-listings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // TODO: Implement settings
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // TODO: Implement logout
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            onTap: () {
              Navigator.pushNamed(context, '/analytics');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Messages'),
            onTap: () {
              Navigator.pushNamed(context, '/messages');
            },
          ),
        ],
      ),
    );
  }
}
