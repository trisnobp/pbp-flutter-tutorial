import 'package:flutter/material.dart';
import 'package:test/pages/drawer.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaLengkap = "";
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;
  String jenjang = "";
  double umur = 0;
  String kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _nilaiSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      drawer: const DrawerApp(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Roger Sumatera",
                      labelText: "Nama Lengkap",
                      // Add icon
                      icon: const Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _namaLengkap = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama lengkap tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.school),
                        title: Text("Jenjang"),
                      ),
                      CheckboxListTile(
                        title: const Text('Sarjana'),
                        value: jenjangSarjana,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangSarjana = value!;
                            jenjang = "Sarjana";
                            if (value) {
                              jenjangMagister =
                                  jenjangDiploma = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Diploma'),
                        value: jenjangDiploma,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDiploma = value!;
                            jenjang = "Diploma";
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Magister'),
                        value: jenjangMagister,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangMagister = value!;
                            jenjang = "Magister";
                            if (value) {
                              jenjangDiploma =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Doktor'),
                        value: jenjangDoktor,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDoktor = value!;
                            jenjang = "Doktor";
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDiploma = false;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.co_present),
                  title: Row(
                    children: [
                      Text('Umur: ${umur.round()}'),
                    ],
                  ),
                  subtitle: Slider(
                    value: umur,
                    max: 100,
                    divisions: 100,
                    label: umur.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        umur = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text('Kelas PBP'),
                  trailing: DropdownButton(
                    value: kelasPBP,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listKelasPBP.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        kelasPBP = value!;
                      });
                    },
                  ),
                ),
                SwitchListTile(
                  title: const Text('Practice Mode'),
                  value: _nilaiSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      _nilaiSwitch = value;
                    });
                  },
                  secondary: const Icon(Icons.run_circle_outlined),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15, // Z-coordinate
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Informasi Data',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Nama: $_namaLengkap",
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Umur: $umur"
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Jenjang: $jenjang",
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Kelas PBP: $kelasPBP"
                                  ),
                                  // Show data
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Kembali'),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
