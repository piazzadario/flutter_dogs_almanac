import 'package:dogs_almanac/pages/breeds_search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dogs Almanac'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dog_logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return BreedsSearchPage(title: 'Random pic by breed');
                      },
                    ),
                  );
                },
                child: const Text('Random pic by breed'),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return BreedsSearchPage(
                          title: 'Random pic by sub-breed',
                          includeSubBreeds: true,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Random pic by sub-breed'),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return BreedsSearchPage(
                          title: 'Random pic by breed',
                          isList: true,
                        );
                      },
                    ),
                  );
                },
                child: const Text('All pics by breed'),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return BreedsSearchPage(
                          title: 'Random pic by breed',
                          isList: true,
                          includeSubBreeds: true,
                        );
                      },
                    ),
                  );
                },
                child: const Text('All pics by sub-breed'),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
