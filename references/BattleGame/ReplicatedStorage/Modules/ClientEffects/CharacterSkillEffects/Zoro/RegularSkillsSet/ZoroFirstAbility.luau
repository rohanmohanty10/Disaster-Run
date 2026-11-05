--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local Players           = game:GetService("Players")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

--local Effects = ReplicatedStorage.Assets.Effects
local Effects = require(ReplicatedStorage.Modules.ClientEffects.RandomModules.EffectsFunctions).new()
local LocalPlayer      = Players.LocalPlayer


local libraryNew = require(ReplicatedStorage.Modules.ClientEffects.RandomModules3.libraryNew)
local QuickFX    = libraryNew.QuickFX

local Maid = libraryNew.Maid
-- inside FinisherCam, before playFinalExplosion2:
local fxMaid = Maid.new()

local spinVFX = {}

return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType
	local isLocalPlayer   = LocalPlayer.Character == attacker

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

   
	local zoroEffectsNew = script.New
	

	if skillType == "trails" then
		-- glowing trails on both arms and legs for the crow spin (was Client Task's HammerHeelAir "Trails")
		local TrailsTemplate = script:FindFirstChild("Trails")
		if not TrailsTemplate then
			warn("ZoroFirstAbility: put the Trails effect inside this module")
			return
		end
		local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
		for _, LimbName in { "Right Arm", "Left Arm", "Right Leg", "Left Leg" } do
			local Limb = attacker:FindFirstChild(LimbName)
			if Limb then
				local Trails = TrailsTemplate:Clone()
				Trails.Parent = Limb
				task.delay(1.275, function()
					EffectUtilities.ToggleVFX(Trails, false)
				end)
				EffectUtilities.Debris(Trails, 1.425)
			end
		end
		return
	end

	
	if skillType == "spin" then
		local spinParticle = zoroEffectsNew.SpinParticle:Clone()
		spinParticle.Parent        = workspace.World.Debris
		spinParticle.Weld.Part1    = hrp

		local beam = zoroEffectsNew.Beam:Clone()
		beam.Parent     = workspace.World.Debris
		beam.Weld.Part1 = hrp
		
		local beam1 = zoroEffectsNew.Beam1:Clone()
		beam1.Parent     = workspace.World.Debris
		beam1.Weld.Part1 = hrp
		
		local Beam2R = zoroEffectsNew.Beam2:Clone()
		Beam2R.Parent     = workspace.World.Debris
		Beam2R.Weld.Part1 = hrp
		Beam2R.Weld.C0    = Beam2R.Weld.C0 *CFrame.new(-1, 0, 0)
		
		local Beam2L = zoroEffectsNew.Beam2:Clone()
		Beam2L.Parent     = workspace.World.Debris
		Beam2L.Weld.Part1 = hrp
		Beam2L.Weld.C0    = Beam2L.Weld.C0 * CFrame.new(1, 0, 0)
		
		local Beam3R = zoroEffectsNew.Beam3:Clone()
		Beam3R.Parent     = workspace.World.Debris
		Beam3R.Weld.Part1 = hrp
		Beam3R.Weld.C0    = Beam3R.Weld.C0 * CFrame.new(2.5,0,0)

		local Beam3L = zoroEffectsNew.Beam3:Clone()
		Beam3L.Parent     = workspace.World.Debris
		Beam3L.Weld.Part1 = hrp
		Beam3L.Weld.C0    = Beam3L.Weld.C0 * CFrame.new(-2.5,0,0)

		local spinning = true
		spinVFX[attacker] = { spinParticle, beam, beam1, Beam2R, Beam2L, Beam3R, Beam3L, spinning = true }

		VFXFunctions.EnableTime(beam, true, 1)
		VFXFunctions.EnableTime(spinParticle, true, 1.25)
		
		VFXFunctions.EnableTime(beam1, true, 1)
		VFXFunctions.EnableTime(Beam2R, true, 1)
		VFXFunctions.EnableTime(Beam2L, true, 1)
		VFXFunctions.EnableTime(Beam3R, true, 1)
		VFXFunctions.EnableTime(Beam3L, true, 1)


		task.spawn(function()
			while spinVFX[attacker] and spinVFX[attacker].spinning do
				beam.Weld.C0  = beam.Weld.C0  * CFrame.Angles(0.8726646259971648, 0, 0)
				beam1.Weld.C0 = beam1.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				Beam2R.Weld.C0 = Beam2R.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				Beam2L.Weld.C0 = Beam2L.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				Beam3R.Weld.C0 = Beam3R.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				Beam3L.Weld.C0 = Beam3L.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				task.wait()
			end
		end)
		
		
		--local endTime = os.clock() + 2
		--task.spawn(function()
		--	while os.clock() < endTime do
		--		beam.Weld.C0 = beam.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				
		--		beam1.Weld.C0 = beam1.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)

		--		Beam2R.Weld.C0 = Beam2R.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)

		--		Beam2L.Weld.C0 = Beam2L.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)

		--		Beam3R.Weld.C0 = Beam3R.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)
				
		--		Beam3L.Weld.C0 = Beam3L.Weld.C0 * CFrame.Angles(0.8726646259971648, 0, 0)


		--		task.wait()
		--	end
		--end)
		
		
		

		--task.delay(3, function()
		--	VFXFunctions.EnableTime(spinParticle, false)
		--	VFXFunctions.EnableTime(beam, false)
		--	VFXFunctions.EnableTime(beam1, false)
		--	VFXFunctions.EnableTime(Beam2R, false)
		--	VFXFunctions.EnableTime(Beam2L, false)
		--	VFXFunctions.EnableTime(Beam3R, false)
		--	VFXFunctions.EnableTime(Beam3L, false)
			
			
		--end)



	end
	if skillType == "stopSpin" then
		local vfx = spinVFX[attacker]
		if vfx then
			vfx.spinning = false  -- stops the spin loop
			for _, effect in vfx do
				if typeof(effect) == "Instance" then
					VFXFunctions.EnableTime(effect, false)
					
					VFXFunctions.TaskDebris(effect, 3)
					
				end
			end
			spinVFX[attacker] = nil
		end
	end
	
    


	if skillType == "slam" then
		local Slash = script.ZoroFinalSlash:Clone()
		Slash.Parent        = workspace.World.Debris
		Slash.Weld.Part1    = hrp
		
		VFXFunctions.EmitAll(Slash, true)
		
		VFXFunctions.TaskDebris(Slash, 4)
	end
	if skillType == "up" then
		if not isLocalPlayer then return end
		for _,v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end


		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 40000
		BodyVelocity.Velocity = hrp.CFrame.LookVector * 19 + Vector3.new(0, 20, 0) -- was 40 up; halved
		BodyVelocity.Parent = hrp
		Debris:AddItem(BodyVelocity, .65)

		shared.addshake(3)

		local StartTick = tick()
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or tick() - StartTick > 5 then
				StopLoop()
			else
				BodyVelocity.Velocity *= 0.94
			end
		end, 60)
	end

	
	if skillType == "SwordTemp" then
		local rightArm = attacker:FindFirstChild("Right Arm")
		local SwordModel = script.Sword.SandaiSheathTemp:Clone()
		SwordModel.Name = "SandaiSheathTemp"
		SwordModel.Parent = attacker
		
		local Sword = script.Sword.Handle:Clone()
		--local Sword1 = weaponModels.Zoro["Handle"]:Clone()
		Sword.Name = "HandleTemp"
		Sword.Part0 = rightArm
		Sword.Part1 = SwordModel.Right_Hilt
		Sword.Parent = attacker
		Sword.C0 = CFrame.new(-0.073, -1.034, -0.086) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		attacker.SandaiSheathTemp.SwordDec.Transparency = 0
		attacker.ZoroSwords["Shisui"].Sword.Transparency = 1
		attacker.ZoroSwordSheaths["Sandai Kitetsu"].Sheath.Transparency = 1

		--SwordModel.SwordDec.Transparency = 1
	end
	
	if skillType == "SwordTransparent1" then
		print("1")
		attacker.ZoroSwords["Sandai Kitetsu"].Sword.Transparency = 1
		attacker.SandaiSheathTemp.SwordDec.Transparency = 0
	end
	if skillType == "SwordUnTransparent1" then
		print("0")
		attacker.ZoroSwords["Sandai Kitetsu"].Sword.Transparency = 0
		attacker.SandaiSheathTemp.SwordDec.Transparency = 1
	end
	
	if skillType == "SwordDestroy" then
		local swordModel = attacker:FindFirstChild("SandaiSheathTemp")
		if swordModel then swordModel:Destroy() end

		local handle = attacker:FindFirstChild("HandleTemp")
		if handle then handle:Destroy() end
		
		attacker.ZoroSwords["Shisui"].Sword.Transparency = 0
		attacker.ZoroSwordSheaths["Sandai Kitetsu"].Sheath.Transparency = 0
	end
	
	
	
	if skillType == "Afterimages" then
		-- tag controls how long the loop runs
		local tag      = Instance.new("BoolValue")
		tag.Name       = "AfterimageActive"
		tag.Parent     = attacker

		AfterimageTrail(hrp, 0.12, "AfterimageActive")

		-- remove the tag after the finisher window
		task.delay(1.3, function()
			local t = attacker:FindFirstChild("AfterimageActive")
			if t then t:Destroy() end
		end)
	end
	
	if skillType == "FinisherDash" then
		if not isLocalPlayer then return end
		local target = argumentData.Target

		local targetHRP = target:FindFirstChild("HumanoidRootPart")
		if not hrp or not targetHRP then return end

		local targetCFrame = CFrame.lookAt(
			targetHRP.Position + (targetHRP.CFrame.LookVector * -10),
			targetHRP.Position
		) * CFrame.Angles(0, math.rad(180), 0)

		TS:Create(hrp, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			CFrame = targetCFrame
		}):Play()

	end
	
	
	
	if skillType == "FinisherCam" then
		local Tweening         = require(ReplicatedStorage.Modules.ClientEffects.RandomModules.EffectsFunctions.Tweening)
		local VFX              = require(ReplicatedStorage.Modules.ClientEffects.RandomModules.VFX_Utility)
		local Clock            = require(script.Modules.Clock)
		local CameraShaker     = require(ReplicatedStorage.Resources.LegacyReplication.library.CameraShaker)
		local MeshManipulation = require(ReplicatedStorage.Modules.ClientEffects.RandomModules.MeshManipulation)
		local LoopService      = require(script.Modules.LoopService)

		local VFXAssets   = script.FinisherVFX
		local RunService  = game:GetService("RunService")
		local localPlayer = Players.LocalPlayer
		local camera      = workspace.CurrentCamera

		local victim      = argumentData.Target
		local cam         = script.Camera.CutsceneCamera:Clone()
		cam.Parent               = attacker
		cam.root_part.CFrame     = hrp.CFrame
		cam.root_part.Weld.Part0 = hrp
		Debris:AddItem(cam, 4.9)

		local sword       = attacker.ZoroSwords["Sandai Kitetsu"].Sword
		local timeBetween = argumentData.TimeBetween or 0
		local startTime   = argumentData.StartTime   or 0

		if not victim then return end

		local casterPlayer = Players:GetPlayerFromCharacter(attacker)
		local victimPlayer = Players:GetPlayerFromCharacter(victim)
		local isInvolved   = (localPlayer == casterPlayer) or (localPlayer == victimPlayer)

		-- ── helpers ──────────────────────────────────────────────────────────

		local function emitMeshFX(container, cframe)
			for _, child in container:GetChildren() do
				VFX.meshEmit(child.Start, cframe * child.Start.Offset.C0)
			end
		end

		local function fadeBeams(parent, duration, easingStyle, easingDirection)
			for _, beam in pairs(parent:GetDescendants()) do
				if beam:IsA("Beam") then
					if beam.Texture == "rbxassetid://91080988765384" then
						Tweening.TweenProperty(beam, duration / 3, easingStyle, easingDirection, { Width0 = 0, Width1 = 0 }):Play()
						task.delay(duration / 3, function() beam.Enabled = false end)
					else
						Tweening.TweenProperty(beam, duration, easingStyle, easingDirection, { Width0 = 0, Width1 = 0 }):Play()
						task.delay(duration, function() beam.Enabled = false end)
					end
				end
			end
		end

		-- ── camera cinematic (involved players only) ──────────────────────────

		if isInvolved and cam then
			local camTrack = cam.AnimationController.Animator:LoadAnimation(script.Camera.Camera)
			camTrack:Play(0)

			task.delay(math.max(2.5 - timeBetween, 0), function()
				local baseplate = workspace.World.Map.Baseplate
				if baseplate then
					baseplate.Transparency = 1
					baseplate.Texture.Transparency  = 1
					task.delay(2.45, function()
						baseplate.Transparency = 0
						baseplate.Texture.Transparency  = 0

					end)
				end
				--if localPlayer == casterPlayer then
				--	attacker:SetAttribute("IdleMouseLock", true)
				--end

				local renderConn
				local connStart = tick()
				renderConn = RunService.RenderStepped:Connect(function()
					if cam and cam:IsDescendantOf(workspace) and cam:FindFirstChild("FakeCamera") then
						camTrack.TimePosition = Clock.get() - startTime
						--local targetCF = cam.FakeCamera.CFrame * CFrame.new(0, -1, 0)
						local targetCF = cam.FakeCamera.CFrame * CFrame.new(-10, -1, 0)

						if tick() - connStart < 0.1 then
							TS:Create(camera, TweenInfo.new(math.max(0.1 - (tick() - connStart), 0)), { CFrame = targetCF }):Play()
						else
							camera.CFrame = targetCF
						end
					else
						renderConn:Disconnect()
						renderConn = nil
					end
				end)

				pcall(function() victim.Humanoid.HealthCounter.Enabled = false end)

				local victimDisplayType = victim.Humanoid.DisplayDistanceType
				attacker.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				victim.Humanoid.DisplayDistanceType   = Enum.HumanoidDisplayDistanceType.None
				task.delay(2.45, function()
					attacker.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
					pcall(function()
						victim.Humanoid.HealthCounter.Enabled = true
						victim.Humanoid.DisplayDistanceType   = victimDisplayType
					end)
				end)

				camera.CameraType  = Enum.CameraType.Scriptable
				camera.FieldOfView = 70
				task.delay(2.45, function()
					camera.CameraType  = Enum.CameraType.Custom
					camera.FieldOfView = 25
					localPlayer.CameraMinZoomDistance = 20
					localPlayer.CameraMaxZoomDistance = 20
					task.delay(0.1, function()
						localPlayer.CameraMinZoomDistance = game.StarterPlayer.CameraMinZoomDistance
						localPlayer.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
					end)
					TS:Create(camera, TweenInfo.new(0.3), { FieldOfView = 70 }):Play()
					if renderConn then renderConn:Disconnect(); renderConn = nil end
					if localPlayer == casterPlayer then
						task.delay(1.85, function()
							attacker:SetAttribute("IdleMouseLock", false)
						end)
					end
				end)

				-- white → black → white highlight flicker
				local function applyHighlight(model)
					if model and model.PrimaryPart and model:IsDescendantOf(workspace) then
						local highlight = VFXAssets.Finisher.Highlight:Clone()
						Debris:AddItem(highlight, 2.3)
						highlight.Parent  = model
						highlight.Adornee = model
						task.delay(0.75,  function() highlight.FillColor = Color3.fromRGB(0,   0,   0)   end)
						task.delay(1.366, function() highlight.FillColor = Color3.fromRGB(255, 255, 255) end)
					end
				end
				task.delay(0.117, function()
					applyHighlight(attacker)
					applyHighlight(victim)
				end)
			end)
		end

		-- ── pre-spawn final explosion (parked far below until used) ──────────

		--local explosionAssets = VFXAssets.Finisher.FinalExplosion
		local explosionAssets = VFXAssets.FinisherNew.FinalExplosion

		local explosionFX = Effects.ObjectService.CreateEffect("Model", explosionAssets.Finish, CFrame.new(0, -500, 0), workspace.World.Visuals)
		explosionFX:Destroy(math.max(4.95 - timeBetween, 0) + 5)
		task.delay(0.02, function()
			for _, p in explosionFX.Object:GetDescendants() do
				if p:IsA("ParticleEmitter") then
					p:Emit(p:GetAttribute("EmitCount") or 1)
				end
			end
			task.wait(1)
			for _, p in explosionFX.Object:GetDescendants() do
				if p:IsA("ParticleEmitter") then p:Clear() end
			end
		end)

		local function playFinalExplosion()
			if isInvolved then
				--CameraShaker.QuickShake({
				--	magnitude = 17, roughness = 15, fadeInTime = 0, fadeOutTime = 0.65,
				--	posInfluence = Vector3.new(1, 0.5, 0.5), rotInfluence = Vector3.new(0, 0, 0),
				--	players = { localPlayer },
				--})
				game.Lighting.Blur.Size = 27
				TS:Create(game.Lighting.Blur, TweenInfo.new(0.4), { Size = 0 }):Play()
			end

			explosionFX:SetCFrame(hrp.CFrame * CFrame.new(0, 0, -1))
			explosionFX:Emit()
			explosionFX:EmitV2()
			for _, beam in pairs(explosionFX.Object.Main.WindBeams:GetDescendants()) do
				if beam:IsA("Beam") then
					Tweening.TweenProperty(beam, 2.25, "Quad", "Out", { TextureSpeed = -0.2 }):Play()
				end
			end
			explosionFX:DisableBeams(2.25, "Quad", "Out")

			local endBeams = Effects.ObjectService.CreateEffect("ParticlePart", explosionAssets.EndBeams, hrp.CFrame * CFrame.new(0, 0, -140), workspace.World.Visuals)
			fadeBeams(endBeams.Object, 1.75, "Sine", "Out")
			Tweening.TweenProperty(endBeams.Object, 1.75, "Cubic", "Out", {
				CFrame = endBeams.Object.CFrame * CFrame.Angles(0, 0, math.pi),
			}):Play()
			endBeams:Destroy(1.75)

			local windBurst = {
				{
					Iterations = 1,
					Function = function() -- -15 to all
						local lightWind = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.LightWind1, hrp.CFrame * CFrame.new(0, 7, 0) * CFrame.Angles(0, math.random(-math.pi, math.pi), 0), workspace.World.Visuals)
						lightWind.Object.Transparency = 0.965 																				--0
						lightWind:Destroy(MeshManipulation.Wind1(lightWind.Object, 0.0975, 3.5, "Y", "Y", false, false, true))

						local groundSwirl = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.GroundSw, hrp.CFrame * CFrame.new(0, 7, 0), workspace.World.Visuals)
						groundSwirl:Destroy(MeshManipulation.Wind4(groundSwirl.Object, 0.65, 7, "Y", false, false, true)) --0

						local thrust = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.ThrustMesh, hrp.CFrame * CFrame.new(0, 0, -10.5) * CFrame.Angles(0, math.pi, 0), workspace.World.Visuals)
						thrust:Destroy(MeshManipulation.Wind5(thrust.Object, 0.325, 7, "Z", "Z", false, false, true, true))

						local swirl = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.WindSwirl, hrp.CFrame * CFrame.new(0, 0, -7) * CFrame.Angles(math.pi / 2, math.random(-math.pi, math.pi), 0), workspace.World.Visuals)
						swirl:Destroy(MeshManipulation.Wind7(swirl.Object, 0.2275, 7, "Y", "Y", "Y", false, false, true, false)) --7

						local sw = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.SW, hrp.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(math.pi / 2, 0, 0), workspace.World.Visuals)
						sw:Destroy(MeshManipulation.Wind6(sw.Object, 0.325, 7, "Y", false, false, true)) -- -3.5

						local ring1 = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.ring, hrp.CFrame * CFrame.new(0, 0, -63) * CFrame.Angles(-math.pi / 2, math.random(-math.pi, math.pi), 0), workspace.World.Visuals)
						ring1.Object.Mesh.Scale       = ring1.Object.Mesh.Scale * 0.35
						ring1.Object.Decal.Transparency = 0.925
						ring1:Destroy(MeshManipulation.Wind1(ring1.Object, 0.2275, 7, "Y", "Y", true, true, true))

						local ring2 = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.ring, hrp.CFrame * CFrame.new(0, 21, -0) * CFrame.Angles(0, math.random(-math.pi, math.pi), 0), workspace.World.Visuals)
						ring2.Object.Mesh.Scale       = ring2.Object.Mesh.Scale * 0.75      --0
						ring2.Object.Decal.Transparency = 0.925
						ring2:Destroy(MeshManipulation.Wind1(ring2.Object, 0.2275, 3.5, "Y", "Y", true, true, true))

						local lightWind2 = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.LightWind1, hrp.CFrame * CFrame.new(0, 0, -7) * CFrame.Angles(math.pi / 2, math.random(-math.pi, math.pi), 0), workspace.World.Visuals)
						lightWind2:Destroy(MeshManipulation.Wind7(lightWind2.Object, 0.11375, 7, "Y", "Y", "Y", false, false, true, false))  -- -7

						local ring3 = Effects.ObjectService.CreateEffect("FullMesh", explosionAssets.ring3, hrp.CFrame * CFrame.new(0, 0, -52.5) * CFrame.Angles(math.pi / 2, 0, 0), workspace.World.Visuals)
						ring3:Destroy(MeshManipulation.Wind1(ring3.Object, 0.325, -5.25, "Y", "Y", true, true, true))
					end,
				},
			}
			local loop = LoopService.LoopWithFunctions(0.5, windBurst)
			task.delay(0.65, function() loop:EndLoop() end)
		end
		
		local function playFinalExplosion2()
			shared.vfx.emit(QuickFX({
				FX = vfx.LastImpact,
				Maid = fxMaid,
				--Anchor = hrp.CFrame * vfx.LastImpact:GetAttribute("Offset"):Inverse(),
				Anchor = hrp.CFrame * CFrame.Angles(0,math.rad(180),0)*vfx.LastImpact:GetAttribute("Offset"):Inverse()

			}))
			local t = {
				FX = vfx.LastPre,
				Maid = fxMaid
			}
			local v22, v3, v4 = hrp.CFrame:ToOrientation()
			t.Anchor = CFrame.new(victim.Torso.Position) * CFrame.Angles(v22, v3, v4)
			shared.vfx.emit((QuickFX(t)))
		end
		

		-- ── black background ──────────────────────────────────────────────────

		local blackBG = nil
		local function spawnBlackBackground()
			--pcall(VFXFunctions.PlayImpactFrames(script.Frames.BSF_IF, 24, "1"))
			--pcall(VFXFunctions.PlayImpactFrames, localPlayer.PlayerGui.ImpactFrames.BSF_IF, 24, "1")

			local op = OverlapParams.new()
			op.FilterDescendantsInstances = { workspace.World.Live, attacker, victim }
			op.FilterType = Enum.RaycastFilterType.Exclude
			blackBG = VFXAssets.Finisher.BlackBG:Clone()
			Debris:AddItem(blackBG, 2.3)
			blackBG.Transparency = 0
			blackBG.CFrame       = hrp.CFrame
			blackBG.Parent       = workspace
			VFX.hideAreaInRadius(blackBG.Position, 2.3, 110, op)
		end

		-- ── pre-cloned burst parts ────────────────────────────────────────────

		local startFX = VFXAssets.Finisher.Start:Clone()
		Debris:AddItem(startFX, 8)
		--startFX.CFrame = hrp.CFrame * startFX.Offset.C0
		startFX.CFrame = victim.HumanoidRootPart.CFrame * startFX.Offset.C0 --* CFrame.new(0,0,-10)

		startFX.Parent = workspace.World.Visuals
		task.delay(0.02, function()
			for _, p in startFX:GetDescendants() do
				if p:IsA("ParticleEmitter") then p:Emit(1); p:Clear() end
				--print("Played")
			end
		end)

		local starsFX = VFXAssets.Finisher.Stars:Clone()
		Debris:AddItem(starsFX, 8)
		starsFX.CFrame = hrp.CFrame * starsFX.Offset.C0
		starsFX.Parent = workspace.World.Visuals
		task.delay(0.02, function()
			for _, p in starsFX:GetDescendants() do
				if p:IsA("ParticleEmitter") then p:Emit(1); p:Clear() end
			end
		end)

		local whiteFX = VFXAssets.Finisher.White:Clone()
		Debris:AddItem(whiteFX, 8)
		whiteFX.CFrame = hrp.CFrame * whiteFX.Offset.C0
		whiteFX.Parent = workspace.World.Visuals
		task.delay(0.02, function()
			for _, p in whiteFX:GetDescendants() do
				if p:IsA("Beam") then
					p.Enabled = true
					task.delay(0.01, function() p.Enabled = false end)
				elseif p:IsA("ParticleEmitter") then
					p:Emit(1); p:Clear()
				end
			end
		end)

		-- ── after stages ──────────────────────────────────────────────────────

		local function playAfterStage(stage)
			if stage == 1 then
				--startFX.CFrame = hrp.CFrame * startFX.Offset.C0 * CFrame.new(0, 0, 1.5)
				startFX.CFrame =   victim.HumanoidRootPart.CFrame* startFX.Offset.C0 * CFrame.new(0, 0, 10)
				for _, e in startFX:GetDescendants() do VFX.emit_effect(e) end
				--starsFX.CFrame = hrp.CFrame * starsFX.Offset.C0 * CFrame.new(0, 0, 1.5)
				starsFX.CFrame = victim.HumanoidRootPart.CFrame * starsFX.Offset.C0 * CFrame.new(0, 0, 1.5)

				for _, e in starsFX:GetDescendants() do VFX.emit_effect(e) end
				coroutine.wrap(function()
					local startedAt = tick()
					while true do
						for _, bubble in { VFX.bubbleModule.CreateBubble(startFX.CFrame, Vector3.new(25, 25, 25), 6, Vector3.new(0.001, 0.001, 0.001), 0.3) } do
							VFX.bubbleModule(bubble.Start)
						end
						task.wait(0.1)
						if tick() - startedAt >= 0.4 then return end
					end
				end)()

			elseif stage == 2 then
				local afterStars = VFXAssets.Finisher.AfterStars:Clone()
				Debris:AddItem(afterStars, 3)
				afterStars.CFrame  = hrp.CFrame * afterStars.Offset.C0 * CFrame.new(0, 0, 1.5)
				afterStars.Parent  = workspace.World.Visuals
				task.delay(0.02, function()
					for _, e in afterStars:GetDescendants() do
						if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
					end
				end)

			elseif stage == 3 then
				whiteFX.CFrame = hrp.CFrame * whiteFX.Offset.C0 * CFrame.new(0, 0, 1.5)
				for _, e in whiteFX:GetDescendants() do VFX.emit_effect(e) end
				TS:Create(whiteFX.Enemy.B.Beam, TweenInfo.new(0.4), { Width0 = 0, Width1 = 0 }):Play()
				if isInvolved then
					local whiteBG = VFXAssets.Finisher.WhiteBG:Clone()
					Debris:AddItem(whiteBG, 0.384)
					whiteBG.Transparency = 0
					whiteBG.CFrame       = hrp.CFrame
					whiteBG.Parent       = workspace
				end

			elseif stage == 4 then
				local afterWhite = VFXAssets.Finisher.AfterWhite:Clone()
				Debris:AddItem(afterWhite, 3)
				afterWhite.CFrame  = hrp.CFrame * afterWhite.Offset.C0 * CFrame.new(0, 0, 1.5)
				afterWhite.Parent  = workspace.World.Visuals
				task.delay(0.02, function()
					for _, e in afterWhite:GetDescendants() do
						if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
					end
				end)

			elseif stage == 5 then
				local afterWhite2 = VFXAssets.Finisher.AfterWhite2:Clone()
				Debris:AddItem(afterWhite2, 3)
				afterWhite2.CFrame  = hrp.CFrame * afterWhite2.Offset.C0 * CFrame.new(0, 0, 1.5)
				afterWhite2.Parent  = workspace.World.Visuals
				task.delay(0.02, function()
					for _, e in afterWhite2:GetDescendants() do
						if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
					end
				end)
			end
		end

		-- ── timeline (cinematic only, no hit stages) ──────────────────────────

		task.delay(math.max(2.617 - timeBetween, 0), function()
			if isInvolved then spawnBlackBackground() end
			playAfterStage(1)
		end)

		--task.delay(math.max(3.101 - timeBetween, 0), function()
		--	local afterStars = VFXAssets.Finisher.AfterStars:Clone()
		--	Debris:AddItem(afterStars, 3)
		--	afterStars.CFrame  = hrp.CFrame * afterStars.Offset.C0 * CFrame.new(0, 0, 1.5)
		--	afterStars.Parent  = workspace.World.Visuals
		--	task.delay(0.02, function()
		--		for _, e in afterStars:GetDescendants() do
		--			if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
		--		end
		--	end)
		--end)

		--task.delay(math.max(3.384 - timeBetween, 0), function()
		--	emitMeshFX(VFXAssets.Finisher.MeshFX.WhiteTransition, hrp.CFrame)
		--end)

		--task.delay(math.max(3.517 - timeBetween, 0), function()
		--	emitMeshFX(VFXAssets.Finisher.MeshFX.Enable1, hrp.CFrame)
		--	playAfterStage(3)
		--end)

		--task.delay(math.max(3.701 - timeBetween, 0), function()
		--	emitMeshFX(VFXAssets.Finisher.MeshFX.Enable1, hrp.CFrame)
		--	task.wait(0.05)
		--	if isInvolved then
		--		--pcall(VFXFunctions.PlayImpactFrames, localPlayer.PlayerGui.ImpactFrames.BSF_IF, 24, "2")
		--	end
		--end)

		--task.delay(math.max(3.784 - timeBetween, 0), function()
		--	emitMeshFX(VFXAssets.Finisher.MeshFX.Enable1, hrp.CFrame)
		--end)

		--task.delay(math.max(3.867 - timeBetween, 0), function()
		--	emitMeshFX(VFXAssets.Finisher.MeshFX.Enable1, hrp.CFrame)
		--end)

		--task.delay(math.max(3.901 - timeBetween, 0), function()
		--	local afterWhite = VFXAssets.Finisher.AfterWhite:Clone()
		--	Debris:AddItem(afterWhite, 3)
		--	afterWhite.CFrame  = hrp.CFrame * afterWhite.Offset.C0 * CFrame.new(0, 0, 1.5)
		--	afterWhite.Parent  = workspace.World.Visuals
		--	task.delay(0.02, function()
		--		for _, e in afterWhite:GetDescendants() do
		--			if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
		--		end
		--	end)
		--end)

		--task.delay(math.max(4.384 - timeBetween, 0), function()
		--	local afterWhite2 = VFXAssets.Finisher.AfterWhite2:Clone()
		--	Debris:AddItem(afterWhite2, 3)
		--	afterWhite2.CFrame  = hrp.CFrame * afterWhite2.Offset.C0 * CFrame.new(0, 0, 1.5)
		--	afterWhite2.Parent  = workspace.World.Visuals
		--	task.delay(0.02, function()
		--		for _, e in afterWhite2:GetDescendants() do
		--			if not e:IsA("Beam") or isInvolved then VFX.emit_effect(e) end
		--		end
		--	end)
		--end)

		--task.delay(math.max(4.95 - timeBetween, 0), function()
		--	playFinalExplosion() 
		--	playFinalExplosion2() 

		--end)
		
		-- ── faithful FirstEvent replication (MoonEmitter-driven) ────────────────
		-- ── faithful FirstEvent replication (MoonEmitter-driven) ────────────────
		local MoonEmitter = require(game.ReplicatedStorage.Modules.ClientEffects.RandomModules3.MoonEmitter)

		-- Global shift applied to ALL finisher VFX. Tune this one value.
		-- (0,0,-20) = 20 studs forward, (0,0,20) = back, (-20,0,0) = left, (0,-20,0) = down, etc.
		local GLOBAL_SHIFT = CFrame.new(0, 0, 0)

		-- HRP-anchored emit helper (skips missing FX/Offset instead of erroring)
		local function emitAtHRP(name)
			local fx = vfx:FindFirstChild(name)
			if not fx then warn("missing FX:", name); return end
			local off = fx:GetAttribute("Offset")
			local anchor = hrp.CFrame * GLOBAL_SHIFT
			shared.vfx.emit(QuickFX({
				FX = fx,
				Maid = fxMaid,
				Anchor = off and (anchor * off:Inverse()) or anchor,
			}))
		end

		-- Victim-anchored emit helper (also shifted)
		local function emitAtVictim(name)
			local fx = vfx:FindFirstChild(name)
			if not fx then warn("missing FX:", name); return end
			local rx, ry, rz = hrp.CFrame:ToOrientation()
			local anchor = CFrame.new(victim.Torso.Position) * CFrame.Angles(rx, ry, rz) * GLOBAL_SHIFT
			shared.vfx.emit(QuickFX({ FX = fx, Maid = fxMaid, Anchor = anchor }))
		end

		local meshEmitter = fxMaid:give(vfx["mrkewlnew2 MeshEmitter"]:Clone())
		local meshOffset = meshEmitter:GetAttribute("Offset")
		if meshOffset then
			meshEmitter:PivotTo(hrp.CFrame * GLOBAL_SHIFT * meshOffset:Inverse())
		else
			meshEmitter:PivotTo(hrp.CFrame * GLOBAL_SHIFT)
		end

		local moon = MoonEmitter.new(meshEmitter)
		print("Moon len:", moon:GetLength(), "PrimaryPart:", meshEmitter.PrimaryPart)
		moon:Play()

		task.delay(0.05, function()
			meshEmitter.Parent = workspace.World.Visuals  -- EFP equivalent
		end)

		-- frame 34 (0.567s): Slash1 + the emitter's own FirstSlashmesh
		moon:AddFrameEvent(function()
			emitAtHRP("Slash1")
			shared.vfx.emit(meshEmitter.VFX.FirstSlashmesh)
		end, 34)

		-- frame 38 (0.633s): BeamSlash
		moon:AddFrameEvent(function() emitAtHRP("BeamSlash") end, 38)

		-- frame 92 (1.533s): spark on the katana
		moon:AddFrameEvent(function()
			local katana = attacker:FindFirstChild("Sandai Kitetsu")
			if not katana then return end
			local spark = fxMaid:give(vfx.spark:Clone())
			spark.Parent = katana.Main
			shared.vfx.emit(spark)
		end, 92)

		-- frame 96 (1.600s): windstart
		moon:AddFrameEvent(function() emitAtHRP("windstart") end, 96)

		-- frame 102 (1.700s): Pre on the katana
		moon:AddFrameEvent(function()
			local katana = attacker:FindFirstChild("#KATANAWEAPON")
			if not katana then return end
			local pre = fxMaid:give(vfx.Pre:Clone())
			pre.Parent = katana.Main
			shared.vfx.emit(pre)
		end, 102)

		-- frame 126 (2.100s): PreFull
		moon:AddFrameEvent(function() emitAtHRP("PreFull") end, 126)

		-- frame 147 (2.450s): Impale1
		moon:AddFrameEvent(function() emitAtHRP("Impale1") end, 147)

		-- frame 153 (2.550s): superslash
		--moon:AddFrameEvent(function() emitAtHRP("superslash") end, 153)

		-- frame 155 (2.583s): Pre2
		--moon:AddFrameEvent(function() emitAtHRP("Pre2") end, 155)

		-- frame 157 (2.617s): delaySlash at victim
		moon:AddFrameEvent(function() emitAtVictim("delaySlash") end, 157)

		-- frame 265 (4.417s): SuperlSAt at victim
		moon:AddFrameEvent(function() emitAtVictim("SuperlSAt") end, 265)

		-- frame 310 (5.167s): LastPre at victim
		moon:AddFrameEvent(function() emitAtVictim("LastPre") end, 310)

		-- frame 327 (5.450s): LastImpact
		moon:AddFrameEvent(function() emitAtHRP("LastImpact") end, 327)
		
		
	end
	
	
end