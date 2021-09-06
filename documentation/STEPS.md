# Test Steps

## Table of Contents

* [Introduction](#introduction)
* [Test Step Summary](#test-step-summary)
* [Details](#details)
  * [assert_location_permission](#assert_location_permission)
  * [reset_location](#reset_location)
  * [set_location](#set_location)
  * [set_location_permission][#set_location_permission]


## Introduction

This plugin provides a few new [Test Steps](https://github.com/peiffer-innovations/automated_testing_framework/blob/main/documentation/STEPS.md) related to test GPS and location related actions.


---

## Test Step Summary

Test Step IDs                                            | Description
----------------------------------------------------------|-------------
[assert_location_permission](#assert_location_permission) | Asserts that the value of of the `permission` from the `GpsPlugin` matches the value set in the step.
[reset_location](#reset_location)                         | Resets any overrides set on the `GpsPlugin`.
[set_location](#set_location)                             | Sets the current latitude and longitude to be reported back via the `GpsPlugin`.
[set_location_permission](#set_location_permission)       | Sets the location permission as reported by the `GpsPlugin`.


---
## Details


### assert_location_permission

**How it Works**

1. Checks to see if the permission set in the `GpsPlugin` matches the given `permission`.


**Example**

```json
{
  "id": "assert_location_permission",
  "image": "<optional_base_64_image>",
  "values": {
    "permission": "whileInUse"
  }
}
```

**Values**

Key          | Type    | Required | Supports Variable | Description
-------------|---------|----------|-------------------|-------------
`permission` | String  | No       | Yes               | The permission to check.  Expected values are: `always`, `denied`, `deniedForever`, and `whileInUse`.


---

### reset_location

**How it Works**

1. Resets the `GpsPlugin` back to the default state so that it gets the values from the device.

**Example**

```json
{
  "id": "reset_location",
  "image": "<optional_base_64_image>",
  "values": {}
}
```

**Values**

n/a


---

### set_location

**How it Works**

1. Sets the location override value on the `GpsPlugin` to the given `latitude` and `longitude`.
2. If no override permission has been set, also sets that to `whileInUse`.

**Example**

```json
{
  "id": "set_connectivity",
  "image": "<optional_base_64_image>",
  "values": {
    "latitude": 50.0,
    "longitude": -50.0,
  }
}
```

**Values**

Key         | Type    | Required | Supports Variable | Description
------------|---------|----------|-------------------|-------------
`latitude`  | double  | Yes      | Yes               | The latitude value to use for the location override.
`longitude` | double  | Yes      | Yes               | The longitude value to use for the location override.


---

### set_location_permission

**How it Works**

1. Sets the location permission override value on the `GpsPlugin` to the given `permission`.

**Example**

```json
{
  "id": "set_location_permission",
  "image": "<optional_base_64_image>",
  "values": {
    "permission": "whileInUse",
  }
}
```

**Values**

Key          | Type    | Required | Supports Variable | Description
-------------|---------|----------|-------------------|-------------
`permission` | String  | No       | Yes               | The permission to use.  Expected values are: `always`, `denied`, `deniedForever`, and `whileInUse`.


