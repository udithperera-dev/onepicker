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
<table>
  <tr>
    <td>Date Picker</td>
     <td>Date Range Picker</td>
     <td>Other Picker</td>
  </tr>
  <tr>
    <td><img src="https://github.com/udithperera-dev/onepicker/blob/main/screenshots/date_picker.png" alt="drawing" style="width:150px;"/></td>
    <td><img src="https://github.com/udithperera-dev/onepicker/blob/main/screenshots/date_picker.png" alt="drawing" style="width:150px;"/></td>
    <td><img src="screenshots/date_picker.png" width=150></td>
  </tr>
 </table>

- See also from Developer

  - [Akurupela Applications](https://akurupela.com)

<p align="center">
      <a href="https://github.com/alexmojaki/futurecoder/blob/master/LICENSE.txt"><img src="https://img.shields.io/github/license/alexmojaki/futurecoder?style=flat" alt="GNU license" align="center"></a>
      <img src="https://www.akurupela.com/assets/images/images_info/ap_logo.png" width="50px" alt="logo">
      <img src="https://pub.dev/static/hash-tihrt5d6/img/pub-dev-logo.svg" width="50px" alt="logo">
      <img src="https://storage.googleapis.com/cms-storage-bucket/6a07d8a62f4308d2b854.svg" width="50px" alt="logo">
</p>