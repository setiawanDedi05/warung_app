import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isEmptyBucket = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        centerTitle: false,
        actions: [
          Stack(children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.shopping_basket)),
            Positioned(
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50)),
                child: const Text("0"),
              ),
            )
          ])
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Stack(children: [
          Container(
            height: 900,
            width: double.infinity,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('barang').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Data Kosong"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    // ignore: avoid_print
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: snapshot.data?.docs.length ?? 1,
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          final docData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  child: Image.asset(
                                      "assets/images/logo_kecil_putih.png"),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      docData["nama_barang"],
                                    ),
                                    Text(docData["harga"].toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove_circle),
                                    ),
                                    const Text("0"),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEmptyBucket = !isEmptyBucket;
                                        });
                                      },
                                      icon: const Icon(Icons.add_circle),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          isEmptyBucket
              ? Container()
              : Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen),
                    child: const Center(
                        child: Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )),
                  ),
                ),
        ]),
      ),
    );
  }
}
