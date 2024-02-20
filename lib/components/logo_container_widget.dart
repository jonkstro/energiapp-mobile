import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogoContainerWidget extends StatelessWidget {
  const LogoContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: kIsWeb ? size.height * 0.3 : size.height * 0.4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: kIsWeb
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
                const SizedBox(width: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'EnergiApp',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'O controle do seu consumo na palma da sua mão.',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : size.height >= 400
              ? Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                      ),
                    ),
                    Text(
                      'EnergiApp',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'O controle do seu consumo na palma da sua mão.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                    ),
                    const SizedBox(width: 50),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'EnergiApp',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'O controle do seu consumo na palma da sua mão.',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
