--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local activeProjectiles = {}

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
                    v:Emit(v:GetAttribute("EmitCount") or 1)
                end
            end
        end
    end
	
	if skillType == "hold" then
		local Torso = attacker:FindFirstChild("Torso") or hrp
		local Arm = attacker:FindFirstChild("Right Arm")
		local source = ReplicatedStorage.Assets.Effects.Ace.FlameFist.Arm

		local clone = source:Clone()

		clone["Images/15 (1)"].Parent = Arm
		clone["Images/15 (2)"].Parent = Arm
		clone.Attachment.Parent = Arm:FindFirstChild("RightGripAttachment")
		--clone.Attachment.CFrame = CFrame.new(0,-2,0)
		Debris:AddItem(clone, 5)
	end	
	
	if skillType == "endhold" then
		local Torso = attacker:FindFirstChild("Torso") or hrp
		local Arm = attacker:FindFirstChild("Right Arm")
		
		for _, v in Arm:GetDescendants() do
			if v:IsA("ParticleEmitter") and v:GetAttribute("FistFlame") then
				v.Enabled = false
				task.delay(.2, function()
					v:Destroy()
				end)
			end
		end
	end	


    if skillType == "start" then
        local Torso = attacker:FindFirstChild("Torso") or hrp
        local LeftLeg = attacker:FindFirstChild("Left Leg")
        local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Start

        local facingCFrame = getFacingCFrame(Torso)

        -- AirWind
        local clone = source:Clone()
        clone.Parent = workspace.World.Visuals

        local airWindRoot = clone.AirWind
        airWindRoot.CFrame = facingCFrame * CFrame.new(0, -.7, .4)
        emitClone(clone.AirWind)

        -- Sweep
        clone.sweep.CFrame = facingCFrame * CFrame.new(.5, -1.9, .4)
        emitClone(clone.sweep)

        Debris:AddItem(clone, 4)
	end
	
	if skillType == "throw" then
		--print("Threw skill")
		local StartCF = argumentData.CFrame
		local Direction = StartCF.LookVector
		local SpawnPos = argumentData.CurrentPos
		local Speed = argumentData.Speed
		local Lifetime = argumentData.Lifetime
		local StartTime = argumentData.StartTime	
		local projectileID = argumentData.ProjectileID
		
		local ring = ReplicatedStorage.Assets.Effects.Ace.FlameFist.Throw.ringLikeTbs:Clone()
		ring.Parent = workspace.World.Visuals
		ring.CFrame = attacker.HumanoidRootPart.CFrame * CFrame.new(0,0,-2) * CFrame.Angles(math.rad(0), math.rad(90), 0)
		emitClone(ring)
		Debris:AddItem(ring, 2)

		local FireFist = ReplicatedStorage.Assets.Effects.Ace.FlameFist.Fist:Clone()
		FireFist.Parent = workspace.World.Visuals
		
		local connection
		activeProjectiles[projectileID] = {
			Model = FireFist,
			Stop = function()
				if connection then connection:Disconnect() end
				FireFist:Destroy()
			end
		}
		
		for _, v in pairs(FireFist:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				-- 1. Just turn them on so they start their natural stream
				v.Enabled = true

				-- 2. ONLY burst a tiny amount to fill the "gap"
				-- This prevents the "Sun" blob but fills the initial transparency
				v:Emit(5) 

				-- 3. Optimization: If there's lag, jump the particles ahead
				local preElapsed = workspace:GetServerTimeNow() - StartTime
				if preElapsed > 0.05 then
					v:Emit(10) -- A bit more if the packet was late
				end
			end
		end
		
		local function getPositionAtTime(currentTime)
			local elapsed = currentTime - StartTime
			-- Standard Physics: d = v * t
			return SpawnPos + (Direction * Speed * elapsed)
		end

		-- 3. Movement Loop
		connection = game:GetService("RunService").Heartbeat:Connect(function()
			local now = workspace:GetServerTimeNow()
			local totalElapsed = now - StartTime

			-- Stop the effect once it exceeds its life
			if totalElapsed > Lifetime then
				activeProjectiles[projectileID] = nil
				connection:Disconnect()
				FireFist:Destroy()
			end

			-- 4. Update Position & Orientation
			local currentPos = getPositionAtTime(now)

			-- CFrame.lookAt ensures the "Fist" faces the direction it's moving
			FireFist.CFrame = CFrame.lookAt(currentPos, currentPos + Direction)

			-- 5. Aesthetic: Growing the flame (Lerp)
			local alpha = math.clamp(totalElapsed / Lifetime, 0, 1)
			-- Starts at 10x10x10 and grows by 100% (alpha)
			--FireFist.Size = Vector3.new(10, 10, 10) * (1 + alpha) 
		end)

	end
	
	if skillType == "explosion" then
		--print("explosion occured")
		local projectileID = argumentData.ProjectileID -- Use the ID sent by the server

		local projectileData = activeProjectiles[projectileID]
		if projectileData then
			projectileData.Stop()
			activeProjectiles[projectileID] = nil
		end
		
		local Position = argumentData.Position
		local Normal = argumentData.Normal

		local Explosion = ReplicatedStorage.Assets.Effects.Ace.FlameFist.AceExplosion.Part:Clone()
		Explosion.Parent = workspace.World.Visuals
		Explosion.CFrame = CFrame.new(Position)	
		
		for _, v in Explosion:GetDescendants() do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount") or 1)
			end
		end
		
		game:GetService("Debris"):AddItem(Explosion, 3) -- Cleanup
	end
	
	if skillType == "groundEffect" then
		print("Ground Effect ")
		local Position = argumentData.Position
		print(Position)
		
		local groundEffect = ReplicatedStorage.Assets.Effects.Ace.FlameFist.AceExplosion.Ground:Clone()
		groundEffect.Parent = workspace.World.Visuals
		groundEffect.Anchored = true
		groundEffect.CanCollide = false

		-- For ground effects, we want them to lie flat.
		-- We position it slightly above the ground (0.05 studs) to prevent "Z-Fighting" 
		-- (where the texture flickers because it's at the exact same height as the floor)
		groundEffect.CFrame = CFrame.new(Position + Vector3.new(0, 0.1, 0))  --* CFrame.Angles(math.rad(90), 0, 0)

		for _, v in ipairs(groundEffect:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end		
		game:GetService("Debris"):AddItem(groundEffect, 4)
		
	end
    
end