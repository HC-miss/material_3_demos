import 'package:flutter/material.dart';

enum AppMenu {
  about,
  privacy,
  settings,
}

void main() {
  runApp(const PlantsApp());
}

class PlantsApp extends StatelessWidget {
  const PlantsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.green[700],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green[700],
      ),
      home: const PlantsHome(),
    );
  }
}

class PlantsHome extends StatelessWidget {
  const PlantsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plants Shop'),
        shadowColor: Theme.of(context).shadowColor,
        scrolledUnderElevation: 4.0,
        leading: const Center(
          child: CircleAvatar(
            radius: 16,
            child: Icon(Icons.person),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, bottom: 10, right: 16),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Browse indoor plants',
                prefixIcon: Icon(Icons.search_off_rounded),
                border: OutlineInputBorder(),
                filled: true,
                isDense: true,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style: enabledFilledButtonStyle(
              true,
              Theme.of(context).colorScheme,
            ),
            icon: const Icon(Icons.sort_rounded),
          ),
          PopupMenuButton<AppMenu>(
            itemBuilder: (context) {
              return const <PopupMenuEntry<AppMenu>>[
                PopupMenuItem(
                  value: AppMenu.about,
                  child: Text('About us'),
                ),
                PopupMenuItem(
                  value: AppMenu.privacy,
                  child: Text('Privacy Policy'),
                ),
                PopupMenuItem(
                  value: AppMenu.settings,
                  child: Text('Settings'),
                ),
              ];
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 12 / 15.5,
        ),
        itemBuilder: (context, index) {
          final String image = 'assets/plants/plant_$index.jpg';
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlantDetailPage(image: image),
                  ),
                );
              },
              child: PlantItem(image: image),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.payment_rounded),
            label: 'Payments',
          ),
        ],
        selectedIndex: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _shoppingCartDialog(context),
        child: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }

  Future<void> _shoppingCartDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Shopping Cart'),
          icon: const Icon(Icons.shopping_cart_rounded),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1 x Lorem Ipsum'),
                  Text('\$9.99'),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Dismiss'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Checkout'),
            ),
          ],
        );
      },
    );
  }

  ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
    return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: selected
          ? colors.onPrimary.withOpacity(0.08)
          : colors.primary.withOpacity(0.08),
      focusColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
      highlightColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
    );
  }
}

class PlantItem extends StatelessWidget {
  final String image;

  const PlantItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    return Hero(
      tag: image,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Lorem Ipsum',
                style: textTheme.titleMedium,
              ),
              Text(
                '\$9.99',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantDetailPage extends StatelessWidget {
  const PlantDetailPage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text("Lorem Ipsum"),
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: image,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
                MaterialBanner(
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lorem Ipsum',
                          style: textTheme.titleLarge,
                        ),
                        Text(
                          '\$9.99',
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ActionChip(
                      onPressed: () {},
                      label: const Text('Indoor'),
                    ),
                    ActionChip(
                      onPressed: () {},
                      label: const Text('Small'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline_rounded),
                label: const Text('Save'),
              ),
              FilledButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text('Include base'),
                                trailing: Switch(
                                  onChanged: (value) {},
                                  value: true,
                                ),
                              ),
                              ListTile(
                                title: const Text('Gifting'),
                                trailing: Checkbox(
                                  onChanged: (value) {},
                                  value: true,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Proceed to payment'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Buy Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
