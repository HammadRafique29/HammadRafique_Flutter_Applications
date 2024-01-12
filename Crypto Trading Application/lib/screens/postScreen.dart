// class PageFour extends StatefulWidget {
//   const PageFour({super.key});

//   @override
//   State<PageFour> createState() => _PageFourState();
// }

// class _PageFourState extends State<PageFour> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController titleController = TextEditingController();
//     TextEditingController paragraphController = TextEditingController();
//     TextEditingController youtubeController = TextEditingController();
//     File? selectedImage;
//     File? selectedFile;

//     Future<void> _pickImage() async {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         setState(() {
//           selectedImage = File(pickedFile.path);
//         });
//       }
//     }

//     Future<void> _pickFile() async {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();

//       if (result != null) {
//         setState(() {
//           selectedFile = File(result.files.single.path!);
//         });
//       }
//     }

//     YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId: '',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: true,
//       ),
//     );

//     bool showYoutubeVideo = false;

//     Future<void> _savePostToFirestore() async {
//       // Check if an image is selected
//       if (selectedImage == null) {
//         print('Please pick an image.');
//         return;
//       }

//       try {
//         // Add post data to Firestore
//         DocumentReference documentReference =
//             await FirebaseFirestore.instance.collection('posts').add({
//           'title': titleController.text,
//           'paragraph': paragraphController.text,
//           'youtubeVideoUrl': youtubeController.text,
//         });

//         // Get the document ID
//         String documentId = documentReference.id;

//         // Upload image to Firebase Storage with a unique name
//         String imageName = '$documentId-${p.basename(selectedImage!.path)}';
//         Reference imageStorageReference =
//             FirebaseStorage.instance.ref().child('images/$imageName');
//         await imageStorageReference.putFile(selectedImage!);

//         // Upload file to Firebase Storage with a unique name
//         if (selectedFile != null) {
//           String fileName = '$documentId-${p.basename(selectedFile!.path)}';
//           Reference fileStorageReference =
//               FirebaseStorage.instance.ref().child('files/$fileName');
//           await fileStorageReference.putFile(selectedFile!);

//           // Update the Firestore document with the file download URL and file name
//           await FirebaseFirestore.instance
//               .collection('posts')
//               .doc(documentId)
//               .update({
//             'imageUrl': await imageStorageReference.getDownloadURL(),
//             'imageName': imageName,
//             'fileUrl': await fileStorageReference.getDownloadURL(),
//             'fileName': fileName,
//           });
//         } else {
//           // Update the Firestore document with only the image download URL and image name
//           await FirebaseFirestore.instance
//               .collection('posts')
//               .doc(documentId)
//               .update({
//             'imageUrl': await imageStorageReference.getDownloadURL(),
//             'imageName': imageName,
//           });
//         }

//         // Reset the form or navigate to another screen after saving the post
//         // Reset form example:
//         setState(() {
//           titleController.clear();
//           paragraphController.clear();
//           youtubeController.clear();
//           selectedImage = null;
//           selectedFile = null;
//           showYoutubeVideo = false;
//           _controller = YoutubePlayerController(
//             initialVideoId: '',
//             flags: YoutubePlayerFlags(
//               autoPlay: true,
//               mute: true,
//             ),
//           );
//         });

//         print('Post saved successfully.');
//       } catch (e) {
//         print('Error saving post: $e');
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Post'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Post Title'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 child: Text('Pick Image'),
//               ),
//               SizedBox(height: 20),
//               if (selectedImage != null)
//                 Image.file(
//                   selectedImage!,
//                   width: 100,
//                   fit: BoxFit.cover,
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _pickFile,
//                 child: Text('Pick File'),
//               ),
//               SizedBox(height: 20),
//               if (selectedFile != null)
//                 Text('Selected File: ${p.basename(selectedFile!.path)}'),
//               SizedBox(height: 20),
//               TextField(
//                 controller: paragraphController,
//                 decoration: InputDecoration(labelText: 'Paragraph'),
//                 maxLines: null,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: youtubeController,
//                 decoration: InputDecoration(labelText: 'YouTube Video URL'),
//               ),
//               SizedBox(height: 20),
//               if (showYoutubeVideo)
//                 YoutubePlayer(
//                   controller: _controller,
//                   showVideoProgressIndicator: true,
//                 ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     // Toggle the visibility of the YouTube video
//                     showYoutubeVideo = !showYoutubeVideo;
//                     _controller = YoutubePlayerController(
//                       initialVideoId: YoutubePlayer.convertUrlToId(
//                                   youtubeController.text) ==
//                               null
//                           ? ""
//                           : YoutubePlayer.convertUrlToId(
//                               youtubeController.text)!,
//                       flags: YoutubePlayerFlags(
//                         autoPlay: true,
//                         mute: true,
//                       ),
//                     );
//                   });
//                 },
//                 child: Text(showYoutubeVideo ? 'Hide Video' : 'Show Video'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _savePostToFirestore();
//                 },
//                 child: Text('Save Post'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     // return Align(
//     //   alignment: Alignment.bottomRight,
//     //   child: Padding(
//     //     padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
//     //     child: FloatingActionButton(
//     //       backgroundColor: Colors.amber[400]!.withOpacity(0.8),
//     //       onPressed: () {
//     //         // Add your onPressed logic here
//     //         showDialog(
//     //           context: context,
//     //           builder: (context) => PostDialog(),
//     //         );
//     //       },
//     //       child: Icon(Icons.add, color: Colors.white),
//     //     ),
//     //   ),
//     // );
//   }
// }
