import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sectios/nurse_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sectios/order_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sectios/test_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sectios/user_managment_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 3, //change the index to currently working section's index
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Section Name",
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            color: Colors.red,
          ),
          OrderManagmentSection(),
          TestManagmentSection(),
          NurseManagmentSection(),
          UserManagmentSection(),
        ],
      ),
      drawer: Material(
        color: Colors.blue,
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "MENU",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white60,
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Dashboard",
                  iconData: Icons.dashboard,
                  onPressed: () {
                    tabController.animateTo(0);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 0,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Order Management",
                  iconData: Icons.online_prediction_rounded,
                  onPressed: () {
                    tabController.animateTo(1);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Test Management",
                  iconData: Icons.text_snippet_rounded,
                  onPressed: () {
                    tabController.animateTo(2);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 2,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Nurse Management",
                  iconData: Icons.medication_outlined,
                  onPressed: () {
                    tabController.animateTo(3);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "User Management",
                  iconData: Icons.person,
                  onPressed: () {
                    tabController.animateTo(4);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.white : Colors.blue,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.zero,
      //   side: BorderSide(
      //     color: Colors.white,
      //     width: 1,
      //   ),
      // ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: isSelected ? Colors.blue : Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: isSelected ? Colors.blue : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
