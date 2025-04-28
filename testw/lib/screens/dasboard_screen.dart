import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:testw/utils/global_values.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName: Text('JAVIER SILVA LOPEZ'), 
            accountEmail: Text('javiirving915@gmail.com')
            );
        },
        extendedTheme: const SidebarXTheme(
          width: 200
        ),
        controller: SidebarXController(selectedIndex: 0,extended: true),
        items:  [
          SidebarXItem(
            onTap:() { 
              Navigator.pop(context);
              Navigator.pushNamed(context,'/pantallas');
            },
            icon: Icons.home,
            label: 'Challenge-6 App'
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Panel de Control'),
      ),
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        body: const Center(
          child: Text('Irving Javier Silva Lopez'),
        ), 
        items: [
          HawkFabMenuItem(
            label: 'Theme Light', 
            ontap: ()=>GlobalValues.themeMode.value=1,
            icon:const Icon(Icons.light_mode)
            ),
            HawkFabMenuItem(
            label: 'Theme Dark', 
            ontap: ()=>GlobalValues.themeMode.value=0,
            icon:const Icon(Icons.dark_mode)
            )
        ]
      )
    );
  }
}


