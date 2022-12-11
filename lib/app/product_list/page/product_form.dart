import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_panel/app/product_list/api/product_api.dart';
import 'package:my_panel/app/product_list/page/appbar.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _listType = ["Panel", "Battery", "Inverter"];
  String? _name;
  int? _price;
  String? _type;
  int? _maxPower;
  int? _capacity;
  int? _output;
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _maxPowerController = TextEditingController();
  final _capacityController = TextEditingController();
  final _outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Panel 123",
                      labelText: "Product's Name",
                      // Added a circular border to make it neater
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Added behavior when name is typed
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi nama!';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "111111",
                      labelText: "Price",
                      prefix: const Text("Rp"),
                      // Added a circular border to make it neater
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Added behavior when name is typed
                    onChanged: (String? value) {
                      setState(() {
                        _price = int.parse(value!);
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _price = int.parse(value!);
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi harga!';
                      }
                      return null;
                    },
                  ),
                ),

                // Dropdown
                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: _type,
                    elevation: 16,
                    hint: const Text("Pilih Jenis"),
                    onChanged: (String? value){
                      setState(() {
                        _type = value!;
                      });
                    },
                    items: _listType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi jenis produk!';
                      }
                      return null;
                    },
                  ),
                ),

                if (_type == "Panel") ...[
                  Padding(
                    // Using padding of 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _maxPowerController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: "100",
                        labelText: "Max Power",
                        suffix: const Text("Watt"),
                        // Added a circular border to make it neater
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Added behavior when name is typed
                      onChanged: (String? value) {
                        setState(() {
                          _maxPower = int.parse(value!);
                        });
                      },
                      // Added behavior when data is saved
                      onSaved: (String? value) {
                        setState(() {
                          _maxPower = int.parse(value!);
                        });
                      },
                      // Validator as form validation
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi power maks!';
                        }
                        return null;
                      },
                    ),
                  ),
                ] else if (_type == "Battery") ... [
                  Padding(
                    // Using padding of 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: "500",
                        labelText: "Capacity",
                        suffix: const Text("Ah"),
                        // Added a circular border to make it neater
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Added behavior when name is typed
                      onChanged: (String? value) {
                        setState(() {
                          _capacity = int.parse(value!);
                        });
                      },
                      // Added behavior when data is saved
                      onSaved: (String? value) {
                        setState(() {
                          _capacity = int.parse(value!);
                        });
                      },
                      // Validator as form validation
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi kapasitas!';
                        }
                        return null;
                      },
                    ),
                  ),
                ] else if (_type == "Inverter") ...[
                  Padding(
                    // Using padding of 8 pixels
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _outputController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: "1000",
                        labelText: "Output",
                        suffix: const Text("Watt"),
                        // Added a circular border to make it neater
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Added behavior when name is typed
                      onChanged: (String? value) {
                        setState(() {
                          _output = int.parse(value!);
                        });
                      },
                      // Added behavior when data is saved
                      onSaved: (String? value) {
                        setState(() {
                          _output = int.parse(value!);
                        });
                      },
                      // Validator as form validation
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi output!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await addProduct(
                  context,
                  _name!,
                  _price!,
                  _type!,
                  _maxPower ?? 0,
                  _capacity ?? 0,
                  _output ?? 0
              );
              _nameController.clear();
              _priceController.clear();
              _maxPowerController.clear();
              _capacityController.clear();
              _outputController.clear();
              final successBar = SnackBar(
                content: const Text("Product berhasil disimpan!"),
                action: SnackBarAction(
                  label: 'Hide',
                  onPressed: () {

                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(successBar);
            }
          },
          child:
          const Text(
            "Add Product",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}