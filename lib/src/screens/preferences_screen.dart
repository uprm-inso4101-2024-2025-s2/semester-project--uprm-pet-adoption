import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/preference_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentPreferences();
  }

  Future<void> _loadCurrentPreferences() async {
    final prefs = Provider.of<PreferenceManager>(context, listen: false);
    await prefs.loadPreferences();
    if (prefs.preferredAge != null) {
      _ageController.text = prefs.preferredAge!;
    }
    if (prefs.preferredBreed != null) {
      _breedController.text = prefs.preferredBreed!;
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Age',
                  hintText: 'e.g., Puppy, Adult, Senior',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter preferred age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Breed',
                  hintText: 'e.g., Labrador, Siamese, etc.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter preferred breed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _savePreferences,
                child: const Text('Save Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _savePreferences() async {
    if (_formKey.currentState!.validate()) {
      final prefs = Provider.of<PreferenceManager>(context, listen: false);
      await prefs.savePreferences(
        _ageController.text.trim(),
        _breedController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved!')),
      );
      Navigator.pop(context);
    }
  }
}*/

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentPreferences();
  }

  Future<void> _loadCurrentPreferences() async {
    final preferences = ref.read(preferenceManagerProvider);
    if (preferences.preferredAge != null) {
      _ageController.text = preferences.preferredAge!;
    }
    if (preferences.preferredBreed != null) {
      _breedController.text = preferences.preferredBreed!;
    }
  }

  Future<void> _savePreferences() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(preferenceManagerProvider.notifier).savePreferences(
        _ageController.text.trim(),
        _breedController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved!')),
      );
      Navigator.pop(context);
    }
  }

  // ... rest of your existing code
  @override
  void dispose() {
    _ageController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Age',
                  hintText: 'e.g., Puppy, Adult, Senior',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter preferred age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Breed',
                  hintText: 'e.g., Labrador, Siamese, etc.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter preferred breed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _savePreferences,
                child: const Text('Save Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

