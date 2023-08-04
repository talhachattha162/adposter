import 'dart:io';
import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/firebase/user_repository.dart';
import 'package:AdvertiseMe/models/admodels.dart';
import 'package:AdvertiseMe/providers/publishadprovider.dart';
import 'package:AdvertiseMe/screen/bottom_navbar.dart';
import 'package:AdvertiseMe/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../utils/categories_list.dart';
import '../utils/districts_list.dart';

class PublishAdScreen extends StatefulWidget {
  final AdModel? ad;

  PublishAdScreen({this.ad});
  @override
  _PublishAdScreenState createState() => _PublishAdScreenState();
}

class _PublishAdScreenState extends State<PublishAdScreen> {

  final _formKey1 = GlobalKey<FormState>();
  final int maxImageCount = 10;
  final int maxImageSize = 10 * 1024 * 1024;

  List<String> _conditions = ['New', 'Open Box', 'Used', 'Not Working'];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _whatsappController = TextEditingController();
  TextEditingController _whatsapp1Controller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _districtController = TextEditingController();

  makeProvidersEmpty(){
    Provider.of<PublishAdProvider>(context,listen: false).images=[];
    Provider.of<PublishAdProvider>(context,listen: false).selectedImages=[];
    Provider.of<PublishAdProvider>(context,listen: false).selectedCondition='';
    Provider.of<PublishAdProvider>(context,listen: false).selectedCategory='Electronics';
    Provider.of<PublishAdProvider>(context,listen: false).isLoading=false;
  }

@override
void initState(){
  super.initState();
  _whatsapp1Controller.text='+92';
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    makeProvidersEmpty();
    // print(widget.ad?.adId);
    if(widget.ad?.adId!=null){
      Provider.of<PublishAdProvider>(context,listen: false).images=widget.ad!.images;

      String cleanedWhatsAppNumber='';
      String cleanedphoneNumber='';
      if( widget.ad!.whatsAppNumber!=''){
        String whatsAppNumber = widget.ad!.whatsAppNumber;
        cleanedWhatsAppNumber = whatsAppNumber.substring(3);
        Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=true;
      }
      else if(widget.ad!.phoneNumber!=''){
        String phoneNumber = widget.ad!.phoneNumber;
        cleanedphoneNumber = phoneNumber.substring(3);
        // print(cleanedphoneNumber);

        Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=false;

      }

      Provider.of<PublishAdProvider>(context,listen: false).selectedCategory=widget.ad!.category;
      Provider.of<PublishAdProvider>(context,listen: false).selectedCondition=widget.ad!.condition;
      _priceController.text=widget.ad!.price;
      _titleController.text=widget.ad!.title;
      _descriptionController.text=widget.ad!.description;
      _priceController.text=widget.ad!.price;
      _whatsappController.text=cleanedWhatsAppNumber;
      _phoneController.text=cleanedphoneNumber;
      _locationController.text=widget.ad!.location;
      _districtController.text=widget.ad!.district;
    }
  });

}



  Future<void> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? pickedFiles;

    try {
      pickedFiles = await _picker.pickMultiImage(imageQuality: 30
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));

    }

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (pickedFiles.length <= maxImageCount) {
        List<File> selectedImages = [];
        int totalImageSize = 0;

        for (var file in pickedFiles) {
          File imageFile = File(file.path);
          int imageSize = await imageFile.length();

          if (imageSize <= maxImageSize) {
            selectedImages.add(imageFile);
            totalImageSize += imageSize;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image size limit 10 mb')));
          }
        }
        Provider.of<PublishAdProvider>(context,listen: false).selectedImages+=(selectedImages);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You can only upload up to $maxImageCount images.')));
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _whatsappController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _districtController.dispose();
    _whatsapp1Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Publish Ad'),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Form(
            key: _formKey1,child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap:  () {
                    pickImages();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upload upto 10 photos',style: TextStyle(fontWeight: FontWeight.bold),),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
                Selector<PublishAdProvider,List<String>>(selector: (p0, p1) => p1.images,builder: (context,images,child) {
                  return
                Selector<PublishAdProvider,List<File>>(selector: (p0, p1) => p1.selectedImages,builder: (context,selectedImages,child) {
                  return
                images.isEmpty && selectedImages.isEmpty?
                GestureDetector(
                  onTap:  () {
                    pickImages();
                  },
                  child: Container(
                    color: Color.fromRGBO(255,128, 0, 0.5),
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline,color: Colors.black87,),
                        Text('Add Images',style: TextStyle(color: Colors.black87)),
                      ],
                    ),
                  ),
                )
                    :
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length + selectedImages.length,
                    itemBuilder: (context, index) {
                      if (index < images.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(images[index]),
                        );
                      }
                      // Otherwise, show the selected local image
                      final selectedImageIndex = index - images.length;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(selectedImages[selectedImageIndex]),
                      );
                    },
                  ),
                );

    },
                );
                },
                )
