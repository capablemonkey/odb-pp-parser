# odb++ parser

Parses odb++ files to give a human readable JSON representation of a board layer.  Currently only parses features file.

```
{
  "pads": [
    {
      "id": "some-component-name-1",
      "net": "ABC123",
      "type": "circle",
      "center": {
        "x": 3.000,
        "y": 1.233
      },
      "radius": 4.32
    },
    {
      "id": "some-component-name-2",
      "net": "ABC123",
      "type": "rectangle",
      "top-left": {
        "x": 3.000,
        "y": 1.233
      },
      "bottom-right": {
        "x": 6,
        "y": 8
      }
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