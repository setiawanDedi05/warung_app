import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [topFiveItem(), itemWillExpired(), debt(), itemWillEmpty()],
        ),
      ),
    );
  }

  Column itemWillEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 10, bottom: 25),
          child: const Text(
            "Barang Yang akan habis",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10),
          child: Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 5),
          ),
        )
      ],
    );
  }

  Column debt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 10, bottom: 25),
          child: const Text(
            "Piutang",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10),
          child: Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 5),
          ),
        )
      ],
    );
  }

  Column itemWillExpired() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 10, bottom: 25),
          child: const Text(
            "Barang Yang Akan Kadaluarsa",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10),
          child: Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 5),
          ),
        )
      ],
    );
  }

  Column topFiveItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 10, bottom: 25),
          child: const Text(
            "Top 5 Penjualan",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10),
          child: Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 5),
          ),
        )
      ],
    );
  }
}
