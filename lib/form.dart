import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  void Jenjang() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (jenjangDiploma) {
        jenjang = "Diploma";
      } else if (jenjangDoktor) {
        jenjang = "Doktor";
      } else if (jenjangMagister) {
        jenjang = "Magister";
      } else if (jenjangSarjana) {
        jenjang = "Sarjana";
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _namaLengkap = "";
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;
  double umur = 0;
  String kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _nilaiSwitch = false;
  String jenjang = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // Menggunakan padding sebesar 8 pixels
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Contoh: Pak Dengklek",
                  labelText: "Nama Lengkap",
                  // Menambahkan icon agar lebih intuitif
                  icon: const Icon(Icons.people),
                  // Menambahkan circular border agar lebih rapi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                // Menambahkan behavior saat nama diketik
                onChanged: (String? value) {
                  setState(() {
                    _namaLengkap = value!;
                  });
                },
                // Menambahkan behavior saat data disimpan
                onSaved: (String? value) {
                  setState(() {
                    _namaLengkap = value!;
                  });
                },
                // Validator sebagai validasi form
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama lengkap tidak boleh kosong!';
                  }
                  return null;
                },
              ),
            ),
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
                  if (value) {
                    jenjangMagister = jenjangDiploma = jenjangDoktor = false;
                  }
                  Jenjang();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Diploma'),
              value: jenjangDiploma,
              onChanged: (bool? value) {
                setState(() {
                  jenjangDiploma = value!;
                  if (value) {
                    jenjangMagister = jenjangSarjana = jenjangDoktor = false;
                  }
                  Jenjang();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Magister'),
              value: jenjangMagister,
              onChanged: (bool? value) {
                setState(() {
                  jenjangMagister = value!;
                  if (value) {
                    jenjangDiploma = jenjangSarjana = jenjangDoktor = false;
                  }
                  Jenjang();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Doktor'),
              value: jenjangDoktor,
              onChanged: (bool? value) {
                setState(() {
                  jenjangDoktor = value!;
                  if (value) {
                    jenjangMagister = jenjangSarjana = jenjangDiploma = false;
                  }
                  Jenjang();
                });
              },
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
              title: const Text(
                'Kelas PBP',
              ),
              trailing: DropdownButton(
                value: kelasPBP,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: listKelasPBP.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    kelasPBP = newValue!;
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
                        elevation: 15,
                        child: Container(
                          child: ListView(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(child: const Text('Informasi Data')),
                              SizedBox(height: 20),
                              Center(child: Text("Nama: $_namaLengkap")),
                              Center(child: Text("Jenjang: $jenjang")),
                              Center(child: Text("Umur: $umur")),
                              Center(child: Text("Kelas: $kelasPBP")),
                              // TODO: Munculkan informasi yang didapat dari form
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Kembali'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
