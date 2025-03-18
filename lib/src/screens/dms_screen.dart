import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
// Import for navigation

class DMScreen extends StatelessWidget {
  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = const Color.fromRGBO(255, 245, 121, 100);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // Setting background image
            image: DecorationImage(
              image: AssetImage('images/Login_SignUp_Background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

      //TOP BAR
      appBar: AppBar(
        backgroundColor: color,
      ),
      
      //keyboard implementation
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding:const EdgeInsets.only(left:40.0),
            child: ChatInputBar(),
        )
      ),
      );
  
  }

}

//keyboard function
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();

}

//keyboard input
class _ChatInputBarState extends State<ChatInputBar> {
  bool _showImage = false;

  //when + button is pressed, show users the option to upload a photo
  void _toggleImage() {
    setState(() {
      _showImage = !_showImage;
    });
  }


  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  final TextEditingController _fileNameController = TextEditingController();

  //when user wants to take a photo
  Future<void> _openCamera() async {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        // Do something with the image file (e.g., upload, preview)
      setState(() {
      _selectedImage = photo;
      _fileNameController.text = photo.name;
      });
        print("Image path: ${photo.path}");
      } else {
        print("Camera closed or permission denied.");
      }
    }

  final ImagePicker _picker2 = ImagePicker();

  //when user wants to upload a photo
  Future<void> _openGallery() async {
    final XFile? image = await _picker2.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Do something with the selected image (e.g., upload, preview)
      setState(() {
      _selectedImage = image;
      _fileNameController.text = image.name;
      });

      print("Image path: ${image.path}");
    } else {
      print("No image selected.");
    }
  }

    //builds the yellow box with options "camera" and "upload"
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showImage)
              
                Container(
                  alignment: Alignment.topLeft,
                  width: 200,
                  height: 105,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      Row(
                        //buttons to open camera 
                        children: [
                          IconButton(onPressed: (){_openCamera();}, icon: Image.asset("images/Camera_button_dms.png",height: 40,width: 40,),padding: EdgeInsets.zero), // or replace with Image.asset(...)
                          SizedBox(width: 8),
                          IconButton(onPressed: (){_openCamera();},icon:Text("Camera",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                        ],
                      ),

                      //buttons to open gallery
                      SizedBox(height: 1),
                      Row(
                        children: [
                          IconButton(onPressed: (){_openGallery();}, icon: Image.asset("images/Documents_button_dms.png",height: 35,width: 35,),padding: EdgeInsets.zero), // or replace with Image.asset(...)
                          SizedBox(width: 8),
                          IconButton(onPressed: (){_openGallery();},icon:Text("Documents",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))),
                        ],
                      ),
                        
                      
                    ],
                  ),
                ),
                

  // Chat input field
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedImage != null)
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File(_selectedImage!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
          
        // + circle button 
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _fileNameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: "Send a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromARGB(255, 207, 207, 207),
                  filled: true,
                  prefixIcon: IconButton(
                    icon: Image.asset(
                      'images/plus_circle_icon.png',
                      height: 35,
                      width: 35,
                    ),
                    onPressed: _toggleImage,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  )
          ],
        ),
      );
    }
}

    


