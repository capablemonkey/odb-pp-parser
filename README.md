# odb++ parser

Parses odb++ files to give a human readable JSON representation of a board layer.  Currently only parses **features** and **netlist** files.

Built against the ODB++ Format Specification Version 8.1 (Sept. 2015), available here: http://www.odb-sa.com/resources/

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

## Getting started

You'll need Ruby 2.0+.  Install dependencies:

```
bundle install
```

Then parse the `sample/features` file.  Output will be sent to `stdout`

```
ruby main.rb features sample/features
```

To parse the `sample/netlist` file:

```
ruby main.rb netlist sample/netlist
```

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