# onepicker

Access many data by using a one picker

## Features

- Date Picker


## Getting started

To use this package, add onepicker as a dependency in your pubspec.yaml file.

## Usage

- On pubspeck.yaml

```
onepicker: ^0.0.1
```

- On Dart Import

```
import 'package:onepicker/onepicker.dart';
```

- On implementation of Date Picker

```
OnePicker().date(
                    context,
                    selectedColor: Colors.green,
                    bgColor: Colors.white,
                    onTap: (value){
                      dateSeleted = value.toString();
                      setState(() {});
                    }
                );
```

<img src="https://github.com/udithperera-dev/onepicker/blob/main/screenshots/date_picker.png" alt="drawing" style="width:200px;"/>

![Date Picker](https://github.com/udithperera-dev/onepicker/blob/main/screenshots/date_picker.png =250x)

- See also from Developer

  - [Akurupela Applications](https://akurupela.com)