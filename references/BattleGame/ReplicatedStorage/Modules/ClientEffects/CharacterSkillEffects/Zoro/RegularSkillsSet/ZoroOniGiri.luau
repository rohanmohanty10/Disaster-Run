--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local Players           = game:GetService("Players")


local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local SlashModule = require(script.SlashModule)
local FloorTrail = require(ReplicatedStorage.Modules.ClientEffects.FloorTrail)
local Effects = ReplicatedStorage.Assets.Effects
local LocalPlayer      = Players.LocalPlayer


local spinVFX = {}

return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType
	local isLocalPlayer   = LocalPlayer.Character == attacker

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    
	local function hideThenFadeIn(character)
		local partsToFade = {}

		for _, part in character:GetDescendants() do
			if part:IsA("BasePart") and part.Transparency == 0 then
				part.Transparency = 1
				table.insert(partsToFade, { part = part, instant = part.Name == "Head" })
			elseif part:IsA("Decal") and part.Transparency == 0 then
				part.Transparency = 1
				table.insert(partsToFade, { part = part, instant = true })
			end
		end

		task.delay(0.135, function()
			for _, entry in partsToFade do
				if not entry.part.Parent then continue end
				if entry.instant then
					entry.part.Transparency = 0
				else
					TS:Create(entry.part, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Transparency = 0,
					}):Play()
				end
			end
		end)
	end
	local function flickerCharacter(character)
		for _, part in character:GetDescendants() do
			local isVisible = (part:IsA("BasePart") or part:IsA("Decal")) and part.Transparency == 0
			if isVisible then
				part.Transparency = 1
				task.delay(0.07, function()
					part.Transparency = 0
				end)
			end
		end
	end
	
	local function spawnVFX(vfxTemplate, cframe, lifetime)
		local clone = vfxTemplate:Clone()
		clone.CFrame = cframe
		clone.Parent = workspace.World.Debris
		VFXFunctions.EmitDescendants(clone)
		Debris:AddItem(clone, lifetime)
		return clone
	end
	
	--local zoroEffects = Effects.Zoro.RegularAbilities.FirstAbility
	--local zoroEffectsNew = Effects.Zoro.RegularAbilities.FirstAbility.New
	
    if skillType == "start" then
        
		
		--local startTime     = os.clock()
		--local lastFlicker   = os.clock()
		local affectedParts = {}

		--while true do
		--	-- Flicker every 0.08 seconds
		--	if os.clock() - lastFlicker >= 0.08 then
		--		lastFlicker = os.clock()
		--		flickerCharacter(attacker)
		--	end

		--	task.wait()

		--	-- Stop after 0.45 seconds and restore full visibility
		--	if os.clock() - startTime > 0.45 then
		--		for _, part in affectedParts do
		--			if part:IsA("BasePart") then
		--				part.Transparency = 0
		--			end
		--		end
		--		return
		--	end
		--end
		
		
		task.spawn(function()
			local startTime   = os.clock()
			local lastFlicker = os.clock()
			while true do
				if os.clock() - lastFlicker >= 0.08 then
					lastFlicker = os.clock()
					flickerCharacter(attacker)
				end
				task.wait()
				if os.clock() - startTime > 0.45 then return end
					
			end
		end)
		
        
	end
	
	if skillType == "OniGiri" then
		local attackerLook = argumentData.attackerLook
		local atkCFrame
		if attackerLook then
			local flat = Vector3.new(attackerLook.X, 0, attackerLook.Z)
			if flat.Magnitude > 0.01 then
				atkCFrame = CFrame.lookAlong(hrp.Position, flat.Unit)
			else
				atkCFrame = hrp.CFrame
			end
		else
			atkCFrame = hrp.CFrame
		end
		
		
		atkCFrame = atkCFrame * CFrame.new(0, 0, 0)
		SlashModule.Play(script.OniGiriNew, attacker, atkCFrame, isLocalPlayer)
	end
	
	if skillType == "Lines" then
		local atkCFrame = argumentData.attackerCFrame
		-- flatten if you don't want vertical tilt:
		local look = atkCFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		atkCFrame = flat.Magnitude > 0.01 and CFrame.lookAlong(atkCFrame.Position, flat.Unit) or atkCFrame
		
		for _, sign in { -1, 1 } do
			local dir = (atkCFrame * CFrame.Angles(0, math.rad(15) * sign, 0)).LookVector
			dir = Vector3.new(dir.X, 0, dir.Z).Unit

			local size = 40       
			local mover = Instance.new("Part")
			mover.Anchored, mover.CanCollide, mover.CanQuery = true, false, false
			mover.Transparency = 1
			mover.Size = Vector3.one * 0.1
			mover.CFrame = CFrame.new(atkCFrame.Position - dir * (size / 2))
			mover.Parent = workspace.World.Visuals

			local duration = .15
			FloorTrail.Start({
				Object = mover,
				Duration = .2,
				MoveThreshold = .5,  -- segment spacing
				Width = .15, 
				GrowTime = .5,
				StartColor = Color3.fromRGB(255, 71, 15),
				EndColor = Color3.fromRGB(0, 0, 0),
				FadeDelay = 0.8,                          -- rolling fade; omit to fade all at end
				FadeTime = 0.5,
			})

			TS:Create(mover, TweenInfo.new(duration, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(atkCFrame.Position + dir * (size / 2)) }):Play()
			Debris:AddItem(mover, duration + 0.2) -- mover leaves workspace → loop breaks → segments fade
		end
	end
	
	
	
end