import 'dart:convert';
/// title : "About Loans"
/// name : "home-loan"
/// slug : "home-loan-questionnaire"
/// description : "This template is used for storing the questionnaire for home loan process"
/// schema : {"fields":[{"type":"SingleChoiceSelector","version":1,"schema":{"name":"typeOFLoan","label":"Type of loan","hidden":false,"readonly":false,"options":[{"key":"new-purchase","value":"New purchase"},{"key":"balance-transfer-top-up","value":"Balance transfer & Top-up"}]}},{"type":"SingleChoiceSelector","version":1,"schema":{"name":"your-work-profile","label":"Your work profile","hidden":false,"readonly":false,"options":[{"key":"salaried","value":"Salaried"},{"key":"id1","value":"Self-employed non-professional"},{"key":"id2","value":"Self-employed professional"},{"key":"id3","value":"Propietary concern"},{"key":"id4","value":"Partnership concern"},{"key":"id5","value":"Limited liability partnership"}]}},{"type":"Section","version":1,"schema":{"name":"Section1","label":"Family income","fields":[{"type":"Numeric","version":1,"schema":{"name":"total-family-income","label":"Total family income"}},{"type":"Label","version":1,"schema":{"name":"Only blood relatives","label":"Only blood relatives"}}]}},{"type":"SingleSelect","version":1,"schema":{"name":"Existing bank where loan exists","label":"Existing bank where loan existse","hidden":"${typeOFLoan !== 'balance-transfer-top-up'}","readonly":false,"options":[{"key":"id1","value":"HDFC"},{"key":"id2","value":"ICICI"},{"key":"id3","value":"SBI"}]}},{"type":"Section","version":1,"schema":{"name":"Section2","label":"What are your current income sources","hidden":false,"readonly":false,"fields":[{"type":"SingleSelect","version":1,"schema":{"name":"Property located state","label":"Property located state","hidden":false,"readonly":false,"options":[{"key":"id1","value":"Haryana"},{"key":"id2","value":"Delhi"},{"key":"id3","value":"UP"}]}},{"type":"SingleSelect","version":1,"schema":{"name":"Property located city","label":"Property located city","hidden":false,"readonly":false,"options":[{"key":"id1","value":"Bhiwani"},{"key":"id2","value":"Faridabad"},{"key":"id3","value":"Gurgaon"}]}}]}}]}

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));
String questionsToJson(Questions data) => json.encode(data.toJson());
class Questions {
  Questions({
      String? title, 
      String? name, 
      String? slug, 
      String? description, 
      Schema? schema,}){
    _title = title;
    _name = name;
    _slug = slug;
    _description = description;
    _schema = schema;
}

  Questions.fromJson(dynamic json) {
    _title = json['title'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _schema = json['schema'] != null ? Schema.fromJson(json['schema']) : null;
  }
  String? _title;
  String? _name;
  String? _slug;
  String? _description;
  Schema? _schema;
Questions copyWith({  String? title,
  String? name,
  String? slug,
  String? description,
  Schema? schema,
}) => Questions(  title: title ?? _title,
  name: name ?? _name,
  slug: slug ?? _slug,
  description: description ?? _description,
  schema: schema ?? _schema,
);
  String? get title => _title;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  Schema? get schema => _schema;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    if (_schema != null) {
      map['schema'] = _schema?.toJson();
    }
    return map;
  }

}

/// fields : [{"type":"SingleChoiceSelector","version":1,"schema":{"name":"typeOFLoan","label":"Type of loan","hidden":false,"readonly":false,"options":[{"key":"new-purchase","value":"New purchase"},{"key":"balance-transfer-top-up","value":"Balance transfer & Top-up"}]}},{"type":"SingleChoiceSelector","version":1,"schema":{"name":"your-work-profile","label":"Your work profile","hidden":false,"readonly":false,"options":[{"key":"salaried","value":"Salaried"},{"key":"id1","value":"Self-employed non-professional"},{"key":"id2","value":"Self-employed professional"},{"key":"id3","value":"Propietary concern"},{"key":"id4","value":"Partnership concern"},{"key":"id5","value":"Limited liability partnership"}]}},{"type":"Section","version":1,"schema":{"name":"Section1","label":"Family income","fields":[{"type":"Numeric","version":1,"schema":{"name":"total-family-income","label":"Total family income"}},{"type":"Label","version":1,"schema":{"name":"Only blood relatives","label":"Only blood relatives"}}]}},{"type":"SingleSelect","version":1,"schema":{"name":"Existing bank where loan exists","label":"Existing bank where loan existse","hidden":"${typeOFLoan !== 'balance-transfer-top-up'}","readonly":false,"options":[{"key":"id1","value":"HDFC"},{"key":"id2","value":"ICICI"},{"key":"id3","value":"SBI"}]}},{"type":"Section","version":1,"schema":{"name":"Section2","label":"What are your current income sources","hidden":false,"readonly":false,"fields":[{"type":"SingleSelect","version":1,"schema":{"name":"Property located state","label":"Property located state","hidden":false,"readonly":false,"options":[{"key":"id1","value":"Haryana"},{"key":"id2","value":"Delhi"},{"key":"id3","value":"UP"}]}},{"type":"SingleSelect","version":1,"schema":{"name":"Property located city","label":"Property located city","hidden":false,"readonly":false,"options":[{"key":"id1","value":"Bhiwani"},{"key":"id2","value":"Faridabad"},{"key":"id3","value":"Gurgaon"}]}}]}}]

