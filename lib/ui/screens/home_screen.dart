import 'package:flutter/material.dart';

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
    tabController = TabController(length: 4, vsync: this);
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
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.amber,
          ),
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
