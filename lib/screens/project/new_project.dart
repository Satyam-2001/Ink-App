import 'package:flutter/material.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final _controllerTitle = TextEditingController.fromValue(
      const TextEditingValue(text: 'New Project'));

  bool isEditingTitle = true;

  @override
  void dispose() {
    _controllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        title: TextField(
          autofocus: true,
          readOnly: !isEditingTitle,
          controller: _controllerTitle,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isEditingTitle = !isEditingTitle;
                  });
                },
                icon: Icon(isEditingTitle ? Icons.close : Icons.edit)),
            border: InputBorder.none,
            hintText: 'Project Title',
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Container(
                height: 200,
                child: const Expanded(
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8)
                        // labelText: 'Enter Text',
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
