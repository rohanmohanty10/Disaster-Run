--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)


return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
        local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
        local rootCFrame = rootPart.CFrame
        for _, v in ipairs(cloneFolder:GetDescendants()) do
            if v:IsA("BasePart") then
                local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
                v.CFrame = facingCFrame * relativeOffset
            end
        end
    end

    local function getFacingCFrame(torso, offset)
        local look = torso.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z).Unit
        return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
    end

    local function emitClone(clone)
        for _, v in ipairs(clone:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                local duration = v:GetAttribute("EmitDuration")
                if duration then
                    v.Enabled = true
                    task.delay(duration, function()
                        v.Enabled = false
                    end)
                else
                    v:Emit(v:GetAttribute("EmitCount"))
                end
            end
        end
	end
	
	
	if skillType == "jump" then
		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (55 * 0.8) -- start tapered
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.8
		local removeTime = .7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 55 * taper
			end
		end, 60)
	end
	if skillType == "jump2" then
		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (80 * 0.6) -- start tapered
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.6
		local removeTime = .7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 100 * taper
			end
		end, 60)
	end
	
	
	
	if skillType == "hit2" then
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * (50 * 0.49)
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (80 * 0.49)

		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.49
		local removeTime = 0.39
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				--BodyVelocity.Velocity = hrp.CFrame.LookVector * 30 * taper
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 80 * taper

			end
		end, 60)
	end
	
	if skillType == "hit3" then
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * (50 * 0.49)
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (80 * 0.49)

		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.49
		local removeTime = 0.39
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				--BodyVelocity.Velocity = hrp.CFrame.LookVector * 30 * taper
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 80 * taper

			end
		end, 60)
	end
	if skillType == "hit4" then
		
		
		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 20000, 40000) -- Y enabled to fight gravity
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (55 * 0.8) + Vector3.new(0, workspace.Gravity * 0.1, 0) -- counteract gravity
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.8
		local removeTime = 0.7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				-- keep counteracting gravity while tapering forward movement
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 55 * taper + Vector3.new(0, workspace.Gravity * 0.1, 0)
			end
		end, 60)
	end
	if skillType == "hit5" then
		--for _, v in hrp:GetChildren() do
		--	if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
		--		v:Destroy()
		--	end
		--end

		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * (55 * 0.8) -- start tapered
		--BodyVelocity.Parent = hrp

		--local start = os.clock()
		--local duration = 0.8
		--local removeTime = .7
		--local StopLoop = nil
		--StopLoop = shared.loop(function()
		--	if not BodyVelocity.Parent or os.clock() - start > removeTime then
		--		if BodyVelocity.Parent then BodyVelocity:Destroy() end
		--		StopLoop()
		--	else
		--		local taper = math.max(0, duration - (os.clock() - start) / duration)
		--		BodyVelocity.Velocity = hrp.CFrame.LookVector * 55 * taper
		--	end
		--end, 60)
		
		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 20000, 40000) -- Y enabled to fight gravity
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (55 * 0.8) + Vector3.new(0, workspace.Gravity * 0.1, 0) -- counteract gravity
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.8
		local removeTime = 0.7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				-- keep counteracting gravity while tapering forward movement
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 55 * taper + Vector3.new(0, workspace.Gravity * 0.1, 0)
			end
		end, 60)
	end
	
	if skillType == "hit4New" then


		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 3000, 40000) -- Y enabled to fight gravity
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (30 * 0.8) + Vector3.new(0, workspace.Gravity * 0.1, 0) -- counteract gravity
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.8
		local removeTime = 0.7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				-- keep counteracting gravity while tapering forward movement
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 30 * taper + Vector3.new(0, workspace.Gravity * 0.1, 0)
			end
		end, 60)
	end
	if skillType == "hit5New" then
		--for _, v in hrp:GetChildren() do
		--	if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
		--		v:Destroy()
		--	end
		--end

		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * (55 * 0.8) -- start tapered
		--BodyVelocity.Parent = hrp

		--local start = os.clock()
		--local duration = 0.8
		--local removeTime = .7
		--local StopLoop = nil
		--StopLoop = shared.loop(function()
		--	if not BodyVelocity.Parent or os.clock() - start > removeTime then
		--		if BodyVelocity.Parent then BodyVelocity:Destroy() end
		--		StopLoop()
		--	else
		--		local taper = math.max(0, duration - (os.clock() - start) / duration)
		--		BodyVelocity.Velocity = hrp.CFrame.LookVector * 55 * taper
		--	end
		--end, 60)

		for _, v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(40000, 3000, 40000) -- Y enabled to fight gravity
		BodyVelocity.Velocity = hrp.CFrame.LookVector * (30 * 0.8) + Vector3.new(0, workspace.Gravity * 0.1, 0) -- counteract gravity
		BodyVelocity.Parent = hrp

		local start = os.clock()
		local duration = 0.8
		local removeTime = 0.7
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or os.clock() - start > removeTime then
				if BodyVelocity.Parent then BodyVelocity:Destroy() end
				StopLoop()
			else
				local taper = math.max(0, duration - (os.clock() - start) / duration)
				-- keep counteracting gravity while tapering forward movement
				BodyVelocity.Velocity = hrp.CFrame.LookVector * 30 * taper + Vector3.new(0, workspace.Gravity * 0.1, 0)
			end
		end, 60)
	end
	
	if skillType == "hit6" then
		for _,v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end


		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 20000
		BodyVelocity.Velocity = hrp.CFrame.LookVector * 15 + Vector3.new(0, 35, 0)
		BodyVelocity.Parent = hrp
		Debris:AddItem(BodyVelocity, .5)

		shared.addshake(3)

		local StartTick = tick()
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or tick() - StartTick > 5 then
				StopLoop()
			else
				BodyVelocity.Velocity *= 0.95
			end
		end, 60)
	end
    
	if skillType == "move" then
		for _,v in hrp:GetChildren() do
			if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
				v:Destroy()
			end
		end


		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(1, .5, 1) * 40000
		BodyVelocity.Velocity = hrp.CFrame.LookVector * 57 + Vector3.new(0, 35, 0)
		BodyVelocity.Parent = hrp
		Debris:AddItem(BodyVelocity, 0.4)

		shared.addshake(3)

		local StartTick = tick()
		local StopLoop = nil
		StopLoop = shared.loop(function()
			if not BodyVelocity.Parent or tick() - StartTick > 5 then
				StopLoop()
			else
				BodyVelocity.Velocity *= 0.875
			end
		end, 60)
		--task.wait(.4)
		--for _,v in hrp:GetChildren() do
		--	if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
		--		v:Destroy()
		--	end
		--end


		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.MaxForce = Vector3.new(1, .75, 1) * 40000
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * 57 + Vector3.new(0, 80, 0)
		--BodyVelocity.Parent = hrp
		--Debris:AddItem(BodyVelocity, 0.4)

		--shared.addshake(3)

		--local StartTick = tick()
		--local StopLoop = nil
		--StopLoop = shared.loop(function()
		--	if not BodyVelocity.Parent or tick() - StartTick > 5 then
		--		StopLoop()
		--	else
		--		BodyVelocity.Velocity *= 0.87
		--		--BodyVelocity.Velocity *= 0.75

		--	end
		--end, 60)
		--task.wait(.15)
		--for _,v in hrp:GetChildren() do
		--	if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") then
		--		v:Destroy()
		--	end
		--end


		--local BodyVelocity = Instance.new("BodyVelocity")
		--BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 40000
		--BodyVelocity.Velocity = hrp.CFrame.LookVector * 19 + Vector3.new(0, 40, 0)
		--BodyVelocity.Parent = hrp
		--Debris:AddItem(BodyVelocity, 1)

		--shared.addshake(3)

		--local StartTick = tick()
		--local StopLoop = nil
		--StopLoop = shared.loop(function()
		--	if not BodyVelocity.Parent or tick() - StartTick > 5 then
		--		StopLoop()
		--	else
		--		BodyVelocity.Velocity *= 0.96
		--	end
		--end, 60)

	end

	if skillType == "barrage" then
		
		local startTime = os.clock()
		local duration = .5
		
		task.spawn(function()
			while os.clock() - startTime < duration do
				local hitPosition = hrp.CFrame * CFrame.new(0, -4, -6) -- point in front of character, tweak the -4

				local WindLines = script.WindLines:Clone()
				WindLines.CFrame = CFrame.new(hitPosition.p, hrp.CFrame.p) * CFrame.Angles(math.rad(90), math.rad(0), 0) 
				WindLines.Parent = workspace.World.Debris

				WindLines.Anchored = false
				local weld = Instance.new("Weld")
				weld.Part0 = hrp
				weld.Part1 = WindLines
				weld.C0 = CFrame.new(0, -2, -4) * CFrame.Angles(math.rad(65), 0, 0)
				weld.Parent = WindLines

				for _, v in ipairs(WindLines:GetDescendants()) do
					if v:IsA("ParticleEmitter") then
						v:Emit(v:GetAttribute("EmitCount"))
					end
				end

				Debris:AddItem(WindLines, .35)

				local HitLines = script.HitLines:Clone()
				--HitLines.CFrame = CFrame.new(hitPosition.p, hrp.CFrame.p) * CFrame.Angles(math.rad(90), math.rad(0), 0) 
				HitLines.Parent = workspace.World.Debris

				HitLines.Anchored = false
				local weld = Instance.new("Weld")
				weld.Part0 = hrp
				weld.Part1 = HitLines
				weld.C0 = CFrame.new(0, 0, -1.5) * CFrame.Angles(math.rad(65), 0, 0)
				weld.Parent = HitLines

				for _, v in ipairs(HitLines:GetDescendants()) do
					if v:IsA("ParticleEmitter") then
						v:Emit(v:GetAttribute("EmitCount"))
					end
				end

				Debris:AddItem(HitLines, .25)

				task.wait(.05)
			end
		end)
		
		task.spawn(function()
			while os.clock() - startTime < duration do
				local Torso = attacker:FindFirstChild("Torso") or hrp
				local source = script.BarragePunches

				local clone = source:Clone()
				clone.Anchored = false
				clone.Parent = workspace.World.Visuals

				local weld = Instance.new("Weld")
				weld.Part0 = hrp
				weld.Part1 = clone
				weld.C0 = CFrame.new(0, -3, -3) * CFrame.new(0, math.pi, 0)-- offset in front of the character
				weld.Parent = clone -- weld should be parented to Part0

				emitClone(clone)
				Debris:AddItem(clone, 2)
				
				task.wait(.15)
			end
		end)
    end
end