import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'menu_screen.dart'; // Make sure this import exists for MenuScreen

// Data model for a single FAQ
class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

// Data model for a section of FAQs
class FAQSection {
  final String category;
  final List<FAQItem> faqs;

  FAQSection({required this.category, required this.faqs});
}

class FAQ_Screen extends StatefulWidget {
  const FAQ_Screen({Key? key}) : super(key: key);

  @override
  State<FAQ_Screen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQ_Screen> {
  // Scaffold key for opening the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // The user's current search text
  String _searchQuery = '';

  // Example data for Pet Adoption FAQs
  final List<FAQItem> _adoptionFAQs = [
    FAQItem(
      question: 'How do I adopt a pet from the app?',
      answer:
      'To adopt a pet, you must be at least 18 years old. Provide valid ID, complete the application, and pay any required fees.',
    ),
    FAQItem(
      question: 'What are the requirements for adoption?',
      answer:
      'Requirements can vary, but typically include a valid ID, proof of residence, and possibly a home visit.',
    ),
    FAQItem(
      question: 'How long does the adoption process take?',
      answer:
      'Most adoptions are completed within a few days, depending on paperwork and approvals.',
    ),
    FAQItem(
      question: 'Are there adoption fees?',
      answer:
      'Yes, adoption fees help cover medical care, vaccinations, microchipping, and more.',
    ),
    FAQItem(
      question: 'Can I return a pet if the adoption doesn’t work out?',
      answer:
      'Many organizations allow returns within a set timeframe. Check your adoption contract or ask the shelter.',
    ),
  ];

  // Example data for Pet Care FAQs
  final List<FAQItem> _careFAQs = [
    FAQItem(
      question: 'How do I take care of a newly adopted pet?',
      answer:
      'Provide a safe space, schedule a vet check-up, and introduce them slowly to your home and family.',
    ),
    FAQItem(
      question: 'What vaccinations does my pet need?',
      answer:
      'Core vaccinations typically include rabies, distemper, and parvovirus. Consult your vet for details.',
    ),
    FAQItem(
      question: 'How often should I take my pet to the vet?',
      answer:
      'At least once a year for routine exams. Senior pets or pets with health issues may need more frequent visits.',
    ),
    FAQItem(
      question: 'What should I feed my pet?',
      answer:
      'Choose a high-quality food suitable for your pet’s age, size, and health. Always have fresh water available.',
    ),
    FAQItem(
      question: 'How can I train my pet?',
      answer:
      'Use positive reinforcement techniques, be consistent, and consider professional training classes if needed.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Combine both sections
    final sections = [
      FAQSection(
        category: 'Pet Adoption Questions',
        faqs: _adoptionFAQs,
      ),
      FAQSection(
        category: 'Pet Care Questions',
        faqs: _careFAQs,
      ),
    ];

    // Filter based on the search query
    final filteredSections = sections.map((section) {
      final filteredFaqs = section.faqs.where((faq) {
        final query = _searchQuery.toLowerCase();
        return faq.question.toLowerCase().contains(query) ||
            faq.answer.toLowerCase().contains(query);
      }).toList();
      return FAQSection(category: section.category, faqs: filteredFaqs);
    }).toList();

    // Count total results after filtering
    final allFilteredFaqsCount = filteredSections.fold<int>(
      0,
          (sum, section) => sum + section.faqs.length,
    );

    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key
      endDrawer: const MenuScreen(), // Add the MenuScreen as a drawer instead of full-screen
      appBar: AppBar(
        automaticallyImplyLeading: false, // disables automatic hamburger
        backgroundColor: Colors.yellow,
        // ✅ Menu icon to open drawer
        leading: IconButton(
          icon: Image.asset(
            'assets/images/Arrow_Circle_dms.png',
            width: 40,
            height: 40,
          ),
          onPressed: () => context.go('/?openMenu=true'),

        ),
        title: const  Text(
          'FAQ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          const SizedBox.shrink(), // placeholder to block auto hamburger
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search FAQs',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Icon & Header Text
              Column(
                children: [
                  const Icon(
                    Icons.help_outline,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find answers to common questions\nabout pet adoption and care',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Display a message if no FAQs match the search query
              if (_searchQuery.isNotEmpty && allFilteredFaqsCount == 0)
                const Text(
                  'Question not found.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),

              // Otherwise, show each section with its FAQs
              for (var section in filteredSections) ...[
                if (section.faqs.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        section.category,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (var faq in section.faqs) _buildFAQCard(faq),
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a single FAQ card as an ExpansionTile
  Widget _buildFAQCard(FAQItem faq) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              faq.answer,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}