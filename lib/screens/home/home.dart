import 'package:flutter/material.dart';
import 'package:ink/screens/project/new_project.dart';
import 'package:ink/utility/gradient_circular_container.dart';
import 'package:ink/widgets/main_drawer.dart';
import 'package:ink/widgets/tools/tools_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.setScreen});

  final void Function(String identifier) setScreen;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openToolsOverlay() {
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (ctx) => const ToolsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black54,
        title: const Text('Ink App'),
      ),
      drawer: MainDrawer(setScreen: widget.setScreen),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: GradientCircularContainer(
                width: double.infinity,
                color: Colors.green,
                radius: 10,
                icon: Icons.add,
                title: 'New Project',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const NewProjectScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              children: [
                GradientCircularContainer(
                  width: double.infinity,
                  color: Colors.red,
                  radius: 10,
                  icon: Icons.folder_copy_outlined,
                  title: 'Saved',
                ),
                GradientCircularContainer(
                  width: double.infinity,
                  color: Colors.orange,
                  radius: 10,
                  icon: Icons.construction,
                  title: 'Tools',
                  onTap: _openToolsOverlay,
                ),
                GradientCircularContainer(
                  width: double.infinity,
                  color: Colors.yellow,
                  radius: 10,
                  icon: Icons.pages,
                  title: 'Pages',
                ),
                GradientCircularContainer(
                  width: double.infinity,
                  color: Colors.blue,
                  radius: 10,
                  icon: Icons.file_download,
                  title: 'Download',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
