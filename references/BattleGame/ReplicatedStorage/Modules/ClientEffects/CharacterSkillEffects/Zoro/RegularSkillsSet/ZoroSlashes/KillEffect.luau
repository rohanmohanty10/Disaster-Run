local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")


local CORNER_OFFSETS = {
	Vector3.new( 0.5,  0.5, 0),
	Vector3.new(-0.5,  0.5, 0),
	Vector3.new( 0.5, -0.5, 0),
	Vector3.new(-0.5, -0.5, 0),
}

-- Breaks every basic Part inside `object` into 4 collidable corner shards,
-- drops them (plus an invisible husk of the original) into workspace.Thrown,
-- then fades everything out and cleans it up.
return function(object)
	local shards = {}

	for _, part in ipairs(object:GetDescendants()) do
		if part:IsA("Part") then
			-- strip it down to a plain block
			local mesh = part:FindFirstChildOfClass("SpecialMesh") or part:FindFirstChildOfClass("FileMesh")
			if mesh then mesh:Destroy() end

			local decal = part:FindFirstChildOfClass("Decal")
			if decal then decal:Destroy() end

			part.Parent = nil

			-- spawn 4 quarter-sized shards, one per corner
			local shardSize = part.Size * Vector3.new(0.25, 0.25, 1)
			for i = 1, 4 do
				local shard = part:Clone()

				for _, child in ipairs(shard:GetChildren()) do
					if child:IsA("ParticleEmitter") or child:IsA("Sound") then
						child:Destroy()
					end
				end

				shard.Size = shardSize
				shard.CFrame = part.CFrame * CFrame.new(CORNER_OFFSETS[i] * shardSize)
				shard.CanCollide = true
				shard.Parent = workspace.Thrown

				table.insert(shards, shard)
			end

			-- keep the original as an invisible, collidable husk
			part.CanCollide = true
			part.Transparency = 1
			part.Parent = workspace.Thrown
			table.insert(shards, part)

			task.wait() -- spread work across frames so big models don't hitch
		end
	end

	task.wait(4)

	-- fade everything out, then let Debris remove it
	for _, shard in ipairs(shards) do
		TweenService:Create(shard, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			Transparency = 1,
		}):Play()
		Debris:AddItem(shard, 1)
	end
end