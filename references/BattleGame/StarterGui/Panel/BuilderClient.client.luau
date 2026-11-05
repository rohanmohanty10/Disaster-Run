if workspace:GetAttribute("ServerOwner") == 0 then return script.Parent:Destroy() end 

shared.buildenabled = false

local UserInputService = game:GetService("UserInputService")
local GUI = script.Parent
local MenuContainer = GUI.MenuContainer
local MenuFrame = MenuContainer.Frame
local SideContainerFrame = MenuContainer.SideContainerFrame
local SideContainer = SideContainerFrame.SideContainer

SideContainer.Parent = script

local InfoTable = require(game.ReplicatedStorage.Info)
local LocalPlayer = game.Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local GetSerial = InfoTable.GetSerial

local function GetBlockSerial(Block)
	local Serial = GetSerial(Block)
	
	if _G.builtblocks[Serial] then
		repeat
			Serial = GetSerial(Block)
		until not _G.builtblocks[Serial]
	end
	
	return Serial
end

local BuilderModule = require(script:WaitForChild("Builder"))
_G.builtblocks = {}

MenuFrame.Grid:GetPropertyChangedSignal("Text"):Connect(function()
	local GridSize = tonumber(MenuFrame.Grid.Text)
	if not GridSize then return end
	
	BuilderModule.SetGridSize(GridSize)
end)


local ModeNames = {
	Delete = "delete", 
	Move = "move", 
	Place = "place", 
	Resize = "resize", 
	Rotate = "rotate", 
	Select = "select"
}
local Containers = {}
local ClickFunctions = {}
local MenuButtons = {}
local v24 = {}
local v25 = {}
local v26 = nil
local v27 = {}
local v28 = nil
local function v37(v29) --[[ Line: 70 ]]
	local v30 = false
	local l_pairs_0 = pairs
	local v32 = v29 or Containers
	for _, v34 in l_pairs_0(v32) do
		if v34.Parent then
			if not v30 then
				v30 = true
				shared.sfx({
					SoundId = ({
						"rbxassetid://15675028888", 
						"rbxassetid://15675024286", 
						"rbxassetid://15674975792"
					})[math.random(1, 3)], 
					Parent = workspace, 
					Volume = 0.3
				}):Play()
			end
			v34:TweenPosition(UDim2.new(v34.Position.X.Scale, 0, 1.75, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.75, true)
			task.delay(0.5, function() --[[ Line: 83 ]]
				v34:Destroy()
			end)
		end
	end
	table.clear(v29 or Containers)
	if not v29 then
		for _, v36 in pairs(v27) do
			v36:Disconnect()
		end
		table.clear(v27)
	end
end
local v38 = 0
local function v49(v39, v40, v41, v42) --[[ Line: 98 ]]
	local v43 = v40 or v24
	shared.sfx({
		SoundId = ({
			"rbxassetid://15675028888", 
			"rbxassetid://15675024286", 
			"rbxassetid://15674975792"
		})[math.random(1, 3)], 
		Parent = workspace, 
		Volume = 0.3
	}):Play()
	v37(v43)
	if (v41 or MenuContainer.SideContainerFrameTwo):FindFirstChild("ColorFrame") then
		return
	else
		local v44 = script.ColorFrame:Clone()
		v44.Position = UDim2.new(2.5, 0, 0.25, 0)
		v44.Parent = v41 or MenuContainer.SideContainerFrameTwo
		v44:TweenPosition(UDim2.new(1.069, 0, 0.25, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.75, true)
		table.insert(Containers, v44)
		v44.Preview:GetPropertyChangedSignal("BackgroundColor3"):Connect(function() --[[ Line: 117 ]]
			if v42 then
				return v42(v44.Preview.BackgroundColor3)
			else
				local l_Communicate_0 = game.ReplicatedStorage.Remotes.Comunicator.Set
				if l_Communicate_0 then
					local v46 = {}
					for _, v48 in pairs(BuilderModule.lockedTargetObjects) do
						table.insert(v46, {
							Serial = v48:GetAttribute("Serial")
						})
						v48.Color = v44.Preview.BackgroundColor3
					end
					l_Communicate_0:FireServer("Buildmode", {
						Todo = "Change Color", 
						Color = v39.Color, 
						List = v46
					})
				end
				return
			end
		end)
		table.insert(v43, v44)
		return
	end
end
local v50 = nil
v50 = function(v51) --[[ Line: 141 ]]
	shared.sfx({
		SoundId = ({
			"rbxassetid://15675028888", 
			"rbxassetid://15675024286", 
			"rbxassetid://15674975792"
		})[math.random(1, 3)], 
		Parent = workspace, 
		Volume = 0.3
	}):Play()
	v37(v24)
	local v52 = v51.Parent or MenuContainer.SideContainerFrameTwo
	if v52:FindFirstChild("SideContainer" .. v51.Title) then
		return
	else
		local v53 = SideContainer:Clone()
		local v54 = v53.ScrollingFrame:FindFirstChild("Transparency"):Clone()
		local v55 = v53.ScrollingFrame.Material:Clone()
		local v56 = nil
		for _, v58 in pairs(v53.ScrollingFrame:GetChildren()) do
			if v58.Name ~= "ImageButton" and v58.Name ~= "UIListLayout" then
				v58:Destroy()
			end
		end
		v37(v24)
		v53.ScrollingFrame.ImageButton:Destroy()
		v53:SetAttribute("Title", v51.Title)
		if v51.Title == "Gears" then
			v56 = script.Search:Clone()
			v56.LayoutOrder = 0
			v56.Parent = v53.ScrollingFrame
			local v59 = 0
			local function _(v60, v61) --[[ Line: 176 ]]
				return string.sub(string.lower(v60), 1, (string.len(v61))) == string.lower(v61)
			end
			do
				local l_v59_0 = v59
				v56:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 180 ]]
					l_v59_0 = tick()
					task.delay(0.3, function() --[[ Line: 183 ]]
						if tick() - l_v59_0 > 0.3 then
							local l_Text_0 = v56.Text
							for _, v66 in pairs(v56.Parent:GetChildren()) do
								if v66:IsA("TextButton") then
									local v67 = false
									local l_Text_1 = v66.Text
									if string.sub(string.lower(l_Text_1), 1, (string.len(l_Text_0))) == string.lower(l_Text_0) then
										v67 = true
									else
										local v69 = v66.Name:split(" ")
										if #v69 > 1 then
											for _, InfoTable1 in pairs(v69) do
												if string.sub(string.lower(InfoTable1), 1, (string.len(l_Text_0))) == string.lower(l_Text_0) then
													v67 = true
													break
												end
											end
										end
									end
									if v67 then
										v66.Visible = true
									else
										v66.Visible = false
									end
								end
							end
						end
					end)
				end)
			end
		end
		local l_ImageButton_0 = v53.ScrollingFrame.ImageButton
		l_ImageButton_0.LayoutOrder = 0
		l_ImageButton_0.BackgroundColor3 = Color3.fromRGB(148, 255, 166)
		l_ImageButton_0.TextLabel.Text = v51.Title
		v53.Position = UDim2.new(1.5, 0, 0.5, 0)
		v53.Name = v53.Name .. v51.Title
		v53.Parent = v52
		v53:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.75, true)
		table.insert(Containers, v53)
		table.insert(v24, v53)
		local InfoTable3 = BuilderModule.lockedTargetObjects[1]
		local InfoTable4 = nil
		local InfoTable5 = nil
		if InfoTable3 then
			InfoTable4 = InfoTable3:GetAttribute("CurrentMoves") or "[]"
			InfoTable4 = game:GetService("HttpService"):JSONDecode(InfoTable4)
			InfoTable5 = InfoTable3:GetAttribute("CurrentGears") or "[]"
			InfoTable5 = game:GetService("HttpService"):JSONDecode(InfoTable5)
		end
		for _, InfoTable7 in pairs(v51.Contents) do
			local InfoTable8 = nil
			local l_InfoTable7_0 = InfoTable7
			local v80 = nil
			local v81 = nil
			local v82 = nil
			local v83 = nil
			if typeof(InfoTable7) == "table" then
				l_InfoTable7_0 = InfoTable7[1]
				v80 = rawget(InfoTable7, "Text")
				v81 = rawget(InfoTable7, "Toggle")
				v82 = rawget(InfoTable7, "Color")
				v83 = rawget(InfoTable7, "ToolName")
			end
			InfoTable8 = if v80 then v54:Clone() else v55:Clone()
			InfoTable8.TextWrapped = true
			if InfoTable8:IsA("TextButton") then
				InfoTable8.Text = l_InfoTable7_0
			else
				InfoTable8.PlaceholderText = l_InfoTable7_0
			end
			InfoTable8.Name = l_InfoTable7_0
			InfoTable8.Parent = v53.ScrollingFrame
			if v82 then
				InfoTable8.TextColor3 = v82
			end
			local v84 = nil
			if v81 then
				InfoTable8.LayoutOrder = 0
				local v85 = nil
				v85 = if v51.Title == "Moves" then table.find(InfoTable4, l_InfoTable7_0) else if v51.Title == "Gears" then table.find(InfoTable5, l_InfoTable7_0) else BuilderModule.lockedTargetObjects[1]:GetAttribute(string.gsub(InfoTable8.Text, " ", ""))
				v84 = script.Toggle:Clone()
				v84.Parent = InfoTable8
				v84.BackgroundColor3 = not v85 and Color3.fromRGB(255, 87, 87) or Color3.fromRGB(114, 255, 98)
			end
			do
				local l_InfoTable8_0, l_l_InfoTable7_0_0, l_v83_0, l_v84_0 = InfoTable8, l_InfoTable7_0, v83, v84
				if l_InfoTable8_0:IsA("TextButton") then
					l_InfoTable8_0.MouseButton1Click:Connect(function() --[[ Line: 285 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local l_Character_0 = LocalPlayer.Character
						local l_Communicate_1 = game.ReplicatedStorage.Remotes.Comunicator.Set
						if l_Communicate_1 then
							if v51.Title == "Object" then
								BuilderModule.setObject(l_l_InfoTable7_0_0)
								return
							elseif l_l_InfoTable7_0_0 == "Emit Light" then
								local v92 = {}
								local l_Attribute_0 = BuilderModule.lockedTargetObjects[1]:GetAttribute("EmitLight")
								for _, v95 in pairs(BuilderModule.lockedTargetObjects) do
									table.insert(v92, {
										Serial = v95:GetAttribute("Serial")
									})
									v95:SetAttribute("EmitLight", not l_Attribute_0)
								end
								if l_Attribute_0 then
									l_v84_0.BackgroundColor3 = Color3.fromRGB(255, 87, 87)
								else
									l_v84_0.BackgroundColor3 = Color3.fromRGB(114, 255, 98)
								end
								l_Communicate_1:FireServer("Buildmode", {
									Todo = "Property Change", 
									List = v92, 
									Property = "EmitLight", 
									New = not l_Attribute_0
								})
								return
							elseif v51.Title == "Save Menu" then
								if l_l_InfoTable7_0_0 == "Buy Slot" then
									return game:GetService("MarketplaceService"):PromptProductPurchase(LocalPlayer, 3275206071)
									
								elseif l_l_InfoTable7_0_0 == "Clear Current" then
									local l_BindableFunction_0 = Instance.new("BindableFunction")
									l_BindableFunction_0.OnInvoke = function(Answer)
										if Answer == "Yes" then
											l_Communicate_1:FireServer("Buildmode", {
												Todo = "Clear"
											})
											
											if l_Character_0:GetAttribute("OPped") and workspace:GetAttribute("ServerOwner") ~= LocalPlayer.UserId then return end
											
											for _, v99 in pairs(game:GetService("CollectionService"):GetTagged("psbuilt2")) do
												v99:Destroy()
											end
											for _, v101 in pairs(game:GetService("CollectionService"):GetTagged("PSBuilt")) do
												v101:Destroy()
											end
										end
									end
									
									game.StarterGui:SetCore("SendNotification", {
										Title = string.sub(l_l_InfoTable7_0_0, 0, 5):upper(), 
										Text = string.format("Are you sure you want to clear the current map, this cannot be undone!"), 
										Duration = 5, 
										Button1 = "Yes", 
										Button2 = "No", 
										Callback = l_BindableFunction_0
									})
									
									shared.sfx({
										SoundId = "rbxassetid://3398620867", 
										Parent = LocalPlayer.PlayerGui, 
										Volume = 0.5
									}):Play()
									
									return
										
								else
									local v102 = string.sub(l_l_InfoTable7_0_0, 0, 4)
									if v102 == "Save" or v102 == "Load" then
										if tick() - (v38 or 0) < 6.25 then
											game:GetService("StarterGui"):SetCore("SendNotification", {
												Title = "NOTIFICATION", 
												Text = "PLEASE WAIT A LITTLE BEFORE USING THIS AGAIN", 
												Duration = 5
											})
											
											shared.sfx({
												SoundId = "rbxassetid://3398620867", 
												Parent = LocalPlayer.PlayerGui, 
												Volume = 0.5
											}):Play()
											
											return
												
										else
											local l_BindableFunction_1 = Instance.new("BindableFunction")
											l_BindableFunction_1.OnInvoke = function(v104) --[[ Line: 383 ]]
												if v104 == "Yes" then
													v38 = tick() - 5
													l_Communicate_1:FireServer("Buildmode", {
														Todo = l_l_InfoTable7_0_0
													})
												end
											end
											
											game.StarterGui:SetCore("SendNotification", {
												Title = string.sub(l_l_InfoTable7_0_0, 0, 4):upper(), 
												Text = string.format("Are you sure you want to %s slot %s?", v102 == "Save" and "save to" or "load", (string.sub(l_l_InfoTable7_0_0, 6, 6))), 
												Duration = 5, 
												Button1 = "Yes", 
												Button2 = "No", 
												Callback = l_BindableFunction_1
											})
											
											shared.sfx({
												SoundId = "rbxassetid://3398620867", 
												Parent = LocalPlayer.PlayerGui, 
												Volume = 0.5
											}):Play()
											
											return
												
										end
										
									else
										return
										
									end
								end
								
							elseif v51.Title == "Text Display" then
								if l_l_InfoTable7_0_0 == "Text Color" then
									v49(InfoTable3, v25, MenuContainer.SideContainerFrameThree, function(v105)
										local v106 = {}
										for _, v108 in pairs(BuilderModule.lockedTargetObjects) do
											table.insert(v106, {
												Serial = v108:GetAttribute("Serial")
											})
											v108:SetAttribute("TextColor", v105)
										end
										
										l_Communicate_1:FireServer("Buildmode", {
											Todo = "Property Change", 
											List = v106, 
											Property = "TextColor", 
											New = v105
										})
									end)
									
									return
									
								elseif l_l_InfoTable7_0_0 == "Text Font" then
									local v109 = {}
									for _, v111 in pairs(Enum.Font:GetEnumItems()) do
										table.insert(v109, v111.Name)
									end
									v50({
										Title = "Font", 
										Contents = v109
									})
									return
								else
									if l_l_InfoTable7_0_0 == "Text Outline" then
										local v112 = {}
										local l_Attribute_1 = BuilderModule.lockedTargetObjects[1]:GetAttribute("TextOutline")
										for _, v115 in pairs(BuilderModule.lockedTargetObjects) do
											table.insert(v112, {
												Serial = v115:GetAttribute("Serial")
											})
											v115:SetAttribute("TextOutline", not l_Attribute_1)
										end
										if l_Attribute_1 then
											l_v84_0.BackgroundColor3 = Color3.fromRGB(255, 87, 87)
										else
											l_v84_0.BackgroundColor3 = Color3.fromRGB(114, 255, 98)
										end
										l_Communicate_1:FireServer("Buildmode", {
											Todo = "Property Change", 
											List = v112, 
											Property = "TextOutline", 
											New = not l_Attribute_1
										})
									end
									return
								end
							elseif v51.Title == "Moves" then
								local v116 = BuilderModule.lockedTargetObjects[1]:GetAttribute("CurrentMoves") or "[]"
								v116 = game:GetService("HttpService"):JSONDecode(v116)
								if table.find(v116, l_l_InfoTable7_0_0) then
									l_v84_0.BackgroundColor3 = Color3.fromRGB(255, 87, 87)
									local v117 = table.find(v116, l_l_InfoTable7_0_0)
									if v117 then
										table.remove(v116, v117)
									end
								else
									l_v84_0.BackgroundColor3 = Color3.fromRGB(114, 255, 98)
									table.insert(v116, l_l_InfoTable7_0_0)
								end
								v116 = game:GetService("HttpService"):JSONEncode(v116)
								local v118 = {}
								for _, v120 in pairs(BuilderModule.lockedTargetObjects) do
									table.insert(v118, {
										Serial = v120:GetAttribute("Serial")
									})
									v120:SetAttribute("CurrentMoves", v116)
								end
								l_Communicate_1:FireServer("Buildmode", {
									Todo = "Change Moves", 
									New = v116, 
									List = v118
								})
								return
							elseif v51.Title == "Gears" then
								local v121 = BuilderModule.lockedTargetObjects[1]:GetAttribute("CurrentGears") or "[]"
								v121 = game:GetService("HttpService"):JSONDecode(v121)
								if table.find(v121, l_v83_0) then
									l_v84_0.BackgroundColor3 = Color3.fromRGB(255, 87, 87)
									local v122 = table.find(v121, l_v83_0)
									if v122 then
										table.remove(v121, v122)
									end
								else
									l_v84_0.BackgroundColor3 = Color3.fromRGB(114, 255, 98)
									table.insert(v121, l_v83_0)
								end
								v121 = game:GetService("HttpService"):JSONEncode(v121)
								local v123 = {}
								for _, v125 in pairs(BuilderModule.lockedTargetObjects) do
									table.insert(v123, {
										Serial = v125:GetAttribute("Serial")
									})
									v125:SetAttribute("CurrentGears", v121)
								end
								l_Communicate_1:FireServer("Buildmode", {
									Todo = "Change Gears", 
									New = v121, 
									List = v123
								})
								return
							else
								local v126 = {}
								for _, v128 in pairs(BuilderModule.lockedTargetObjects) do
									table.insert(v126, {
										Serial = v128:GetAttribute("Serial")
									})
									if v51.Title == "Font" then
										v128:SetAttribute("TextFont", Enum.Font[l_l_InfoTable7_0_0])
									else
										v128.Material = Enum.Material[l_l_InfoTable7_0_0]
									end
								end
								l_Communicate_1:FireServer("Buildmode", {
									Todo = "Change " .. v51.Title, 
									List = v126, 
									New = l_l_InfoTable7_0_0
								})
							end
						end
					end)
				else
					local v129 = 0
					do
						local l_v129_0 = v129
						l_InfoTable8_0:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 553 ]]
							l_v129_0 = tick()
							local l_Communicate_2 = game.ReplicatedStorage.Remotes.Comunicator.Set
							if v51.Title == "Light" or v51.Title == "Text Display" then
								if l_InfoTable8_0.PlaceholderText ~= "Text" and not tonumber(l_InfoTable8_0.Text) then
									return
								else
									if l_InfoTable8_0.PlaceholderText == "Text" then
										task.wait(0.3)
									end
									if tick() - l_v129_0 >= 0.3 or l_InfoTable8_0.PlaceholderText ~= "Text" then
										local v132 = {}
										local v133 = string.gsub(l_InfoTable8_0.PlaceholderText, " ", "")
										for _, v135 in pairs(BuilderModule.lockedTargetObjects) do
											table.insert(v132, {
												Serial = v135:GetAttribute("Serial")
											})
											if l_InfoTable8_0.PlaceholderText ~= "Text" then
												v135:SetAttribute(v133, l_InfoTable8_0.Text)
											end
										end
										l_Communicate_2:FireServer("Buildmode", {
											Todo = "Property Change", 
											List = v132, 
											Property = v133, 
											New = l_InfoTable8_0.Text
										})
									end
									return
								end
							else
								return
							end
						end)
					end
				end
			end
		end
		local l_ScrollingFrame_0 = v53.ScrollingFrame
		local function v137() --[[ Line: 595 ]]
			l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y)
		end
		l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y)
		l_ScrollingFrame_0.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v137)
		return
	end
end
local function v139(v138) --[[ Line: 602 ]]
	if typeof(v138) == "string" then
		v138 = MenuButtons[v138]
	end
	if v26 then
		v26.Frame.BackgroundTransparency = 0.7
		v26.Frame.BackgroundColor3 = Color3.new(0, 0, 0)
	end
	v138.Frame.BackgroundTransparency = 0
	v138.Frame.BackgroundColor3 = Color3.new(1, 1, 1)
	v26 = v138
end
separateCapLockedChars = function(v140) --[[ Line: 616 ]] --[[ Name: separateCapLockedChars ]]
	local v141 = ""
	for v142 = 1, #v140 do
		local v143 = v140:sub(v142, v142)
		if v143:match("%u") and v142 > 1 then
			v141 = v141 .. " "
		end
		v141 = v141 .. v143
	end
	return v141
end
for _, v145 in pairs(MenuFrame:GetChildren()) do
	if v145:IsA("TextButton") then
		if v145.Text == "Save Menu" then
			v145.MouseButton1Click:Connect(function() --[[ Line: 631 ]]
				shared.sfx({
					SoundId = "rbxassetid://15675055424", 
					Parent = workspace, 
					Volume = 0.3
				}):Play()
				local v146 = {}
				for v147 = 1, LocalPlayer:GetAttribute("SaveSlots") do
					table.insert(v146, "Save " .. v147)
				end
				for v148 = 1, LocalPlayer:GetAttribute("SaveSlots") do
					table.insert(v146, "Load " .. v148)
				end
				table.insert(v146, {
					"Buy Slot",
					Color = Color3.fromRGB(255, 216, 19)
				})
				table.insert(v146, {
					"Clear Current",
					COlor = BrickColor.new("Persimmon").Color
				})
				local l_SideContainerFrame_Children_0 = SideContainerFrame:GetChildren()
				if l_SideContainerFrame_Children_0[1] and (l_SideContainerFrame_Children_0[1]:GetAttribute("Title") == "Save Menu" or l_SideContainerFrame_Children_0[1]:GetAttribute("Title") == "Object") then
					l_SideContainerFrame_Children_0 = {}
				end
				local v150 = false
				if #l_SideContainerFrame_Children_0 == 0 then
					v150 = SideContainerFrame
				end
				return v50({
					Title = "Save Menu", 
					Parent = v150, 
					Contents = v146
				})
			end)
		end
		local v151 = rawget(ModeNames, v145.Name)
		if v151 then
			MenuButtons[v151] = v145
			local function v154() --[[ Line: 668 ]]
				shared.sfx({
					SoundId = "rbxassetid://15675055424", 
					Parent = workspace, 
					Volume = 0.3
				}):Play()
				v139(v145)
				BuilderModule.SetMode(v151)
				if v151 == "place" then
					local l_SideContainerFrame_Children_1 = SideContainerFrame:GetChildren()
					if l_SideContainerFrame_Children_1[1] and (l_SideContainerFrame_Children_1[1]:GetAttribute("Title") == "Save Menu" or l_SideContainerFrame_Children_1[1]:GetAttribute("Title") == "Object") then
						l_SideContainerFrame_Children_1 = {}
					end
					local v153 = false
					if #l_SideContainerFrame_Children_1 == 0 then
						v153 = SideContainerFrame
					end
					v50({
						Title = "Object", 
						Parent = SideContainerFrame, 
						Contents = {
							"Block", 
							"Spawn Location", 
							"Trashcan"
						}
					})
					BuilderModule.Default = nil
				end
			end
			v145.MouseButton1Click:Connect(v154)
			ClickFunctions[v151] = v154
		end
	end
end
local v155 = {
	[Enum.KeyCode.One] = "place", 
	[Enum.KeyCode.Two] = "select", 
	[Enum.KeyCode.Three] = "move", 
	[Enum.KeyCode.Four] = "rotate", 
	[Enum.KeyCode.Five] = "resize", 
	[Enum.KeyCode.Six] = "delete"
}
local function v166(v156) --[[ Line: 712 ]]
	if #BuilderModule.lockedTargetObjects == 1 then
		BuilderModule.Clone(v156)
		local v157 = v156:Clone()
		v157:SetAttribute("Serial", nil)
		BuilderModule.Default = v157
		BuilderModule.SetMode("place", true)
		v139("place")
		return
	else
		local v158 = {}
		for _, v160 in pairs(BuilderModule.lockedTargetObjects) do
			local v161 = v160:Clone()
			local v162 = GetBlockSerial(v161)
			v161:SetAttribute("Serial", v162)
			v161.Parent = workspace
			BuilderModule.PartCreated:Fire(v161, v162, v161.CFrame)
			table.insert(v158, v161)
		end
		BuilderModule.ResetSelection()
		for _, v164 in pairs(v158) do
			BuilderModule.ToggleSelection(v164)
			local l_SpecialMesh_0 = v164:FindFirstChildOfClass("SpecialMesh")
			if l_SpecialMesh_0 then
				l_SpecialMesh_0:Destroy()
			end
		end
		BuilderModule.SetMode("move")
		v139("move")
		return
	end
end
UserInputService.InputBegan:Connect(function(v167, v168) --[[ Line: 745 ]]
	if v168 then
		return
	else
		if v167.KeyCode == Enum.KeyCode.R and not BuilderModule.ghostObject then
			local l_l_Builder_0_Mode_0 = BuilderModule:GetMode()
			if (l_l_Builder_0_Mode_0 == "rotate" or l_l_Builder_0_Mode_0 == "move") and #BuilderModule.lockedTargetObjects > 0 then
				BuilderModule.SetMode(l_l_Builder_0_Mode_0 == "rotate" and "move" or "rotate")
				v139(BuilderModule:GetMode())
				return
			end
		elseif v167.KeyCode == Enum.KeyCode.V and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and #BuilderModule.lockedTargetObjects > 0 and not BuilderModule.ghostObject then
			v166(BuilderModule.lockedTargetObjects[1])
			return
		elseif BuilderModule.active then
			local v170 = v155[v167.KeyCode]
			if v170 then
				ClickFunctions[v170]()
			end
		end
		return
	end
end)
local function v208() --[[ Line: 765 ]]
	local v171 = BuilderModule.lockedTargetObjects[1]
	if BuilderModule:GetMode() == "select" and v171 then
		v171 = workspace.Built:FindFirstChild(v171.Name)
		if not v171 then return end
		
		if v28 ~= v171 then
			v37()
			table.insert(v27, v171:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 773 ]]
				if not v171.Parent then
					v37()
				end
			end))
			local v172 = SideContainer:Clone()
			for _, v174 in pairs(v172:GetDescendants()) do
				if v174.Name == "Toggle" then
					local l_Parent_1 = v174.Parent
					local v176 = string.gsub(l_Parent_1.Name, " ", "")
					v174.BackgroundColor3 = not v171:GetAttribute(v176) and Color3.fromRGB(255, 87, 87) or Color3.fromRGB(114, 255, 98)
					if not v171:IsA("SpawnLocation") then
						if l_Parent_1.Name == "Checkpoint" then
							l_Parent_1:Destroy()
						end
					elseif l_Parent_1.Name == "Destructible" or l_Parent_1.Name == "Fragile" or l_Parent_1.Name == "No Attack" then
						l_Parent_1:Destroy()
					end
					if l_Parent_1.Parent then
						l_Parent_1.MouseButton1Click:Connect(function() --[[ Line: 798 ]]
							shared.sfx({
								SoundId = "rbxassetid://15675055424", 
								Parent = workspace, 
								Volume = 0.3
							}):Play()
							local l_Communicate_3 = game.ReplicatedStorage.Remotes.Comunicator.Set
							local CurrentValue = v171:GetAttribute(v176)
							
							if not l_Communicate_3 then
								return
							else
								local v179 = {}
								for _, v181 in pairs(BuilderModule.lockedTargetObjects) do
									table.insert(v179, {
										Serial = v181:GetAttribute("Serial")
									})
									if v181:GetAttribute("NoAttack") then
										game:GetService("CollectionService"):AddTag(v181, "NoAttackPS")
									else
										game:GetService("CollectionService"):RemoveTag(v181, "NoAttackPS")
									end
								end
								if CurrentValue then
									v174.BackgroundColor3 = Color3.fromRGB(255, 87, 87)
								else
									v174.BackgroundColor3 = Color3.fromRGB(114, 255, 98)
								end
								
								l_Communicate_3:FireServer("Buildmode", {
									Todo = "Property Change", 
									List = v179, 
									Property = v176, 
									New = not CurrentValue
								})
								return
							end
						end)
					end
				elseif v174.Name == "Clone" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 844 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						v166(v171)
					end)
				elseif v174.Name == "Material" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 854 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local v182 = {}
						for _, v184 in pairs(Enum.Material:GetEnumItems()) do
							table.insert(v182, v184.Name)
						end
						v50({
							Title = "Material", 
							Contents = v182
						})
					end)
				elseif v174.Name == "Light" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 871 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local v185 = {
							{
								"Emit Light",
								Toggle = true
							}, 
							{
								"Range",
								Text = true
							}, 
							{
								"Brightness",
								Text = true
							}
						}
						v50({
							Title = "Light", 
							Contents = v185
						})
					end)
				elseif v174.Name == "Text" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 889 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local v186 = {
							{
								"Text",
								Text = true
							}, 
							{
								"Text Font",
								Button = true
							}, 
							{
								"Text Color",
								Button = true
							}, 
							{
								"Text Transparency",
								Text = true
							}, 
							{
								"Text Outline",
								Toggle = true
							}
						}
						v50({
							Title = "Text Display", 
							Contents = v186
						})
					end)
				elseif v174.Name == "Moveset Modifier" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 909 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local v187 = {
							{
								"Random Moveset",
								Toggle = true
							}, 
							{
								"Clear Previous",
								Toggle = true
							}
						}
						for v188, v189 in pairs(InfoTable.Movesets) do
							for _, v191 in pairs(v189.Base) do
								table.insert(v187, {
									v191,
									Toggle = true
								})
							end
							
							for _, v193 in pairs(v189.Ultimate) do
								table.insert(v187, {
									v193,
									Toggle = true
								})
							end
						end
						
						v50({
							Title = "Moves", 
							Contents = v187
						})
					end)
				elseif v174.Name == "Gear Spawner" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 937 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						local v196 = {
							{
								"Random Gears",
								Toggle = true, 
								ToolName = "Random Gears"
							}, 
							{
								"Clear Previous",
								Toggle = true, 
								ToolName = "Clear Previous"
							}
						}
						local l_Children_0 = game.ReplicatedStorage.Gears:GetChildren()
						table.sort(l_Children_0, function(v198, v199) --[[ Line: 946 ]]
							return string.byte(string.sub(v198.Name, 1, 1):lower()) < string.byte(string.sub(v199.Name, 1, 1):lower())
						end)
						for _, v201 in pairs(l_Children_0) do
							table.insert(v196, {
								separateCapLockedChars(v201.Name),
								Toggle = true, 
								ToolName = v201.Name
							})
						end
						v50({
							Title = "Gears", 
							Contents = v196
						})
					end)
				elseif v174.Name == "Transparency" then
					v174:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 959 ]]
						local l_Communicate_4 = game.ReplicatedStorage.Remotes.Comunicator.Set
						if not l_Communicate_4 then
							v174.Text = v171.Transparency
							return
						elseif not tonumber(v174.Text) then
							v174.Text = v171.Transparency
							return
						else
							if tonumber(v174.Text) > 1 then
								v174.Text = 1
							end
							local v203 = {}
							for _, v205 in pairs(BuilderModule.lockedTargetObjects) do
								table.insert(v203, {
									Serial = v205:GetAttribute("Serial")
								})
								v205:SetAttribute("Transparency", v174.Text)
								v205.Transparency = v174.Text
							end
							l_Communicate_4:FireServer("Buildmode", {
								Todo = "Property Change", 
								List = v203, 
								Property = "Transparency", 
								New = v174.Text
							})
							return
						end
					end)
				elseif v174.Name == "Color" then
					v174.MouseButton1Click:Connect(function() --[[ Line: 985 ]]
						shared.sfx({
							SoundId = "rbxassetid://15675055424", 
							Parent = workspace, 
							Volume = 0.3
						}):Play()
						v49(v171)
					end)
				end
			end
			local l_ScrollingFrame_1 = v172.ScrollingFrame
			local function v207() --[[ Line: 998 ]]
				l_ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_1.UIListLayout.AbsoluteContentSize.Y)
			end
			l_ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, l_ScrollingFrame_1.UIListLayout.AbsoluteContentSize.Y)
			l_ScrollingFrame_1.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v207)
			v172.Position = UDim2.new(1.5, 0, 0.5, 0)
			v172.Parent = SideContainerFrame
			v172:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.75, true)
			table.insert(Containers, v172)
			shared.sfx({
				SoundId = ({
					"rbxassetid://15675028888", 
					"rbxassetid://15675024286", 
					"rbxassetid://15674975792"
				})[math.random(1, 3)], 
				Parent = workspace, 
				Volume = 0.3
			}):Play()
			v28 = v171
			return
		end
	else
		v28 = nil
		v37()
	end
end
local v209 = false
shared.buildmode = function()
	shared.buildenabled = true
	shared.repfire("flystart")
	
	if not LocalCharacter:FindFirstChild("flyhighlight") then
		local Highlight = Instance.new("Highlight")
		Highlight.Name = "flyhighlight"
		Highlight.FillColor = Color3.fromRGB(1, 175, 255)
		Highlight.FillTransparency = 0.8
		Highlight.OutlineTransparency = 1
		Highlight.Parent = LocalCharacter
	end
	
	local v210 = BuilderModule.Activate(v208)
	BuilderModule.SetGridSize(4)
	BuilderModule.SetAngleSnap(5)
	BuilderModule.SetMoveSnap(0)
	BuilderModule.SetResizeSnap(0.25)
	v210.Orientation = Vector3.new(0, -67.4990005493164, 0)
	GUI.Enabled = true
	if not v209 then
		if not shared.ismobile then
			game.StarterGui:SetCore("SendNotification", {
				Title = "INFO", 
				Text = string.format("Hold left control to multi select :)"), 
				Duration = 5
			})
		end
		v209 = true
		LocalPlayer:GetAttributeChangedSignal("SaveBuildCD"):Connect(function() --[[ Line: 1041 ]]
			v38 = tick()
		end)
	end
end
shared.nobuildmode = function()
	shared.buildenabled = false
	shared.repfire("flyend")
	
	local Highlight = LocalCharacter:FindFirstChild("flyhighlight")
	if Highlight then
		Highlight:Destroy()
	end
	
	GUI.Enabled = false
	BuilderModule.ResetSelection()
	BuilderModule.Deactivate()
	if v26 then
		v26.Frame.BackgroundTransparency = 0.7
		v26.Frame.BackgroundColor3 = Color3.new(0, 0, 0)
	end
