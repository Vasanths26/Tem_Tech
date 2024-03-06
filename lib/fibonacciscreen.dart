import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temtech/controller.dart';

class FibonacciScreen extends StatelessWidget {
  const FibonacciScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 25)),
        title: const Text('Fibonacci Calculator'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ImageController>(
                builder: (context, calculator, _) {
                  return TextField(
                    controller: calculator.controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter position',
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int position = int.tryParse(
                          Provider.of<ImageController>(context, listen: false)
                              .controller
                              .text) ??
                      0;
                  Provider.of<ImageController>(context, listen: false)
                      .calculateFibonacci(position);
                },
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20.0),
              Consumer<ImageController>(
                builder: (context, calculator, _) {
                  return Text(
                    'Fibonacci Result: ${calculator.fibonacciResult}',
                    style: const TextStyle(fontSize: 18.0),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
