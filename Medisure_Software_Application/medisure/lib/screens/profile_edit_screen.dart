import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisure/firestore.dart';
import 'package:medisure/globals.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

final FirestoreService firestoreService = FirestoreService();
final TextEditingController nameController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController ailmentController = TextEditingController();

class _UserProfilePageState extends State<UserProfilePage> {
  File? _imageFile;
  String? _imageUrl;
  String gender = '';
  final List<String> genders = ['', 'Male', 'Female', 'Undefined'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await firestoreService.getUser(global.user_id);
    setState(() {
      nameController.text = user.name;
      ageController.text = user.age.toString();
      ailmentController.text = user.ailments;
      gender = user.gender;
      _imageUrl = user.photoUrl;
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    final file = File(picked.path);
    setState(() => _imageFile = file);

    final url = await firestoreService.uploadProfileImage(global.user_id, file);

    await firestoreService.updateUser(
      global.user_id,
      nameController.text,
      ailmentController.text,
      ageController.text,
      gender,
      url,
    );

    setState(() => _imageUrl = url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (_imageUrl != null && _imageUrl!.isNotEmpty)
                        ? NetworkImage(_imageUrl!) as ImageProvider
                        : null,
                child: (_imageFile == null &&
                        (_imageUrl == null || _imageUrl!.isEmpty))
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ailmentController,
              decoration: const InputDecoration(labelText: 'Ailments'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: gender,
              items: genders
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Gender'),
              onChanged: (v) => setState(() => gender = v as String),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await firestoreService.updateUser(
                  global.user_id,
                  nameController.text,
                  ailmentController.text,
                  ageController.text,
                  gender,
                  _imageUrl ?? '',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile saved')),
                );
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload / Change Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
