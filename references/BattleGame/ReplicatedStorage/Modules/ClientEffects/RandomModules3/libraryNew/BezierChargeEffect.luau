 
  
game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
game:GetService("Debris")
local RunService = game:GetService("RunService")
local t = {}
local function getBezierCFrame(p1, p2, p3, p4, p5) --[[ getBezierCFrame | Line: 9 ]]
	local v1 = 1 - p1
	local v2 = v1 * v1
	local v3 = p1 * p1
	local v4 = p2.Position * (v2 * v1) + p3.Position * (v2 * 3 * p1) + p4.Position * (v1 * 3 * v3) + p5.Position * (v3 * p1)
	local v5 = (p3.Position - p2.Position) * (v2 * 3) + (p4.Position - p3.Position) * (v1 * 6 * p1) + (p5.Position - p4.Position) * (v3 * 3)
	if v5.Magnitude < 0.001 then
		v5 = if p1 < 0.5 then (p3.Position - p2.Position).Unit else (p5.Position - p4.Position).Unit
		if v5.Magnitude < 0.001 then
			v5 = p5.Position - p2.Position
			if v5.Magnitude < 0.001 then
				v5 = Vector3.new(0, 0, -1)
			end
		end
	end
	return CFrame.lookAt(v4, v4 + v5)
end
function t.Create(p1, p2) --[[ Create | Line: 43 | Upvalues: TweenService (copy), RunService (copy), getBezierCFrame (copy) ]]
	local v1 = if p2 then p2 else {}
	if typeof(p1) ~= "CFrame" then
		warn("BezierChargeEffect.Create: \'targetCFrame\' must be a CFrame value, but received an " .. typeof(p1) .. ". Did you pass a Part/Instance instead of Part.CFrame?")
		return
	end
	local v3 = v1.SpawnRadius or 20
	local v4 = v1.MinDuration or 0.8
	local v5 = v1.MaxDuration or 1.5
	local v6 = v1.Lifetime or 2
	local ParticleTemplate = v1.ParticleTemplate
	local v7 = v1.ControlPointHeight or 15
	local v8 = v1.RandomControlOffset or 8
	local v9 = v1.Parent or workspace.Thrown
	local v10 = v1.EasingStyle or Enum.EasingStyle.Quart
	local v11 = v1.EasingDirection or Enum.EasingDirection.Out
	local v12 = v1.SpawnDelay or 0.05
	local v13 = v1.ColorSequence
	local TransparencySequence = v1.TransparencySequence
	local v14 = v1.SwirlStrength or 0
	if not (ParticleTemplate and ParticleTemplate:IsA("BasePart")) then
		warn("BezierChargeEffect.Create: ParticleTemplate is required and must be a BasePart.")
		return
	end
	for i = 1, v1.Count or 30 do
		task.spawn(function() --[[ Line: 89 | Upvalues: v12 (copy), i (copy), ParticleTemplate (copy), v6 (copy), v9 (copy), v3 (copy), p1 (copy), v4 (copy), v5 (copy), v8 (copy), v14 (copy), v7 (copy), v10 (copy), v11 (copy), TweenService (ref), RunService (ref), getBezierCFrame (ref), v13 (copy), TransparencySequence (copy) ]]
			if v12 > 0 then
				task.wait(i * v12)
			end
			local v1 = ParticleTemplate:Clone()
			game.Debris:AddItem(v1, v6)
			v1.Anchored = false
			v1.CanCollide = false
			v1.CanTouch = false
			v1.Massless = true
			v1.Parent = v9
			local v2 = math.random() * 2 - 1
			local v32 = math.random() * 2 - 1
			local v42 = math.random() * 2 - 1
			local v62 = CFrame.new(p1.Position + Vector3.new(v2, v32, v42).Unit * math.random(0, v3))
			v1.CFrame = v62
			local v72 = math.random(v4 * 100, v5 * 100) / 100
			local v82 = p1
			local v92 = v62:Lerp(v82, 0.5)
			local v112 = math.abs(v8)
			local v122 = math.random() * 2 - 1
			local v132 = math.random() * 2 - 1
			local v142 = math.random() * 2 - 1
			local v15 = Vector3.new(v122, v132, v142).Unit * (math.random() * v112)
			local v16 = math.random() * 2 - 1
			local v17 = math.random() * 2 - 1
			local v18 = math.random() * 2 - 1
			local v19 = Vector3.new(v16, v17, v18).Unit * (math.random() * v112)
			local Unit = (v82.Position - v62.Position).Unit
			local v20 = Unit:Cross(Vector3.new(0, 1, 0))
			if v20.Magnitude < 0.001 then
				v20 = Unit:Cross(Vector3.new(0, 0, -1))
			end
			local Unit_2 = v20.Unit
			local v22 = Unit_2 * (math.random() * 2 - 1) * v14
			local v23 = Unit_2 * (math.random() * 2 - 1) * v14
			local v25 = v62.Position:Lerp(v92.Position, 0.3) + Vector3.new(0, v7, 0) + v15 + v22
			local v27 = v92.Position:Lerp(v82.Position, 0.7) + Vector3.new(0, v7, 0) + v19 + v23
			local v28 = CFrame.new(v25)
			local v29 = CFrame.new(v27)
			local v30 = Instance.new("NumberValue")
			v30.Value = 0
			v30.Parent = nil
			local v31 = TweenService:Create(v30, TweenInfo.new(v72, v10, v11, 0, false, 0), {
				Value = 1
			})
			local v322 = nil
			v322 = RunService.Heartbeat:Connect(function() --[[ Line: 171 | Upvalues: v1 (copy), v31 (copy), getBezierCFrame (ref), v30 (copy), v62 (copy), v28 (copy), v29 (copy), v82 (copy), v322 (ref) ]]
				if v1 and (v1.Parent and v31.PlaybackState == Enum.PlaybackState.Playing) then
					v1.CFrame = getBezierCFrame(v30.Value, v62, v28, v29, v82)
					return
				end
				if not v322 then
					return
				end
				v322:Disconnect()
				v322 = nil
			end)
			if v13 then
				local Trail = v1:FindFirstChildOfClass("Trail")
				if Trail then
					Trail.Color = v13
				end
			end
			if not TransparencySequence then
				v31:Play()
				v31.Completed:Connect(function() --[[ Line: 197 | Upvalues: v322 (ref), v30 (copy) ]]
					if not v322 then
						v30:Destroy()
						return
					end
					v322:Disconnect()
					v322 = nil
					v30:Destroy()
				end)
				return
			end
			local Trail = v1:FindFirstChildOfClass("Trail")
			if not Trail then
				v31:Play()
				v31.Completed:Connect(function() --[[ Line: 197 | Upvalues: v322 (ref), v30 (copy) ]]
					if not v322 then
						v30:Destroy()
						return
					end
					v322:Disconnect()
					v322 = nil
					v30:Destroy()
				end)
				return
			end
			Trail.Transparency = TransparencySequence
			v31:Play()
			v31.Completed:Connect(function() --[[ Line: 197 | Upvalues: v322 (ref), v30 (copy) ]]
				if not v322 then
					v30:Destroy()
					return
				end
				v322:Disconnect()
				v322 = nil
				v30:Destroy()
			end)
		end)
	end
end
return t