,
                SizedBox(height: 10),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title.';
                    }
                    // You can add more complex validation checks if needed.
                    return null; // Return null if the input is valid.
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(),),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description.';
                    }
                    // You can add more complex validation checks if needed.
                    return null; // Return null if the input is valid.
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price', border: OutlineInputBorder(),),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Price.';
                    }
                    // You can add more complex validation checks if needed.
                    return null; // Return null if the input is valid.
                  },
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: _conditions.map((condition) {
                    return Selector<PublishAdProvider,String?>(
                      selector: (p0, p1) => p1.selectedCondition,
                      builder: (context,selectedCondition,_) {
                        return ChoiceChip(
                          label: Text(condition),
                          selected: selectedCondition == condition,
                          onSelected: (selected) {
                            Provider.of<PublishAdProvider>(context,listen: false).selectedCondition=(selected ? condition : null)!;
                          },
                        );
                      }
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),
                Selector<PublishAdProvider,String>(selector: (p0, p1) => p1.selectedCategory,
                  builder: (context,selectedCategory,_) {
                    return DropdownButtonFormField<String>(
                      value: selectedCategory,
                      onChanged: (newValue) {
                        Provider.of<PublishAdProvider>(context,listen: false).selectedCategory=newValue!;
                      },
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder(),),
                    );
                  }
                ),

                SizedBox(height: 10),
            TypeAheadField(
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              getImmediateSuggestions: true,
              intercepting: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: _districtController, // Use the TextEditingController here
                decoration: InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return districtNames.where((district) =>
                    district.toLowerCase().startsWith(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _districtController.text = suggestion; // Set the selected district to the text field
                });
                print('Selected district: $suggestion');
              },
            ),

                SizedBox(height: 10),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder(),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address.';
                    }
                    // You can add more complex validation checks if needed.
                    return null; // Return null if the input is valid.
                  },
                ),
            Selector<PublishAdProvider,bool>(selector: (p0, p1) => p1.useWhatsApp,
                builder: (context,useWhatsApp,_) {
                  return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Wrap(

                      children: [
                        ListTile(
                          leading: Radio(
                            value: true,
                            groupValue: useWhatsApp,
                            onChanged: (value) {
                              Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=true;
                            },
                          ),
                          title: Text('WhatsApp Number'),
                          onTap: () {
                            Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=true;
                          },
                        ),
                        ListTile(
                          leading: Radio(
                            value: false,
                            groupValue: useWhatsApp,
                            onChanged: (value) {
                              Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=false;
                            },
                          ),
                          title: Text('Phone Number'),
                          onTap: () {
                            Provider.of<PublishAdProvider>(context,listen: false).useWhatsApp=false;
                          },
                        ),

                      ],
                    ),

                SizedBox(height: 10),
                useWhatsApp?
                  Row(
                    children: [
                      SizedBox(
                        width: width*0.2,
                        child: TextFormField(
                          controller: _whatsapp1Controller,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,

                        ),
                      ),
                      SizedBox(width: width*0.04,),
                      SizedBox(
                        width: width*0.62,
                        child: TextFormField(
                          controller: _whatsappController,
                          decoration: InputDecoration(
                            labelText: 'WhatsApp Number',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,

                        ),
                      ),
                    ],
                  )
                :
                  Row(
                    children: [
                      SizedBox(
                        width: width*0.2,
                        child: TextField(
                          controller: _whatsapp1Controller,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(width: width*0.04,),
                      SizedBox(
    width: width*0.62,
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),

                        ),
                      ),
                    ],
                  ),
              ],
            );
                  }
            ),
                SizedBox(height: 20),
               Selector<PublishAdProvider,bool>(builder: (context, isLoading, child) {
                 return isLoading
                     ?
                 Center(child: CircularProgressIndicator())
                     :
                 ElevatedButton(
                   onPressed: () async {

    if (_formKey1.currentState!.validate()
        &&
       ( Provider
        .of<PublishAdProvider>(context, listen: false)
        .selectedImages.length!=0 || Provider
           .of<PublishAdProvider>(context, listen: false)
           .images.length!=0)
    &&
        Provider
            .of<PublishAdProvider>(context, listen: false).selectedCondition!='' && (_whatsappController.text!='' || _phoneController.text!='')
    ) {
      Provider
            .of<PublishAdProvider>(context, listen: false)
            .isLoading = true;
      String title = _titleController.text;
      String description = _descriptionController.text;
      String price = _priceController.text;
      String? condition = Provider
            .of<PublishAdProvider>(context, listen: false)
            .selectedCondition;
      String whatsAppNumber = '';
      String phoneNumber = '';
      if (_whatsappController.text != '') {
          whatsAppNumber = '+92${_whatsappController.text}';
      }
      if (_phoneController.text != '') {
          phoneNumber = '+92${_phoneController.text}';
      }
      String location = _locationController.text;
      String category = Provider
            .of<PublishAdProvider>(context, listen: false)
            .selectedCategory;
      String district = _districtController.text;
      DateTime timePosted = DateTime.now();
      AdRepository adRepository = AdRepository();
      try {
          List<String> selectedimagespaths = await adRepository
            .uploadImages(Provider
            .of<PublishAdProvider>(context, listen: false)
            .selectedImages);
          List<String> images1 = selectedimagespaths;
          if (widget.ad?.adId != null) {
            images1.addAll(widget.ad!.images);
          }
          AdModel ads = AdModel(
            '',
            images: images1,
            title: title,
            description: description,
            price: price,
            condition: condition,
            category: category,
            whatsAppNumber: whatsAppNumber,
            phoneNumber: phoneNumber,
            location: location,
            district: district,
            timeposted: timePosted,
            postedBy: FirebaseAuth.instance.currentUser!.email,);
          print(widget.ad?.adId.toString());
          if (widget.ad?.adId != null) {
            ads.adId = widget.ad!.adId;
            print('talha2');
            await adRepository.updateAd(widget.ad!.adId, ads);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Updated')));
          }
          else {
            // print('talha');
            await adRepository.registerAd(ads);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Uploaded')));
          }
      }
      catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e')));
      }
      Provider
            .of<PublishAdProvider>(context, listen: false)
            .isLoading = false;
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen(),),);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('image or condtion or number not added')));
    }
                   },
                   child: Text('Publish Ad'),
                 );
               }, selector: (p0, p1) => p1.isLoading,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
