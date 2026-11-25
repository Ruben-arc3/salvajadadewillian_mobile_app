// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_database.dart';

// ignore_for_file: type=lint
class $CachedProductsTable extends CachedProducts
    with TableInfo<$CachedProductsTable, CachedProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiersJsonMeta = const VerificationMeta(
    'modifiersJson',
  );
  @override
  late final GeneratedColumn<String> modifiersJson = GeneratedColumn<String>(
    'modifiers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    productId,
    name,
    category,
    description,
    price,
    modifiersJson,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('modifiers_json')) {
      context.handle(
        _modifiersJsonMeta,
        modifiersJson.isAcceptableOrUnknown(
          data['modifiers_json']!,
          _modifiersJsonMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  CachedProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProduct(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
      modifiersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modifiers_json'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $CachedProductsTable createAlias(String alias) {
    return $CachedProductsTable(attachedDatabase, alias);
  }
}

class CachedProduct extends DataClass implements Insertable<CachedProduct> {
  final String productId;
  final String name;
  final String category;
  final String description;
  final int price;
  final String modifiersJson;
  final bool active;
  const CachedProduct({
    required this.productId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.modifiersJson,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<int>(price);
    map['modifiers_json'] = Variable<String>(modifiersJson);
    map['active'] = Variable<bool>(active);
    return map;
  }

  CachedProductsCompanion toCompanion(bool nullToAbsent) {
    return CachedProductsCompanion(
      productId: Value(productId),
      name: Value(name),
      category: Value(category),
      description: Value(description),
      price: Value(price),
      modifiersJson: Value(modifiersJson),
      active: Value(active),
    );
  }

  factory CachedProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProduct(
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<int>(json['price']),
      modifiersJson: serializer.fromJson<String>(json['modifiersJson']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<int>(price),
      'modifiersJson': serializer.toJson<String>(modifiersJson),
      'active': serializer.toJson<bool>(active),
    };
  }

  CachedProduct copyWith({
    String? productId,
    String? name,
    String? category,
    String? description,
    int? price,
    String? modifiersJson,
    bool? active,
  }) => CachedProduct(
    productId: productId ?? this.productId,
    name: name ?? this.name,
    category: category ?? this.category,
    description: description ?? this.description,
    price: price ?? this.price,
    modifiersJson: modifiersJson ?? this.modifiersJson,
    active: active ?? this.active,
  );
  CachedProduct copyWithCompanion(CachedProductsCompanion data) {
    return CachedProduct(
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      modifiersJson: data.modifiersJson.present
          ? data.modifiersJson.value
          : this.modifiersJson,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProduct(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('modifiersJson: $modifiersJson, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    productId,
    name,
    category,
    description,
    price,
    modifiersJson,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProduct &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.category == this.category &&
          other.description == this.description &&
          other.price == this.price &&
          other.modifiersJson == this.modifiersJson &&
          other.active == this.active);
}

class CachedProductsCompanion extends UpdateCompanion<CachedProduct> {
  final Value<String> productId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> description;
  final Value<int> price;
  final Value<String> modifiersJson;
  final Value<bool> active;
  final Value<int> rowid;
  const CachedProductsCompanion({
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.modifiersJson = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProductsCompanion.insert({
    required String productId,
    required String name,
    required String category,
    this.description = const Value.absent(),
    required int price,
    this.modifiersJson = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       name = Value(name),
       category = Value(category),
       price = Value(price);
  static Insertable<CachedProduct> custom({
    Expression<String>? productId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? price,
    Expression<String>? modifiersJson,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (modifiersJson != null) 'modifiers_json': modifiersJson,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProductsCompanion copyWith({
    Value<String>? productId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? description,
    Value<int>? price,
    Value<String>? modifiersJson,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return CachedProductsCompanion(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      modifiersJson: modifiersJson ?? this.modifiersJson,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (modifiersJson.present) {
      map['modifiers_json'] = Variable<String>(modifiersJson.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProductsCompanion(')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('modifiersJson: $modifiersJson, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedIngredientsTable extends CachedIngredients
    with TableInfo<$CachedIngredientsTable, CachedIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minimumMeta = const VerificationMeta(
    'minimum',
  );
  @override
  late final GeneratedColumn<double> minimum = GeneratedColumn<double>(
    'minimum',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    ingredientId,
    name,
    unit,
    quantity,
    minimum,
    unitCost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('minimum')) {
      context.handle(
        _minimumMeta,
        minimum.isAcceptableOrUnknown(data['minimum']!, _minimumMeta),
      );
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ingredientId};
  @override
  CachedIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedIngredient(
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      minimum: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
    );
  }

  @override
  $CachedIngredientsTable createAlias(String alias) {
    return $CachedIngredientsTable(attachedDatabase, alias);
  }
}

class CachedIngredient extends DataClass
    implements Insertable<CachedIngredient> {
  final String ingredientId;
  final String name;
  final String unit;
  final double quantity;
  final double minimum;
  final double unitCost;
  const CachedIngredient({
    required this.ingredientId,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.minimum,
    required this.unitCost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ingredient_id'] = Variable<String>(ingredientId);
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    map['quantity'] = Variable<double>(quantity);
    map['minimum'] = Variable<double>(minimum);
    map['unit_cost'] = Variable<double>(unitCost);
    return map;
  }

  CachedIngredientsCompanion toCompanion(bool nullToAbsent) {
    return CachedIngredientsCompanion(
      ingredientId: Value(ingredientId),
      name: Value(name),
      unit: Value(unit),
      quantity: Value(quantity),
      minimum: Value(minimum),
      unitCost: Value(unitCost),
    );
  }

  factory CachedIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedIngredient(
      ingredientId: serializer.fromJson<String>(json['ingredientId']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
      quantity: serializer.fromJson<double>(json['quantity']),
      minimum: serializer.fromJson<double>(json['minimum']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ingredientId': serializer.toJson<String>(ingredientId),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
      'quantity': serializer.toJson<double>(quantity),
      'minimum': serializer.toJson<double>(minimum),
      'unitCost': serializer.toJson<double>(unitCost),
    };
  }

  CachedIngredient copyWith({
    String? ingredientId,
    String? name,
    String? unit,
    double? quantity,
    double? minimum,
    double? unitCost,
  }) => CachedIngredient(
    ingredientId: ingredientId ?? this.ingredientId,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    quantity: quantity ?? this.quantity,
    minimum: minimum ?? this.minimum,
    unitCost: unitCost ?? this.unitCost,
  );
  CachedIngredient copyWithCompanion(CachedIngredientsCompanion data) {
    return CachedIngredient(
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      minimum: data.minimum.present ? data.minimum.value : this.minimum,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedIngredient(')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('minimum: $minimum, ')
          ..write('unitCost: $unitCost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(ingredientId, name, unit, quantity, minimum, unitCost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedIngredient &&
          other.ingredientId == this.ingredientId &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.quantity == this.quantity &&
          other.minimum == this.minimum &&
          other.unitCost == this.unitCost);
}

class CachedIngredientsCompanion extends UpdateCompanion<CachedIngredient> {
  final Value<String> ingredientId;
  final Value<String> name;
  final Value<String> unit;
  final Value<double> quantity;
  final Value<double> minimum;
  final Value<double> unitCost;
  final Value<int> rowid;
  const CachedIngredientsCompanion({
    this.ingredientId = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.quantity = const Value.absent(),
    this.minimum = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedIngredientsCompanion.insert({
    required String ingredientId,
    required String name,
    required String unit,
    this.quantity = const Value.absent(),
    this.minimum = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ingredientId = Value(ingredientId),
       name = Value(name),
       unit = Value(unit);
  static Insertable<CachedIngredient> custom({
    Expression<String>? ingredientId,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? quantity,
    Expression<double>? minimum,
    Expression<double>? unitCost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (quantity != null) 'quantity': quantity,
      if (minimum != null) 'minimum': minimum,
      if (unitCost != null) 'unit_cost': unitCost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedIngredientsCompanion copyWith({
    Value<String>? ingredientId,
    Value<String>? name,
    Value<String>? unit,
    Value<double>? quantity,
    Value<double>? minimum,
    Value<double>? unitCost,
    Value<int>? rowid,
  }) {
    return CachedIngredientsCompanion(
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      minimum: minimum ?? this.minimum,
      unitCost: unitCost ?? this.unitCost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (minimum.present) {
      map['minimum'] = Variable<double>(minimum.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedIngredientsCompanion(')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('minimum: $minimum, ')
          ..write('unitCost: $unitCost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductRecipesTable extends ProductRecipes
    with TableInfo<$ProductRecipesTable, ProductRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<String> ingredientId = GeneratedColumn<String>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMeta = const VerificationMeta(
    'unitCost',
  );
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
    'unit_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    productId,
    ingredientId,
    quantity,
    unitCost,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(
        _unitCostMeta,
        unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta),
      );
    } else if (isInserting) {
      context.missing(_unitCostMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, ingredientId};
  @override
  ProductRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRecipe(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_cost'],
      )!,
    );
  }

  @override
  $ProductRecipesTable createAlias(String alias) {
    return $ProductRecipesTable(attachedDatabase, alias);
  }
}

class ProductRecipe extends DataClass implements Insertable<ProductRecipe> {
  final String productId;
  final String ingredientId;
  final double quantity;
  final double unitCost;
  const ProductRecipe({
    required this.productId,
    required this.ingredientId,
    required this.quantity,
    required this.unitCost,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['ingredient_id'] = Variable<String>(ingredientId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_cost'] = Variable<double>(unitCost);
    return map;
  }

  ProductRecipesCompanion toCompanion(bool nullToAbsent) {
    return ProductRecipesCompanion(
      productId: Value(productId),
      ingredientId: Value(ingredientId),
      quantity: Value(quantity),
      unitCost: Value(unitCost),
    );
  }

  factory ProductRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRecipe(
      productId: serializer.fromJson<String>(json['productId']),
      ingredientId: serializer.fromJson<String>(json['ingredientId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<String>(productId),
      'ingredientId': serializer.toJson<String>(ingredientId),
      'quantity': serializer.toJson<double>(quantity),
      'unitCost': serializer.toJson<double>(unitCost),
    };
  }

  ProductRecipe copyWith({
    String? productId,
    String? ingredientId,
    double? quantity,
    double? unitCost,
  }) => ProductRecipe(
    productId: productId ?? this.productId,
    ingredientId: ingredientId ?? this.ingredientId,
    quantity: quantity ?? this.quantity,
    unitCost: unitCost ?? this.unitCost,
  );
  ProductRecipe copyWithCompanion(ProductRecipesCompanion data) {
    return ProductRecipe(
      productId: data.productId.present ? data.productId.value : this.productId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRecipe(')
          ..write('productId: $productId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, ingredientId, quantity, unitCost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRecipe &&
          other.productId == this.productId &&
          other.ingredientId == this.ingredientId &&
          other.quantity == this.quantity &&
          other.unitCost == this.unitCost);
}

class ProductRecipesCompanion extends UpdateCompanion<ProductRecipe> {
  final Value<String> productId;
  final Value<String> ingredientId;
  final Value<double> quantity;
  final Value<double> unitCost;
  final Value<int> rowid;
  const ProductRecipesCompanion({
    this.productId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductRecipesCompanion.insert({
    required String productId,
    required String ingredientId,
    required double quantity,
    required double unitCost,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       ingredientId = Value(ingredientId),
       quantity = Value(quantity),
       unitCost = Value(unitCost);
  static Insertable<ProductRecipe> custom({
    Expression<String>? productId,
    Expression<String>? ingredientId,
    Expression<double>? quantity,
    Expression<double>? unitCost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (quantity != null) 'quantity': quantity,
      if (unitCost != null) 'unit_cost': unitCost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductRecipesCompanion copyWith({
    Value<String>? productId,
    Value<String>? ingredientId,
    Value<double>? quantity,
    Value<double>? unitCost,
    Value<int>? rowid,
  }) {
    return ProductRecipesCompanion(
      productId: productId ?? this.productId,
      ingredientId: ingredientId ?? this.ingredientId,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.unitCost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductRecipesCompanion(')
          ..write('productId: $productId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCost: $unitCost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalShiftsTable extends LocalShifts
    with TableInfo<$LocalShiftsTable, LocalShift> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<String> shiftId = GeneratedColumn<String>(
    'shift_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingCashMeta = const VerificationMeta(
    'openingCash',
  );
  @override
  late final GeneratedColumn<int> openingCash = GeneratedColumn<int>(
    'opening_cash',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ABIERTO'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    shiftId,
    userId,
    openingCash,
    openedAt,
    state,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_shifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalShift> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
        _openingCashMeta,
        openingCash.isAcceptableOrUnknown(
          data['opening_cash']!,
          _openingCashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingCashMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shiftId};
  @override
  LocalShift map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalShift(
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      openingCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_cash'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
    );
  }

  @override
  $LocalShiftsTable createAlias(String alias) {
    return $LocalShiftsTable(attachedDatabase, alias);
  }
}

class LocalShift extends DataClass implements Insertable<LocalShift> {
  final String shiftId;
  final String userId;
  final int openingCash;
  final DateTime openedAt;
  final String state;
  const LocalShift({
    required this.shiftId,
    required this.userId,
    required this.openingCash,
    required this.openedAt,
    required this.state,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shift_id'] = Variable<String>(shiftId);
    map['user_id'] = Variable<String>(userId);
    map['opening_cash'] = Variable<int>(openingCash);
    map['opened_at'] = Variable<DateTime>(openedAt);
    map['state'] = Variable<String>(state);
    return map;
  }

  LocalShiftsCompanion toCompanion(bool nullToAbsent) {
    return LocalShiftsCompanion(
      shiftId: Value(shiftId),
      userId: Value(userId),
      openingCash: Value(openingCash),
      openedAt: Value(openedAt),
      state: Value(state),
    );
  }

  factory LocalShift.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalShift(
      shiftId: serializer.fromJson<String>(json['shiftId']),
      userId: serializer.fromJson<String>(json['userId']),
      openingCash: serializer.fromJson<int>(json['openingCash']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      state: serializer.fromJson<String>(json['state']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shiftId': serializer.toJson<String>(shiftId),
      'userId': serializer.toJson<String>(userId),
      'openingCash': serializer.toJson<int>(openingCash),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'state': serializer.toJson<String>(state),
    };
  }

  LocalShift copyWith({
    String? shiftId,
    String? userId,
    int? openingCash,
    DateTime? openedAt,
    String? state,
  }) => LocalShift(
    shiftId: shiftId ?? this.shiftId,
    userId: userId ?? this.userId,
    openingCash: openingCash ?? this.openingCash,
    openedAt: openedAt ?? this.openedAt,
    state: state ?? this.state,
  );
  LocalShift copyWithCompanion(LocalShiftsCompanion data) {
    return LocalShift(
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      openingCash: data.openingCash.present
          ? data.openingCash.value
          : this.openingCash,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      state: data.state.present ? data.state.value : this.state,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalShift(')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('openingCash: $openingCash, ')
          ..write('openedAt: $openedAt, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shiftId, userId, openingCash, openedAt, state);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalShift &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.openingCash == this.openingCash &&
          other.openedAt == this.openedAt &&
          other.state == this.state);
}

class LocalShiftsCompanion extends UpdateCompanion<LocalShift> {
  final Value<String> shiftId;
  final Value<String> userId;
  final Value<int> openingCash;
  final Value<DateTime> openedAt;
  final Value<String> state;
  final Value<int> rowid;
  const LocalShiftsCompanion({
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.state = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalShiftsCompanion.insert({
    required String shiftId,
    required String userId,
    required int openingCash,
    required DateTime openedAt,
    this.state = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : shiftId = Value(shiftId),
       userId = Value(userId),
       openingCash = Value(openingCash),
       openedAt = Value(openedAt);
  static Insertable<LocalShift> custom({
    Expression<String>? shiftId,
    Expression<String>? userId,
    Expression<int>? openingCash,
    Expression<DateTime>? openedAt,
    Expression<String>? state,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (openingCash != null) 'opening_cash': openingCash,
      if (openedAt != null) 'opened_at': openedAt,
      if (state != null) 'state': state,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalShiftsCompanion copyWith({
    Value<String>? shiftId,
    Value<String>? userId,
    Value<int>? openingCash,
    Value<DateTime>? openedAt,
    Value<String>? state,
    Value<int>? rowid,
  }) {
    return LocalShiftsCompanion(
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      openingCash: openingCash ?? this.openingCash,
      openedAt: openedAt ?? this.openedAt,
      state: state ?? this.state,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shiftId.present) {
      map['shift_id'] = Variable<String>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<int>(openingCash.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalShiftsCompanion(')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('openingCash: $openingCash, ')
          ..write('openedAt: $openedAt, ')
          ..write('state: $state, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverResultJsonMeta = const VerificationMeta(
    'serverResultJson',
  );
  @override
  late final GeneratedColumn<String> serverResultJson = GeneratedColumn<String>(
    'server_result_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientUuid,
    eventType,
    payloadJson,
    createdAt,
    syncedAt,
    lastError,
    serverResultJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('server_result_json')) {
      context.handle(
        _serverResultJsonMeta,
        serverResultJson.isAcceptableOrUnknown(
          data['server_result_json']!,
          _serverResultJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientUuid};
  @override
  SyncOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxData(
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      serverResultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_result_json'],
      ),
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxData extends DataClass implements Insertable<SyncOutboxData> {
  final String clientUuid;
  final String eventType;
  final String payloadJson;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final String? lastError;
  final String? serverResultJson;
  const SyncOutboxData({
    required this.clientUuid,
    required this.eventType,
    required this.payloadJson,
    required this.createdAt,
    this.syncedAt,
    this.lastError,
    this.serverResultJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_uuid'] = Variable<String>(clientUuid);
    map['event_type'] = Variable<String>(eventType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || serverResultJson != null) {
      map['server_result_json'] = Variable<String>(serverResultJson);
    }
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      clientUuid: Value(clientUuid),
      eventType: Value(eventType),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      serverResultJson: serverResultJson == null && nullToAbsent
          ? const Value.absent()
          : Value(serverResultJson),
    );
  }

  factory SyncOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxData(
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      eventType: serializer.fromJson<String>(json['eventType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      serverResultJson: serializer.fromJson<String?>(json['serverResultJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientUuid': serializer.toJson<String>(clientUuid),
      'eventType': serializer.toJson<String>(eventType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'lastError': serializer.toJson<String?>(lastError),
      'serverResultJson': serializer.toJson<String?>(serverResultJson),
    };
  }

  SyncOutboxData copyWith({
    String? clientUuid,
    String? eventType,
    String? payloadJson,
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    Value<String?> serverResultJson = const Value.absent(),
  }) => SyncOutboxData(
    clientUuid: clientUuid ?? this.clientUuid,
    eventType: eventType ?? this.eventType,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    lastError: lastError.present ? lastError.value : this.lastError,
    serverResultJson: serverResultJson.present
        ? serverResultJson.value
        : this.serverResultJson,
  );
  SyncOutboxData copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxData(
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      serverResultJson: data.serverResultJson.present
          ? data.serverResultJson.value
          : this.serverResultJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxData(')
          ..write('clientUuid: $clientUuid, ')
          ..write('eventType: $eventType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('lastError: $lastError, ')
          ..write('serverResultJson: $serverResultJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientUuid,
    eventType,
    payloadJson,
    createdAt,
    syncedAt,
    lastError,
    serverResultJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxData &&
          other.clientUuid == this.clientUuid &&
          other.eventType == this.eventType &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt &&
          other.lastError == this.lastError &&
          other.serverResultJson == this.serverResultJson);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxData> {
  final Value<String> clientUuid;
  final Value<String> eventType;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  final Value<String?> lastError;
  final Value<String?> serverResultJson;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.clientUuid = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.serverResultJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String clientUuid,
    required String eventType,
    required String payloadJson,
    required DateTime createdAt,
    this.syncedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.serverResultJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       eventType = Value(eventType),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<SyncOutboxData> custom({
    Expression<String>? clientUuid,
    Expression<String>? eventType,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
    Expression<String>? lastError,
    Expression<String>? serverResultJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (eventType != null) 'event_type': eventType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (lastError != null) 'last_error': lastError,
      if (serverResultJson != null) 'server_result_json': serverResultJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? clientUuid,
    Value<String>? eventType,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
    Value<String?>? lastError,
    Value<String?>? serverResultJson,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      clientUuid: clientUuid ?? this.clientUuid,
      eventType: eventType ?? this.eventType,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      lastError: lastError ?? this.lastError,
      serverResultJson: serverResultJson ?? this.serverResultJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (serverResultJson.present) {
      map['server_result_json'] = Variable<String>(serverResultJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('clientUuid: $clientUuid, ')
          ..write('eventType: $eventType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('lastError: $lastError, ')
          ..write('serverResultJson: $serverResultJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSettingsTable extends LocalSettings
    with TableInfo<$LocalSettingsTable, LocalSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  LocalSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $LocalSettingsTable createAlias(String alias) {
    return $LocalSettingsTable(attachedDatabase, alias);
  }
}

class LocalSetting extends DataClass implements Insertable<LocalSetting> {
  final String key;
  final String value;
  const LocalSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  LocalSettingsCompanion toCompanion(bool nullToAbsent) {
    return LocalSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory LocalSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  LocalSetting copyWith({String? key, String? value}) =>
      LocalSetting(key: key ?? this.key, value: value ?? this.value);
  LocalSetting copyWithCompanion(LocalSettingsCompanion data) {
    return LocalSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class LocalSettingsCompanion extends UpdateCompanion<LocalSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const LocalSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<LocalSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return LocalSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedOrdersTable extends CachedOrders
    with TableInfo<$CachedOrdersTable, CachedOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productsJsonMeta = const VerificationMeta(
    'productsJson',
  );
  @override
  late final GeneratedColumn<String> productsJson = GeneratedColumn<String>(
    'products_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('WHATSAPP'),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _recipeSnapshotJsonMeta =
      const VerificationMeta('recipeSnapshotJson');
  @override
  late final GeneratedColumn<String> recipeSnapshotJson =
      GeneratedColumn<String>(
        'recipe_snapshot_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _ingredientsConsumedMeta =
      const VerificationMeta('ingredientsConsumed');
  @override
  late final GeneratedColumn<bool> ingredientsConsumed = GeneratedColumn<bool>(
    'ingredients_consumed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ingredients_consumed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    orderId,
    customerName,
    phone,
    status,
    productsJson,
    total,
    paymentMethod,
    source,
    address,
    recipeSnapshotJson,
    ingredientsConsumed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('products_json')) {
      context.handle(
        _productsJsonMeta,
        productsJson.isAcceptableOrUnknown(
          data['products_json']!,
          _productsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productsJsonMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('recipe_snapshot_json')) {
      context.handle(
        _recipeSnapshotJsonMeta,
        recipeSnapshotJson.isAcceptableOrUnknown(
          data['recipe_snapshot_json']!,
          _recipeSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('ingredients_consumed')) {
      context.handle(
        _ingredientsConsumedMeta,
        ingredientsConsumed.isAcceptableOrUnknown(
          data['ingredients_consumed']!,
          _ingredientsConsumedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId};
  @override
  CachedOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedOrder(
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      productsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}products_json'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      recipeSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_snapshot_json'],
      )!,
      ingredientsConsumed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ingredients_consumed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedOrdersTable createAlias(String alias) {
    return $CachedOrdersTable(attachedDatabase, alias);
  }
}

class CachedOrder extends DataClass implements Insertable<CachedOrder> {
  final int orderId;
  final String customerName;
  final String phone;
  final String status;
  final String productsJson;
  final int total;
  final String paymentMethod;
  final String source;
  final String address;
  final String recipeSnapshotJson;
  final bool ingredientsConsumed;
  final DateTime createdAt;
  const CachedOrder({
    required this.orderId,
    required this.customerName,
    required this.phone,
    required this.status,
    required this.productsJson,
    required this.total,
    required this.paymentMethod,
    required this.source,
    required this.address,
    required this.recipeSnapshotJson,
    required this.ingredientsConsumed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['customer_name'] = Variable<String>(customerName);
    map['phone'] = Variable<String>(phone);
    map['status'] = Variable<String>(status);
    map['products_json'] = Variable<String>(productsJson);
    map['total'] = Variable<int>(total);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['source'] = Variable<String>(source);
    map['address'] = Variable<String>(address);
    map['recipe_snapshot_json'] = Variable<String>(recipeSnapshotJson);
    map['ingredients_consumed'] = Variable<bool>(ingredientsConsumed);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CachedOrdersCompanion toCompanion(bool nullToAbsent) {
    return CachedOrdersCompanion(
      orderId: Value(orderId),
      customerName: Value(customerName),
      phone: Value(phone),
      status: Value(status),
      productsJson: Value(productsJson),
      total: Value(total),
      paymentMethod: Value(paymentMethod),
      source: Value(source),
      address: Value(address),
      recipeSnapshotJson: Value(recipeSnapshotJson),
      ingredientsConsumed: Value(ingredientsConsumed),
      createdAt: Value(createdAt),
    );
  }

  factory CachedOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedOrder(
      orderId: serializer.fromJson<int>(json['orderId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phone: serializer.fromJson<String>(json['phone']),
      status: serializer.fromJson<String>(json['status']),
      productsJson: serializer.fromJson<String>(json['productsJson']),
      total: serializer.fromJson<int>(json['total']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      source: serializer.fromJson<String>(json['source']),
      address: serializer.fromJson<String>(json['address']),
      recipeSnapshotJson: serializer.fromJson<String>(
        json['recipeSnapshotJson'],
      ),
      ingredientsConsumed: serializer.fromJson<bool>(
        json['ingredientsConsumed'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'customerName': serializer.toJson<String>(customerName),
      'phone': serializer.toJson<String>(phone),
      'status': serializer.toJson<String>(status),
      'productsJson': serializer.toJson<String>(productsJson),
      'total': serializer.toJson<int>(total),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'source': serializer.toJson<String>(source),
      'address': serializer.toJson<String>(address),
      'recipeSnapshotJson': serializer.toJson<String>(recipeSnapshotJson),
      'ingredientsConsumed': serializer.toJson<bool>(ingredientsConsumed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CachedOrder copyWith({
    int? orderId,
    String? customerName,
    String? phone,
    String? status,
    String? productsJson,
    int? total,
    String? paymentMethod,
    String? source,
    String? address,
    String? recipeSnapshotJson,
    bool? ingredientsConsumed,
    DateTime? createdAt,
  }) => CachedOrder(
    orderId: orderId ?? this.orderId,
    customerName: customerName ?? this.customerName,
    phone: phone ?? this.phone,
    status: status ?? this.status,
    productsJson: productsJson ?? this.productsJson,
    total: total ?? this.total,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    source: source ?? this.source,
    address: address ?? this.address,
    recipeSnapshotJson: recipeSnapshotJson ?? this.recipeSnapshotJson,
    ingredientsConsumed: ingredientsConsumed ?? this.ingredientsConsumed,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedOrder copyWithCompanion(CachedOrdersCompanion data) {
    return CachedOrder(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      status: data.status.present ? data.status.value : this.status,
      productsJson: data.productsJson.present
          ? data.productsJson.value
          : this.productsJson,
      total: data.total.present ? data.total.value : this.total,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      source: data.source.present ? data.source.value : this.source,
      address: data.address.present ? data.address.value : this.address,
      recipeSnapshotJson: data.recipeSnapshotJson.present
          ? data.recipeSnapshotJson.value
          : this.recipeSnapshotJson,
      ingredientsConsumed: data.ingredientsConsumed.present
          ? data.ingredientsConsumed.value
          : this.ingredientsConsumed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrder(')
          ..write('orderId: $orderId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('productsJson: $productsJson, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('source: $source, ')
          ..write('address: $address, ')
          ..write('recipeSnapshotJson: $recipeSnapshotJson, ')
          ..write('ingredientsConsumed: $ingredientsConsumed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    orderId,
    customerName,
    phone,
    status,
    productsJson,
    total,
    paymentMethod,
    source,
    address,
    recipeSnapshotJson,
    ingredientsConsumed,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedOrder &&
          other.orderId == this.orderId &&
          other.customerName == this.customerName &&
          other.phone == this.phone &&
          other.status == this.status &&
          other.productsJson == this.productsJson &&
          other.total == this.total &&
          other.paymentMethod == this.paymentMethod &&
          other.source == this.source &&
          other.address == this.address &&
          other.recipeSnapshotJson == this.recipeSnapshotJson &&
          other.ingredientsConsumed == this.ingredientsConsumed &&
          other.createdAt == this.createdAt);
}

class CachedOrdersCompanion extends UpdateCompanion<CachedOrder> {
  final Value<int> orderId;
  final Value<String> customerName;
  final Value<String> phone;
  final Value<String> status;
  final Value<String> productsJson;
  final Value<int> total;
  final Value<String> paymentMethod;
  final Value<String> source;
  final Value<String> address;
  final Value<String> recipeSnapshotJson;
  final Value<bool> ingredientsConsumed;
  final Value<DateTime> createdAt;
  const CachedOrdersCompanion({
    this.orderId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.productsJson = const Value.absent(),
    this.total = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.source = const Value.absent(),
    this.address = const Value.absent(),
    this.recipeSnapshotJson = const Value.absent(),
    this.ingredientsConsumed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CachedOrdersCompanion.insert({
    this.orderId = const Value.absent(),
    required String customerName,
    required String phone,
    required String status,
    required String productsJson,
    required int total,
    required String paymentMethod,
    this.source = const Value.absent(),
    this.address = const Value.absent(),
    this.recipeSnapshotJson = const Value.absent(),
    this.ingredientsConsumed = const Value.absent(),
    required DateTime createdAt,
  }) : customerName = Value(customerName),
       phone = Value(phone),
       status = Value(status),
       productsJson = Value(productsJson),
       total = Value(total),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<CachedOrder> custom({
    Expression<int>? orderId,
    Expression<String>? customerName,
    Expression<String>? phone,
    Expression<String>? status,
    Expression<String>? productsJson,
    Expression<int>? total,
    Expression<String>? paymentMethod,
    Expression<String>? source,
    Expression<String>? address,
    Expression<String>? recipeSnapshotJson,
    Expression<bool>? ingredientsConsumed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (customerName != null) 'customer_name': customerName,
      if (phone != null) 'phone': phone,
      if (status != null) 'status': status,
      if (productsJson != null) 'products_json': productsJson,
      if (total != null) 'total': total,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (source != null) 'source': source,
      if (address != null) 'address': address,
      if (recipeSnapshotJson != null)
        'recipe_snapshot_json': recipeSnapshotJson,
      if (ingredientsConsumed != null)
        'ingredients_consumed': ingredientsConsumed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CachedOrdersCompanion copyWith({
    Value<int>? orderId,
    Value<String>? customerName,
    Value<String>? phone,
    Value<String>? status,
    Value<String>? productsJson,
    Value<int>? total,
    Value<String>? paymentMethod,
    Value<String>? source,
    Value<String>? address,
    Value<String>? recipeSnapshotJson,
    Value<bool>? ingredientsConsumed,
    Value<DateTime>? createdAt,
  }) {
    return CachedOrdersCompanion(
      orderId: orderId ?? this.orderId,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      productsJson: productsJson ?? this.productsJson,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      source: source ?? this.source,
      address: address ?? this.address,
      recipeSnapshotJson: recipeSnapshotJson ?? this.recipeSnapshotJson,
      ingredientsConsumed: ingredientsConsumed ?? this.ingredientsConsumed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (productsJson.present) {
      map['products_json'] = Variable<String>(productsJson.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (recipeSnapshotJson.present) {
      map['recipe_snapshot_json'] = Variable<String>(recipeSnapshotJson.value);
    }
    if (ingredientsConsumed.present) {
      map['ingredients_consumed'] = Variable<bool>(ingredientsConsumed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedOrdersCompanion(')
          ..write('orderId: $orderId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('productsJson: $productsJson, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('source: $source, ')
          ..write('address: $address, ')
          ..write('recipeSnapshotJson: $recipeSnapshotJson, ')
          ..write('ingredientsConsumed: $ingredientsConsumed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CachedSalesTable extends CachedSales
    with TableInfo<$CachedSalesTable, CachedSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedSalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ENTREGADO'),
  );
  static const VerificationMeta _productsJsonMeta = const VerificationMeta(
    'productsJson',
  );
  @override
  late final GeneratedColumn<String> productsJson = GeneratedColumn<String>(
    'products_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modalityMeta = const VerificationMeta(
    'modality',
  );
  @override
  late final GeneratedColumn<String> modality = GeneratedColumn<String>(
    'modality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('LOCAL'),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    sourceId,
    customerName,
    phone,
    status,
    productsJson,
    total,
    paymentMethod,
    modality,
    address,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedSale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('products_json')) {
      context.handle(
        _productsJsonMeta,
        productsJson.isAcceptableOrUnknown(
          data['products_json']!,
          _productsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productsJsonMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('modality')) {
      context.handle(
        _modalityMeta,
        modality.isAcceptableOrUnknown(data['modality']!, _modalityMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sourceId};
  @override
  CachedSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedSale(
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      productsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}products_json'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      modality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modality'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedSalesTable createAlias(String alias) {
    return $CachedSalesTable(attachedDatabase, alias);
  }
}

class CachedSale extends DataClass implements Insertable<CachedSale> {
  final String sourceId;
  final String customerName;
  final String phone;
  final String status;
  final String productsJson;
  final int total;
  final String paymentMethod;
  final String modality;
  final String address;
  final DateTime createdAt;
  const CachedSale({
    required this.sourceId,
    required this.customerName,
    required this.phone,
    required this.status,
    required this.productsJson,
    required this.total,
    required this.paymentMethod,
    required this.modality,
    required this.address,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['source_id'] = Variable<String>(sourceId);
    map['customer_name'] = Variable<String>(customerName);
    map['phone'] = Variable<String>(phone);
    map['status'] = Variable<String>(status);
    map['products_json'] = Variable<String>(productsJson);
    map['total'] = Variable<int>(total);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['modality'] = Variable<String>(modality);
    map['address'] = Variable<String>(address);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CachedSalesCompanion toCompanion(bool nullToAbsent) {
    return CachedSalesCompanion(
      sourceId: Value(sourceId),
      customerName: Value(customerName),
      phone: Value(phone),
      status: Value(status),
      productsJson: Value(productsJson),
      total: Value(total),
      paymentMethod: Value(paymentMethod),
      modality: Value(modality),
      address: Value(address),
      createdAt: Value(createdAt),
    );
  }

  factory CachedSale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedSale(
      sourceId: serializer.fromJson<String>(json['sourceId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phone: serializer.fromJson<String>(json['phone']),
      status: serializer.fromJson<String>(json['status']),
      productsJson: serializer.fromJson<String>(json['productsJson']),
      total: serializer.fromJson<int>(json['total']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      modality: serializer.fromJson<String>(json['modality']),
      address: serializer.fromJson<String>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sourceId': serializer.toJson<String>(sourceId),
      'customerName': serializer.toJson<String>(customerName),
      'phone': serializer.toJson<String>(phone),
      'status': serializer.toJson<String>(status),
      'productsJson': serializer.toJson<String>(productsJson),
      'total': serializer.toJson<int>(total),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'modality': serializer.toJson<String>(modality),
      'address': serializer.toJson<String>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CachedSale copyWith({
    String? sourceId,
    String? customerName,
    String? phone,
    String? status,
    String? productsJson,
    int? total,
    String? paymentMethod,
    String? modality,
    String? address,
    DateTime? createdAt,
  }) => CachedSale(
    sourceId: sourceId ?? this.sourceId,
    customerName: customerName ?? this.customerName,
    phone: phone ?? this.phone,
    status: status ?? this.status,
    productsJson: productsJson ?? this.productsJson,
    total: total ?? this.total,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    modality: modality ?? this.modality,
    address: address ?? this.address,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedSale copyWithCompanion(CachedSalesCompanion data) {
    return CachedSale(
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      status: data.status.present ? data.status.value : this.status,
      productsJson: data.productsJson.present
          ? data.productsJson.value
          : this.productsJson,
      total: data.total.present ? data.total.value : this.total,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      modality: data.modality.present ? data.modality.value : this.modality,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedSale(')
          ..write('sourceId: $sourceId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('productsJson: $productsJson, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('modality: $modality, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sourceId,
    customerName,
    phone,
    status,
    productsJson,
    total,
    paymentMethod,
    modality,
    address,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedSale &&
          other.sourceId == this.sourceId &&
          other.customerName == this.customerName &&
          other.phone == this.phone &&
          other.status == this.status &&
          other.productsJson == this.productsJson &&
          other.total == this.total &&
          other.paymentMethod == this.paymentMethod &&
          other.modality == this.modality &&
          other.address == this.address &&
          other.createdAt == this.createdAt);
}

class CachedSalesCompanion extends UpdateCompanion<CachedSale> {
  final Value<String> sourceId;
  final Value<String> customerName;
  final Value<String> phone;
  final Value<String> status;
  final Value<String> productsJson;
  final Value<int> total;
  final Value<String> paymentMethod;
  final Value<String> modality;
  final Value<String> address;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CachedSalesCompanion({
    this.sourceId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.productsJson = const Value.absent(),
    this.total = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.modality = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedSalesCompanion.insert({
    required String sourceId,
    required String customerName,
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    required String productsJson,
    required int total,
    required String paymentMethod,
    this.modality = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : sourceId = Value(sourceId),
       customerName = Value(customerName),
       productsJson = Value(productsJson),
       total = Value(total),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt);
  static Insertable<CachedSale> custom({
    Expression<String>? sourceId,
    Expression<String>? customerName,
    Expression<String>? phone,
    Expression<String>? status,
    Expression<String>? productsJson,
    Expression<int>? total,
    Expression<String>? paymentMethod,
    Expression<String>? modality,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sourceId != null) 'source_id': sourceId,
      if (customerName != null) 'customer_name': customerName,
      if (phone != null) 'phone': phone,
      if (status != null) 'status': status,
      if (productsJson != null) 'products_json': productsJson,
      if (total != null) 'total': total,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (modality != null) 'modality': modality,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedSalesCompanion copyWith({
    Value<String>? sourceId,
    Value<String>? customerName,
    Value<String>? phone,
    Value<String>? status,
    Value<String>? productsJson,
    Value<int>? total,
    Value<String>? paymentMethod,
    Value<String>? modality,
    Value<String>? address,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedSalesCompanion(
      sourceId: sourceId ?? this.sourceId,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      productsJson: productsJson ?? this.productsJson,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      modality: modality ?? this.modality,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (productsJson.present) {
      map['products_json'] = Variable<String>(productsJson.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (modality.present) {
      map['modality'] = Variable<String>(modality.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedSalesCompanion(')
          ..write('sourceId: $sourceId, ')
          ..write('customerName: $customerName, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('productsJson: $productsJson, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('modality: $modality, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PosDatabase extends GeneratedDatabase {
  _$PosDatabase(QueryExecutor e) : super(e);
  $PosDatabaseManager get managers => $PosDatabaseManager(this);
  late final $CachedProductsTable cachedProducts = $CachedProductsTable(this);
  late final $CachedIngredientsTable cachedIngredients =
      $CachedIngredientsTable(this);
  late final $ProductRecipesTable productRecipes = $ProductRecipesTable(this);
  late final $LocalShiftsTable localShifts = $LocalShiftsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $LocalSettingsTable localSettings = $LocalSettingsTable(this);
  late final $CachedOrdersTable cachedOrders = $CachedOrdersTable(this);
  late final $CachedSalesTable cachedSales = $CachedSalesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedProducts,
    cachedIngredients,
    productRecipes,
    localShifts,
    syncOutbox,
    localSettings,
    cachedOrders,
    cachedSales,
  ];
}

typedef $$CachedProductsTableCreateCompanionBuilder =
    CachedProductsCompanion Function({
      required String productId,
      required String name,
      required String category,
      Value<String> description,
      required int price,
      Value<String> modifiersJson,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$CachedProductsTableUpdateCompanionBuilder =
    CachedProductsCompanion Function({
      Value<String> productId,
      Value<String> name,
      Value<String> category,
      Value<String> description,
      Value<int> price,
      Value<String> modifiersJson,
      Value<bool> active,
      Value<int> rowid,
    });

class $$CachedProductsTableFilterComposer
    extends Composer<_$PosDatabase, $CachedProductsTable> {
  $$CachedProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modifiersJson => $composableBuilder(
    column: $table.modifiersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProductsTableOrderingComposer
    extends Composer<_$PosDatabase, $CachedProductsTable> {
  $$CachedProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modifiersJson => $composableBuilder(
    column: $table.modifiersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProductsTableAnnotationComposer
    extends Composer<_$PosDatabase, $CachedProductsTable> {
  $$CachedProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get modifiersJson => $composableBuilder(
    column: $table.modifiersJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$CachedProductsTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $CachedProductsTable,
          CachedProduct,
          $$CachedProductsTableFilterComposer,
          $$CachedProductsTableOrderingComposer,
          $$CachedProductsTableAnnotationComposer,
          $$CachedProductsTableCreateCompanionBuilder,
          $$CachedProductsTableUpdateCompanionBuilder,
          (
            CachedProduct,
            BaseReferences<_$PosDatabase, $CachedProductsTable, CachedProduct>,
          ),
          CachedProduct,
          PrefetchHooks Function()
        > {
  $$CachedProductsTableTableManager(
    _$PosDatabase db,
    $CachedProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<String> modifiersJson = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProductsCompanion(
                productId: productId,
                name: name,
                category: category,
                description: description,
                price: price,
                modifiersJson: modifiersJson,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                required String name,
                required String category,
                Value<String> description = const Value.absent(),
                required int price,
                Value<String> modifiersJson = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProductsCompanion.insert(
                productId: productId,
                name: name,
                category: category,
                description: description,
                price: price,
                modifiersJson: modifiersJson,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $CachedProductsTable,
      CachedProduct,
      $$CachedProductsTableFilterComposer,
      $$CachedProductsTableOrderingComposer,
      $$CachedProductsTableAnnotationComposer,
      $$CachedProductsTableCreateCompanionBuilder,
      $$CachedProductsTableUpdateCompanionBuilder,
      (
        CachedProduct,
        BaseReferences<_$PosDatabase, $CachedProductsTable, CachedProduct>,
      ),
      CachedProduct,
      PrefetchHooks Function()
    >;
typedef $$CachedIngredientsTableCreateCompanionBuilder =
    CachedIngredientsCompanion Function({
      required String ingredientId,
      required String name,
      required String unit,
      Value<double> quantity,
      Value<double> minimum,
      Value<double> unitCost,
      Value<int> rowid,
    });
typedef $$CachedIngredientsTableUpdateCompanionBuilder =
    CachedIngredientsCompanion Function({
      Value<String> ingredientId,
      Value<String> name,
      Value<String> unit,
      Value<double> quantity,
      Value<double> minimum,
      Value<double> unitCost,
      Value<int> rowid,
    });

class $$CachedIngredientsTableFilterComposer
    extends Composer<_$PosDatabase, $CachedIngredientsTable> {
  $$CachedIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimum => $composableBuilder(
    column: $table.minimum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedIngredientsTableOrderingComposer
    extends Composer<_$PosDatabase, $CachedIngredientsTable> {
  $$CachedIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimum => $composableBuilder(
    column: $table.minimum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedIngredientsTableAnnotationComposer
    extends Composer<_$PosDatabase, $CachedIngredientsTable> {
  $$CachedIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get minimum =>
      $composableBuilder(column: $table.minimum, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);
}

class $$CachedIngredientsTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $CachedIngredientsTable,
          CachedIngredient,
          $$CachedIngredientsTableFilterComposer,
          $$CachedIngredientsTableOrderingComposer,
          $$CachedIngredientsTableAnnotationComposer,
          $$CachedIngredientsTableCreateCompanionBuilder,
          $$CachedIngredientsTableUpdateCompanionBuilder,
          (
            CachedIngredient,
            BaseReferences<
              _$PosDatabase,
              $CachedIngredientsTable,
              CachedIngredient
            >,
          ),
          CachedIngredient,
          PrefetchHooks Function()
        > {
  $$CachedIngredientsTableTableManager(
    _$PosDatabase db,
    $CachedIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> ingredientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> minimum = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedIngredientsCompanion(
                ingredientId: ingredientId,
                name: name,
                unit: unit,
                quantity: quantity,
                minimum: minimum,
                unitCost: unitCost,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ingredientId,
                required String name,
                required String unit,
                Value<double> quantity = const Value.absent(),
                Value<double> minimum = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedIngredientsCompanion.insert(
                ingredientId: ingredientId,
                name: name,
                unit: unit,
                quantity: quantity,
                minimum: minimum,
                unitCost: unitCost,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $CachedIngredientsTable,
      CachedIngredient,
      $$CachedIngredientsTableFilterComposer,
      $$CachedIngredientsTableOrderingComposer,
      $$CachedIngredientsTableAnnotationComposer,
      $$CachedIngredientsTableCreateCompanionBuilder,
      $$CachedIngredientsTableUpdateCompanionBuilder,
      (
        CachedIngredient,
        BaseReferences<
          _$PosDatabase,
          $CachedIngredientsTable,
          CachedIngredient
        >,
      ),
      CachedIngredient,
      PrefetchHooks Function()
    >;
typedef $$ProductRecipesTableCreateCompanionBuilder =
    ProductRecipesCompanion Function({
      required String productId,
      required String ingredientId,
      required double quantity,
      required double unitCost,
      Value<int> rowid,
    });
typedef $$ProductRecipesTableUpdateCompanionBuilder =
    ProductRecipesCompanion Function({
      Value<String> productId,
      Value<String> ingredientId,
      Value<double> quantity,
      Value<double> unitCost,
      Value<int> rowid,
    });

class $$ProductRecipesTableFilterComposer
    extends Composer<_$PosDatabase, $ProductRecipesTable> {
  $$ProductRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductRecipesTableOrderingComposer
    extends Composer<_$PosDatabase, $ProductRecipesTable> {
  $$ProductRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitCost => $composableBuilder(
    column: $table.unitCost,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductRecipesTableAnnotationComposer
    extends Composer<_$PosDatabase, $ProductRecipesTable> {
  $$ProductRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);
}

class $$ProductRecipesTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $ProductRecipesTable,
          ProductRecipe,
          $$ProductRecipesTableFilterComposer,
          $$ProductRecipesTableOrderingComposer,
          $$ProductRecipesTableAnnotationComposer,
          $$ProductRecipesTableCreateCompanionBuilder,
          $$ProductRecipesTableUpdateCompanionBuilder,
          (
            ProductRecipe,
            BaseReferences<_$PosDatabase, $ProductRecipesTable, ProductRecipe>,
          ),
          ProductRecipe,
          PrefetchHooks Function()
        > {
  $$ProductRecipesTableTableManager(
    _$PosDatabase db,
    $ProductRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> productId = const Value.absent(),
                Value<String> ingredientId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitCost = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductRecipesCompanion(
                productId: productId,
                ingredientId: ingredientId,
                quantity: quantity,
                unitCost: unitCost,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productId,
                required String ingredientId,
                required double quantity,
                required double unitCost,
                Value<int> rowid = const Value.absent(),
              }) => ProductRecipesCompanion.insert(
                productId: productId,
                ingredientId: ingredientId,
                quantity: quantity,
                unitCost: unitCost,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $ProductRecipesTable,
      ProductRecipe,
      $$ProductRecipesTableFilterComposer,
      $$ProductRecipesTableOrderingComposer,
      $$ProductRecipesTableAnnotationComposer,
      $$ProductRecipesTableCreateCompanionBuilder,
      $$ProductRecipesTableUpdateCompanionBuilder,
      (
        ProductRecipe,
        BaseReferences<_$PosDatabase, $ProductRecipesTable, ProductRecipe>,
      ),
      ProductRecipe,
      PrefetchHooks Function()
    >;
typedef $$LocalShiftsTableCreateCompanionBuilder =
    LocalShiftsCompanion Function({
      required String shiftId,
      required String userId,
      required int openingCash,
      required DateTime openedAt,
      Value<String> state,
      Value<int> rowid,
    });
typedef $$LocalShiftsTableUpdateCompanionBuilder =
    LocalShiftsCompanion Function({
      Value<String> shiftId,
      Value<String> userId,
      Value<int> openingCash,
      Value<DateTime> openedAt,
      Value<String> state,
      Value<int> rowid,
    });

class $$LocalShiftsTableFilterComposer
    extends Composer<_$PosDatabase, $LocalShiftsTable> {
  $$LocalShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalShiftsTableOrderingComposer
    extends Composer<_$PosDatabase, $LocalShiftsTable> {
  $$LocalShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalShiftsTableAnnotationComposer
    extends Composer<_$PosDatabase, $LocalShiftsTable> {
  $$LocalShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);
}

class $$LocalShiftsTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $LocalShiftsTable,
          LocalShift,
          $$LocalShiftsTableFilterComposer,
          $$LocalShiftsTableOrderingComposer,
          $$LocalShiftsTableAnnotationComposer,
          $$LocalShiftsTableCreateCompanionBuilder,
          $$LocalShiftsTableUpdateCompanionBuilder,
          (
            LocalShift,
            BaseReferences<_$PosDatabase, $LocalShiftsTable, LocalShift>,
          ),
          LocalShift,
          PrefetchHooks Function()
        > {
  $$LocalShiftsTableTableManager(_$PosDatabase db, $LocalShiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shiftId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> openingCash = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalShiftsCompanion(
                shiftId: shiftId,
                userId: userId,
                openingCash: openingCash,
                openedAt: openedAt,
                state: state,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shiftId,
                required String userId,
                required int openingCash,
                required DateTime openedAt,
                Value<String> state = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalShiftsCompanion.insert(
                shiftId: shiftId,
                userId: userId,
                openingCash: openingCash,
                openedAt: openedAt,
                state: state,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalShiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $LocalShiftsTable,
      LocalShift,
      $$LocalShiftsTableFilterComposer,
      $$LocalShiftsTableOrderingComposer,
      $$LocalShiftsTableAnnotationComposer,
      $$LocalShiftsTableCreateCompanionBuilder,
      $$LocalShiftsTableUpdateCompanionBuilder,
      (
        LocalShift,
        BaseReferences<_$PosDatabase, $LocalShiftsTable, LocalShift>,
      ),
      LocalShift,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      required String clientUuid,
      required String eventType,
      required String payloadJson,
      required DateTime createdAt,
      Value<DateTime?> syncedAt,
      Value<String?> lastError,
      Value<String?> serverResultJson,
      Value<int> rowid,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<String> clientUuid,
      Value<String> eventType,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<String?> lastError,
      Value<String?> serverResultJson,
      Value<int> rowid,
    });

class $$SyncOutboxTableFilterComposer
    extends Composer<_$PosDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverResultJson => $composableBuilder(
    column: $table.serverResultJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$PosDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverResultJson => $composableBuilder(
    column: $table.serverResultJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$PosDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get serverResultJson => $composableBuilder(
    column: $table.serverResultJson,
    builder: (column) => column,
  );
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $SyncOutboxTable,
          SyncOutboxData,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxData,
            BaseReferences<_$PosDatabase, $SyncOutboxTable, SyncOutboxData>,
          ),
          SyncOutboxData,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$PosDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientUuid = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> serverResultJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                clientUuid: clientUuid,
                eventType: eventType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                syncedAt: syncedAt,
                lastError: lastError,
                serverResultJson: serverResultJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientUuid,
                required String eventType,
                required String payloadJson,
                required DateTime createdAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> serverResultJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                clientUuid: clientUuid,
                eventType: eventType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                syncedAt: syncedAt,
                lastError: lastError,
                serverResultJson: serverResultJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $SyncOutboxTable,
      SyncOutboxData,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxData,
        BaseReferences<_$PosDatabase, $SyncOutboxTable, SyncOutboxData>,
      ),
      SyncOutboxData,
      PrefetchHooks Function()
    >;
typedef $$LocalSettingsTableCreateCompanionBuilder =
    LocalSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$LocalSettingsTableUpdateCompanionBuilder =
    LocalSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$LocalSettingsTableFilterComposer
    extends Composer<_$PosDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSettingsTableOrderingComposer
    extends Composer<_$PosDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSettingsTableAnnotationComposer
    extends Composer<_$PosDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$LocalSettingsTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $LocalSettingsTable,
          LocalSetting,
          $$LocalSettingsTableFilterComposer,
          $$LocalSettingsTableOrderingComposer,
          $$LocalSettingsTableAnnotationComposer,
          $$LocalSettingsTableCreateCompanionBuilder,
          $$LocalSettingsTableUpdateCompanionBuilder,
          (
            LocalSetting,
            BaseReferences<_$PosDatabase, $LocalSettingsTable, LocalSetting>,
          ),
          LocalSetting,
          PrefetchHooks Function()
        > {
  $$LocalSettingsTableTableManager(_$PosDatabase db, $LocalSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  LocalSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => LocalSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $LocalSettingsTable,
      LocalSetting,
      $$LocalSettingsTableFilterComposer,
      $$LocalSettingsTableOrderingComposer,
      $$LocalSettingsTableAnnotationComposer,
      $$LocalSettingsTableCreateCompanionBuilder,
      $$LocalSettingsTableUpdateCompanionBuilder,
      (
        LocalSetting,
        BaseReferences<_$PosDatabase, $LocalSettingsTable, LocalSetting>,
      ),
      LocalSetting,
      PrefetchHooks Function()
    >;
typedef $$CachedOrdersTableCreateCompanionBuilder =
    CachedOrdersCompanion Function({
      Value<int> orderId,
      required String customerName,
      required String phone,
      required String status,
      required String productsJson,
      required int total,
      required String paymentMethod,
      Value<String> source,
      Value<String> address,
      Value<String> recipeSnapshotJson,
      Value<bool> ingredientsConsumed,
      required DateTime createdAt,
    });
typedef $$CachedOrdersTableUpdateCompanionBuilder =
    CachedOrdersCompanion Function({
      Value<int> orderId,
      Value<String> customerName,
      Value<String> phone,
      Value<String> status,
      Value<String> productsJson,
      Value<int> total,
      Value<String> paymentMethod,
      Value<String> source,
      Value<String> address,
      Value<String> recipeSnapshotJson,
      Value<bool> ingredientsConsumed,
      Value<DateTime> createdAt,
    });

class $$CachedOrdersTableFilterComposer
    extends Composer<_$PosDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipeSnapshotJson => $composableBuilder(
    column: $table.recipeSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ingredientsConsumed => $composableBuilder(
    column: $table.ingredientsConsumed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedOrdersTableOrderingComposer
    extends Composer<_$PosDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipeSnapshotJson => $composableBuilder(
    column: $table.recipeSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ingredientsConsumed => $composableBuilder(
    column: $table.ingredientsConsumed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedOrdersTableAnnotationComposer
    extends Composer<_$PosDatabase, $CachedOrdersTable> {
  $$CachedOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get recipeSnapshotJson => $composableBuilder(
    column: $table.recipeSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get ingredientsConsumed => $composableBuilder(
    column: $table.ingredientsConsumed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedOrdersTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $CachedOrdersTable,
          CachedOrder,
          $$CachedOrdersTableFilterComposer,
          $$CachedOrdersTableOrderingComposer,
          $$CachedOrdersTableAnnotationComposer,
          $$CachedOrdersTableCreateCompanionBuilder,
          $$CachedOrdersTableUpdateCompanionBuilder,
          (
            CachedOrder,
            BaseReferences<_$PosDatabase, $CachedOrdersTable, CachedOrder>,
          ),
          CachedOrder,
          PrefetchHooks Function()
        > {
  $$CachedOrdersTableTableManager(_$PosDatabase db, $CachedOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> productsJson = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> recipeSnapshotJson = const Value.absent(),
                Value<bool> ingredientsConsumed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CachedOrdersCompanion(
                orderId: orderId,
                customerName: customerName,
                phone: phone,
                status: status,
                productsJson: productsJson,
                total: total,
                paymentMethod: paymentMethod,
                source: source,
                address: address,
                recipeSnapshotJson: recipeSnapshotJson,
                ingredientsConsumed: ingredientsConsumed,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> orderId = const Value.absent(),
                required String customerName,
                required String phone,
                required String status,
                required String productsJson,
                required int total,
                required String paymentMethod,
                Value<String> source = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> recipeSnapshotJson = const Value.absent(),
                Value<bool> ingredientsConsumed = const Value.absent(),
                required DateTime createdAt,
              }) => CachedOrdersCompanion.insert(
                orderId: orderId,
                customerName: customerName,
                phone: phone,
                status: status,
                productsJson: productsJson,
                total: total,
                paymentMethod: paymentMethod,
                source: source,
                address: address,
                recipeSnapshotJson: recipeSnapshotJson,
                ingredientsConsumed: ingredientsConsumed,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $CachedOrdersTable,
      CachedOrder,
      $$CachedOrdersTableFilterComposer,
      $$CachedOrdersTableOrderingComposer,
      $$CachedOrdersTableAnnotationComposer,
      $$CachedOrdersTableCreateCompanionBuilder,
      $$CachedOrdersTableUpdateCompanionBuilder,
      (
        CachedOrder,
        BaseReferences<_$PosDatabase, $CachedOrdersTable, CachedOrder>,
      ),
      CachedOrder,
      PrefetchHooks Function()
    >;
typedef $$CachedSalesTableCreateCompanionBuilder =
    CachedSalesCompanion Function({
      required String sourceId,
      required String customerName,
      Value<String> phone,
      Value<String> status,
      required String productsJson,
      required int total,
      required String paymentMethod,
      Value<String> modality,
      Value<String> address,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CachedSalesTableUpdateCompanionBuilder =
    CachedSalesCompanion Function({
      Value<String> sourceId,
      Value<String> customerName,
      Value<String> phone,
      Value<String> status,
      Value<String> productsJson,
      Value<int> total,
      Value<String> paymentMethod,
      Value<String> modality,
      Value<String> address,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CachedSalesTableFilterComposer
    extends Composer<_$PosDatabase, $CachedSalesTable> {
  $$CachedSalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modality => $composableBuilder(
    column: $table.modality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedSalesTableOrderingComposer
    extends Composer<_$PosDatabase, $CachedSalesTable> {
  $$CachedSalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modality => $composableBuilder(
    column: $table.modality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedSalesTableAnnotationComposer
    extends Composer<_$PosDatabase, $CachedSalesTable> {
  $$CachedSalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get productsJson => $composableBuilder(
    column: $table.productsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modality =>
      $composableBuilder(column: $table.modality, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedSalesTableTableManager
    extends
        RootTableManager<
          _$PosDatabase,
          $CachedSalesTable,
          CachedSale,
          $$CachedSalesTableFilterComposer,
          $$CachedSalesTableOrderingComposer,
          $$CachedSalesTableAnnotationComposer,
          $$CachedSalesTableCreateCompanionBuilder,
          $$CachedSalesTableUpdateCompanionBuilder,
          (
            CachedSale,
            BaseReferences<_$PosDatabase, $CachedSalesTable, CachedSale>,
          ),
          CachedSale,
          PrefetchHooks Function()
        > {
  $$CachedSalesTableTableManager(_$PosDatabase db, $CachedSalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedSalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedSalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedSalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sourceId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> productsJson = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> modality = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedSalesCompanion(
                sourceId: sourceId,
                customerName: customerName,
                phone: phone,
                status: status,
                productsJson: productsJson,
                total: total,
                paymentMethod: paymentMethod,
                modality: modality,
                address: address,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sourceId,
                required String customerName,
                Value<String> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String productsJson,
                required int total,
                required String paymentMethod,
                Value<String> modality = const Value.absent(),
                Value<String> address = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedSalesCompanion.insert(
                sourceId: sourceId,
                customerName: customerName,
                phone: phone,
                status: status,
                productsJson: productsJson,
                total: total,
                paymentMethod: paymentMethod,
                modality: modality,
                address: address,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedSalesTableProcessedTableManager =
    ProcessedTableManager<
      _$PosDatabase,
      $CachedSalesTable,
      CachedSale,
      $$CachedSalesTableFilterComposer,
      $$CachedSalesTableOrderingComposer,
      $$CachedSalesTableAnnotationComposer,
      $$CachedSalesTableCreateCompanionBuilder,
      $$CachedSalesTableUpdateCompanionBuilder,
      (
        CachedSale,
        BaseReferences<_$PosDatabase, $CachedSalesTable, CachedSale>,
      ),
      CachedSale,
      PrefetchHooks Function()
    >;

class $PosDatabaseManager {
  final _$PosDatabase _db;
  $PosDatabaseManager(this._db);
  $$CachedProductsTableTableManager get cachedProducts =>
      $$CachedProductsTableTableManager(_db, _db.cachedProducts);
  $$CachedIngredientsTableTableManager get cachedIngredients =>
      $$CachedIngredientsTableTableManager(_db, _db.cachedIngredients);
  $$ProductRecipesTableTableManager get productRecipes =>
      $$ProductRecipesTableTableManager(_db, _db.productRecipes);
  $$LocalShiftsTableTableManager get localShifts =>
      $$LocalShiftsTableTableManager(_db, _db.localShifts);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$LocalSettingsTableTableManager get localSettings =>
      $$LocalSettingsTableTableManager(_db, _db.localSettings);
  $$CachedOrdersTableTableManager get cachedOrders =>
      $$CachedOrdersTableTableManager(_db, _db.cachedOrders);
  $$CachedSalesTableTableManager get cachedSales =>
      $$CachedSalesTableTableManager(_db, _db.cachedSales);
}
