import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/spider.png'),
              ),
              accountName: Text('Jose Andres'), 
              accountEmail: Text('18030514@itcelaya.edu.mx')
              ),
              ListTile(
                title: Text('FruitApp'),
                subtitle: Text('Widget Challenge'),
                leading: Icon(Icons.restaurant),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, '/fruit');
                },
              ),
              ListTile(
                title: Text('Notes App'),
                subtitle: Text('Test SQLite'),
                leading: Icon(Icons.data_exploration),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, '/notes');
                },
              ),
              ListTile(
                title: Text('MoviesApp'),
                subtitle: Text('Test Api'),
                leading: Icon(Icons.movie),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, '/movies');
                },
              ),
              ListTile(
                title: Text('About US'),
                subtitle: Text('Test Map'),
                leading: Icon(Icons.help),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, '/about');
                },
              )
          ],
        ),
      ),
    );
  }
}