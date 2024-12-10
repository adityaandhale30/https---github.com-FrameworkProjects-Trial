import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExamplePage(),
    );
  }
}

// Add these to pubspec.yaml:
// dependencies:
//   flutter_gradient_colors: ^2.1.1
//   font_awesome_flutter: ^10.6.0
//   glassmorphism: ^3.0.0
//   animated_text_kit: ^4.2.2

class SuperFancyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final bool showSearchBar;

  const SuperFancyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onMenuPressed,
    this.showSearchBar = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(showSearchBar ? 140.0 : 120.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[900]!,
            Colors.purple[700]!,
            Colors.red[400]!,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: 60,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildIconButton(
                          icon: FontAwesomeIcons.bars,
                          onPressed: onMenuPressed ?? () {},
                        ),
                        const SizedBox(width: 16),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              title,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 5,
                        ),
                      ],
                    ),
                    Row(
                      children: actions ??
                          [
                            _buildIconButton(
                              icon: FontAwesomeIcons.bell,
                              hasBadge: true,
                            ),
                            _buildIconButton(
                              icon: FontAwesomeIcons.user,
                            ),
                          ],
                    ),
                  ],
                ),
              ),
            ),
            if (showSearchBar)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: 40,
                  borderRadius: 20,
                  blur: 20,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.7)),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    VoidCallback? onPressed,
    bool hasBadge = false,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: FaIcon(icon, color: Colors.white, size: 20),
            onPressed: onPressed ?? () {},
          ),
        ),
        if (hasBadge)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Example usage:
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFancyAppBar(
        title: 'Awesome App',
        showSearchBar: true,
        onMenuPressed: () {
          // Handle menu press
        },
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.gear, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Your content here'),
      ),
    );
  }
}
