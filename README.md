# odb++ parser

[![Build Status](https://travis-ci.org/capablemonkey/odb-pp-parser.svg?branch=master)](https://travis-ci.org/capablemonkey/odb-pp-parser)

Parses odb++ files to give a human readable JSON representation of a board layer.  Currently only parses **features** and **netlist** files.

Built against the ODB++ Format Specification Version 8.1 (Sept. 2015), available here: http://www.odb-sa.com/resources/

## Getting started

You'll need Ruby 2.0+.  Install dependencies:

```
bundle install
```

Output will be sent to `stdout`

### Parsing the board 

To parse the board:

```
ruby main.rb layer sample/features sample/netlist sample/components
```

```json
{
  "nets": [],
  "components": [],
  "pads": []
}
```

### Parsing `features`

To parse the `sample/features` file:

```
ruby main.rb features sample/features
```

```json
{
  "pads": [
    {
      "id": "209",
      "symbol": {
        "type": "round",
        "diameter": "55"
      },
      "x": "1.59",
      "y": "0.1"
    },
    {
      "id": "312",
      "symbol": {
        "type": "oval",
        "width": "24",
        "height": "74"
      },
      "x": "1.64",
      "y": "0.66"
    },
    {
      "id": "346",
      "symbol": {
        "type": "square",
        "side": "70"
      },
      "x": "0.25425295",
      "y": "0.69755837"
    }
  ]
}
```

### Parsing `netlist`

To parse the `sample/netlist` file:

```
ruby main.rb netlist sample/netlist
```

```json
{
  "nets": [
    {
      "name": "GND",
      "points": [
        {
          "x": "1.72",
          "y": "0.56"
        },
        {
          "x": "1.14",
          "y": "0.41"
        },
        {
          "x": "1.59",
          "y": "0.1"
        },
        {
          "x": "1.64",
          "y": "0.56"
        },
        {
          "x": "1.64",
          "y": "0.51"
        },
        {
          "x": "0.2552531",
          "y": "0.2975584"
        },
        {
          "x": "1.2197234",
          "y": "0.4059187"
        },
        {
          "x": "1.5294807",
          "y": "0.1026173"
        }
      ]
    }
  ]
}
```

### Parsing layer

This includes net information for each pad:

To parse the layer:

```
ruby main.rb layer sample/features sample/netlist
```

```json
{
  "pads": [
    {
      "id": "90",
      "symbol": {
        "type": "round",
        "diameter": 55.0
      },
      "x": 1.94,
      "y": 0.36,
      "net": "+5V"
    },
    {
      "id": "96",
      "symbol": {
        "type": "round",
        "diameter": 55.0
      },
      "x": 1.52,
      "y": 0.56,
      "net": "+5V"
    },
    {
      "id": "100",
      "symbol": {
        "type": "round",
        "diameter": 55.0
      },
      "x": 1.41,
      "y": 0.1,
      "net": "+5V"
    }
  ]
}
```

### Running tests

To run tests:

```
rspec
```

### Abilities

Currently it can identify these entities:

#### Standard symbols

- round
- square
- rectangle
- oval

#### Features

- pads
- lines

#### Nets

- net_name
- serial_num

#### Net points

- net_num
- radius
- x
- y
- side
- w (optional)
- h (optional)
- epoint
- exp

#### Components

- CMP records (components)
- PRP records (properties)
- TOP records (toeprints)
