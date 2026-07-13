# Tria-Types-Module
tria maplib autocomplete with function documentation

# Instructions

## Setup
No effective setup solution other than inserting the code into the MapScript itself yet.
Throw the module somewhere under your map model and, in every script that uses MapLib, require this module and cast MapLib to the MapLib type after its declaration
That's all you really need...
In my case, I put the types module under a folder called `Modules` under the map model
Then, I pathed to it and cast it like this in the `MapScript`
```lua
local MapLib = game.GetMapLib:Invoke()()
local map = MapLib.Map

local types = require "@self/Types" -- disable this line before updating your map model
local MapLib = MapLib :: types.MapLib -- disable this line before updating your map model
```
It should work like this.

## How can I use the `map` instance autofill?
Make sure your map is a `Model`, then name the model `map` and make sure the map model is directly under workspace, instead of inside some folder or something

Sorry that this was the only way i thought of to make it work

# Notes

## What am I doing for method annotating?

I'm getting the type of a newly declared function with the given args. This is so i can add on the function documentation. Basically:

`typeof(--[[]] function() end)`


If there's a return type, i return `nil` (or the closest type) casted to the return types

`typeof(--[[]] function() return nil :: any end)`