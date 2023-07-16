import 'package:flutter/material.dart';
import 'package:milkcollection/help/milk_collection_helper.dart';
import 'package:milkcollection/models/milk_collection.dart';

class MilkCollectionPage extends StatefulWidget {
  const MilkCollectionPage({super.key});

  @override
  State<MilkCollectionPage> createState() => _MilkCollectionPageState();
}

class _MilkCollectionPageState extends State<MilkCollectionPage> {
  List<Milk_Collection_model> milk_collection_list = [];
  late DateTime date;

  var loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    date = DateTime(now.year, now.month, now.day);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MilkCollection_helper milkCollection_helper = MilkCollection_helper();
    await milkCollection_helper.getMilkData();
    milk_collection_list =
        milkCollection_helper.milkData.cast<Milk_Collection_model>();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 117, 194),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: const Text("Milk Collection"),
          centerTitle: true,
          toolbarHeight: 60.2,
          // automaticallyImplyLeading: false,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              // bottomLeft: Radius.circular(25),
            ),
          ),
          elevation: 1.00,
          backgroundColor: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Milk Collection",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Date : ${date.toString().replaceAll("00:00:00.000", "")}",
                    style: const TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          loading
              ? const CircularProgressIndicator()
              : Flexible(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: milk_collection_list.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Date : ${milk_collection_list[index].date}"),
                                      Text(
                                          "Qty : ${milk_collection_list[index].qty}")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Fat : ${milk_collection_list[index].fat}"),
                                      Text(
                                          "Per Qty : ${milk_collection_list[index].per_qty}"),
                                      Text(
                                          "Rs : ${milk_collection_list[index].rs}")
                                    ],
                                  )
                                ],
                              ),
                            ));
                      }),
                ),
        ]),
      ),
    );
  }
}
