import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController with ChangeNotifier {
  final BuildContext context;
  ImageController(this.context);
  File? _image;
  bool _uploading = false;
  bool _uploadSuccess = false;

  File? get image => _image;
  bool get uploading => _uploading;
  bool get uploadSuccess => _uploadSuccess;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select image to upload'),
        ),
      );
    }

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
    if (_image!.lengthSync() > 10 * 1024 * 1024) {
      print('File size exceeds 10 MB');
      return;
    }
    try {
      _uploading = true;
      notifyListeners();
      await storageRef.putFile(_image!);
      _uploadSuccess = true;
    } catch (e) {
      print('Failed to upload image: $e');
      _uploadSuccess = false;
    } finally {
      _uploading = false;
      notifyListeners();
    }
  }

  // For Fibonacci series
  final TextEditingController controller = TextEditingController();
  String fibonacciResult = '';

  void calculateFibonacci(int position) {
    BigInt result = _fibonacci(position);
    fibonacciResult = result.toString();
    notifyListeners();
  }

  BigInt _fibonacci(int n, {Map<int, BigInt>? memo}) {
    memo ??= {};
    if (memo.containsKey(n)) return memo[n]!;

    if (n == 0) return BigInt.zero;
    if (n == 1) return BigInt.one;

    memo[n] = _fibonacci(n - 1, memo: memo) + _fibonacci(n - 2, memo: memo);
    return memo[n]!;
  }

  // For SubString
  String _input = '';
  List<String> _balancedSubstrings = [];

  String get input => _input;
  List<String> get balancedSubstrings => _balancedSubstrings;

  void setInput(String value) {
    _input = value;
    notifyListeners();
  }

  void calculateBalancedSubstrings() {
    String S = input;
    List<String> longestBalancedSubstrings = [];
    int maxLen = 0;

    for (int i = 0; i < S.length; i++) {
      for (int j = i + 2; j <= S.length; j++) {
        String substring = S.substring(i, j);
        if (_isBalanced(substring)) {
          if (substring.length > maxLen) {
            maxLen = substring.length;
            longestBalancedSubstrings = [substring];
          } else if (substring.length == maxLen) {
            longestBalancedSubstrings.add(substring);
          }
        }
      }
    }

    _balancedSubstrings = longestBalancedSubstrings;
    notifyListeners();
  }

  bool _isBalanced(String substring) {
    Map<String, int> charCount = {};
    for (int i = 0; i < substring.length; i++) {
      charCount[substring[i]] = (charCount[substring[i]] ?? 0) + 1;
    }

    if (charCount.keys.length != 2) return false;

    List<int> counts = charCount.values.toList();
    return counts[0] == counts[1];
  }

  @override
  void dispose() {
    controller.dispose();
    fibonacciResult = '';
    _image = null;
    _input = '';
    _balancedSubstrings = [];
    super.dispose();
  }
}
