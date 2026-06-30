require(game:GetService("ServerScriptService").Runtime):Init()
--@author untroublua (@signupredirectlol), TRIA

-- only run module in studio edit
if game:GetService("RunService"):IsRunning() then return nil end 

export type LightingConfigurable = {
	Ambient: Color3?,
	Brightness: number?,
	ClockTime: number?,
	ColorShift_Bottom: Color3?,
	ColorShift_Top: Color3?,
	EnvironmentDiffuseScale: number?,
	EnvironmentSpecularScale: number?,
	ExposureCompensation: number?,
	FogColor: Color3?,
	FogEnd: number?,
	FogStart: number?,
	GeographicLatitude: number?,
	GlobalShadows: boolean?,
	OutdoorAmbient: Color3?,
	ShadowSoftness: number?,
	TimeOfDay: string?
}

export type ButtonEventSignalFn = (player: Player) -> ()
export type ButtonEventSignal = {
	Connect: (ButtonEventSignal, func: ButtonEventSignalFn) -> RBXScriptConnection,
	Wait: Player,
	Once: (ButtonEventSignal, func: ButtonEventSignalFn) -> RBXScriptConnection,
	ConnectParallel: (ButtonEventSignal, func: ButtonEventSignalFn) -> RBXScriptConnection
}

export type Cleanable = () -> () | thread | Instance | RBXScriptConnection | Janitor | { Cleanable }

export type AlertColorStrings = "white" | "red" | "green" | "blue" | "yellow" | "pink" | "cyan"

export type MapLib = {
	--__index: MapLib,
	map: typeof(workspace.map),
	--Map: Model,
	--_MapHandler: any,
	--new: (any, any) -> MapLib,
	RoundEnding: RBXScriptSignal,

	Alert: typeof(
		--[[This method can be used to send an alert, these alerts can be customized by color and duration.

Example:

‎ ‎ ‎ ‎ MapLib:Alert("Hello world!", Color3.new(255, 255, 255), 3)
‎ ‎ ‎ ‎ -- Creates an alert with the given message with the color white and the duration of 3 seconds.

TIP

You can pass the color argument as string and it'll still work, just make sure to use a common color name! (All color string arguments given in autocomplete)

‎ ‎ ‎ ‎ MapLib:Alert("Hello world!", "red", 3)

]]
		function(self: MapLib, message: string, color: Color3 | AlertColorStrings, length: number?) end
	),
	ChangeMusic: typeof(
		--[[This method can be used to change the current music playing in a map, this also replicates to people spectating.

Example:

‎ ‎ ‎ ‎ MapLib:ChangeMusic(12245541717, 1, 5)
‎ ‎ ‎ ‎ -- Changes the currently playing music to volume 1 and starts at 5 seconds in.
]]
		function(self: MapLib, musicId: number, volume: number?, startTick: number?) end
	),
	GetButtonEvent: typeof(
		--[[SERVER SIDED ONLY
		This method can be used to run functions once a specific button has been pressed.

Example:

‎ ‎ ‎ ‎ MapLib:GetButtonEvent(5):Connect(function(player: Player?)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ MapLib:Alert("Button 5 was pressed!", Color3.fromRGB(255, 255, 255), 4)
	end)

NOTE

The player argument here is the player that pressed the button or nil if the button was activated automatically.
tip

Path buttons work the same as normal buttons, you just need to give a valid button ID in quotation marks (e.g. "6A")

Example:

‎ ‎ ‎ ‎ MapLib:GetButtonEvent("6A"):Connect(function(player: Player?)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ MapLib:Alert("Button 6A was pressed!", Color3.fromRGB(255, 0, 0), 5)
‎ ‎ ‎ ‎ end)

]]
		function(self: MapLib, buttonId: number | string) return nil :: ButtonEventSignal? end
	),
	Survive: typeof(
		--[[SERVER SIDED ONLY
		This method can be used to make a player survive the round without touching the ExitRegion.

Example:

‎ ‎ ‎ ‎ local Players = game:GetService("Players")
‎ ‎ ‎ ‎ local MapLib = game.GetMapLib:Invoke()()

‎ ‎ ‎ ‎ script.Parent.Touched:Connect(function(other)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ local player = Players:GetPlayerFromCharacter(other.Parent)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ if player then
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ MapLib:Survive(player)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ end
‎ ‎ ‎ ‎ end)
]]
		function(self: MapLib, player: Player) end
	),
	SetLiquidType: typeof(
		--[[This method can be used to change the state of a liquid. There are 3 default types you can choose, these are water, acid and lava.

Example:

‎ ‎ ‎ ‎ MapLib:SetLiquidType(map.Liquid1, "lava")
‎ ‎ ‎ ‎ -- Changes the liquidType of map.Liquid1 to lava.

TIP

You can make your own liquid type in your map's Settings.Liquids folder. For example a custom liquid type named "bromine" will have the usage:

‎ ‎ ‎ ‎ MapLib:SetLiquidType(map.LiquidWater, "bromine")

]]
		function(self: MapLib, liquid: BasePart, liquidType: "water" | "acid" | "lava" | string) end
	),

	Move: typeof(
		--[[Used to move PVInstances (Parts or Models).

Example:

‎ ‎ ‎ ‎ MapLib:Move(map.MovingPart1, Vector3.new(12, 0, 0), 3)
‎ ‎ ‎ ‎ -- Moves map.MovingPart1 along the X axis 12 studs and finishes moving after 3 seconds
]]
		function(self: MapLib, moveable: PVInstance, movement: Vector3, duration: number?) end
	),
	MoveModel: typeof(
		--Used to move Models. Use :Move() instead.
		@deprecated
		function(self: MapLib, moveable: Model, movement: Vector3, duration: number?) end
	),
	MovePart: typeof(
		--Used to move Parts. Use :Move() instead.
		@deprecated
		function(self: MapLib, moveable: BasePart, movement: Vector3, duration: number?) end
	),
	
	MoveRelative: typeof(
		--[[Used to move PVInstances (Parts or Models) along their axis. 

Example:

‎ ‎ ‎ ‎ MapLib:MoveRelative(map.MovingPart2, Vector3.new(12, 0, 0), 5)
‎ ‎ ‎ ‎ -- Moves map.MovingPart2 relative to its rotation.
]]
		function(self: MapLib, moveable: PVInstance, movement: Vector3, duration: number?) end
	),
	MoveModelLocal: typeof(
		--Used to move Models along their axis. Use :Move() instead.
		@deprecated
		function(self: MapLib, moveable: Model, movement: Vector3, duration: number?) end
	),
	MovePartLocal: typeof(
		--Used to move Parts along their axis. Use :Move() instead.
		@deprecated
		function(self: MapLib, moveable: BasePart, movement: Vector3, duration: number?) end
	),

	GetPlayers: typeof(
		--This method returns a table containing players currently in a map.
		function(self: MapLib) return {} :: { Player } end
	),
	GetFeature: Features

}

