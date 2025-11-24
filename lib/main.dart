import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Notes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _showForm({String? id, String? oldTitle, String? oldContent}) {
    if (id != null) {
      _titleController.text = oldTitle ?? '';
      _contentController.text = oldContent ?? '';
    } else {
      _titleController.clear();
      _contentController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20, left: 20, right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Isi Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;

                if (content.isEmpty) return;

                if (id == null) {
                  // tambah data baru
                  await _notes.add({
                    "title": title,
                    "content": content,
                    "timestamp": FieldValue.serverTimestamp(),
                  });
                } else {
                  // update data lama
                  await _notes.doc(id).update({
                    "title": title,
                    "content": content,
                  });
                }

                _titleController.clear();
                _contentController.clear();
                Navigator.pop(context);
              },
              child: Text(id == null ? 'Simpan Catatan' : 'Update Catatan'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Notes Fire")),
      body: StreamBuilder(
        stream: _notes.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada catatan."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    doc['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(doc['content']),
                  onTap: () {
                    _showForm(
                      id: doc.id,
                      oldTitle: doc['title'],
                      oldContent: doc['content'],
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _notes.doc(doc.id).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
