local module = {}

function module.Start(char)
	local c = script.LeftHandle:Clone()
	c.Parent = char["Left Arm"]
	
	for _, v in pairs(c:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
			v.Color = char["Left Arm"].Color
		end
	end 
	
	local w = Instance.new("Weld",char["Left Arm"])
	w.Part0 = char["Left Arm"]
	w.Part1 = c.LeftHandleMain
	w.Name = "LeftHandleMain"
	w.C0 = CFrame.new(-0.047, -1.037, -0.044)
	
	local c2 = script.RightHandle:Clone()
	c2.Parent = char["Right Arm"]
	
	for _, v in pairs(c2:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
			v.Color = char["Right Arm"].Color
		end
	end 

	local w2 = Instance.new("Weld",char["Right Arm"])
	w2.Part0 = char["Right Arm"]
	w2.Part1 = c2.RightHandleMain
	w2.Name = "RightHandleMain"
	w2.C0 = CFrame.new(-0.016, -1.023, 0.031)
end

function module.End(char)
	local c = char["Left Arm"].LeftHandle
	local w = char["Left Arm"].LeftHandleMain
	local c2 = char["Right Arm"].RightHandle
	local w2 = char["Right Arm"].RightHandleMain
	c:Destroy()
	w:Destroy()
	c2:Destroy()
	w2:Destroy()
end

function module.Timed(char,duration)
	local c = script.LeftHandle:Clone()
	c.Parent = char["Left Arm"]

	for _, v in pairs(c:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
			v.Color = char["Left Arm"].Color
		end
	end 

	local w = Instance.new("Weld",char["Left Arm"])
	w.Part0 = char["Left Arm"]
	w.Part1 = c.LeftHandleMain
	w.Name = "Left Arm"
	w.C0 = CFrame.new(-0.047, 1.037, -0.044)

	local c2 = script.RightHandle:Clone()
	c2.Parent = char["Right Arm"]

	for _, v in pairs(c2:GetDescendants()) do
		if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
			v.Color = char["Right Arm"].Color
		end
	end 

	local w2 = Instance.new("Weld",char["Right Arm"])
	w2.Part0 = char["Right Arm"]
	w2.Part1 = c2.RightHandleMain
	w2.Name = "RightHandleMain"
	w2.C0 = CFrame.new(-0.016, -1.023, 0.031)
	
	task.delay(duration,function()
		c:Destroy()
		w:Destroy()
		c2:Destroy()
		w2:Destroy()
	end)
end

return module
