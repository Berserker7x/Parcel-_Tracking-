
import 'package:flutter/cupertino.dart';

class PageModel{
  String _title;
   String _description;
   IconData _icon;
  String _image;
  PageModel(this._title,this._description,this._icon,this._image);
  String get image=>_image;
  String get description=>_description;
  IconData get icon=>_icon;
  String get title=>_title;

}