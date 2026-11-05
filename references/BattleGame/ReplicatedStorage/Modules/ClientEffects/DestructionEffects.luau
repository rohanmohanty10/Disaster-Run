local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local Emit        = VFX.Emit
local TweenCreate = Essentials.Tween     -- re-exported from Essentials
local Ess         = Essentials           -- if you also used Ess.Destroy: VFX.Destroy works

local function scaleSequence(seq: NumberSequence, s: number)
	local keypoints = {}
	for _, kp in seq.Keypoints do
		table.insert(keypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * s, kp.Envelope * s))
	end
	return NumberSequence.new(keypoints)
end

return function(argumentData: any)
	local skillType = argumentData.SkillType

	local function emitClone(clone)
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local duration = v:GetAttribute("EmitDuration")
				if duration then
					v.Enabled = true
					task.delay(duration, function()
						v.Enabled = false
					end)
				end
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end
	end
	
	if skillType == "Bush" then
		local effectCFrames: {CFrame} = argumentData.EffectCFrames
		local effectSizes: {Vector3} = argumentData.EffectSizes
		local folder = script:FindFirstChild("Bush")

		if not effectCFrames then warn("No effect part cframes") end

		if folder and effectCFrames then
			local REFERENCE_SIZE = 3.33

			for i, effectCFrame in effectCFrames do
				local partSize = (effectSizes and effectSizes[i]) or Vector3.one
				local sizeMeasure = (partSize.X + partSize.Y + partSize.Z) / 3
				local scale = math.clamp(sizeMeasure / REFERENCE_SIZE, 0.3, 2.5)

				local holder = Instance.new("Part")
				holder.Anchored = true
				holder.CanCollide = false
				holder.CanQuery = false
				holder.CanTouch = false
				holder.Transparency = 1
				holder.Size = partSize
				holder.CFrame = effectCFrame
				holder.Parent = workspace

				local longestLife = 0
				for _, emitter in ipairs(folder:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						local clone = emitter:Clone()
						clone.Size = scaleSequence(clone.Size, scale)
						clone.Parent = holder

						local duration = clone:GetAttribute("EmitDuration")
						if duration then
							clone.Enabled = true
							task.delay(duration, function()
								clone.Enabled = false
							end)
						else
							local count = clone:GetAttribute("EmitCount") or 10
							clone:Emit(math.max(1, math.round(count * scale)))
						end

						longestLife = math.max(longestLife, (duration or 0) + clone.Lifetime.Max)
					end
				end

				game:GetService("Debris"):AddItem(holder, longestLife + 0.5)
			end
		end
	end
	
	if skillType == "Wood Object" then
		local effectCFrames: {CFrame} = argumentData.EffectCFrames
		local effectSizes: {Vector3} = argumentData.EffectSize
		local folder = script:FindFirstChild("Wood Object")

		if not effectCFrames then warn("No effect part cframes") end

		if folder and effectCFrames then
			local REFERENCE_SIZE = 4.5

			for i, effectCFrame in effectCFrames do
				local partSize = (effectSizes and effectSizes[i]) or Vector3.one
				local sizeMeasure = (partSize.X + partSize.Y + partSize.Z) / 3
				local scale = math.clamp(sizeMeasure / REFERENCE_SIZE, 0.3, 2.5)

				local holder = Instance.new("Part")
				holder.Anchored = true
				holder.CanCollide = false
				holder.CanQuery = false
				holder.CanTouch = false
				holder.Transparency = 1
				holder.Size = partSize
				holder.CFrame = effectCFrame
				holder.Parent = workspace

				local longestLife = 0
				for _, emitter in ipairs(folder:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						local clone = emitter:Clone()
						clone.Size = scaleSequence(clone.Size, scale)
						clone.Parent = holder

						local duration = clone:GetAttribute("EmitDuration")
						if duration then
							clone.Enabled = true
							task.delay(duration, function()
								clone.Enabled = false
							end)
						else
							local count = clone:GetAttribute("EmitCount") or 10
							clone:Emit(math.max(1, math.round(count * scale)))
						end

						longestLife = math.max(longestLife, (duration or 0) + clone.Lifetime.Max)
					end
				end

				game:GetService("Debris"):AddItem(holder, longestLife + 0.5)
			end
		end
	end
	
	if skillType == "Tree" then
		local LeafDebris = require(script.LeafDebris)
		
		
		local REFERENCE_SIZE = 7.123
		local function spawnEffect(folder: Instance, effectCFrame: CFrame, partSize: Vector3?)
			partSize = partSize or Vector3.one
			local sizeMeasure = (partSize.X + partSize.Y + partSize.Z) / 3
			local scale = math.clamp(sizeMeasure / REFERENCE_SIZE, 0.3, 2.5)

			local holder = Instance.new("Part")
			holder.Anchored = true
			holder.CanCollide = false
			holder.CanQuery = false
			holder.CanTouch = false
			holder.Transparency = 1
			holder.Size = partSize
			holder.CFrame = effectCFrame
			holder.Parent = workspace

			local longestLife = 0
			for _, emitter in ipairs(folder:GetDescendants()) do
				if emitter:IsA("ParticleEmitter") then
					local clone = emitter:Clone()
					clone.Size = scaleSequence(clone.Size, scale)
					clone.Parent = holder

					local duration = clone:GetAttribute("EmitDuration")
					if duration then
						clone.Enabled = true
						task.delay(duration, function()
							clone.Enabled = false
						end)
					else
						local count = clone:GetAttribute("EmitCount") or 10
						clone:Emit(math.max(1, math.round(count * scale)))
					end

					longestLife = math.max(longestLife, (duration or 0) + clone.Lifetime.Max)
				end
			end

			game:GetService("Debris"):AddItem(holder, longestLife + 0.5)
		end
		
		local treeFolder = script:FindFirstChild("Tree")
		local sections = argumentData.Sections

		if treeFolder and sections then
			for sectionName, data in sections do
				local folder = treeFolder:FindFirstChild(sectionName)
				if folder and data.CFrames then
					for i, cf in data.CFrames do
						spawnEffect(folder, cf, data.Sizes and data.Sizes[i])
						--if sectionName == "Leaves" then
						--	LeafDebris.burst(cf, (data.Sizes and data.Sizes[i]) or Vector3.one, data.Colors and data.Colors[i])
						--end
					end
				end
			end
		end
	end
end