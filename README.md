# Tria-Types-Module
tria maplib autocomplete with function documentation

# Instructions

## Setup
<!-- No effective setup solution other than inserting the code into the MapScript itself yet. -->
Throw the module under the script you're using it in and declare a variable set to MapLib with the type casted to the `MapLib` type in this module.

That's all you really need...

```lua
local MapLib = game.GetMapLib:Invoke()()
local map = MapLib.Map

local types = require "@self/Types" -- disable this line before updating your map model
local MapLib = MapLib :: types.MapLib -- disable this line before updating your map model
```

It should work like this.

If you don't have the require and the type cast lines disabled before updating your map model, your map **will** error.
You can disable lines by selecting them and pressing `Ctrl+/`.

## How can I use the `map` instance autofill?
Make sure your map is a `Model`, then name the model `map` and make sure the map model is directly under workspace, instead of inside some folder or something

Sorry that this was the only way i thought of to make it work

# Notes

## What am I doing for method annotating?

I'm getting the type of a newly declared function with the given args. This is so i can add on the function documentation. Basically:

`typeof(--[[]] function() end)`


If there's a return type, i return `nil` (or the closest type) casted to the return types

`typeof(--[[]] function() return nil :: any end)`