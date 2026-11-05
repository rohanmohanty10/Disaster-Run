--script:Destroy() i know im dumb... i just cant prove it


local RNS = game:GetService("RunService")
local TS = game:GetService("TweenService")


return {
	Visualizer = function(Character: Model)
		local Player: Player = game.Players.LocalPlayer
		
		if Character.Parent then
			for _, Child in pairs(workspace.Thrown:GetChildren()) do
				if Child:IsA("Part") and (Child:FindFirstChild("owner") and Child.owner.Value == Character) then
					return
				end
			end
			

			local HumRP: BasePart = Character:WaitForChild("HumanoidRootPart")
			local Humanoid: Humanoid = Character:WaitForChild("Humanoid")
			
			
			local VisualizerPart: Part = Instance.new("Part")
			VisualizerPart.Parent = workspace.Thrown
			VisualizerPart.CFrame = HumRP.CFrame
			VisualizerPart.CanCollide = false
			VisualizerPart.Anchored = true 
			VisualizerPart.Transparency = 0.7
			VisualizerPart.Color = Color3.fromRGB(31, 128, 29)
			VisualizerPart.Material = Enum.Material.Neon
			VisualizerPart.CastShadow = true
			
			
			local OwnerValue: ObjectValue = Instance.new("ObjectValue")
			OwnerValue.Parent = VisualizerPart
			OwnerValue.Name = "owner"
			OwnerValue.Value = Character
			
			
			local Assembly = nil
			local FirstMagnitude = nil
			local OnVelocity = false
			local GoalVelocity = nil
			
			
			local Connection: RBXScriptConnection
			Connection = RNS.Heartbeat:Connect(function()
				if not OnVelocity then
					if Character.Parent then
						if Character:FindFirstChild("Ragdolled") then
							local VelocityX = HumRP.AssemblyLinearVelocity.X
							local MathVelocityX = math.floor(VelocityX)
							
							local VelocityY = HumRP.AssemblyLinearVelocity.Y
							local MathVelocityY = math.floor(VelocityY)
							
							local VelocityZ = HumRP.AssemblyLinearVelocity.Z
							local MathVelocityZ = math.floor(VelocityZ)
							
							
							local VelPos = Vector3.new(MathVelocityX, MathVelocityY, MathVelocityZ)
							
							
							local MapRayParams = RaycastParams.new()
							MapRayParams.FilterType = Enum.RaycastFilterType.Include
							MapRayParams.FilterDescendantsInstances = {
								workspace.World:WaitForChild("Map") 
							}
							
							
							if VelPos ~= GoalVelocity then
								local RayPos = workspace:Raycast(HumRP.Position, VelPos / 6, MapRayParams)
								
								if RayPos and RayPos.Instance ~= nil then
									GoalVelocity = VelPos
									
									
									local NextPart = Instance.new("Part")
									NextPart.Parent = workspace.Thrown
									NextPart.CFrame = CFrame.new(RayPos.Position)
									NextPart.Size = Vector3.new(4, 4, 4)
									NextPart.CanCollide = false
									NextPart.Anchored = true
									NextPart.Transparency = 0.7
									NextPart.Color = Color3.fromRGB(212, 40, 40)
									NextPart.Material = Enum.Material.Neon
									NextPart.CastShadow = false
									game.Debris:AddItem(NextPart, 2)
									
									
									TS:Create(NextPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {
										["Transparency"] = 1
									}):Play()
									
									
									task.spawn(function()
										OnVelocity = true
										
										wait(0.5)
										
										OnVelocity = false
									end)
									
									return
								end
							end
						end
					else
						Connection:Disconnect()
					end
				end
			end)
			
			
			HumRP:GetPropertyChangedSignal("Velocity"):Connect(function()
				local MapRayParams = RaycastParams.new()
				MapRayParams.FilterType = Enum.RaycastFilterType.Include
				MapRayParams.FilterDescendantsInstances = {
					workspace.World:WaitForChild("Map") 
				}
				
				local RayPos = workspace:Raycast(HumRP.Position, HumRP.AssemblyLinearVelocity / 4, MapRayParams)
				if RayPos then
					if OnVelocity then
						return
					end
					
					if RayPos.Instance ~= nil then
						local NextPart = Instance.new("Part")
						NextPart.Parent = workspace.Thrown
						NextPart.CFrame = CFrame.new(RayPos.Position)
						NextPart.Size = Vector3.new(4, 4, 4)
						NextPart.CanCollide = false
						NextPart.Anchored = true
						NextPart.Transparency = 0.7
						NextPart.Color = Color3.fromRGB(31, 128, 29)
						NextPart.Material = Enum.Material.Neon
						NextPart.CastShadow = false
						game.Debris:AddItem(NextPart, 2)
						
						
						TS:Create(NextPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {
							["Transparency"] = 1
						}):Play()
						
						
						task.spawn(function()
							OnVelocity = true
							
							wait(0.15)
							
							OnVelocity = false
						end)
					end
				end
			end)
			
			
			local VelocityConnection: RBXScriptConnection
			VelocityConnection = RNS.Heartbeat:Connect(function()
				if Character.Parent then
					local CharacterVelocity = HumRP.AssemblyLinearVelocity
					local CharacterMagnitude = CharacterVelocity.Magnitude
					local CharacterUnit = CharacterVelocity.Unit
					
					VisualizerPart.CFrame = HumRP.CFrame
					VisualizerPart.CFrame = CFrame.lookAt(VisualizerPart.Position, VisualizerPart.Position + CharacterUnit)
					VisualizerPart.Position = VisualizerPart.Position + CFrame.new(CharacterUnit * (CharacterMagnitude / 4)).Position
				else
					VelocityConnection:Disconnect()
				end
			end)
			
			
			while true do
				if not (HumRP.Parent and Player) then
					VisualizerPart:Destroy()
					
					break
				end
				
				if HumRP.Parent and (HumRP:FindFirstChild("Torso") and (HumRP.Parent.Torso.Transparency == 1 and Humanoid.Health == 0)) then
					VisualizerPart:Destroy()
					
					break
				end
				
				
				local CharacterVelocity = HumRP.AssemblyLinearVelocity
				
				if HumRP.Anchored then
					if not Assembly then
						FirstMagnitude = CharacterVelocity.Magnitude
						Assembly = CharacterVelocity
					end
					
					local FloorMagnitude = FirstMagnitude / 3
					VisualizerPart.Size = Vector3.new(0.25, 0.25, FloorMagnitude)
				else
					FirstMagnitude = CharacterVelocity.Magnitude
					local FloorMagnitude = FirstMagnitude / 3
					
					VisualizerPart.Size = Vector3.new(0.25, 0.25, FloorMagnitude)
					Assembly = CharacterVelocity
				end
				
				
				local MapRayParams = RaycastParams.new()
				MapRayParams.FilterType = Enum.RaycastFilterType.Include
				MapRayParams.FilterDescendantsInstances = { 
					workspace.World:WaitForChild("Map") 
				}
				
				if workspace:Raycast(HumRP.Position, CharacterVelocity / 4, MapRayParams) then
					VisualizerPart.Color = Color3.fromRGB(212, 40, 40)
				else
					VisualizerPart.Color = Color3.fromRGB(31, 128, 29)
				end
				
				wait(0.01)
			end
		end
	end
}