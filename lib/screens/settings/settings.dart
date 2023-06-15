import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/mode.dart';
import 'package:ink/widgets/settings/theme_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(modeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 4,
        shadowColor: Colors.black54,
        title: const Text('Settings'),
      ),
      // drawer: const MainDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.light_mode,
                size: 30,
              ),
              title: const Text('Theme'),
              subtitle: Text(mode),
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground),
              subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const ThemeDialog(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
