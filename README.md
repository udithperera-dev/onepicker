# onepicker

Introducing our innovative data picker called OnePicker, a powerful tool that allows you to access a wide range of data effortlessly. With just one picker, you can conveniently retrieve and analyze multiple data sets, saving you time and effort. This user-friendly device is designed to provide seamless access to various data sources, making it an essential tool for professionals in various industries. Stay ahead of the game with our data picker and unlock a world of information at your fingertips.

## Features

- Date Picker
- Date Range Picker


## Getting started

To use this package, add onepicker as a dependency in your pubspec.yaml file.

## Usage

- On pubspeck.yaml

```
onepicker: ^0.1.4
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

- On implementation of Date Range Picker

```
   OnePicker().dateRange(
                    context,
                    onTap: (from, to){
                      dateFromSeleted = DateFormat('yyyy-MM-dd') .format(from).toString();
                      dateToSeleted = DateFormat('yyyy-MM-dd') .format(to).toString();
                      setState(() {});
                    }
                );
```
<table>
  <tr>
    <td>Date Picker</td>
     <td>Date Range Picker</td>
     <td>Country Picker</td>
  </tr>
  <tr>
    <td width="30%"><img src="https://github.com/udithperera-dev/onepicker/raw/da699e52551ccc39f7775bf55679d7139a7cedc9/ss_date_picker_01.png" alt="date-picker" style="width:150px;"/></td>
    <td width="30%"><img src="https://github.com/udithperera-dev/onepicker/raw/6d3256556bcde588cc10e1fae84b42a13ea21d6a/ss_date_range_picker_02.png" alt="date-range-picker" style="width:150px;"/></td>
    <td width="30%"><img src="https://github.com/udithperera-dev/onepicker/raw/da699e52551ccc39f7775bf55679d7139a7cedc9/ss_country_picker.png" style="width:150px;"></td>
  </tr>
 </table>

- See also from Developer

    - [Akurupela Applications](https://akurupela.com)

<p align="center">
      <img src="https://www.akurupela.com/assets/images/images_info/ap_logo.png" width="25px" alt="logo" align="center">
      <img src="https://storage.googleapis.com/cms-storage-bucket/6a07d8a62f4308d2b854.svg" width="100px" alt="logo" align="center">
      <img src="https://pub.dev/static/hash-tihrt5d6/img/pub-dev-logo.svg" width="100px" alt="logo" align="center">
</p>