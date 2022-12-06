import 'dart:io';

import 'package:Wanderer/Screens/MarketPlace/Catalogue.dart';

import 'package:Wanderer/Services/MarketPlaceService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddProduct extends StatefulWidget {
  static final String routeName = "/addProduct";
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> categories = [
    'Boots',
    'Jackets',
    'Tents',
    'Sleeping bags',
    'Utensils',
    'Mattresses',
    'Lamps & hamac',
    'Chairs & tables',
    'Survival(+kit)'
  ];

  //city Picker

  static List<String> cities = [
    'Ariana',
    'Béja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'Le Kef	',
    'Mahdia',
    'La Manouba',
    'Médenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];

  var product = {
    'Product Name': '',
    'Product Price': 0,
    'Brand': '',
    'Description': '',
    'Category': -1,
    'Phone Number': 0,
    'City': 'Select a City'
  };
  String errorPictures = '';
  List<File> _selectedFile = [];
  FormData toUpload = new FormData();
  imageTpUpload() async {
    /*for (int i = 0; i < _selectedFile.length; i++) {
      FormData formData = new FormData.fromMap({
        "prodname": dataProd[0],
        "image": await MultipartFile.fromFile(_selectedFile[i].path,
            filename: basename(_selectedFile[i].path))
      });
      setState(() {
        this.toUpload.add(formData);
      });
    }*/
  }

  String category = 'Select Category';
  int cat = -1;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            title: Text("Upload picture from",
                style: TextStyle(color: Colors.white70)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.white70,
                          ),
                        ),
                        Text("Gallery",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    onTap: () async {
                      File pic = await ImageService.pickImage(
                          source: ImageSource.gallery);
                      if (pic != null)
                        setState(() {
                          _selectedFile.add(pic);
                        });
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white70,
                          ),
                        ),
                        Text("Camera", style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    onTap: () async {
                      File pic = await ImageService.pickImage(
                          source: ImageSource.camera);
                      if (pic != null) {
                        setState(() {
                          _selectedFile.add(pic);
                        });
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ScrollController _scrollController = new ScrollController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: CustomColor.backgroundColor,
        ),
        child: ModalProgressHUD(
          color: Colors.black,
          progressIndicator: LoadingWidget(),
          opacity: 0.5,
          inAsyncCall: _saving,
          child: Container(
            child: SingleChildScrollView(
                child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 28),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Product Informations :',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      ),
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty !';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white70),
                            decoration: inputDecoration('Product Name'),
                            onChanged: (val) {
                              setState(() {
                                product['Product Name'] = val;
                              });
                            }),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty !';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white70),
                            decoration: inputDecoration('Product Price'),
                            onChanged: (val) {
                              setState(() {
                                product['Product Price'] = val;
                              });
                            }),
                      ),
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty !';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white70),
                            decoration: inputDecoration('Brand'),
                            onChanged: (val) {
                              setState(() {
                                product['Brand'] = val;
                              });
                            }),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 35, right: 30, left: 30),
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty !';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.yellow),
                              focusedErrorBorder: errorstyle(),
                              errorBorder: errorstyle(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white70),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: CustomColor.interactable),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white70),
                              ),
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.white70),
                              hintText: 'Describe the state , age ...',
                              hintStyle: TextStyle(color: Colors.white70)),
                          maxLength: 350,
                          maxLengthEnforced: true,
                          maxLines: 8,
                          minLines: 1,
                          buildCounter: (_,
                                  {currentLength, maxLength, isFocused}) =>
                              Container(
                                  child: Text(
                                currentLength.toString() +
                                    "/" +
                                    maxLength.toString(),
                                style: TextStyle(color: Colors.white70),
                              )),
                          onChanged: (val) {
                            setState(() {
                              product['Description'] = val;
                            });
                          }),
                    ),

                    //Category Select Drop Down Menu
                    SizedBox(
                      width: 250,
                      child: DropdownButtonFormField(
                        dropdownColor: CustomColor.backgroundColor,
                        hint: Text(category,
                            style: TextStyle(color: Colors.white70)),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          labelStyle: TextStyle(color: Colors.white70),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow),
                          ),
                          errorStyle: TextStyle(color: Colors.yellow),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category !';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            product['Category'] = categories.indexOf(val);
                            category = val;
                          });
                        },
                        items: categories.map((String s) {
                          return DropdownMenuItem<String>(
                            value: s,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  s,
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Container(
                        height: 1,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellow[50],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 30),
                          child: Text(
                            'Seller Informations :',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 20),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 42),
                        child: Text('How can potential buyers contact you ',
                            style: TextStyle(
                                color: CustomColor.interactableAccent)),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty !';
                              }
                              if (value.toString().length != 8) {
                                return 'Phone number was be 8 digits long !';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white70),
                            decoration: inputDecoration('Phone Number'),
                            onChanged: (val) {
                              setState(() {
                                product['Phone Number'] = val;
                              });
                            }),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        width: 250,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.yellow),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorStyle: TextStyle(color: Colors.yellow),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a city!';
                            }
                            return null;
                          },
                          hint: Text(product['City'],
                              style: TextStyle(color: Colors.white70)),
                          onChanged: (val) {
                            setState(() {
                              product['City'] = val;
                            });
                          },
                          items: cities.map((String s) {
                            return DropdownMenuItem<String>(
                              value: s,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    s,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 30),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.info,
                                color: CustomColor.interactableAccent,
                              ),
                            ),
                            Text(
                                'These changes will be updated in your profile',
                                style: TextStyle(
                                    color: CustomColor.interactableAccent))
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                      child: Container(
                        height: 1,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellow[50],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 30),
                          child: Text(
                            'Product Pictures :',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 20),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 42),
                        child: Text(
                            'A preview picture and 3 additional pictures must be provided :\n',
                            style: TextStyle(
                                color: CustomColor.interactableAccent)),
                      ),
                    ),
                    _selectedFile.length == 4
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(right: 7),
                                      child: Icon(Icons.check,
                                          color: CustomColor.interactable)),
                                  Text(
                                    'you have reached the required number  ',
                                    style: TextStyle(
                                        color: CustomColor.interactable),
                                  )
                                ],
                              ),
                            ),
                          )
                        : RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            textColor: CustomColor.highlightText,
                            color: CustomColor.interactable,
                            onPressed: () {
                              setState(() {
                                this.errorPictures = '';
                              });
                              _showChoiceDialog(context);
                            },
                            child: Text(
                              "Add Pictures",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),

                    // displayting the selected images
                    Container(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _selectedFile.isEmpty
                              ? Text('')
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: SizedBox(
                                    width: 400,
                                    height: 300,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        controller: _scrollController,
                                        itemCount: _selectedFile.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 10),
                                            child: Stack(children: [
                                              Image.file(
                                                  new File(_selectedFile[index]
                                                      .path),
                                                  width: 200,
                                                  height: 200,
                                                  fit: BoxFit.cover),
                                              InkWell(
                                                onTap: () => {
                                                  setState(() {
                                                    _selectedFile
                                                        .removeAt(index);
                                                  })
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 180, bottom: 80),
                                                    padding: EdgeInsets.only(
                                                        bottom: 40),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 30,
                                                    )),
                                              )
                                            ]),
                                          );
                                        }),
                                  ),
                                ),
                          //error message display if pictures are less than required
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, bottom: 20),
                            child: Text(
                              errorPictures,
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              textColor: CustomColor.highlightText,
                              color: CustomColor.interactable,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (_selectedFile.length == 4) {
                                    setState(() {
                                      _saving = true;
                                    });

                                    MarketPlaceService.addProduct(
                                            product, _selectedFile)
                                        .then((value) => {
                                              print(value),
                                              {
                                                setState(() {
                                                  _saving = false;
                                                }),
                                                if (value != null)
                                                  {
                                                    setState(() {
                                                      _saving = false;
                                                    }),
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            Catalogue.routeName)
                                                  }
                                              }
                                            });
                                  } else {
                                    setState(() {
                                      this.errorPictures =
                                          "Not enough pictures !";
                                    });
                                  }
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

//to avoid repeatitive chunks of styling code
OutlineInputBorder errorstyle() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.yellow),
    borderRadius: BorderRadius.circular(10.0),
  );
}

InputDecoration inputDecoration(String text) {
  return InputDecoration(
    errorStyle: TextStyle(color: Colors.yellow),
    focusedErrorBorder: errorstyle(),
    errorBorder: errorstyle(),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: new BorderSide(color: Colors.white70),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: CustomColor.interactable),
    ),
    labelText: text,
    labelStyle: TextStyle(color: Colors.white70),
  );
}
