import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doan/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatingEvent extends StatefulWidget {
  const CreatingEvent({super.key});

  @override
  _CreatingEventState createState() => _CreatingEventState();
}

class _CreatingEventState extends State<CreatingEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _participantsTargetController = TextEditingController();
  final TextEditingController _meetingLocationController = TextEditingController();
  final TextEditingController _participantsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailedDescriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();  final TextEditingController _pointController = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  File? _imageFile;
  String? _imageUrl;
  bool _isLoadingImage = false;

  double get deviceWidth => MediaQuery.of(context).size.width;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập thông tin';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Xử lý dữ liệu khi form hợp lệ
      print('Tên sự kiện: ${_eventNameController.text}');
      print('Mô tả: ${_descriptionController.text}');
      print('Mô tả chi tiết: ${_detailedDescriptionController.text}');
      print('Ngày: $_selectedDate');
      print('Giờ bắt đầu: $_selectedStartTime');
      print('Giờ kết thúc: $_selectedEndTime');
      print('Địa điểm: ${_locationController.text}');
      print('Đối tượng tham gia: ${_participantsTargetController.text}');
      print('Địa điểm tập trung: ${_meetingLocationController.text}');
      print('Số lượng sinh viên: ${_participantsController.text}');
      if (_imageFile != null) {
        print('Ảnh: ${_imageFile!.path}');
      }
    }
  }

  void _loadImageFromUrl() {
    if (_imageUrlController.text.isEmpty) return;
    setState(() {
      _isLoadingImage = true;
      _imageUrl = _imageUrlController.text;
      _imageFile = null;
    });
    // Add image loading completion handler
    precacheImage(NetworkImage(_imageUrlController.text), context).then((_) {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }).catchError((_) {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    });
  }

  void _resetImage() {
    setState(() {
      _imageUrl = null;
      _imageUrlController.clear();
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Tạo sự kiện'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.arrowLeft, color: AppColors.textBlack, size: 18),
                        SizedBox(width: 12),
                        Text(
                          'Trở lại',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'URL Ảnh',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _loadImageFromUrl,
                      child: Text('Tải ảnh'),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: _resetImage,
                      icon: Icon(Icons.refresh),
                      tooltip: 'Đặt lại ảnh',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: (_imageUrl != null)
                        ? DecorationImage(
                            image: NetworkImage(_imageUrl!),
                            fit: BoxFit.contain,
                          )
                        : _imageFile != null
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              )
                            : null,
                  ),
                  child: _isLoadingImage
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _imageUrl == null && _imageFile == null
                          ? Center(
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                            )
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _eventNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên sự kiện',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32, // 32 is total padding (16 * 2)
                        ),
                      ),
                      validator: _validateNotEmpty,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả sự kiện',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32,
                        ),
                      ),
                      maxLines: 3,
                      validator: _validateNotEmpty,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21, // Account for padding and spacing
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Ngày',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedDate != null
                                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                    : '',
                              ),
                              validator: (value) => _selectedDate == null ? 'Vui lòng chọn ngày' : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Giờ bắt đầu',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () => _selectStartTime(context),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedStartTime != null
                                    ? '${_selectedStartTime!.hour}:${_selectedStartTime!.minute}'
                                    : '',
                              ),
                              validator: (value) => _selectedStartTime == null ? 'Vui lòng chọn giờ bắt đầu' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Ngày kết thúc',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _selectEndDate(context),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedEndDate != null
                                    ? '${_selectedEndDate!.day}/${_selectedEndDate!.month}/${_selectedEndDate!.year}'
                                    : '',
                              ),
                              validator: (value) => _selectedEndDate == null ? 'Vui lòng chọn ngày kết thúc' : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Giờ kết thúc',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () => _selectEndTime(context),
                                ),
                              ),
                              controller: TextEditingController(
                                text: _selectedEndTime != null
                                    ? '${_selectedEndTime!.hour}:${_selectedEndTime!.minute}'
                                    : '',
                              ),
                              validator: (value) => _selectedEndTime == null ? 'Vui lòng chọn giờ kết thúc' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _locationController,
                              decoration: InputDecoration(
                                labelText: 'Địa điểm',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _participantsTargetController,
                              decoration: InputDecoration(
                                labelText: 'Đối tượng tham gia',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                      ],
                    ),                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _meetingLocationController,
                              decoration: InputDecoration(
                                labelText: 'Địa điểm tập trung',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: (deviceWidth / 2) - 21,
                            child: TextFormField(
                              controller: _participantsController,
                              decoration: InputDecoration(
                                labelText: 'Số lượng sinh viên',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: _validateNotEmpty,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _pointController,
                      decoration: InputDecoration(
                        labelText: 'Điểm dự kiến',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNotEmpty,
                    ),
                    
                   
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _detailedDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả chi tiết',
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxWidth: deviceWidth - 32,
                        ),
                      ),
                      maxLines: 8,
                      validator: _validateNotEmpty,
                    ),                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _submitForm();
        },
        label: const Text(
          'Tạo sự kiện',
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      drawer: DrawerBaseKhoa(),
    );
  }
}