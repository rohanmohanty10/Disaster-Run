--!strict
-- RainSystem — controller (LocalScript).
-- Owns the subsystems, fans the single occlusion state out to the ones that care,
-- handles respawns, and exposes start/stop. Place under StarterPlayerScripts.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Config = require(script.Config)
local Types = require(script.Types)
local Maid = require(script.Maid)
local OcclusionDetector = require(script.OcclusionDetector)
local VisualRain = require(script.VisualRain)
local AudioManager = require(script.AudioManager)
local CharacterVFX = require(script.CharacterVFX)
local GroundSplashes = require(script.GroundSplashes)
local RainRig = require(script.RainRig)

local player = Players.LocalPlayer

local runMaid = Maid.new() -- cleaned on stop()
local running = false

-- Subsystem instances (recreated on each start; GC'd after stop).
local occlusion: OcclusionDetector.OcclusionDetector
--local visual: VisualRain.VisualRain
local audio: AudioManager.AudioManager
local vfx: CharacterVFX.CharacterVFX
local splashes: GroundSplashes.GroundSplashes
--local rainRig: RainRig.RainRig

-- Single point where one occlusion state drives every state-aware subsystem.
local function applyState(state: Types.RainState)
	audio:setState(state)
	vfx:setState(state)
	splashes:setActive(state == "Exposed")
	--rainRig:setActive(state == "Exposed")
end

local function bindCharacter(character: Model)
	character:WaitForChild("HumanoidRootPart", 10)
	occlusion:setCharacter(character)
	audio:setCharacter(character)
	vfx:setCharacter(character)
	splashes:setCharacter(character)
	--rainRig:setCharacter(character)
end

local function start()
	if running then
		return
	end
	running = true

	local camera = Workspace.CurrentCamera

	occlusion = OcclusionDetector.new()
	--visual = VisualRain.new(camera)
	audio = AudioManager.new()
	vfx = CharacterVFX.new()
	splashes = GroundSplashes.new(camera)
	--rainRig = RainRig.new()

	occlusion:onStateChanged(function(state)
		applyState(state)
	end)

	--visual:start()
	audio:start()
	splashes:start()
	occlusion:start()
	--rainRig:start()

	if player.Character then
		bindCharacter(player.Character)
	end
	runMaid:give(player.CharacterAdded:Connect(bindCharacter))

	-- Seed every subsystem with the detector's current read.
	applyState(occlusion:getState())
end

local function stop()
	if not running then
		return
	end
	running = false
	occlusion:stop()
	--visual:stop()
	audio:stop()
	vfx:stop()
	splashes:stop()
	runMaid:clean()
	
	--rainRig:stop()
end

-- ── Boot ─────────────────────────────────────────────────────────────────────
-- Turn it on by default. Replace this with your weather signal: e.g. a RemoteEvent
-- the server fires when it starts/stops raining → call start()/stop() accordingly.
start()

-- Debug toggle (set Config.DebugToggleKey = nil to remove). This connection is
-- intentionally NOT in runMaid so the key still works after a stop().
if Config.DebugToggleKey then
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end
		if input.KeyCode == Config.DebugToggleKey then
			if running then
				warn("stopped rain")
				stop()
			else
				warn("started rain")
				start()
			end
		end
	end)
end