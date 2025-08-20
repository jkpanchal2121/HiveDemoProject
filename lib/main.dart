import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:productcost/Bloc/ProductCostBloc/product_cost_bloc.dart';
import 'package:productcost/Repo/product_cost_repo.dart';
import 'package:productcost/Screens/cost_tab_bar_screen.dart';

import 'models/additional_cost_model.dart';
import 'models/damage_cost_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AdditionalCostAdapter());
  Hive.registerAdapter(DamageCostAdapter());

  await Hive.openBox<AdditionalCost>('additionalcost');
  await Hive.openBox<DamageCost>('damagecost');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      color: Colors.white,

      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ProductCostBloc(ProductCostRepository())
          ..add(GetAllAdditionalEvent())
          ..add(GetAllDamageEvent()),

        child: CostPage(),
      ),
    );
  }
}
