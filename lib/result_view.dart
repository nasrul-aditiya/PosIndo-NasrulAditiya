import 'package:flutter/material.dart';
import 'package:posindo/controller/kodepos_controller.dart';
import 'package:posindo/models/kodepos_model.dart';

class ResultView extends StatefulWidget {
  final String searchKey;
  ResultView({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  List<KodePosModel> data = [];
  ValueNotifier isLoading = ValueNotifier<bool>(true);
  KodePosController controller = KodePosController();
  Future<void> searching() async {
    isLoading.value = true;
    var result = await controller.searchKodePos(widget.searchKey);
    if (result["status"] == 200) {
      data.clear();
      data.addAll(result["data"]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${result['message']}",
            style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ));
    }
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    searching();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Hasil Pencarian : ",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              if ((value as bool) == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (data.isEmpty) {
                  return const Center(
                    child: Text("Tidak ditemukan"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Provinsi : ${data[index].province}"),
                              Text("Kota : ${data[index].city}"),
                              Text("Kecamatan : ${data[index].subdistrict}"),
                              Text("Kelurahan : ${data[index].urban}"),
                              Text("Kode Pos : ${data[index].postalCode}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      });
                }
              }
            },
          ),
        ));
  }
}
