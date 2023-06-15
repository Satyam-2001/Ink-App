import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ink/models/page_info.dart';
import 'package:ink/screens/page/add_page.dart';
import 'package:ink/utility/container_selctor/container_selector.dart';
import 'package:ink/utility/container_selctor/container_selector_controller.dart';

class PageListItem extends ConsumerWidget {
  const PageListItem({super.key, required this.page, required this.controller});

  final PageInfo page;
  final ContainerSelectorController controller;

  void _editPageScreenOpen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddPageScreen.edit(page),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerSelector(
      tag: page,
      controller: controller,
      elevation: 4,
      onTap: () => _editPageScreenOpen(context),
      child: SizedBox(
        height: double.infinity,
        child: Hero(
          tag: page.image.path,
          child: Image.file(
            page.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// return InkWell(
//       onLongPress: togglePage,
//       onTap:
//           isAnyPageSelected ? togglePage : () => _editPageScreenOpen(context),
//       child: Card(
//         elevation: 8,
//         child: Stack(
//           children: [
//             Container(
//               height: double.infinity,
//               padding: const EdgeInsets.all(0),
//               foregroundDecoration: isSelected
//                   ? BoxDecoration(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .primary
//                           .withOpacity(0.4),
//                     )
//                   : null,
//               child: Hero(
//                 tag: page.image.path,
//                 child: Image.file(
//                   page.image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             if (isSelected)
//               Center(
//                 child: Icon(
//                   Icons.check,
//                   size: 50,
//                   color: Theme.of(context).colorScheme.background,
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }