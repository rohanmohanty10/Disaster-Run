 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=4894507266

-- ! Source from the asset above; the game may have edited it since.

--[==[
--[=[

	VPF Replay Module
	© Zack Ovits | boatbomber
	2020
	Version 1.1

	Write up:
	https://devforum.roblox.com/t/open-source-vpf-replay-module/523112/1

	Update Log:
		Version 1.1
			Humanoid and character handling
			Async registering

		Version 1.0
			Initial creation

--------------------------------------------------------------------
API Documentation:
--------------------------------------------------------------------

[function] Replay.new(Settings)
	Returns a new ReplayObject
    @param [table] Settings
		[number] Settings.FPS
			The FPS to record at
			defaults to 20
		[string] Settings.CameraType
			The type of camera for the Replay object playback
			("Recorded", "Track", "Follow", or "Custom")
			defaults to "Recorded"
		[Vector3] Settings.CameraPosition
			Where the camera should sit during playback
			Only relevant when set to "Track"
		[Instance] Settings.CameraSubject
			Not relevant to "Recorded"

[Instance] ReplayObject.VPF
	The ViewportFrame for you to parent to your desired GUI

[Instance] ReplayObject.Camera
	The Camera (use only if CameraType is set to "Custom")

[function] ReplayObject:Register(Object, IgnoreDescendants)
	Adds Object	to be recorded for playback
    @param [Instance] Object
		The object to register for recording
	@param [Boolean] IgnoreDescendants
		Whether or not it should recursively register the entire object (useful for models and folders)
		defaults to false

[function] ReplayObject:RegisterStatic(Object, IgnoreDescendants)
	Adds Object	to be displayed during playback without moving or recording (Useful for map and props)
	@param [Instance] Object
		The object to register for static display
	@param [Boolean] IgnoreDescendants
		Whether or not it should recursively register the entire object (useful for models and folders)
		defaults to false

[function] ReplayObject:StartRecording(MaxRecordingTime)
	Begins recording all registered objects
	@param [number] MaxRecordingTime
		How long the recording can be before automatically stopping
		defaults to 30

[function] ReplayObject:StopRecording()
	Stops the in-progress recording	, and prepares the playback functions

[function] ReplayObject:ClearRecording()
	Clears the stored recording to allow another to be recorded without needing a new ReplayObject and registering everything again

[function] ReplayObject:Destroy()
	Empties the ReplayObject and associated objects for GC

[function] ReplayObject:Play(PlaySpeed,StartTime,Override)
	Plays the stored recording in the ViewportFrame
	@param [number] PlaySpeed
		The time multiplier (useful for slow motion replays or sped up recaps)
		defaults to 1
	@param [number] StartTime
		The time at which playback should begin
		defaults to 0
	@param [Boolean] Override
		Wether or not this playback should override any in-progress playback
		defaults to false

[function] ReplayObject:Stop()
	Halts any in-progress playback

[function] ReplayObject:GoToTime(Time)
	Displays the state in the stored recording in the ViewportFrame at the given Time
	@param [number] Time
		What time in the recording to render

[function] ReplayObject:GoToPercent(Percent)
	Displays the state in the stored recording in the ViewportFrame at the given Percent
	@param [number] Percent
		What percent of the way through the recording to render

[function] ReplayObject:GoToFrame(Frame)
	Displays the state in the stored recording in the ViewportFrame at the given Frame
	@param [number] Percent
		What frame of the recording to render

[event] ReplayObject.RecordingStarted
	Fires when a recording starts

[event] ReplayObject.RecordingStopped
	Fires when a recording stops

[event] ReplayObject.FrameChanged
	Fires when the rendered frame of the recording changes
	@arg [number] Frame
		What frame is now being rendered
	@arg [number] Time
		What time is now being rendered
	@arg [number] Percent
		What percent is now being rendered

[property] ReplayObject.Playing
	Read only boolean of the playing state

[property] ReplayObject.Recording
	Read only boolean of the recording state

[property] ReplayObject.Recorded
	Read only boolean whether there is a stored recording

[property] ReplayObject.FrameCount
	Read only number of how many frames are in the stored recording

[property] ReplayObject.RecordingTime
	Read only number of how long the stored recording is (in seconds)


--]=]

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local DEBUG = false --RS:IsStudio()

local Module = {}

local RenderStepped = RS.RenderStepped

local CleanChildren = { ["Decal"] = true, ["Texture"] = true, ["SpecialMesh"] = true, ["BlockMesh"] = true }
local function CleanClone(Object: BasePart)
	local CleanObject = Object:Clone()

	for _, c in ipairs(CleanObject:GetChildren()) do
		if not CleanChildren[c.ClassName] then
			c:Destroy()
		end
	end

	CleanObject.Anchored = true
	CleanObject.CanCollide = false
	CleanObject.CanTouch = false
	CleanObject.CanQuery = false

	return CleanObject
end

function Module.new(Settings)
	Settings = Settings or {}

	local RecordingStopped = Instance.new("BindableEvent")
	local RecordingStarted = Instance.new("BindableEvent")
	local FrameChanged = Instance.new("BindableEvent")

	local Replay = {
		-- States
		Playing = false,
		Recording = false,
		Recorded = false,

		-- Main
		Registers = {},
		StaticRegisters = {},
		CloneIndex = {},
		RegisteredObjects = {},

		Frames = {},
		FrameTimes = {},
		FrameCount = 0,
		RecordingTime = 0,

		LastSnapshotTick = 0,
		FPSDelay = 1 / (Settings.FPS or 20),

		-- Objects
		VPF = Instance.new("ViewportFrame"),
		MouseDetector = Instance.new("TextButton"),
		WheelSinker = Instance.new("ScrollingFrame"),
		Camera = Instance.new("Camera"),
		Skybox = script.Skybox:Clone(),

		-- Connections (written for reference and autofill)
		RecordConnection = nil,
		PlayConnection = nil,

		-- Events
		RecordingStarted = RecordingStarted.Event,
		RecordingStopped = RecordingStopped.Event,
		FrameChanged = FrameChanged.Event,

		-- Settings
		CameraType = Settings.CameraType or "Recorded",
		CameraPosition = Settings.CameraPosition or Vector3.new(0, 10, 0),
		CameraSubject = Settings.CameraSubject,

		-- Camera
		CameraAngle = { X = 0, Y = 0 },
		CameraOffset = 20,
	}

	-- Setup
	Replay.VPF.CurrentCamera = Replay.Camera
	Replay.VPF.Size = UDim2.new(1, 0, 1, 0)
	Replay.VPF.BorderSizePixel = 0
	Replay.Skybox.Parent = Replay.VPF
	Replay.MouseDetector.Text = ""
	Replay.MouseDetector.Size = UDim2.new(1, 0, 1, 0)
	Replay.MouseDetector.BackgroundTransparency = 1
	Replay.MouseDetector.Parent = Replay.VPF
	Replay.WheelSinker.Size = UDim2.new(1, 0, 1, 0)
	Replay.WheelSinker.BackgroundTransparency = 1
	Replay.WheelSinker.ScrollBarImageTransparency = 1
	Replay.WheelSinker.BorderSizePixel = 0
	Replay.WheelSinker.Parent = Replay.VPF

	local MouseHovering = false
	Replay.VPF.MouseEnter:Connect(function()
		MouseHovering = true
	end)
	Replay.VPF.MouseLeave:Connect(function()
		MouseHovering = false
	end)

	local CameraDrag
	Replay.MouseDetector.MouseButton2Down:Connect(function()
		local LastX, LastY = Mouse.X, Mouse.Y
		CameraDrag = RS.Heartbeat:Connect(function()
			if Replay.CameraType == "Follow" then
				Replay.CameraAngle = {
					X = Replay.CameraAngle.X - math.rad(((Mouse.X - LastX) / Replay.VPF.AbsoluteSize.X) * 100),
					Y = Replay.CameraAngle.Y - math.rad(((Mouse.Y - LastY) / Replay.VPF.AbsoluteSize.Y) * 100),
				}

				Replay.Camera.CFrame = (
						CFrame.new(Replay.CamSubClone.Position)
						* (CFrame.Angles(0, Replay.CameraAngle.X or 0, 0))
						* CFrame.Angles(Replay.CameraAngle.Y or 0, 0, 0)
					) * CFrame.new(0, 0, Replay.CameraOffset or 20)
			elseif Replay.CameraType == "Free" then
				Replay.Camera.CFrame = (
						Replay.Camera.CFrame:ToWorldSpace(
							CFrame.Angles(math.rad(((Mouse.Y - LastY) / Replay.VPF.AbsoluteSize.Y) * 100), 0, 0)
						)
					) * (CFrame.Angles(0, math.rad(((Mouse.X - LastX) / Replay.VPF.AbsoluteSize.X) * 100), 0))
			end
			LastX, LastY = Mouse.X, Mouse.Y
		end)
	end)
	UIS.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			if CameraDrag then
				CameraDrag:Disconnect()
				CameraDrag = nil
			end
		end
	end)
	UIS.InputChanged:Connect(function(Input, GP)
		if MouseHovering and GP and Input.UserInputType == Enum.UserInputType.MouseWheel then
			if Replay.CameraType == "Free" then
				Replay.Camera.CFrame = Replay.Camera.CFrame * CFrame.new(0, 0, Input.Position.Z * -4)
			elseif Replay.CameraType == "Follow" then
				Replay.CameraOffset = math.clamp(Replay.CameraOffset - (Input.Position.Z * 4), 0.5, 100)
				Replay.Camera.CFrame = (
						CFrame.new(Replay.CamSubClone.Position)
						* (CFrame.Angles(0, Replay.CameraAngle.X or 0, 0))
						* CFrame.Angles(Replay.CameraAngle.Y or 0, 0, 0)
					) * CFrame.new(0, 0, Replay.CameraOffset or 20)
			end
		end
	end)

	-- Primary functions

	function Replay:Register(Object: Instance, IgnoreDescendants: boolean)
		task.spawn(function() -- Run async due to possible yielding
			if Replay.Recording then
				warn("Cannot register new objects while recording is in progress")
				return
			end

			if typeof(Object) ~= "Instance" then
				return
			end

			if DEBUG then
				print("Register:", Object)
			end

			local IsHumanoid = false

			if Object:IsA("Model") and Object:FindFirstChildWhichIsA("Humanoid") then
				IsHumanoid = true

				if DEBUG then
					print("Character detected:", Object)
				end

				while Object:FindFirstChildWhichIsA("BasePart") == nil do
					task.wait(0.05) -- .CharacterAdded is fired before the character loads, so this wait is needed or the model has no basepart children yet
				end

				local CharClone = Instance.new("Model")
				CharClone.Name = Object.Name

				for _, Child in ipairs(Object:GetDescendants()) do
					if Child:IsA("BasePart") then
						if not Replay.RegisteredObjects[Child] then -- Avoid duplication
							if DEBUG then
								print("   Valid character part:", Child)
							end

							Replay.RegisteredObjects[Child] = true

							local Clone = CleanClone(Child)
							Replay.CloneIndex[Child] = Clone

							Replay.Registers[#Replay.Registers + 1] = { Mirror = Clone, Original = Child }
							Clone.Parent = CharClone
						end
					elseif Child:IsA("CharacterMesh") then
						Child:Clone().Parent = CharClone
					end
				end

				local Shirt, Pants, Tee =
					Object:FindFirstChildWhichIsA("Shirt"),
					Object:FindFirstChildWhichIsA("Pants"),
					Object:FindFirstChildWhichIsA("ShirtGraphic")
				do -- Handles clothing in a `do end` just for easy code folding, not really about scope or anything
					if Shirt then
						if DEBUG then
							print("   Shirt registered:")
						end

						local ShirtClone = Shirt:Clone()
						ShirtClone.Parent = CharClone

						Shirt.Changed:Connect(function(Prop)
							ShirtClone[Prop] = Shirt[Prop]
						end)
					end

					if Pants then
						if DEBUG then
							print("   Pants registered:")
						end

						local PantsClone = Pants:Clone()
						PantsClone.Parent = CharClone

						Pants.Changed:Connect(function(Prop)
							PantsClone[Prop] = Pants[Prop]
						end)
					end

					if Tee then
						if DEBUG then
							print("   Tee registered:")
						end

						local TeeClone = Tee:Clone()
						TeeClone.Parent = CharClone

						Tee.Changed:Connect(function(Prop)
							TeeClone[Prop] = Tee[Prop]
						end)
					end
				end

				local StatelessHumanoid = Instance.new("Humanoid")
				do -- Again, the `do end` block is just so I can fold the code
					StatelessHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
					for _, enum in next, Enum.HumanoidStateType:GetEnumItems() do
						if enum ~= Enum.HumanoidStateType.None then
							StatelessHumanoid:SetStateEnabled(enum, false)
						end
					end
					StatelessHumanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)

					StatelessHumanoid.RigType = Object:FindFirstChildWhichIsA("Humanoid").RigType
				end
				StatelessHumanoid.Parent = CharClone

				CharClone.Parent = Replay.VPF
			end

			if Object:IsA("BasePart") and Object.ClassName ~= "Terrain" and Object.Archivable then
				if not Replay.RegisteredObjects[Object] then -- Avoid duplication
					if DEBUG then
						print("   Valid register")
					end

					Replay.RegisteredObjects[Object] = true

					local Clone = CleanClone(Object)
					Replay.CloneIndex[Object] = Clone

					Replay.Registers[#Replay.Registers + 1] = { Mirror = Clone, Original = Object }
					Clone.Parent = Replay.VPF
				end
			end

			if not IsHumanoid then
				if not IgnoreDescendants then
					for _, Child in ipairs(Object:GetChildren()) do
						Replay:Register(Child)
					end
				end
			end
		end)
	end

	function Replay:RegisterStatic(Object: Instance, IgnoreDescendants: boolean)
		task.spawn(function() -- Run async due to possible yielding
			if Replay.Recording then
				warn("Cannot register new objects while recording is in progress")
				return
			end

			if typeof(Object) ~= "Instance" then
				return
			end

			if DEBUG then
				print("Register Static:", Object)
			end

			local IsHumanoid = false

			if Object:IsA("Model") and Object:FindFirstChildWhichIsA("Humanoid") then
				IsHumanoid = true

				if DEBUG then
					print("Character detected:", Object)
				end

				while Object:FindFirstChildWhichIsA("BasePart") == nil do
					task.wait(0.05) -- .CharacterAdded is fired before the character loads, so this wait is needed or the model has no basepart children yet
				end

				local CharClone = Instance.new("Model")
				CharClone.Name = Object.Name

				for _, Child in ipairs(Object:GetDescendants()) do
					if Child:IsA("BasePart") then
						if not Replay.StaticRegisters[Child] then -- Avoid duplication
							if DEBUG then
								print("   Valid character part:", Child)
							end

							Replay.StaticRegisters[Child] = true

							local Clone = CleanClone(Child)
							Replay.CloneIndex[Child] = Clone

							Clone.Parent = CharClone
						elseif Child:IsA("CharacterMesh") then
							Child:Clone().Parent = CharClone
						end
					end
				end

				local Shirt, Pants, Tee =
					Object:FindFirstChildWhichIsA("Shirt"),
					Object:FindFirstChildWhichIsA("Pants"),
					Object:FindFirstChildWhichIsA("ShirtGraphic")
				do -- Handles clothing in a `do end` just for easy code folding, not really about scope or anything
					if Shirt then
						if DEBUG then
							print("   Shirt registered:")
						end

						local ShirtClone = Shirt:Clone()
						ShirtClone.Parent = CharClone

						Shirt.Changed:Connect(function(Prop)
							ShirtClone[Prop] = Shirt[Prop]
						end)
					end

					if Pants then
						if DEBUG then
							print("   Pants registered:")
						end

						local PantsClone = Pants:Clone()
						PantsClone.Parent = CharClone

						Pants.Changed:Connect(function(Prop)
							PantsClone[Prop] = Pants[Prop]
						end)
					end

					if Tee then
						if DEBUG then
							print("   Tee registered:")
						end

						local TeeClone = Tee:Clone()
						TeeClone.Parent = CharClone

						Tee.Changed:Connect(function(Prop)
							TeeClone[Prop] = Tee[Prop]
						end)
					end
				end

				local StatelessHumanoid = Instance.new("Humanoid")
				do -- Again, the `do end` block is just so I can fold the code
					StatelessHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
					for _, enum in next, Enum.HumanoidStateType:GetEnumItems() do
						if enum ~= Enum.HumanoidStateType.None then
							StatelessHumanoid:SetStateEnabled(enum, false)
						end
					end
					StatelessHumanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)

					StatelessHumanoid.RigType = Object:FindFirstChildWhichIsA("Humanoid").RigType
				end
				StatelessHumanoid.Parent = CharClone

				CharClone.Parent = Replay.VPF
			end

			if Object:IsA("BasePart") and Object.ClassName ~= "Terrain" and Object.Archivable then
				if not Replay.StaticRegisters[Object] then -- Avoid duplication
					Replay.StaticRegisters[Object] = true

					if DEBUG then
						print("   Valid static register")
					end

					local Clone = CleanClone(Object)
					Replay.CloneIndex[Object] = Clone

					Clone.Parent = Replay.VPF
				end
			end

			if not IsHumanoid then
				if not IgnoreDescendants then
					for _, Child in ipairs(Object:GetChildren()) do
						Replay:RegisterStatic(Child, IgnoreDescendants)
					end
				end
			end
		end)
	end

	function Replay:StartRecording(MaxRecordingTime: number?)
		if Replay.Recorded then
			warn("Cannot start recording until previous recording is cleared")
			return
		end

		if Replay.Recording then
			warn("Cannot start recording since recording is already in progress")
			return
		end

		MaxRecordingTime = MaxRecordingTime or 30

		if DEBUG then
			print("Start Recording")
		end

		RecordingStarted:Fire()

		Replay.Recording = true

		Replay.RecordConnection = RenderStepped:Connect(function(DeltaTime)
			if Replay.RecordingTime + DeltaTime > MaxRecordingTime then
				Replay:StopRecording()
				return
			end

			Replay.RecordingTime = Replay.RecordingTime + DeltaTime
			local FrameDelta = os.clock() - Replay.LastSnapshotTick
			if FrameDelta >= Replay.FPSDelay then
				if DEBUG then
					print("Snapshotting")
				end

				Replay.FrameCount = Replay.FrameCount + 1
				Replay.LastSnapshotTick = os.clock()

				Replay.FrameTimes[Replay.FrameCount] = Replay.RecordingTime

				local ObjectData = {}

				for _, Object in ipairs(Replay.Registers) do
					local mir, og = Object.Mirror, Object.Original

					if og and og:IsDescendantOf(game) then
						ObjectData[Object.Mirror] = {
							["CFrame"] = og.CFrame,
							["Color"] = og.Color,
							["Transparency"] = og.Transparency,
						}
					else
						ObjectData[Object.Mirror] = {
							["Destroyed"] = true,
						}
					end
				end

				if Replay.Frames[Replay.FrameCount - 1] then
					Replay.Frames[Replay.FrameCount - 1].FrameLength = FrameDelta
				end

				Replay.Frames[Replay.FrameCount] = {
					ID = Replay.FrameCount,
					Time = Replay.RecordingTime,
					CameraCF = workspace.CurrentCamera.CFrame,
					ObjectData = ObjectData,
				}
			end
		end)

		local Sky = game.Lighting:FindFirstChildWhichIsA("Sky")
		if Sky then
			Replay.Skybox.Bk.Decal.Texture = Sky.SkyboxBk
			Replay.Skybox.Dn.Decal.Texture = Sky.SkyboxDn
			Replay.Skybox.Ft.Decal.Texture = Sky.SkyboxFt
			Replay.Skybox.Lf.Decal.Texture = Sky.SkyboxLf
			Replay.Skybox.Rt.Decal.Texture = Sky.SkyboxRt
			Replay.Skybox.Up.Decal.Texture = Sky.SkyboxUp
		end
	end

	function Replay:StopRecording()
		if Replay.Recorded then
			warn("Cannot stop recording since it has already stopped")
			return
		end

		if not Replay.Recording then
			warn("Cannot stop recording since no recording is in progress")
			return
		end

		if DEBUG then
			print("Stop Recording")
		end

		RecordingStopped:Fire()

		Replay.RecordConnection:Disconnect()

		Replay.Recording = false
		Replay.Recorded = true

		if Replay.CameraSubject and Replay.CloneIndex[Replay.CameraSubject] then
			Replay.CamSubClone = Replay.CloneIndex[Replay.CameraSubject]
		end

		Replay:GoToFrame(1)
	end

	function Replay:ClearRecording()
		if not Replay.Recorded then
			warn("Cannot clear nonexistent recording")
			return
		end

		if Replay.RecordConnection then
			Replay.RecordConnection:Disconnect()
		end
		if Replay.PlayConnection then
			Replay.PlayConnection:Disconnect()
		end

		Replay.FrameCount = 0
		Replay.Frames = {}
		Replay.FrameTimes = {}
		Replay.RecordingTime = 0

		Replay.Recorded = false
		Replay.Recording = false
		Replay.Playing = false
	end

	function Replay:Destroy()
		RecordingStopped:Destroy()
		RecordingStarted:Destroy()
		FrameChanged:Destroy()

		Replay.VPF:Destroy()
		Replay.MouseDetector:Destroy()
		Replay.WheelSinker:Destroy()
		Replay.Camera:Destroy()
		Replay.Skybox:Destroy()

		if Replay.RecordConnection then
			Replay.RecordConnection:Disconnect()
		end
		if Replay.PlayConnection then
			Replay.PlayConnection:Disconnect()
		end

		for _, Object in pairs(Replay.CloneIndex) do
			Object:Destroy()
		end

		Replay = nil
	end

	local function FindFrame(f, t)
		if not f then
			return
		end

		t = t or 0

		local FrameDepth = t - (f.Time or 0)

		if (FrameDepth or 0) <= (f.FrameLength or 0) then
			return Replay:GoToFrame(f.ID + (FrameDepth / (f.FrameLength or 0)))
		else
			return FindFrame(Replay.Frames[f.ID + 1], t)
		end
	end

	function Replay:Play(PlaySpeed: number?, StartTime: number?, Override: boolean?)
		if not Replay.Recorded then
			warn("Cannot play nonexistent recording")
			return
		end
		if Replay.Playing and not Override then
			warn("Cannot play recording since playback is already in progress")
			return
		end

		if Replay.PlayConnection then
			Replay.PlayConnection:Disconnect()
		end

		PlaySpeed = math.clamp(PlaySpeed or 1, 0.02, 999)

		Replay.Playing = true

		local Timer = math.clamp(StartTime or 0, 0, Replay.RecordingTime)
		local Frame = Replay:GoToTime(Timer)

		Replay.PlayConnection = RenderStepped:Connect(function(DeltaTime)
			Timer = Timer + (DeltaTime * PlaySpeed)

			Frame = FindFrame(Frame, Timer)

			if Timer > Replay.RecordingTime or not Frame then
				Replay:Stop()
				return
			end
		end)
	end

	function Replay:Stop()
		if not Replay.Playing then
			warn("Cannot stop playback since playback isn't in progress")
			return
		end

		Replay.Playing = false
		Replay.PlayConnection:Disconnect()
	end

	function Replay:GoToPercent(Percent: number)
		if not Replay.Recorded then
			warn("Cannot go to percent since there is no recording")
			return
		end

		if DEBUG then
			print("GoToPercent:", Percent)
		end

		return Replay:GoToTime(Replay.RecordingTime * math.clamp(Percent, 0, 1))
	end

	function Replay:GoToTime(Time: number)
		if not Replay.Recorded then
			warn("Cannot go to time since there is no recording")
			return
		end

		if DEBUG then
			print("GoToTime:", Time)
		end

		-- Find frame
		for f, t in ipairs(Replay.FrameTimes) do
			if t == Time then
				return Replay:GoToFrame(f)
			else
				local FrameLength = Replay.Frames[f].FrameLength or 0
				if t + FrameLength >= Time then
					return Replay:GoToFrame(f + ((Time - t) / FrameLength))
				end
			end
		end
	end

	function Replay:GoToFrame(Frame: number)
		if not Replay.Recorded then
			warn("Cannot go to frame since there is no recording")
			return
		end

		if DEBUG then
			print("GoToFrame:", Frame)
		end

		Frame = math.clamp(Frame, 1, Replay.FrameCount)

		local StartFrameData = Replay.Frames[math.floor(Frame)]
		local EndFrameData = Replay.Frames[math.ceil(Frame)]
		local FrameDelta = Frame - math.floor(Frame)
		local Time = StartFrameData.Time + (FrameDelta * (StartFrameData.FrameLength or 0))

		FrameChanged:Fire(Frame, Time, Time / Replay.RecordingTime)

		for Object, Data in pairs(StartFrameData.ObjectData) do
			local NextData = EndFrameData.ObjectData[Object]

			if Data.Destroyed then
				Object.Transparency = 1
			else
				if NextData.Destroyed then
					Object.CFrame = Data.CFrame
					Object.Color = Data.Color
					Object.Transparency = Data.Transparency
				else
					Object.CFrame = Data.CFrame:lerp(NextData.CFrame, FrameDelta)
					Object.Color = Data.Color:lerp(NextData.Color, FrameDelta)
					Object.Transparency = Data.Transparency + ((NextData.Transparency - Data.Transparency) * FrameDelta)
				end
			end
		end

		if Replay.CameraType == "Recorded" then
			Replay.Camera.CFrame = StartFrameData.CameraCF:lerp(EndFrameData.CameraCF, FrameDelta)
		elseif Replay.CameraType == "Track" then
			Replay.Camera.CFrame = CFrame.new(
				Replay.CameraPosition or Vector3.new(0, 10, 0),
				Replay.CamSubClone.Position or Vector3.new()
			)
		elseif Replay.CameraType == "Follow" then
			Replay.Camera.CFrame = (
					CFrame.new(Replay.CamSubClone.Position)
					* (CFrame.Angles(0, Replay.CameraAngle.X or 0, 0))
					* CFrame.Angles(Replay.CameraAngle.Y or 0, 0, 0)
				) * CFrame.new(0, 0, Replay.CameraOffset or 20)
		end

		return StartFrameData
	end

	return Replay
end

return Module

]==]

 

game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Players").LocalPlayer:GetMouse();
local v1 = {};
local RenderStepped = RunService.RenderStepped;
local u2 = {
    Decal = true,
    Texture = true,
    SpecialMesh = true,
    BlockMesh = true
};

local function CleanClone(p3: userdata) -- Line: 150
    -- upvalues: u2 (copy)
    local v4 = p3:Clone();
    local Children = v4:GetChildren();

    for _, v in ipairs(Children) do
        if not u2[v.ClassName] then
            v:Destroy();
        end;
    end;

    table.clear(Children);
    v4.Anchored = true;
    v4.CanCollide = false;
    v4.CanTouch = false;
    v4.CanQuery = false;

    return v4;
end;

function v1.new(p5) -- Line: 171
    -- upvalues: CleanClone (copy), RenderStepped (copy)
    local v6 = p5 or {};
    local BindableEvent = Instance.new("BindableEvent");
    local BindableEvent2 = Instance.new("BindableEvent");
    local BindableEvent3 = Instance.new("BindableEvent");
    local u7 = {
        Playing = false,
        Recording = false,
        Recorded = false,
        FrameCount = 0,
        RecordingTime = 0,
        LastSnapshotTick = 0,
        RecordConnection = nil,
        PlayConnection = nil,
        CameraOffset = 20,
        Registers = {},
        StaticRegisters = {},
        CloneIndex = {},
        RegisteredObjects = {},
        Frames = {},
        FrameTimes = {},
        FPSDelay = 1 / (v6.FPS or 20),
        VPF = Instance.new("ViewportFrame"),
        MouseDetector = Instance.new("TextButton"),
        WheelSinker = Instance.new("ScrollingFrame"),
        Camera = Instance.new("Camera"),
        Skybox = script.Skybox:Clone(),
        RecordingStarted = BindableEvent2.Event,
        RecordingStopped = BindableEvent.Event,
        FrameChanged = BindableEvent3.Event,
        CameraType = v6.CameraType or "Recorded",
        CameraPosition = v6.CameraPosition or Vector3.new(0, 10, 0),
        CameraSubject = v6.CameraSubject,
        CameraAngle = {
            X = 0,
            Y = 0
        }
    };
    u7.VPF.CurrentCamera = u7.Camera;
    u7.VPF.Size = UDim2.new(1, 0, 1, 0);
    u7.VPF.LightColor = Color3.new(1, 1, 1);
    u7.VPF.Ambient = Color3.new(0.662745, 0.607843, 0.694118);
    u7.VPF.BorderSizePixel = 0;
    u7.Skybox.Parent = u7.VPF;
    u7.MouseDetector.Text = "";
    u7.MouseDetector.Size = UDim2.new(1, 0, 1, 0);
    u7.MouseDetector.BackgroundTransparency = 1;
    u7.MouseDetector.Parent = u7.VPF;
    u7.WheelSinker.Size = UDim2.new(1, 0, 1, 0);
    u7.WheelSinker.BackgroundTransparency = 1;
    u7.WheelSinker.ScrollBarImageTransparency = 1;
    u7.WheelSinker.BorderSizePixel = 0;
    u7.WheelSinker.Parent = u7.VPF;
    local u8 = false;
    u7.VPF.MouseEnter:Connect(function() -- Line: 242
        -- upvalues: u8 (ref)
        u8 = true;
    end);
    u7.VPF.MouseLeave:Connect(function() -- Line: 245
        -- upvalues: u8 (ref)
        u8 = false;
    end);

    function u7.Register(p9: table, u10: userdata, u11: boolean) -- Line: 253
        -- upvalues: u7 (ref), CleanClone (ref)
        task.spawn(function() -- Line: 254
            -- upvalues: u7 (ref), u10 (copy), CleanClone (ref), u11 (copy)
            if u7.Recording then
                warn("Cannot register new objects while recording is in progress");

                return;
            end;

            if typeof(u10) ~= "Instance" then
                return;
            end;

            local v12;

            if u10:IsA("Model") and u10:FindFirstChildWhichIsA("Humanoid") then
                v12 = true;

                while u10:FindFirstChildWhichIsA("BasePart") == nil do
                    task.wait(0.05);
                end;

                local Model = Instance.new("Model");
                Model.Name = u10.Name;
                local Descendants = u10:GetDescendants();

                for _, v in ipairs(Descendants) do
                    if v:IsA("BasePart") then
                        if not u7.RegisteredObjects[v] then
                            u7.RegisteredObjects[v] = true;
                            local v13 = CleanClone(v);
                            u7.CloneIndex[v] = v13;
                            u7.Registers[#u7.Registers + 1] = {
                                Mirror = v13,
                                Original = v
                            };
                            v13.Parent = Model;
                        end;
                    elseif v:IsA("CharacterMesh") then
                        v:Clone().Parent = Model;
                    end;
                end;

                table.clear(Descendants);
                local u14 = u10:FindFirstChildWhichIsA("Shirt");
                local u15 = u10:FindFirstChildWhichIsA("Pants");
                local u16 = u10:FindFirstChildWhichIsA("ShirtGraphic");

                if u14 then
                    local u17 = u14:Clone();
                    u17.Parent = Model;
                    u14.Changed:Connect(function(p18) -- Line: 322
                        -- upvalues: u17 (copy), u14 (copy)
                        u17.ShirtTemplate = u14.ShirtTemplate;
                    end);
                end;

                if u15 then
                    local u19 = u15:Clone();
                    u19.Parent = Model;
                    u15.Changed:Connect(function(p20) -- Line: 335
                        -- upvalues: u19 (copy), u15 (copy)
                        u19.PantsTemplate = u15.PantsTemplate;
                    end);
                end;

                if u16 then
                    local u21 = u16:Clone();
                    u21.Parent = Model;
                    u16.Changed:Connect(function(p22) -- Line: 348
                        -- upvalues: u21 (copy), u16 (copy)
                        u21[p22] = u16[p22];
                    end);
                end;

                local Humanoid = Instance.new("Humanoid");
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

                for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
                    if v ~= Enum.HumanoidStateType.None then
                        Humanoid:SetStateEnabled(v, false);
                    end;
                end;

                Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true);
                Humanoid.RigType = u10:FindFirstChildWhichIsA("Humanoid").RigType;
                Humanoid.Parent = Model;
                Model.Parent = u7.VPF;
            else
                v12 = false;
            end;

            if u10:IsA("BasePart") and (u10.ClassName ~= "Terrain" and (u10.Archivable and not u7.RegisteredObjects[u10])) then
                u7.RegisteredObjects[u10] = true;
                local v23 = CleanClone(u10);
                u7.CloneIndex[u10] = v23;
                u7.Registers[#u7.Registers + 1] = {
                    Mirror = v23,
                    Original = u10
                };
                v23.Parent = u7.VPF;
            end;

            if not (v12 or u11) then
                local Children = u10:GetChildren();

                for _, v in ipairs(Children) do
                    u7:Register(v);
                end;

                table.clear(Children);
            end;
        end);
    end;

    function u7.RegisterStatic(p24: table, u25: userdata, u26: boolean) -- Line: 400
        -- upvalues: u7 (ref), CleanClone (ref)
        task.spawn(function() -- Line: 401
            -- upvalues: u7 (ref), u25 (copy), CleanClone (ref), u26 (copy)
            if u7.Recording then
                warn("Cannot register new objects while recording is in progress");

                return;
            end;

            if typeof(u25) ~= "Instance" then
                return;
            end;

            local v27;

            if u25:IsA("Model") and u25:FindFirstChildWhichIsA("Humanoid") then
                v27 = true;

                while u25:FindFirstChildWhichIsA("BasePart") == nil do
                    task.wait(0.05);
                end;

                local Model = Instance.new("Model");
                Model.Name = u25.Name;
                local Descendants = u25:GetDescendants();

                for _, v in ipairs(Descendants) do
                    if v:IsA("BasePart") then
                        if u7.StaticRegisters[v] then
                            if v:IsA("CharacterMesh") then
                                v:Clone().Parent = Model;
                            end;
                        else
                            u7.StaticRegisters[v] = true;
                            local v28 = CleanClone(v);
                            u7.CloneIndex[v] = v28;
                            v28.Parent = Model;
                        end;
                    end;
                end;

                table.clear(Descendants);
                local u29 = u25:FindFirstChildWhichIsA("Shirt");
                local u30 = u25:FindFirstChildWhichIsA("Pants");
                local u31 = u25:FindFirstChildWhichIsA("ShirtGraphic");

                if u29 then
                    local u32 = u29:Clone();
                    u32.Parent = Model;
                    u29.Changed:Connect(function(p33) -- Line: 466
                        -- upvalues: u32 (copy), u29 (copy)
                        u32[p33] = u29[p33];
                    end);
                end;

                if u30 then
                    local u34 = u30:Clone();
                    u34.Parent = Model;
                    u30.Changed:Connect(function(p35) -- Line: 479
                        -- upvalues: u34 (copy), u30 (copy)
                        u34[p35] = u30[p35];
                    end);
                end;

                if u31 then
                    local u36 = u31:Clone();
                    u36.Parent = Model;
                    u31.Changed:Connect(function(p37) -- Line: 492
                        -- upvalues: u36 (copy), u31 (copy)
                        u36[p37] = u31[p37];
                    end);
                end;

                local Humanoid = Instance.new("Humanoid");
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

                for _, v in next, Enum.HumanoidStateType:GetEnumItems() do
                    if v ~= Enum.HumanoidStateType.None then
                        Humanoid:SetStateEnabled(v, false);
                    end;
                end;

                Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true);
                Humanoid.RigType = u25:FindFirstChildWhichIsA("Humanoid").RigType;
                Humanoid.Parent = Model;
                Model.Parent = u7.VPF;
            else
                v27 = false;
            end;

            if u25:IsA("BasePart") and (u25.ClassName ~= "Terrain" and (u25.Archivable and not u7.StaticRegisters[u25])) then
                u7.StaticRegisters[u25] = true;
                local v38 = CleanClone(u25);
                u7.CloneIndex[u25] = v38;
                v38.Parent = u7.VPF;
            end;

            if not (v27 or u26) then
                local Children = u25:GetChildren();

                for _, v in ipairs(Children) do
                    u7:RegisterStatic(v, u26);
                end;

                table.clear(Children);
            end;
        end);
    end;

    function u7.StartRecording(p39: table, p40: number?) -- Line: 544
        -- upvalues: u7 (ref), BindableEvent2 (copy), RenderStepped (ref)
        if u7.Recorded then
            warn("Cannot start recording until previous recording is cleared");

            return;
        end;

        if u7.Recording then
            warn("Cannot start recording since recording is already in progress");

            return;
        end;

        local u41 = p40 or 30;
        BindableEvent2:Fire();
        u7.Recording = true;
        u7.RecordConnection = RenderStepped:Connect(function(p42) -- Line: 565
            -- upvalues: u7 (ref), u41 (ref)
            if u41 < u7.RecordingTime + p42 then
                u7:StopRecording();

                return;
            end;

            u7.RecordingTime = u7.RecordingTime + p42;
            local v43 = os.clock() - u7.LastSnapshotTick;

            if u7.FPSDelay <= v43 then
                u7.FrameCount = u7.FrameCount + 1;
                u7.LastSnapshotTick = os.clock();
                u7.FrameTimes[u7.FrameCount] = u7.RecordingTime;
                local v44 = {};

                for _, v in ipairs(u7.Registers) do
                    local _ = v.Mirror;
                    local Original = v.Original;

                    if Original and Original:IsDescendantOf(game) then
                        v44[v.Mirror] = {
                            CFrame = Original.CFrame,
                            Color = Original.Color,
                            Transparency = Original.Transparency
                        };
                    else
                        v44[v.Mirror] = {
                            Destroyed = true
                        };
                    end;
                end;

                if u7.Frames[u7.FrameCount - 1] then
                    u7.Frames[u7.FrameCount - 1].FrameLength = v43;
                end;

                u7.Frames[u7.FrameCount] = {
                    ID = u7.FrameCount,
                    Time = u7.RecordingTime,
                    CameraCF = workspace.CurrentCamera.CFrame,
                    ObjectData = v44
                };
            end;
        end);
        local v45 = game.Lighting:FindFirstChildWhichIsA("Sky");

        if v45 then
            u7.Skybox.Bk.Decal.Texture = v45.SkyboxBk;
            u7.Skybox.Dn.Decal.Texture = v45.SkyboxDn;
            u7.Skybox.Ft.Decal.Texture = v45.SkyboxFt;
            u7.Skybox.Lf.Decal.Texture = v45.SkyboxLf;
            u7.Skybox.Rt.Decal.Texture = v45.SkyboxRt;
            u7.Skybox.Up.Decal.Texture = v45.SkyboxUp;
        end;
    end;

    function u7.StopRecording(p46) -- Line: 625
        -- upvalues: u7 (ref), BindableEvent (copy)
        if u7.Recorded then
            warn("Cannot stop recording since it has already stopped");

            return;
        end;

        if not u7.Recording then
            warn("Cannot stop recording since no recording is in progress");

            return;
        end;

        BindableEvent:Fire();
        u7.RecordConnection:Disconnect();
        u7.Recording = false;
        u7.Recorded = true;

        if u7.CameraSubject and u7.CloneIndex[u7.CameraSubject] then
            u7.CamSubClone = u7.CloneIndex[u7.CameraSubject];
        end;

        u7:GoToFrame(1);
    end;

    function u7.ClearRecording(p47) -- Line: 654
        -- upvalues: u7 (ref)
        if not u7.Recorded then
            warn("Cannot clear nonexistent recording");

            return;
        end;

        if u7.RecordConnection then
            u7.RecordConnection:Disconnect();
        end;

        if u7.PlayConnection then
            u7.PlayConnection:Disconnect();
        end;

        u7.FrameCount = 0;
        u7.Frames = {};
        u7.FrameTimes = {};
        u7.RecordingTime = 0;
        u7.Recorded = false;
        u7.Recording = false;
        u7.Playing = false;
    end;

    function u7.Destroy(p48) -- Line: 677
        -- upvalues: BindableEvent (copy), BindableEvent2 (copy), BindableEvent3 (copy), u7 (ref)
        BindableEvent:Destroy();
        BindableEvent2:Destroy();
        BindableEvent3:Destroy();
        u7.VPF:Destroy();
        u7.MouseDetector:Destroy();
        u7.WheelSinker:Destroy();
        u7.Camera:Destroy();
        u7.Skybox:Destroy();

        if u7.RecordConnection then
            u7.RecordConnection:Disconnect();
        end;

        if u7.PlayConnection then
            u7.PlayConnection:Disconnect();
        end;

        for _, v in pairs(u7.CloneIndex) do
            v:Destroy();
        end;

        u7 = nil;
    end;

    local function FindFrame(p49, p50) -- Line: 702
        -- upvalues: u7 (ref), FindFrame (copy)
        if p49 then
            local v51 = p50 or 0;
            local v52 = v51 - (p49.Time or 0);

            if (v52 or 0) <= (p49.FrameLength or 0) then
                return u7:GoToFrame(p49.ID + v52 / (p49.FrameLength or 0));
            end;

            return FindFrame(u7.Frames[p49.ID + 1], v51);
        end;
    end;

    function u7.Play(p53: table, p54: number?, p55: number?, p56: boolean?) -- Line: 718
        -- upvalues: u7 (ref), RenderStepped (ref), FindFrame (copy)
        if not u7.Recorded then
            warn("Cannot play nonexistent recording");

            return;
        end;

        if u7.Playing and not p56 then
            warn("Cannot play recording since playback is already in progress");

            return;
        end;

        if u7.PlayConnection then
            u7.PlayConnection:Disconnect();
        end;

        local math_clamp_ret = math.clamp(p54 or 1, 0.02, 999);
        u7.Playing = true;
        local math_clamp_ret2 = math.clamp(p55 or 0, 0, u7.RecordingTime);
        local u57 = u7:GoToTime(math_clamp_ret2);
        u7.PlayConnection = RenderStepped:Connect(function(p58) -- Line: 739
            -- upvalues: math_clamp_ret2 (ref), math_clamp_ret (ref), u57 (ref), FindFrame (ref), u7 (ref)
            math_clamp_ret2 = math_clamp_ret2 + p58 * math_clamp_ret;
            u57 = FindFrame(u57, math_clamp_ret2);

            if math_clamp_ret2 <= u7.RecordingTime and u57 then
                return;
            end;

            u7:Stop();
        end);
    end;

    function u7.Stop(p59) -- Line: 751
        -- upvalues: u7 (ref)
        if not u7.Playing then
            warn("Cannot stop playback since playback isn\'t in progress");

            return;
        end;

        u7.Playing = false;
        u7.PlayConnection:Disconnect();
    end;

    function u7.GoToPercent(p60: table, p61: number) -- Line: 761
        -- upvalues: u7 (ref)
        if u7.Recorded then
            return u7:GoToTime(u7.RecordingTime * math.clamp(p61, 0, 1));
        end;

        warn("Cannot go to percent since there is no recording");
    end;

    function u7.GoToTime(p62: table, p63: number) -- Line: 774
        -- upvalues: u7 (ref)
        if u7.Recorded then
            for i, v in ipairs(u7.FrameTimes) do
                if v == p63 then
                    return u7:GoToFrame(i);
                end;

                local v64 = u7.Frames[i].FrameLength or 0;

                if p63 <= v + v64 then
                    return u7:GoToFrame(i + (p63 - v) / v64);
                end;
            end;

            return;
        end;

        warn("Cannot go to time since there is no recording");
    end;

    function u7.GoToFrame(p65: table, p66: number) -- Line: 797
        -- upvalues: u7 (ref)
        if u7.Recorded then
            local math_clamp_ret = math.clamp(p66, 1, u7.FrameCount);
            local v67 = u7.Frames[math.floor(math_clamp_ret)];
            local v68 = u7.Frames[math.ceil(math_clamp_ret)];
            local v69 = math_clamp_ret - math.floor(math_clamp_ret);
            local v70 = v67.Time + v69 * (v67.FrameLength or 0);

            for i, v in pairs(v67.ObjectData) do
                local v71 = v68.ObjectData[i];

                if v.Destroyed then
                    i.Transparency = 1;
                elseif v71.Destroyed then
                    i.CFrame = v.CFrame;
                    i.Color = v.Color;
                    i.Transparency = v.Transparency;
                else
                    i.CFrame = v.CFrame:lerp(v71.CFrame, v69);
                    i.Color = v.Color:lerp(v71.Color, v69);
                    i.Transparency = v.Transparency + (v71.Transparency - v.Transparency) * v69;
                end;
            end;

            if u7.CameraType == "Recorded" then
                u7.Camera.CFrame = v67.CameraCF:lerp(v68.CameraCF, v69);

                return v67;
            end;

            if u7.CameraType ~= "Track" then
                if u7.CameraType == "Follow" then
                    u7.Camera.CFrame = CFrame.new(u7.CamSubClone.Position) * CFrame.Angles(0, u7.CameraAngle.X or 0, 0) * CFrame.Angles(u7.CameraAngle.Y or 0, 0, 0) * CFrame.new(5, 3, u7.CameraOffset or 20);
                end;

                return v67;
            end;

            if u7.RecordingTime / 2 < v70 then
                u7.Camera.CFrame = CFrame.new(u7.Camera.CFrame.Position, u7.CamSubClone.Position or Vector3.new());

                return v67;
            end;

            u7.Camera.CFrame = CFrame.new(u7.CamSubClone.Position) * CFrame.Angles(0, u7.CameraAngle.X or 0, 0) * CFrame.Angles(u7.CameraAngle.Y or 0, 0, 0) * CFrame.new(0, 3, u7.CameraOffset or 20);

            return v67;
        end;

        warn("Cannot go to frame since there is no recording");
    end;

    return u7;
end;

return v1;