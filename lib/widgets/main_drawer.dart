import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _MainDrawerHeader extends StatelessWidget {
  const _MainDrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icon/icon.png',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            color: Theme.of(context).colorScheme.primary,
          ),
          // Icon(
          //   Icons.create,
          //   size: 48,
          //   color: Theme.of(context).colorScheme.primary,
          // ),
          const SizedBox(width: 18),
          Text(
            'Ink App',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}

class _MainDrawerListTile extends ListTile {
  _MainDrawerListTile(
      {required icon, required title, required super.onTap, required context})
      : super(
          leading: Icon(
            icon,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
          ),
        );
}

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
    required this.setScreen,
  });

  final void Function(String identifier) setScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          const _MainDrawerHeader(),
          _MainDrawerListTile(
            context: context,
            icon: Icons.home,
            title: 'Home',
            onTap: () => setScreen('Home'),
          ),
          _MainDrawerListTile(
            context: context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => setScreen('Settings'),
          ),
          const Spacer(),
          const Divider(thickness: 1),
          const SizedBox(height: 8),
          Text(
            'Developed By Satyam Lohiya',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withAlpha(160),
              fontSize: 16,
              wordSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
