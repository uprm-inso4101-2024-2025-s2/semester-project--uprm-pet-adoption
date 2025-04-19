import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShelterInfoScreen extends StatelessWidget {
  const ShelterInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> shelters = [
      {
        'name': 'Hope For Rescue',
        'email': 'hopeforarescue@gmail.com',
        'phone': '-',
        'address': 'linktr.ee/hopeforarescue',

      },
      {
        'name': 'Silver Paws PR',
        'email': 'shelter@mail.com',
        'phone': '+1-(787) 472-7603',
        'address': 'Las Marías, Mayagüez 00680',
      },
      {
        'name': 'Villa Michelle Albergue de Animales',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'Las Marías, Mayagüez 00680',
      },
      {
        'name': 'San Juan Municipality Animal Shelter',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'CWM7+2J2, Marginal, San Juan, 00920',
      },
      {
        'name': 'Animal Den Shelter',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'United States, F17–F99, Cll 4, Añasco, 00610',
      },
      {
        'name': 'El Faro de los Animales',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'Cam Alonzo Flecha, Humacao, 00791',
      },
      {
        'name': 'Amigos de los Animales Animal Shelter',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'Rd 187, Interior, C. Playa Kilómetro 5.2, Loíza 00772',
      },
      {
        'name': 'Humane Society of Puerto Rico',
        'email': 'shelter@mail.com',
        'phone': '+1-(787)-555-555',
        'address': 'Cll 16, Guaynabo, 00968',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shelters',
          style: TextStyle(
            fontFamily: 'Archivo',
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 32,
          onPressed: () {
            context.go('/'); // Go back to menu screen
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: shelters.length,
        separatorBuilder: (_, __) => const Divider(thickness: 1.2),
        itemBuilder: (context, index) {
          final shelter = shelters[index];

          return GestureDetector(
            onTap: () => _showShelterPopup(context, shelter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shelter['name']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Archivo',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.email, size: 18),
                    const SizedBox(width: 6),
                    Text(shelter['email']!, style: const TextStyle(fontSize: 15)),
                    const SizedBox(width: 12),
                    const Icon(Icons.phone, size: 18, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(shelter['phone']!, style: const TextStyle(fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        shelter['address']!,
                        style: const TextStyle(fontSize: 15, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showShelterPopup(BuildContext context, Map<String, String> shelter) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromRGBO(255, 245, 129, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Text(
                        shelter['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email, size: 20),
                              const SizedBox(width: 10),
                              Text(shelter['email']!),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 20, color: Colors.blue),
                              const SizedBox(width: 10),
                              Text(shelter['phone']!),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on, size: 20, color: Colors.blueGrey),
                              const SizedBox(width: 10),
                              Expanded(child: Text(shelter['address']!)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // 📍 Map Icon Button Row
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(); // Close popup first
                              context.go('/map'); // Go to map screen
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.map, size: 20, color: Colors.green),
                                SizedBox(width: 10),
                                Text(
                                  'View on Map',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 24, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
