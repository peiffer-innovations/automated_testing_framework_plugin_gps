<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [automated_testing_framework_plugin_gps](#automated_testing_framework_plugin_gps)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Live Example](#live-example)
  - [Quick Start](#quick-start)
  - [Reserved Variables](#reserved-variables)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# automated_testing_framework_plugin_gps

## Table of Contents

* [Introduction](#introduction)
* [Live Example](#live-example)
* [Quick Start](#quick-start)
* [Reserved Variables](#reserved_variables)
* [Additional Test Steps](https://github.com/peiffer-innovations/automated_testing_framework_plugin_flow_control/blob/main/documentation/STEPS.md)


## Introduction

A series of test steps that are related to test GPS and location functionality.  

Applications wishing to utilize this plugin should utilize the `GpsPlugin` when testing for location.



## Live Example

* [Web](https://peiffer-innovations.github.io/automated_testing_framework_plugin_gps/web/#/)


## Quick Start

```dart
import 'package:automated_testing_framework_plugin_gps/automated_testing_framework_plugin_gps.dart';

void main() {
  TestGpsHelper.registerTestSteps();

  ...

  // You _must_ initialize the plugin, though the controller may be null in 
  // release mode which puts the plugin in "passthrough" mode rather than active
  // testable mode.
  GpsPlugin().initialize(testController: testController);

  // rest of app initialization
  // ...
}
```

## Reserved Variables

n/a