Schema schemaFromJson(String str) => Schema.fromJson(json.decode(str));
String schemaToJson(Schema data) => json.encode(data.toJson());
class Schema {
  Schema({
      List<Fields>? fields,}){
    _fields = fields;
}

  Schema.fromJson(dynamic json) {
    if (json['fields'] != null) {
      _fields = [];
      json['fields'].forEach((v) {
        _fields?.add(Fields.fromJson(v));
      });
    }
  }
  List<Fields>? _fields;
Schema copyWith({  List<Fields>? fields,
}) => Schema(  fields: fields ?? _fields,
);
  List<Fields>? get fields => _fields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fields != null) {
      map['fields'] = _fields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type : "SingleChoiceSelector"
/// version : 1
/// schema : {"name":"typeOFLoan","label":"Type of loan","hidden":false,"readonly":false,"options":[{"key":"new-purchase","value":"New purchase"},{"key":"balance-transfer-top-up","value":"Balance transfer & Top-up"}]}

Fields fieldsFromJson(String str) => Fields.fromJson(json.decode(str));
String fieldsToJson(Fields data) => json.encode(data.toJson());
class Fields {
  Fields({
      String? type, 
      num? version,
    FieldsSchema? schema,}){
    _type = type;
    _version = version;
    _schema = schema;
}

  Fields.fromJson(dynamic json) {
    _type = json['type'];
    _version = json['version'];
    _schema = json['schema'] != null ? FieldsSchema.fromJson(json['schema']) : null;
  }
  String? _type;
  num? _version;
  FieldsSchema? _schema;
Fields copyWith({  String? type,
  num? version,
  FieldsSchema? schema,
}) => Fields(  type: type ?? _type,
  version: version ?? _version,
  schema: schema ?? _schema,
);
  String? get type => _type;
  num? get version => _version;
  FieldsSchema? get schema => _schema;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['version'] = _version;
    if (_schema != null) {
      map['schema'] = _schema?.toJson();
    }
    return map;
  }

}

/// name : "typeOFLoan"
/// label : "Type of loan"
/// hidden : false
/// readonly : false
/// options : [{"key":"new-purchase","value":"New purchase"},{"key":"balance-transfer-top-up","value":"Balance transfer & Top-up"}]

FieldsSchema fieldsSchemaFromJson(String str) => FieldsSchema.fromJson(json.decode(str));
String fieldsSchemaToJson(Schema data) => json.encode(data.toJson());
class FieldsSchema {
  FieldsSchema({
      String? name, 
      String? label, 
      bool? hidden,
      bool? readonly,
      List<Options>? options,}){
    _name = name;
    _label = label;
    _readonly = readonly;
    _options = options;
}

  FieldsSchema.fromJson(dynamic json) {
    _name = json['name'];
    _label = json['label'];
    _readonly = json['readonly'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }

  String? _name;
  String? _label;
  bool? _readonly;
  List<Options>? _options;

  FieldsSchema copyWith({  String? name,
  String? label,
  bool? readonly,
  List<Options>? options,
}) => FieldsSchema(  name: name ?? _name,
  label: label ?? _label,
  readonly: readonly ?? _readonly,
  options: options ?? _options,
);

  String? get name => _name;
  String? get label => _label;
  bool? get readonly => _readonly;
  List<Options>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['label'] = _label;
    map['readonly'] = _readonly;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "new-purchase"
/// value : "New purchase"

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));
String optionsToJson(Options data) => json.encode(data.toJson());
class Options {
  Options({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Options.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String? _key;
  String? _value;
Options copyWith({  String? key,
  String? value,
}) => Options(  key: key ?? _key,
  value: value ?? _value,
);
  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }

}