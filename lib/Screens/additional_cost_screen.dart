import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productcost/Bloc/ProductCostBloc/product_cost_bloc.dart';
import 'package:productcost/Heplers/custom_button.dart';
import 'package:productcost/Heplers/custom_dropdown.dart';
import 'package:productcost/Heplers/custom_text_field.dart';
import 'package:productcost/utils/colors.dart';

import '../Heplers/theme_helper.dart';
import '../models/additional_cost_model.dart';

class AdditionalCostTab extends StatefulWidget {
  const AdditionalCostTab({super.key});

  @override
  State<AdditionalCostTab> createState() => _AdditionalCostTabState();
}

class _AdditionalCostTabState extends State<AdditionalCostTab> {
  TextEditingController ownerFixedPriceController = TextEditingController();
  TextEditingController administrativeFeeController = TextEditingController();

  String? issue;
  List<DropdownItem> issueList = [
    DropdownItem(id: 1, name: "Missing Fuel"),
    DropdownItem(id: 2, name: "Late Vehicle Return"),
    DropdownItem(id: 3, name: "Interior Dirty"),
    DropdownItem(id: 4, name: "Traffic Violation"),
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
              'issue',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            CustomDropdown(
              items: issueList,
               selectedItem:issueList.first ,

              onChanged: (p0) {
                setState(() {
                  issue = p0.name;
                });
              },
              hintText: 'Select Issue',
            ),
            SizedBox(height: 10),
            Text(
              'Owner\'s Fixed price',
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              hint: 'Enter Fixed price',
              keyboardType: TextInputType.number,
              controller: ownerFixedPriceController,
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
            BlocConsumer<ProductCostBloc, ProductCostState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return CustomButton(
                  text: 'Submit',

                  onPressed: () {
                    if (issue == '' ||
                        (issue?.isEmpty ?? false) ||
                        ownerFixedPriceController.text.isEmpty ||
                        administrativeFeeController.text.isEmpty) {
                      ThemeHelper.showError(context, 'All fields are required');
                    } else {
                      context.read<ProductCostBloc>().add(
                        AddAdditionalEvent(
                          AdditionalCost(
                            issue: issue ?? '',
                            ownerFixedPrice: ownerFixedPriceController.text,
                            administrativeFee: administrativeFeeController.text,
                          ),
                        ),
                      );
                    }
                  },

                  backgroundColor: darkColor,
                  textColor: yellowColor,
                );
              },
            ),

            SizedBox(height: 20),


            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
            BlocConsumer<ProductCostBloc, ProductCostState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.addAdditionalCostStatus == RequestStatus.success) {
                  ThemeHelper.showSuccess(
                    context,
                    'Additional cost add successfully.',
                  );
                  issue = null;
                  ownerFixedPriceController.clear();
                  administrativeFeeController.clear();
                }
              },
              builder: (context, state) {
                return (state.additionalCostData?.isEmpty ?? false)
                    ? SizedBox()
                    : Table(
                        border: TableBorder.all(color: Colors.grey.shade300),
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1.5),
                          2: FlexColumnWidth(1.2),
                        },
                        children: [
                          // Header Row

                          // Column Header Row
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
                            (item) => _buildRow(item),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static TableRow _buildRow(AdditionalCost item) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(item.issue)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.ownerFixedPrice),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.administrativeFee),
        ),
      ],
    );
  }
}

final List<CostItem> dummyCostList = [
  CostItem(
    issue: "Missing Electricity (For EVs)",
    ownerPrice: "€520",
    adminFee: "€30",
  ),
  CostItem(issue: "Interior Dirty", ownerPrice: "€720", adminFee: "€30"),
  CostItem(issue: "Exterior Dirty", ownerPrice: "€540", adminFee: "€30"),
  CostItem(issue: "Traffic Violation", ownerPrice: "€570", adminFee: "€30"),
  CostItem(
    issue: "Missing Electricity (For EVs)",
    ownerPrice: "€520",
    adminFee: "€30",
  ),
  CostItem(issue: "Interior Dirty", ownerPrice: "€720", adminFee: "€30"),
  CostItem(issue: "Exterior Dirty", ownerPrice: "€540", adminFee: "€30"),
  CostItem(issue: "Traffic Violation", ownerPrice: "€570", adminFee: "€30"),
];

class CostItem {
  final String issue;
  final String ownerPrice;
  final String adminFee;

  CostItem({
    required this.issue,
    required this.ownerPrice,
    required this.adminFee,
  });
}

class FlatAdditionalCostsTable extends StatelessWidget {
  const FlatAdditionalCostsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.2),
        },
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(color: Colors.blueGrey.shade900),
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Flat Additional Costs Owed To The Owner",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ],
          ),
          // Column Header Row
          TableRow(
            decoration: BoxDecoration(color: Colors.amber.shade700),
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

          ...dummyCostList.map((item) => _buildRow(item)),
        ],
      ),
    );
  }

  static TableRow _buildRow(CostItem item) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(item.issue)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.ownerPrice),
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(item.adminFee)),
      ],
    );
  }
}
