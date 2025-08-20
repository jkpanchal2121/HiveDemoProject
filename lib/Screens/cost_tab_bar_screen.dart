import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productcost/Bloc/ProductCostBloc/product_cost_bloc.dart';
import 'package:productcost/Screens/additional_cost_screen.dart';
import 'package:productcost/Screens/group_table_screen.dart';

import '../Repo/product_cost_repo.dart';
import '../utils/colors.dart';
import 'damage_cost.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        ProductCostBloc(ProductCostRepository())
                          ..add(GetAllAdditionalEvent())
                          ..add(GetAllDamageEvent()),
                    child: GroupTableScreen(),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Grouped Table',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          title: Text(
            "Product Cost",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: darkColor,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: yellowColor, // Selected tab background color
                  borderRadius: BorderRadius.circular(15),
                ),
                labelColor: darkColor, // Selected text color
                unselectedLabelColor: yellowColor, // Unselected text color
                tabs: const [
                  Tab(text: "Additional Cost"),
                  Tab(text: "Damage Cost"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [AdditionalCostTab(), DamageCostTab()],
        ),
      ),
    );
  }
}
