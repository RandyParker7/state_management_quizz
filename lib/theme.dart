import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Theme Configuration
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.blue.shade50,
    appBarTheme: AppBarTheme(
      color: Colors.blue, // Default solid color
      toolbarTextStyle: TextStyle(color: Colors.white),
    ),
  );
  String _currentFont = 'Arial';

  ThemeData get currentTheme => _currentTheme;
  String get currentFont => _currentFont;

  void setTheme(ThemeData theme) {
    _currentTheme = theme.copyWith(
      textTheme: theme.textTheme.apply(fontFamily: _currentFont),
      appBarTheme: AppBarTheme(color: theme.primaryColor),
    );
    notifyListeners();
  }

  void setFont(String font) {
    _currentFont = font;
    _currentTheme = _currentTheme.copyWith(
      textTheme: _currentTheme.textTheme.apply(fontFamily: font),
    );
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: themeNotifier.currentTheme,
          home: MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is Main Screen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: Provider.of<ThemeNotifier>(context, listen: false),
                      child: SettingsScreen(),
                    ),
                  ),
                );
              },
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text('Settings'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title: Select Theme
              Text('Select Theme:', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 10),
              // Theme Selection ListTiles
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.color_lens, color: Colors.blue),
                      title: Text('Theme A'),
                      onTap: () => themeNotifier.setTheme(
                        ThemeData(
                          primarySwatch: Colors.blue,
                          brightness: Brightness.light,
                          scaffoldBackgroundColor: Colors.blue.shade50,
                          appBarTheme: AppBarTheme(
                            toolbarTextStyle: TextStyle(color: Colors.white),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.color_lens, color: Colors.red),
                      title: Text('Theme B'),
                      onTap: () => themeNotifier.setTheme(
                        ThemeData(
                          primarySwatch: Colors.red,
                          brightness: Brightness.dark,
                          scaffoldBackgroundColor: Colors.red.shade900,
                          appBarTheme: AppBarTheme(
                            toolbarTextStyle: TextStyle(color: Colors.white),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.color_lens, color: Colors.green),
                      title: Text('Theme C'),
                      onTap: () => themeNotifier.setTheme(
                        ThemeData(
                          primarySwatch: Colors.green,
                          brightness: Brightness.light,
                          scaffoldBackgroundColor: Colors.green.shade50,
                          appBarTheme: AppBarTheme(
                            toolbarTextStyle: TextStyle(color: Colors.white),
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.color_lens, color: Colors.purple),
                      title: Text('Theme D'),
                      onTap: () => themeNotifier.setTheme(
                        ThemeData(
                          primarySwatch: Colors.purple,
                          brightness: Brightness.light,
                          scaffoldBackgroundColor: Colors.purple.shade50,
                          appBarTheme: AppBarTheme(
                            toolbarTextStyle: TextStyle(color: Colors.white),
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.color_lens, color: Colors.orange),
                      title: Text('Theme E'),
                      onTap: () => themeNotifier.setTheme(
                        ThemeData(
                          primarySwatch: Colors.orange,
                          brightness: Brightness.light,
                          scaffoldBackgroundColor: Colors.orange.shade50,
                          appBarTheme: AppBarTheme(
                            toolbarTextStyle: TextStyle(color: Colors.white),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Title: Select Font
              Text('Select Font:', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 10),
              // Font Selection ListTiles
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.font_download),
                      title: Text('Arial'),
                      onTap: () => themeNotifier.setFont('Arial'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.font_download),
                      title: Text('Courier'),
                      onTap: () => themeNotifier.setFont('Courier'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.font_download),
                      title: Text('Times New Roman'),
                      onTap: () => themeNotifier.setFont('Times New Roman'),
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
