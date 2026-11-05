--!strict
-- AudioManager.luau
-- Full outdoor rain when exposed; ducked + EQ-muffled outdoor plus roof patter
-- when protected. Also overlays wet footstep sounds while exposed and moving.

local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local Config = require(script.Parent.Config)
local Types = require(script.Parent.Types)
local Maid = require(script.Parent.Maid)

local AudioManager = {}
AudioManager.__index = AudioManager

export type AudioManager = typeof(setmetatable(
	{} :: {
		_maid: Maid.Maid,
		_charMaid: Maid.Maid,
		_outdoor: Sound?,
		_roof: Sound?,
		_eq: EqualizerSoundEffect?,
		_stepSounds: { Sound },
		_activeTweens: { Tween },
		_humanoid: Humanoid?,
		_moveSpeed: number,
		_stride: number,
		_state: Types.RainState,
	},
	AudioManager
	))

function AudioManager.new(): AudioManager
	local self = setmetatable({}, AudioManager) :: AudioManager
	self._maid = Maid.new()
	self._charMaid = Maid.new()
	self._stepSounds = {}
	self._activeTweens = {}
	self._moveSpeed = 0
	self._stride = 0
	self._state = "Exposed"
	return self
end

local function makeLoop(id: string, volume: number, parent: Instance): Sound
	local s = Instance.new("Sound")
	s.SoundId = id
	s.Looped = true
	s.Volume = volume
	s.Parent = parent -- parented under SoundService → plays as 2D ambient
	return s
end

function AudioManager.start(self: AudioManager)
	local folder = Instance.new("Folder")
	folder.Name = "RainAudio"
	folder.Parent = SoundService
	self._maid:give(folder)

	local outdoor = makeLoop(Config.Audio.OutdoorSoundId, Config.Audio.OutdoorVolume, folder)
	local roof = makeLoop(Config.Audio.RoofSoundId, 0, folder)

	-- EQ lives on the outdoor loop so we can muffle the highs when indoors.
	local eq = Instance.new("EqualizerSoundEffect")
	eq.LowGain = 0
	eq.MidGain = 0
	eq.HighGain = 0
	eq.Parent = outdoor

	for _, id in Config.Audio.StepSoundIds do
		local step = Instance.new("Sound")
		step.SoundId = id
		step.Volume = Config.Audio.StepVolume
		step.Parent = folder
		table.insert(self._stepSounds, step)
	end

	self._outdoor = outdoor
	self._roof = roof
	self._eq = eq
	outdoor:Play()
	roof:Play()

	-- Footstep stride accumulator: only while exposed, grounded and moving.
	self._maid:give(RunService.Heartbeat:Connect(function(dt)
		if self._state ~= "Exposed" or self._moveSpeed < 1 then
			self._stride = 0
			return
		end
		local hum = self._humanoid
		if not hum or hum.FloorMaterial == Enum.Material.Air then
			self._stride = 0
			return
		end
		self._stride += self._moveSpeed * dt
		if self._stride >= Config.Audio.StepStride then
			self._stride -= Config.Audio.StepStride
			self:_playWetStep()
		end
	end))
end

function AudioManager.setCharacter(self: AudioManager, character: Model?)
	self._charMaid:clean() -- drop the previous character's hooks
	self._humanoid = nil
	self._moveSpeed = 0
	if not character then
		return
	end
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		self._humanoid = hum
		self._charMaid:give(hum.Running:Connect(function(speed)
			self._moveSpeed = speed
		end))
	end
end

function AudioManager._playWetStep(self: AudioManager)
	local sounds = self._stepSounds
	if #sounds == 0 then
		return
	end
	local snd = sounds[math.random(1, #sounds)]
	snd.PlaybackSpeed = 0.9 + math.random() * 0.2 -- slight variation per step
	snd.TimePosition = 0
	snd:Play()
end

function AudioManager._tween(self: AudioManager, inst: Instance, props: { [string]: any })
	local tw = TweenService:Create(
		inst,
		TweenInfo.new(Config.Audio.TweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	)
	table.insert(self._activeTweens, tw)
	tw:Play()
end

function AudioManager._cancelTweens(self: AudioManager)
	for _, tw in self._activeTweens do
		tw:Cancel()
	end
	table.clear(self._activeTweens)
end

function AudioManager.setState(self: AudioManager, state: Types.RainState)
	self._state = state
	local outdoor, roof, eq = self._outdoor, self._roof, self._eq
	if not (outdoor and roof and eq) then
		return
	end
	self:_cancelTweens()

	local a = Config.Audio
	if state == "Protected" then
		self:_tween(outdoor, { Volume = a.OutdoorMuffledVolume })
		self:_tween(eq, { HighGain = a.MuffledHighGain, MidGain = a.MuffledMidGain })
		self:_tween(roof, { Volume = a.RoofVolume })
	else
		self:_tween(outdoor, { Volume = a.OutdoorVolume })
		self:_tween(eq, { HighGain = 0, MidGain = 0 })
		self:_tween(roof, { Volume = 0 })
	end
end

function AudioManager.stop(self: AudioManager)
	self:_cancelTweens()
	self._charMaid:clean()
	self._maid:clean()
	self._outdoor, self._roof, self._eq = nil, nil, nil
	self._humanoid = nil
	table.clear(self._stepSounds)
end

return AudioManager