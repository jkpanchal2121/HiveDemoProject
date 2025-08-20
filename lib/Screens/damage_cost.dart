import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/ProductCostBloc/product_cost_bloc.dart';
import '../Heplers/custom_button.dart';
import '../Heplers/custom_dropdown.dart';
import '../Heplers/custom_text_field.dart';
import '../Heplers/theme_helper.dart';
import '../models/damage_cost_model.dart';
import '../utils/colors.dart';
import 'additional_cost_screen.dart';

class DamageCostTab extends StatefulWidget {
  const DamageCostTab({super.key});

  @override
  State<DamageCostTab> createState() => _DamageCostTabState();

  static TableRow _buildRow(DamageCost item) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(item.part)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.costMinus10CM),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.costPlus10CM),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.administrativeFee),
        ),
      ],
    );
  }
}

class _DamageCostTabState extends State<DamageCostTab> {
  TextEditingController costMinus10CMController = TextEditingController();
  TextEditingController costPlus10CMController = TextEditingController();
  TextEditingController administrativeFeeController = TextEditingController();
  String? part;

  List<DropdownItem> damageList = [
    DropdownItem(id: 1, name: "Fender"),
    DropdownItem(id: 2, name: "Bumper"),
    DropdownItem(id: 3, name: "Door"),
    DropdownItem(id: 4, name: "Roof"),
    DropdownItem(id: 5, name: "Trunk"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Part',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            CustomDropdown(
              items: damageList,
              onChanged: (p0) {
                part = p0.name;
              },
              hintText: 'Select Part',
            ),
            SizedBox(height: 10),
            Text(
              'Cost (-) 10 CM',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              hint: 'Enter Cost',
              controller: costMinus10CMController,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),

            Text(
              'Cost (+) 10 CM',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              hint: 'Enter Cost',
              controller: costPlus10CMController,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 10),
            Text(
              'Administrative Fee',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              hint: 'Enter Fee',
              controller: administrativeFeeController,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 50),
            CustomButton(
              text: 'Submit',
              onPressed: () {
                if (part == '' ||
                    (part?.isEmpty ?? false) ||
                    costMinus10CMController.text.isEmpty ||
                    costPlus10CMController.text.isEmpty ||
                    administrativeFeeController.text.isEmpty) {
                  ThemeHelper.showError(context, 'All fields are required');
                } else {
                  context.read<ProductCostBloc>().add(
                    AddDamageEvent(
                      DamageCost(
                        part: part ?? '',
                        costMinus10CM: costMinus10CMController.text,
                        costPlus10CM: costPlus10CMController.text,
                        administrativeFee: administrativeFeeController.text,
                      ),
                    ),
                  );
                }
              },
              backgroundColor: darkColor,
              textColor: yellowColor,
            ),

            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
            BlocConsumer<ProductCostBloc, ProductCostState>(
              listener: (context, state) {
                if (state.addDamageCostStatus == RequestStatus.success) {
                  ThemeHelper.showSuccess(
                    context,
                    'Damage cost add successfully.',
                  );
                  part = null;
                  costPlus10CMController.clear();
                  costMinus10CMController.clear();
                  administrativeFeeController.clear();
                }
              },
              builder: (context, state) {
                return Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.2),
                    3: FlexColumnWidth(1.2),
                    4: FlexColumnWidth(1.2),
                  },
                  children: [
                    // Header Row

                    // Column Header Row
                    TableRow(
                      decoration: BoxDecoration(color: Colors.amber.shade700),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "part",
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
                    // Data Rows from dummy list ✅
                    ...?state.damageCostData?.map(
                      (item) => DamageCostTab._buildRow(item),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class DamageCostItem {
  final String part;
  final String costMinus10CM;
  final String costPlus10;
  final String adminFee;

  DamageCostItem({
    required this.part,
    required this.costMinus10CM,
    required this.costPlus10,
    required this.adminFee,
  });
}