end
LocalPlayer.CharacterAdded:Connect(shared.nobuildmode)
for _, v212 in pairs({
	SideContainerFrame, 
	MenuContainer.SideContainerFrameTwo, 
	MenuContainer.SideContainerFrameThree
	}) do
	local function v213() --[[ Line: 1060 ]]
		if #v212:GetChildren() == 0 then
			v212.Visible = false
			return
		else
			v212.Visible = true
			return
		end
	end
	v212.ChildAdded:Connect(v213)
	v212.ChildRemoved:Connect(v213)
	if #v212:GetChildren() == 0 then
		v212.Visible = false
	else
		v212.Visible = true
	end
end
BuilderModule.PartCreated:Connect(function(v214, v215, v216) --[[ Line: 1073 ]]
	local l_Communicate_5 = game.ReplicatedStorage.Remotes.Comunicator.Set
	local v218 = v215 or GetBlockSerial(v214)
	
	l_Communicate_5:FireServer("Buildmode", {
		Todo = "Place", 
		Class = v214:HasTag("Throwable") and "Throwable" or v214.ClassName, 
		Properties = v214:GetAttributes(), 
		Size = v214.Size, 
		Serial = v218, 
		Transparency = v214:GetAttribute("Transparency"), 
		Material = v214.Material, 
		Color = v214.Color, 
		CFrame = v216 or BuilderModule.currentGoal
	})
	v214:SetAttribute("Serial", v218)
end)
BuilderModule.PartRemoved:Connect(function(v219) --[[ Line: 1091 ]]
	local l_Communicate_6 = game.ReplicatedStorage.Remotes.Comunicator.Set
	local v221 = v219:GetAttribute("Serial") or GetBlockSerial(v219)
	if v221 then
		l_Communicate_6:FireServer("Buildmode", {
			Todo = "Delete", 
			Serial = v221
		})
		shared.sfx({
			SoundId = "rbxassetid://15675075163", 
			CFrame = v219.CFrame, 
			Volume = 0.2
		}):Play()
	end
end)
BuilderModule.PartChanged:Connect(function(v222)
	local l_Communicate_7 = game.ReplicatedStorage.Remotes.Comunicator.Set
	local v224 = {}
	for _, v226 in pairs(v222) do
		table.insert(v224, {
			Serial = v226:GetAttribute("Serial") or v226.Name, 
			Size = v226.Size, 
			CFrame = v226.CFrame
		})
	end
	l_Communicate_7:FireServer("Buildmode", {
		Todo = "Resize", 
		List = v224
	})
end)