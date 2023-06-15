import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/providers/letters.dart';
import 'package:ink/providers/page_info_list.dart';
import 'package:ink/providers/select_teb.dart';
import 'package:ink/screens/home/home.dart';
import 'package:ink/screens/page/pages.dart';
import 'package:ink/screens/settings/settings.dart';
import 'package:ink/screens/text/text.dart';
import 'package:ink/screens/tools/tools.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem(
    context, {
    required IconData icon,
    required label,
  }) : super(
          icon: Icon(icon),
          label: label,
          activeIcon: SizedBox(
            width: double.infinity,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
}

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  late Future<void> _pageInfoFuture;

  @override
  void initState() {
    ref.read(lettersProvider.notifier).loadLetters();
    _pageInfoFuture = ref.read(pageInfoListProvider.notifier).loadPages();
    super.initState();
  }

  @override
  void dispose() {
    // ref.read(pageInfoListProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late Widget content;
    int _selectedTabIndex = ref.watch(selectTabProvider);

    void setScreen(String identifier) {
      Navigator.of(context).pop();
      if (identifier == 'Settings') {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
      }
    }

    if (_selectedTabIndex == 0) {
      content = HomeScreen(setScreen: setScreen);
    } else if (_selectedTabIndex == 1) {
      content = TextScreen(setScreen: setScreen);
    } else if (_selectedTabIndex == 2) {
      content = PagesScreen(setScreen: setScreen);
    } else {
      content = ToolsScreen(setScreen: setScreen);
    }

    return Scaffold(
      body: FutureBuilder(
        future: _pageInfoFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return content;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        onTap: ref.read(selectTabProvider.notifier).setTab,
        currentIndex: _selectedTabIndex,
        fixedColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        elevation: 8,
        items: <BottomNavigationBarItem>[
          CustomBottomNavigationBarItem(
            context,
            icon: Icons.home,
            label: 'Home',
          ),
          CustomBottomNavigationBarItem(
            context,
            icon: Icons.abc,
            label: 'Text',
          ),
          CustomBottomNavigationBarItem(
            context,
            icon: Icons.book,
            label: 'Pages',
          ),
          // CustomBottomNavigationBarItem(
          //   context,
          //   icon: Icons.construction,
          //   label: 'Tools',
          // ),
        ],
      ),
    );
  }
}
