import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ReligionsTruthApp());
}

class ReligionsTruthApp extends StatelessWidget {
  const ReligionsTruthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Religions Truth',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
        Locale('fr'), // French
        Locale('es'), // Spanish
        Locale('de'), // German
        Locale('ja'), // Japanese
        Locale('ru'), // Russian
        Locale('zh'), // Chinese
      ],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Religions Truth'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // Language selection dialog
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Religions Truth',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Discover the unity of divine messages across all revealed scriptures'),
            SizedBox(height: 32),
            FeatureCard(
              title: 'Search Quran',
              icon: Icons.search,
            ),
            FeatureCard(
              title: 'Evidence Browser',
              icon: Icons.menu_book,
            ),
            FeatureCard(
              title: 'Topics',
              icon: Icons.category,
            ),
            FeatureCard(
              title: 'Scripture Comparison',
              icon: Icons.compare,
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to feature - we'll implement this later
          // For now, just handle the tap without printing
        },
      ),
    );
  }
}