export type Janitor = {
	--__index: Janitor,
	ClassName: string,

	new: typeof(
		-- Constructs a new Janitor class and is cached for later use. Janitor provides an option in case you want to name your Janitor for easier reference later.
		function(janitorName: string?) return nil :: Janitor end
	),
	isJanitor: typeof(
		-- Returns true if the given class is a Janitor, if not it returns false.
		function(value: any) return false end
	),

	Give: typeof(
		--[[Example:

‎ ‎ ‎ ‎ local janitor = MapLib:GetFeature("Cleanup").Janitor.new() -- Constructs new Janitor

‎ ‎ ‎ ‎ local part = Instance.new("Part")
‎ ‎ ‎ ‎ part.Anchored = true
‎ ‎ ‎ ‎ part.Size = Vector3.new(1, 1, 1)
‎ ‎ ‎ ‎ part.Parent = workspace

‎ ‎ ‎ ‎ janitor:Give(part)

‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ janitor:Cleanup() -- Destroys the part 

This method is used to give Janitor tasks to cleanup, these tasks can be anything, some examples include, functions, threads, coroutines or anything with a .Destroy function.

TIP

‎ ‎ ‎ ‎ Janitor allows for tables to be given in as an argument. If Janitor detects a table it will loop through the table and add anything it finds will be added to the tasks table.

‎ ‎ ‎ ‎ local janitor = MapLib:GetFeature("Cleanup").Janitor.new() -- Constructs new Janitor

‎ ‎ ‎ ‎ local connection1 = RunService.Heartbeat:Connect(function() 
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ print("Running")
‎ ‎ ‎ ‎ end)

‎ ‎ ‎ ‎ local connection2 = RunService.Heartbeat:Connect(function() 
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ print("Running")
‎ ‎ ‎ ‎ end)

‎ ‎ ‎ ‎ janitor:Give({connection1, connection2})

‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ janitor:Cleanup() -- Destroys both connections


CAUTION

Janitor does not have the ability to completly clear references if they are defined to a variable. To initate proper garbage collection using Janitor we recommend setting the variable to reference = janitor:Give(task) which will set the reference to nil.

‎ ‎ ‎ ‎ local janitor = MapLib:GetFeature("Cleanup").Janitor.new() -- Constructs new Janitor

‎ ‎ ‎ ‎ local part = Instance.new("Part")
‎ ‎ ‎ ‎ part.Anchored = true
‎ ‎ ‎ ‎ part.Size = Vector3.new(1, 1, 1)
‎ ‎ ‎ ‎ part.Parent = workspace

‎ ‎ ‎ ‎ part = janitor:Give(part)
‎ ‎ ‎ ‎ --Since :Give returns nil we can lose the reference and initate proper garbage collection.

‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ janitor:Cleanup() -- Destroys the part and initates garbage collection

]]
		function(self: Janitor, task: Cleanable) return nil end
	),
	Cleanup: typeof(
		-- Calls for the Janitor to cleanup up all the tasks it was given.	
		function(self: Janitor, taskTable: { any }?) end
	),
	Destroy: typeof(
		-- Completely destroys Janitor and all references to it. If the Janitor has tasks then those tasks are cleaned up.
		function(self: Janitor) end
	)
}


