import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller.dart';

class BalancedSubstringsScreen extends StatelessWidget {
  const BalancedSubstringsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balanced Substring'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                Provider.of<ImageController>(context, listen: false)
                    .setInput(value);
              },
              decoration: const InputDecoration(labelText: 'Enter a string'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<ImageController>(context, listen: false)
                    .calculateBalancedSubstrings();
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Longest Balanced Substrings:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<ImageController>(
                builder: (context, provider, _) {
                  List<String> balancedSubstrings = provider.balancedSubstrings;
                  if (balancedSubstrings.isEmpty) {
                    return const Center(
                        child: Text("No balanced substrings found."));
                  } else {
                    return ListView.builder(
                      itemCount: balancedSubstrings.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(balancedSubstrings[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
