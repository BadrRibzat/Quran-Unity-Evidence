import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ReligionsTruthApp());
}

class ReligionsTruthApp extends StatelessWidget {
  const ReligionsTruthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unity of Abraham',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
        Locale('ru'),
        Locale('zh'),
        Locale('ja'),
      ],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const QuranReaderScreen(),
    const QuestionsAnswersScreen(),
    const AboutMeScreen(),
    const SupportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Quran',
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer),
            label: 'Truth',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'About',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}

// ==================== QURAN READER SCREEN ====================
class QuranReaderScreen extends StatefulWidget {
  const QuranReaderScreen({super.key});

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  String selectedLanguage = 'en';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read the Quran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguageDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search verses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                // Implement search
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 114, // Number of Surahs
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Surah ${index + 1}'),
                    subtitle: const Text('Click to read'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahDetailScreen(
                            surahNumber: index + 1,
                            language: selectedLanguage,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Translation Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption('English', 'en'),
            _languageOption('العربية', 'ar'),
            _languageOption('Français', 'fr'),
            _languageOption('Español', 'es'),
            _languageOption('Русский', 'ru'),
            _languageOption('中文', 'zh'),
            _languageOption('日本語', 'ja'),
          ],
        ),
      ),
    );
  }

  Widget _languageOption(String name, String code) {
    return ListTile(
      title: Text(name),
      trailing: selectedLanguage == code 
        ? const Icon(Icons.check, color: Colors.green)
        : null,
      onTap: () {
        setState(() {
          selectedLanguage = code;
        });
        Navigator.pop(context);
      },
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;
  final String language;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah $surahNumber'),
      ),
      body: FutureBuilder(
        future: _loadSurahData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10, // Will be replaced with actual verse count
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verse ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Arabic text will be loaded from API',
                        style: TextStyle(fontSize: 18),
                        textDirection: TextDirection.rtl,
                      ),
                      const Divider(height: 24),
                      const Text(
                        'Translation will be loaded from API',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _loadSurahData() async {
    // Will implement API call to fetch Quran data
    await Future.delayed(const Duration(seconds: 1));
  }
}

// ==================== Q&A SCREEN ====================
class QuestionsAnswersScreen extends StatelessWidget {
  const QuestionsAnswersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      QAItem(
        question: 'Is humanity one nation according to the Quran?',
        answer: 'Yes! The Quran clearly states that all humans are one nation from Abraham.',
        verses: [
          '\"Indeed, this is your nation - a single nation, and I am your Lord, so worship Me.\" (Quran 21:92)',
          '\"[He is] the religion of your father, Abraham. He named you Muslims...\" (Quran 22:78)',
        ],
      ),
      QAItem(
        question: 'What is the real "Sunnah" according to the Quran?',
        answer: 'The Quran only mentions "Sunnah of Allah" - never "Sunnah of the Prophet".',
        verses: [
          '\"[This is] the established way of Allah which has occurred before. And never will you find in the way of Allah any change.\" (Quran 33:62)',
          '\"Say: I only follow what is revealed to me from my Lord.\" (Quran 7:203)',
        ],
      ),
      QAItem(
        question: 'How should we pray according to the Quran?',
        answer: 'Prayer in the Quran is simple: remembrance of Allah and recitation.',
        verses: [
          '\"And establish prayer for My remembrance.\" (Quran 20:14)',
          '\"So recite what is easy from the Quran.\" (Quran 73:20)',
          '\"Stand before Allah with devotion.\" (Quran 2:238)',
        ],
      ),
      QAItem(
        question: 'Were the first Christians Muslims?',
        answer: 'Yes! The disciples of Jesus called themselves Muslims in the Quran.',
        verses: [
          '\"The disciples said: We are helpers of Allah. We believe in Allah, and bear witness that we are Muslims.\" (Quran 3:52)',
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover the Truth'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QACard(item: questions[index]);
        },
      ),
    );
  }
}

class QAItem {
  final String question;
  final String answer;
  final List<String> verses;

  QAItem({
    required this.question,
    required this.answer,
    required this.verses,
  });
}

class QACard extends StatefulWidget {
  final QAItem item;

  const QACard({super.key, required this.item});

  @override
  State<QACard> createState() => _QACardState();
}

class _QACardState extends State<QACard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.item.question,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.answer,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Evidence from Quran:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.item.verses.map((verse) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        verse,
                        style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ==================== ABOUT ME SCREEN ====================
class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Story'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal,
                child: Text(
                  'BR',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Who Am I?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'My name is Badr Ribzat, a 34-year-old independent researcher from Morocco. '
              'Despite having no formal education due to illness in my childhood, '
              'I taught myself through free online courses and made groundbreaking discoveries '
              'about the unity of divine messages.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'My Journey',
              'I was denied education certificates and faced persecution for my research. '
              'But I never gave up. I discovered that all revealed religions - Judaism, '
              'Christianity, and Islam - are actually one religion, and that the Quran '
              'is the preserved book that proves this truth.',
            ),
            _buildSection(
              context,
              'What I Discovered',
              '• All humanity is one nation from Abraham\n'
              '• The "Sunnah" mentioned in Quran is Allah\'s Sunnah, not prophetic traditions\n'
              '• Prayer is simple: remembrance and Quran recitation\n'
              '• The first Christians were Muslims\n'
              '• The division into sects was a political conspiracy',
            ),
            _buildSection(
              context,
              'My Mission',
              'To reunite humanity under the one true religion as revealed in the preserved Quran, '
              'free from the corruptions and complications added by scholars throughout history.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ==================== SUPPORT SCREEN ====================
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support This Mission'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Help Spread the Truth',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'I am currently facing persecution and have no resources. '
                      'Your support will help me continue this research and spread '
                      'the truth to the world.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildContactCard(
              context,
              'PayPal',
              '@Ribzat',
              Icons.payment,
              () => _launchUrl('https://paypal.me/Ribzat'),
            ),
            _buildContactCard(
              context,
              'Phone / WhatsApp',
              '+212 627 764 176',
              Icons.phone,
              () => _launchUrl('tel:+212627764176'),
            ),
            _buildContactCard(
              context,
              'Alternative Phone',
              '+212 622 200 190',
              Icons.phone,
              () => _launchUrl('tel:+212622200190'),
            ),
            _buildContactCard(
              context,
              'Email',
              'badrribzat@gmail.com',
              Icons.email,
              () => _launchUrl('mailto:badrribzat@gmail.com'),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.teal.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.volunteer_activism,
                      size: 48,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Western Union Transfer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Name: Badr Ribzat\nCountry: Morocco\nCity: Tangier',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '"O Allah, I have conveyed the message. O Allah, bear witness."\n\n'
              'اللهم إني قد بلغت، اللهم فاشهد',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
