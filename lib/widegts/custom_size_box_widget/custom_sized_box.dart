import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Spacing on num {
  SizedBox get sbh => SizedBox(height: sp);

  SizedBox get sbw => SizedBox(width: sp);
}
