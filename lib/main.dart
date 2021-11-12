import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'foodies_together_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(
    const FoodiesTogether(),
  );
}

class FoodiesTogether extends StatefulWidget {
  const FoodiesTogether({Key? key}) : super(key: key);

  @override
  _FoodiesTogetherState createState() => _FoodiesTogetherState();
}

class _FoodiesTogetherState extends State<FoodiesTogether> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _groceryManager),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        )
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FoodiesTogetherTheme.dark();
          } else {
            theme = FoodiesTogetherTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Foodies Together',
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