export type SkillFeature = {
	ToggleSliding: typeof(
		--[[CLIENT SIDED ONLY
		This function can be used for toggling sliding on or off during a map.

Example:

‎ ‎ ‎ ‎ local SkillsFeature = MapLib:GetFeature("Skills")

‎ ‎ ‎ ‎ SkillsFeature:ToggleSliding(false)
‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ SkillsFeature:ToggleSliding(true)
]]
		function(self: SkillFeature, value: boolean) end
	),
	ToggleAirDive: typeof(
		--[[CLIENT SIDED ONLY
		This function can be used for toggling airdive on or off during a map.

Example:

‎ ‎ ‎ ‎ local SkillsFeature = MapLib:GetFeature("Skills")

‎ ‎ ‎ ‎ SkillsFeature:ToggleAirDive(false)
‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ SkillsFeature:ToggleAirDive(true)
]]
		function(self: SkillFeature, value: boolean) end
	)
}
export type PlayersFeature = {
	GetPlayers: typeof(
		--[[This function can be used to get all players in the current round.

Example:

‎ ‎ ‎ ‎ --Teleports all players ingame to map.Destination.
‎ ‎ ‎ ‎ local PlayersFeature = MapLib:GetFeature("Players")
‎ ‎ ‎ ‎ local TeleportFeature = MapLib:GetFeature("Teleport")

‎ ‎ ‎ ‎ for _, player in pairs(PlayersFeature:GetPlayers()) do
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ TeleportFeature:Teleport(player, map.Destination.Position)
‎ ‎ ‎ ‎ end
]]
		function(self: PlayersFeature) return {} :: {Player} end
	),
	GetPlayersInRadius: typeof(
		--[[This function can be used to get all the players which are in a radius from a position.

Example:

‎ ‎ ‎ ‎ --Teleports all players that are within 5 studs from map.Spawn.
‎ ‎ ‎ ‎ local PlayersFeature = MapLib:GetFeature("Players")
‎ ‎ ‎ ‎ local TeleportFeature = MapLib:GetFeature("Teleport")

‎ ‎ ‎ ‎ for _, player in pairs(PlayersFeature:GetPlayersInRadius(map.Spawn.Position, 5)) do
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ TeleportFeature:Teleport(player, map.Destination.Position)
‎ ‎ ‎ ‎ end
]]
		function(self: PlayersFeature, position: Vector3, radius: number) return {} :: {Player} end
	)
}
export type TeleportFeature = {
	Teleport: typeof(
		--[[CLIENT SIDED ONLY
		This function can be used to teleport players.

Example:
‎ ‎ ‎ ‎ --Teleports all players ingame to map.Destination and makes the camera face the front.
‎ ‎ ‎ ‎ local PlayersFeature = MapLib:GetFeature("Players")
‎ ‎ ‎ ‎ local TeleportFeature = MapLib:GetFeature("Teleport")

‎ ‎ ‎ ‎ for _, player in pairs(PlayersFeature:GetPlayers()) do
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ TeleportFeature:Teleport(player, map.Destination.Position, true)
‎ ‎ ‎ ‎ end
]]
		function(TeleportFeature, player: Player, pos: CFrame | Vector3, faceFront: boolean) end
	)
}

