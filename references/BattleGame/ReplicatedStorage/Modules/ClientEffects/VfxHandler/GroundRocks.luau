local Visual = workspace
local TweenService = game:GetService("TweenService")

local Debris = game:GetService("Debris")
return function(Data)
	
	local Amount = Data.Amount or 10
	local Offset = Data.Offset or 10
	local StartPos = Data.StartPos
	local Filter = Data.Filter or Visual
	local Size = Data.Size or Vector3.new(2,2,2)
	local Duration = Data.Duration or 2
	local Pattern = Data.Pattern or nil
	local Random = Data.Random or false
	
	local directions = {
		Vector3.new(1, 0, 0),   -- right
		Vector3.new(0, 0, 1),   -- forward
		Vector3.new(-1, 0, 0),  -- left
		Vector3.new(0, 0, -1),  -- back
	}
	

	
	--[[ Terrain Rocks on Ground ]]--
	coroutine.wrap(function()
		local GroundRocks = {}
		for i = 1,Amount do

			--[[ Raycast ]]--
			local StartPosition = (Vector3.new(math.sin(360*i)*Offset, 0, math.cos(360*i)*Offset) + StartPos)

			if Pattern == "FourWay" then
				local dir = directions[((i - 1) % #directions) + 1]
				StartPosition = StartPos + dir * Offset
			end
			
			local EndPosition = CFrame.new(StartPosition).UpVector * -10

			local RayData = RaycastParams.new()
			RayData.FilterDescendantsInstances = Filter
			RayData.FilterType = Enum.RaycastFilterType.Exclude
			RayData.IgnoreWater = true

			local ray = game.Workspace:Raycast(StartPosition, EndPosition, RayData)
			if ray then
				local partHit, pos, normVector = ray.Instance or nil, ray.Position or nil, ray.Normal or nil
				if partHit then

					local Block = script.Block:Clone()
		
					if Random then
						local randomX = math.random(0, 30) * .1
						local randomY = math.random(0, 50) * .01
						local randomZ = math.random(0, 20) * .1
						Block.Size = Size + Vector3.new(randomX, randomY, randomZ) --
					else
						Block.Size = Size
					end 
					
					if Random then
						local randomX = math.random(0, 30) * .1
						local randomZ = math.random(0, 20) * .1
						Block.Position = pos + Vector3.new(randomX, 0, randomZ)
					else
						Block.Position = pos
					end
					
					Block.Anchored = true
					Block.CanCollide = true
					Block.CanTouch = false
					
					local lookCF = CFrame.lookAt(pos, StartPos)
						
					if Random then
						local randomY = math.random(-100, 100) * .1
						local randomZ = math.random(-50, 50) * .1
						local tiltAngle = math.rad(math.random(-50, -35))
						Block.CFrame = lookCF * CFrame.Angles(tiltAngle, math.rad(randomY), math.rad(randomZ))
					else
						local tiltAngle = math.rad(math.random(-50, -35))
						Block.CFrame = lookCF * CFrame.Angles(tiltAngle, math.rad(0), math.rad(0))
					end
					

					Block.Transparency = 0
					Block.Color = partHit.Color
					Block.Material = partHit.Material
					Block.CollisionGroup = "TouchableDebris"
					Block.Parent = Visual
					GroundRocks[i] = Block;
					Debris:AddItem(Block, 10)
				end
			end
		end	
		--[[ Delete Rocks ]]--
		task.delay(Duration-2, function()
			if #GroundRocks > 0 then
				for _,v in ipairs(GroundRocks) do
					--could add tweening.
					local info = TweenInfo.new(5)
					local goal = {
						Position = v.Position - Vector3.new(0, 5, 0)
					}
					local tween = TweenService:Create(v, info, goal)
					tween:Play()
					wait(.2)
				end
			end	
		end)		
	end)()
	
end