import 'package:energiapp/components/logo_container_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          const LogoContainerWidget(),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: kIsWeb
                    ? size.height * 0.25
                    : size.height >= 400
                        ? size.height * 0.3
                        : size.height * 0.5,
              ),
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
