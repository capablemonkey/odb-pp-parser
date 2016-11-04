# odb++ parser

Parses odb++ files to give a human readable JSON representation of a board layer.  Currently only parses features file.

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

## Getting started

You'll need Ruby 2.0+.  Install dependencies:

```
bundle install
```

Then parse the `sample_features` file.  Output will be sent to `stdout`

```
ruby main.rb sample/features
```