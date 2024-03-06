import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temtech/fibonacciscreen.dart';
import 'controller.dart';
import 'substring.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageController>(context);
    final image = imageProvider.image;
    final uploading = imageProvider.uploading;
    final uploadSuccess = imageProvider.uploadSuccess;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image to Firebase'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '',
              ),
            ),
            ListTile(
              title: const Text(
                'Fibonacci Calculator',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FibonacciScreen()));
              },
            ),
            ListTile(
              title: const Text(
                'SubString',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const BalancedSubstringsScreen()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black54)),
              child: image != null
                  ? Image.file(
                      image,
                      fit: BoxFit.fitHeight,
                    )
                  : const Center(child: Text('No image selected')),
            ),
            const SizedBox(height: 20),
            if (!uploading && !uploadSuccess && image == null)
              const Text('Select Image to Upload')
            else if (image != null && !uploading && !uploadSuccess)
              const Text('')
            else if (uploading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Uploading...'),
                ],
              )
            else if (uploadSuccess)
              const Text('Upload Successful!',
                  style: TextStyle(color: Colors.green))
            else
              const Text('Upload Failed!', style: TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: imageProvider.pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                imageProvider.uploadImage();
                if (uploadSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const PreviewScreen())));
                }
              },
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Image'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('uploaded image'),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.file(imageProvider.image!),
            ),
          ],
        ),
      ),
    );
  }
}
