String controllerStub({String controllerName}) => '''
import 'controller.dart';
import 'package:flutter/widgets.dart';

class ${controllerName}Controller extends Controller {
  
  @override
  construct(BuildContext context) {
    
  }

} 
''';
