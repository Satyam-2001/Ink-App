import 'package:flutter/material.dart';
import 'package:ink/providers/mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/screens/tabs.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 31, 31, 31),
  brightness: Brightness.dark,
  // primary: const Color.fromARGB(255, 42, 51, 55),
  surface: const Color.fromARGB(255, 31, 31, 31),
  tertiary: const Color.fromARGB(255, 31, 31, 31),
  background: const Color.fromARGB(255, 28, 26, 27),
);

final theme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
    colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 115, 105, 0)));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(modeProvider);

    return MaterialApp(
      title: 'Ink App',
      theme: mode == 'Light'
          ? ThemeData.light(
              useMaterial3: true,
            )
          : ThemeData.dark(
              useMaterial3: true,
            ),
      home: FutureBuilder(
          future: ref.read(modeProvider.notifier).getMode(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const TabScreen();
          }),
    );
  }
}
