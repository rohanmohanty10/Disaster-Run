--[[
	LowGraphics (LocalScript)

	The "Low Graphics" setting (Settings menu). While it's on: no shadows, no bloom / sun rays /
	depth of field, a thinner atmosphere, and fewer particles and less dust from destruction
	(it also turns the existing "Destruction Physics" dust off for you). Turning it off puts
	everything back the way the place had it.
]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Configuration = Player:WaitForChild("Configuration")
local Setting: BoolValue = Configuration:WaitForChild("Low Graphics")

local PARTICLE_SCALE = 0.35 -- emitters keep this share of their particles

local Saved = {
	GlobalShadows = Lighting.GlobalShadows,
	Effects = {}, -- [PostEffect] = Enabled
	AtmosphereDensity = {}, -- [Atmosphere] = Density
}
local ScaledEmitters = setmetatable({}, { __mode = "k" }) -- [ParticleEmitter] = original Rate
local EmitterConnection: RBXScriptConnection? = nil

local function ScaleEmitter(Emitter: Instance)
	if Emitter:IsA("ParticleEmitter") and not ScaledEmitters[Emitter] then
		ScaledEmitters[Emitter] = Emitter.Rate
		Emitter.Rate *= PARTICLE_SCALE
	end
end

local function Apply(Low: boolean)
	if Low then
		Lighting.GlobalShadows = false
		for _, Effect in Lighting:GetChildren() do
			if Effect:IsA("BloomEffect") or Effect:IsA("SunRaysEffect") or Effect:IsA("DepthOfFieldEffect") then
				if Saved.Effects[Effect] == nil then
					Saved.Effects[Effect] = Effect.Enabled
				end
				Effect.Enabled = false
			elseif Effect:IsA("Atmosphere") then
				if Saved.AtmosphereDensity[Effect] == nil then
					Saved.AtmosphereDensity[Effect] = Effect.Density
				end
				Effect.Density = Saved.AtmosphereDensity[Effect] * 0.5
			end
		end
		for _, Emitter in workspace:GetDescendants() do
			ScaleEmitter(Emitter)
		end
		if not EmitterConnection then
			EmitterConnection = workspace.DescendantAdded:Connect(ScaleEmitter)
		end
	else
		Lighting.GlobalShadows = Saved.GlobalShadows
		for Effect, Enabled in Saved.Effects do
			if Effect.Parent then
				Effect.Enabled = Enabled
			end
		end
		for Atmosphere, Density in Saved.AtmosphereDensity do
			if Atmosphere.Parent then
				Atmosphere.Density = Density
			end
		end
		table.clear(Saved.Effects)
		table.clear(Saved.AtmosphereDensity)
		if EmitterConnection then
			EmitterConnection:Disconnect()
			EmitterConnection = nil
		end
		for Emitter, Rate in ScaledEmitters do
			if Emitter.Parent then
				Emitter.Rate = Rate
			end
		end
		table.clear(ScaledEmitters)
	end

	-- DebreeController reads "Destruction Physics" for its dust; it's local-only, so set it here
	local Dust = Configuration:FindFirstChild("Destruction Physics")
	if Dust and Dust:IsA("BoolValue") then
		Dust.Value = not Low
	end
end

Setting.Changed:Connect(Apply)
Apply(Setting.Value)