export type LightingFeature = {
	SetLighting: typeof(
		--[[This function can to be used to change the lighting of a map mid round. We discourage usage of changing lighting
with game.Lighting[Property] = value cause it doesnt replicate for spectators.

Example:
‎ ‎ ‎ ‎ -- Changes the fog to 100 and the fog color to white
‎ ‎ ‎ ‎ local LightingFeature = MapLib:GetFeature("Lighting")

‎ ‎ ‎ ‎ LightingFeature:SetLighting({
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ FogEnd = 100,
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ FogColor = Color3.fromRGB(255, 255, 255)
‎ ‎ ‎ ‎ })

This function also supports lighting effects to be updated and they will be replicated to specators.
 
‎ ‎ ‎ ‎ -- Changes the fog to 100 and the fog color to white and makes everything monochrome.
‎ ‎ ‎ ‎ local LightingFeature = MapLib:GetFeature("Lighting")

‎ ‎ ‎ ‎ LightingFeature:SetLighting({
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ FogEnd = 100,
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ FogColor = Color3.fromRGB(255, 255, 255)
‎ ‎ ‎ ‎ }, {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ColorCorrection = {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Saturation = -1,
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ },
‎ ‎ ‎ ‎ })

CAUTION
For the game to be able to edit post effects they have to be correctly placed inside the lighting folder inside settings.
If they are created in a script the game will not see these and refuse to update the lighting properties.

TIP
Since atmosphere instances don't have any enabled or disabled property we can get around that by parenting the instance to ReplicatedStorage
and then we can parent it back to lighting when we need it.

‎ ‎ ‎ ‎ local LightingFeature = MapLib:GetFeature("Lighting")

‎ ‎ ‎ ‎ --Disables the atmosphere effect
‎ ‎ ‎ ‎ LightingFeature:SetLighting({}, {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Atmosphere = {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Parent = game.ReplicatedStorage,
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ },
‎ ‎ ‎ ‎ })

‎ ‎ ‎ ‎ task.wait(5)
‎ ‎ ‎ ‎ --Enables the atmosphere effect
‎ ‎ ‎ ‎ LightingFeature:SetLighting({}, {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Atmosphere = {
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ Parent = game.Lighting,
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ },
‎ ‎ ‎ ‎ })
]]
		function(self: LightingFeature, properties: LightingConfigurable, postEffects: { [string]: { [string]: any } }) end),
	EaseLighting: typeof(
		--SetLighting but with a TweenInfo parameter for smoothly changing lighting.
		function(self: LightingFeature, tweenInfo: TweenInfo, properties: LightingConfigurable, postEffects: { [string]: { [string]: any } }) end
	)
}
export type CleanupFeature = {
	--Janitors: { Janitor },
	Janitor: Janitor,
	GetJanitor: typeof(
		-- This method returns a Janitor class with the given name
		function(self: CleanupFeature, janitorName: string | number) return nil :: Janitor? end
	),
	GetJanitors: typeof(
		-- This method returns all the active Janitor classes.
		function(self: CleanupFeature) return {} :: { Janitor } end
	),
}
export type PlayerUIFeature = {
	LoadUI: typeof(
	--[[CLIENT SIDED ONLY
‎ ‎ ‎ ‎ This function can be used to load a ScreenGui from the map into the players PlayerGui.

‎ ‎ ‎ ‎ Example:
‎ ‎ ‎ ‎ 
‎ ‎ ‎ ‎ -- Loads an UI for everyone in the round
‎ ‎ ‎ ‎ local PlayersFeature = MapLib:GetFeature("Players")
‎ ‎ ‎ ‎ local PlayerUI = MapLib:GetFeature("PlayerUI")

‎ ‎ ‎ ‎ local ui = map:WaitForChild("MyGUI")

‎ ‎ ‎ ‎ for _, player in pairs(PlayersFeature:GetPlayers()) do
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ if player and player.Character then
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ PlayerUI:LoadUI(ui)
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ end
‎ ‎ ‎ ‎ end]]
		function(self: PlayerUIFeature, gui: ScreenGui) end
	)
}
export type SettingsFeature = {
	GetSetting: typeof(
		--[[CLIENT SIDED ONLY
This function can be used to get the value of any setting under map.Settings.
This means any attribute under any descendant of map.Settings.
Example:

‎ ‎ ‎ ‎ -- Changes the camera FOV to an arbitrary number and then sets it back to the saved settings value.
‎ ‎ ‎ ‎ local SettingsFeature = MapLib:GetFeature("Settings")

‎ ‎ ‎ ‎ local camera = workspace.CurrentCamera

‎ ‎ ‎ ‎ camera.FieldOFView = 120
‎ ‎ ‎ ‎ task.wait(3)
‎ ‎ ‎ ‎ camera.FieldOFView = SettingsFeature:GetSetting("Field Of View")
]]
	function(mapSetting: string) return nil :: any? end
	)
}

export type Features = 
	((MapLib, name: "Skills") -> SkillFeature)
& ((MapLib, name: "PlayerUI") -> PlayerUIFeature)
& ((MapLib, name: "Settings") -> SettingsFeature)
& ((MapLib, name: "Players") -> PlayersFeature)
& ((MapLib, name: "Cleanup") -> CleanupFeature)
& ((MapLib, name: "Teleport") -> TeleportFeature)
& ((MapLib, name: "Teleport") -> TeleportFeature)
& ((MapLib, name: "Lighting") -> LightingFeature)

return nil