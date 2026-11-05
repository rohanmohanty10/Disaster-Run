--Replicated Storage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityThree
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players           = game:GetService("Players")


local LocalPlayer      = Players.LocalPlayer

local Assets = ReplicatedStorage:WaitForChild("Assets")
local Effects = Assets:WaitForChild("Effects")
local VFXFunctions     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local GroundRocks = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler:WaitForChild("GroundRocks"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Modules = ReplicatedStorage:WaitForChild("Modules")

local activeFX = {}

--Variables
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)


local RandomSeed = Random.new()

local DefaultFilter = { workspace.World.Live, workspace.World.Debris }


local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = {
	workspace.World.Map,
	--workspace.Map:WaitForChild("Miscellaneous"), 
	--workspace.Map.Borders, 
	--workspace.Map:WaitForChild("Destroyable"):WaitForChild("Buildings")
}

local function performRaycast(rayData)
	local orig = rayData.orig
	local dir = rayData.dir
	local raycastParams = RaycastParams.new()

	raycastParams.FilterDescendantsInstances = rayData.Whitelist or rayData.Ignore or DefaultFilter
	if rayData.Whitelist then
		raycastParams.FilterType = Enum.RaycastFilterType.Include
	else
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	end

	if rayData.Blockcast then
		local result = workspace:Blockcast(orig, rayData.Blockcast, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	else
		local result = workspace:Raycast(orig, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	end
end


--For sanji ability 4
return function(Params: any) --Got this from default in server script services.
	local character:Model = Params.Attacker --The character btw.
	local humanoid: Humanoid = character:FindFirstChild("Humanoid")

	local skillType = Params.SkillType
	local isLocalPlayer   = LocalPlayer.Character == character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end


	local table1 = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

	local activeTweens = table1
	
	local function cleanup()
		for _, tween in ipairs(activeTweens) do
			tween:Cancel()
		end
		table.clear(activeTweens)
	end
	
	local Velocity = require(ReplicatedStorage.Modules.Velocity2)
	if skillType == "useTwice" then
		local player = Params.Player
		if player == LocalPlayer then
			--AnimationService.stop_humanoid_anims(humanoid, 0.1)
			--VFX.anim = AnimationService.play_anim(character, animations.Base[Utility.Name].Player, { start_time = st })

			-- Dash toward the victim, spitting out rush meshes along the way.
			local camera      = workspace.CurrentCamera
			local time_between = Params.time_between or .1
			local meshTimer = 0
			print("Reached the client")
			local bodyMover1, bodyMover2 = Velocity.bezier(
				rootPart,
				Params.Enemy.HumanoidRootPart,
				CFrame.new(-15, 10, 0),
				math.max(.3, 0), --				math.max(37/60 - time_between, 0),
				Enum.EasingStyle.Sine, Enum.EasingDirection.Out,
				CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
				false,
				function(currentCF, _, dt)
					local faceCF = CFrame.lookAt(rootPart.CFrame.Position, currentCF.Position) * CFrame.Angles(0, -math.pi/2, 0)
					meshTimer = meshTimer + dt
					if meshTimer > 1/12 then
						--emitMeshSet(faceCF, vfx.Rush)
						meshTimer = 0
					end
				end
			)

			TS:Create(camera, TweenInfo.new(1/3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true), {
				FieldOfView = 50,
			}):Play()
			print("Reached the client2")

			--StunService:ListenToHeavyStun(character, math.max(37/60 - time_between, 0), function()
			--	if bodyMover1 or bodyMover2 then
			--		bodyMover1:Destroy()
			--		bodyMover2:Destroy()
			--	end
			--	localHrp.AssemblyLinearVelocity = Vector3.zero
			--end)

			--task.delay(math.max(37/60 - time_between, 0), function()
			--	CameraShaker.QuickShake({
			--		magnitude = 17, roughness = 12,
			--		fadeInTime = 0, fadeOutTime = 0.45,
			--		posInfluence = Vector3.new(1, 1, 1),
			--		rotInfluence = Vector3.new(0, 0, 0),
			--		players = { localPlayer },
			--	})
			--end)
		end

		--Sound.Play(sfxAssets.Base[Utility.Name].Spin, character.Torso).TimePosition = time_between
		--MilkVFX.Highlight.tweenHighlight(character, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 1, Enum.HighlightDepthMode.Occluded, "In", 0.3)

		--local launch = vfx.Attachments.Launch:Clone()
		--launch.Parent = hrp
		--MilkVFX.Particles.emitParticles(launch)
		--task.delay(4, launch.Destroy, launch)

		---- Spin trail on the torso + jump trails on both arms.
		--local trailDuration = math.max(37/60 - time_between, 0)
		--local spin = attachParticleEmitter(character.Torso, vfx.Attachments.Spin, trailDuration, false)
		--attachParticleEmitter(character["Left Arm"], vfx.Attachments.JumpTrail, trailDuration, false)
		--attachParticleEmitter(character["Right Arm"], vfx.Attachments.JumpTrail, trailDuration, false)

		--task.delay(trailDuration, function()
		--	if spin then
		--		local land = vfx.Attachments.Land:Clone()
		--		land.Parent = hrp
		--		MilkVFX.Particles.emitParticles(land)
		--		task.delay(4, land.Destroy, land)
		--	end
		--end)
	end
end