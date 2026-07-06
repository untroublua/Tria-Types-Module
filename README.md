# Tria-Types-Module
tria maplib autocomplete with function documentation

# Instructions

## Setup
Throw the module under the script you're using it for and require it. Then cast MapLib to the MapLib type
That's all you really need...
In my case, I put the types module under a folder called `Modules` under the map model
Then, I pathed to it and cast it like this in the `MapScript`
```lua
local Types = require "@self/Types" -- so it was pretty much script.Parent.Modules.Types
local MapLib = game.GetMapLib:Invoke()() :: Types.MapLib -- casted the type here
```
It should work like this.

## How can I use the `map` instance autofill?
Make sure your map is a `Model`, then name the model `map` and make sure the map model is directly under workspace, instead of inside some folder or something

Sorry that this was the only way i thought of to make it work

# Notes

## What am I doing for method annotating?

I'm getting the type of a newly declared function with the given args. This is so i can add on the function documentation. Basically:

`typeof(--[[]] function() end)`


If there's a return type, i return `nil` casted to the return types

`typeof(--[[]] function() return nil :: any end)`