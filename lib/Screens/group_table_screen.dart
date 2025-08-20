import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productcost/models/additional_cost_model.dart';
import 'package:productcost/models/damage_cost_model.dart';

import '../Bloc/ProductCostBloc/product_cost_bloc.dart';
import '../utils/colors.dart';

// Example GroupTableScreen
class GroupTableScreen extends StatelessWidget {
  const GroupTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Group Tables"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BlocConsumer<ProductCostBloc, ProductCostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.additionalCostData?.isEmpty ?? true) {
                  return const SizedBox();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      width: double.infinity,
                      color: darkColor,
                      child: Text(
                        'Flat Additional Costs Owed To The Owner',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.2),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.amber.shade700,
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Issue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Owner's Fixed Price",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Administrative Fee",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...?state.additionalCostData?.map(
                          (item) => _buildAdditionalRow(item),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),


            BlocConsumer<ProductCostBloc, ProductCostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.damageCostData?.isEmpty ?? true) {
                  return const SizedBox();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      width: double.infinity,
                      color: darkColor,
                      child: Text(
                        'Paint Touch-Up or Surface Damage',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.2),
                        3: FlexColumnWidth(1.2),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.amber.shade700,
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Part",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Cost (-) 10 CM",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Cost (+) 10 CM",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Administrative Fee",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...?state.damageCostData?.map(
                          (item) => _buildDamageRow(item),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  TableRow _buildAdditionalRow(AdditionalCost item) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.issue ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.ownerFixedPrice ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.administrativeFee ?? ''),
        ),
      ],
    );
  }


  TableRow _buildDamageRow(DamageCost item) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.part ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.costMinus10CM ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.costPlus10CM ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.administrativeFee ?? ''),
        ),
      ],
    );
  }
}
