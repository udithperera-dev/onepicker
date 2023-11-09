# onepicker

Access many data by using a one picker

## Features

- Date Picker


## Getting started

To use this package, add boxing_images as a dependency in your pubspec.yaml file.

## Usage

- On pubspeck.yaml

```onepicker: ^1.0.0
```

- On Dart Import

```import 'package:onepicker/onepicker.dart';
     BoxingImages()
```

- On implementation

```OnePicker().date(
                    context,
                    selectedColor: Colors.green,
                    bgColor: Colors.white,
                    onTap: (value){
                      dateSeleted = value.toString();
                      setState(() {});
                    }
                );
```