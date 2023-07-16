import 'package:flutter/material.dart';
import 'package:milkcollection/help/deshboard_helper.dart';
import 'package:milkcollection/models/destboard.dart';
import 'package:milkcollection/page/milk_collection_page.dart';

class DeshboardPage extends StatefulWidget {
  final String name;
  final String code;
  const DeshboardPage({super.key, required this.name, required this.code});

  @override
  State<DeshboardPage> createState() => _DeshboardPageState();
}

class _DeshboardPageState extends State<DeshboardPage> {
  Deshboard_model? deshboard_model;
  bool loading = true;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Deshboard_helper deshboard_helper = Deshboard_helper();
    deshboard_model = await deshboard_helper.getDestbordData();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 117, 194),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
            toolbarHeight: 60.2,
            automaticallyImplyLeading: false,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                // bottomLeft: Radius.circular(25),
              ),
            ),
            elevation: 1.00,
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.name}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text("Code : ${widget.code}")
                        ],
                      ),
                      const Column(
                        children: [Icon(Icons.logout), Text("Logout")],
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),),
        // color: Colors.blue,
        child: Align(
          alignment: Alignment.center,
          child: loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  const Text(
                                    "Submitted Milk",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "${deshboard_model!.submittedMilk.toString()} ltr")
                                ]),
                          ),
                          Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  const Text(
                                    "Total Payment",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(deshboard_model!.totalPayment.toString())
                                ]),
                          ),
                          Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.receipt,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  const Text(
                                    "Received Payment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(deshboard_model!.receivedPayment
                                      .toString())
                                ]),
                          ),
                          Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.remove_circle,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  const Text(
                                    "Remining Payment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(deshboard_model!.reminingPayment
                                      .toString())
                                ]),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MilkCollectionPage()));
                        },
                        child: const Text("Milk Collection", style: TextStyle(color: Colors.blue),))
                  ],
                ),
        ),
      ),
    );
  }
}
