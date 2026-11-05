 
local l_Signal_0 = require(script:WaitForChild("Signal"))
local l_BoxSelection_0 = require(script:WaitForChild("BoxSelection"))
local l_LocalPlayer_0 = game.Players.LocalPlayer

local v4 = {}
local BuilderModule = {
    PartChanged = l_Signal_0(), 
    PartCreated = l_Signal_0(), 
    PartRemoved = l_Signal_0(), 
    gridSize = 4, 
    sizeSnap = 0.2, 
    moveSnap = 0.2, 
    ghostObjectSkyPlaceDist = 60, 
    angleSnap = 0.2617993877991494, 
    mode = "none", 
    targetObject = nil, 
    lockedTargetObjects = {}, 
    mouseHittableObjects = {}, 
    ghostObject = nil, 
    base = nil, 
    active = false
}
local PlayersService = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local v11 = nil
BuilderModule.currentGoal = nil
local l_LocalPlayer_1 = PlayersService.LocalPlayer
local l_PlayerGui_0 = l_LocalPlayer_1:WaitForChild("PlayerGui")
local l_CurrentCamera_0 = workspace.CurrentCamera
local l_l_LocalPlayer_1_Mouse_0 = l_LocalPlayer_1:GetMouse()
local l_Highlight_0 = Instance.new("Highlight")
l_Highlight_0.FillTransparency = 0.9
l_Highlight_0.Parent = l_PlayerGui_0:WaitForChild("MobileJunk")
local l_Highlight_1 = Instance.new("Highlight")
l_Highlight_1.FillTransparency = 0.9
l_Highlight_1.Parent = l_PlayerGui_0
l_Highlight_0:GetPropertyChangedSignal("FillColor"):Connect(function() --[[ Line: 85 ]]
    l_Highlight_1.FillColor = l_Highlight_0.FillColor
end)
local l_Model_0 = Instance.new("Model")
l_Model_0.Name = "BuilderStorage"
l_Model_0.Parent = workspace.Built
local l_Model_1 = Instance.new("Model")
l_Model_1.Name = "GroupSelectionGhostHolder"
l_Model_1.Parent = l_Model_0
local l_Model_2 = Instance.new("Model")
l_Model_2.Name = "BuildSelectionHolder"
l_Model_2.Parent = l_Model_0
l_Model_2.ChildAdded:Connect(function(v21)
	v21.CanCollide = false
	v21.CanQuery = false
	v21.CanTouch = false
	
    local v22 = v21:Clone()
    for _, v24 in pairs(game:GetService("CollectionService"):GetTags(v22)) do
        game:GetService("CollectionService"):RemoveTag(v22, v24)
    end
    for v25, _ in pairs(v22:GetAttributes()) do
        v22:SetAttribute(v25, nil)
    end
    v22.CanCollide = false
    v22.CanQuery = false
    v22.CanTouch = false
    v22:ClearAllChildren()
    v22.BrickColor = BrickColor.new("Light blue")
    v22.Parent = workspace.Thrown
    local v27 = 0
    local function v29(v28) --[[ Line: 117 ]]
        if v28 == "BrickColor" or v28 == "Color3uint8" or v28 == "Attributes" then
            return
        else
            v22.Size = v21.Size + Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0)
            v22.Material = Enum.Material.SmoothPlastic
            v22.CFrame = v21.CFrame
            if v28 == "Color" or v28 == "Transparency" then
                v22.Transparency = 1
                v27 = tick()
                task.delay(2.5, function() --[[ Line: 125 ]]
                    if tick() - v27 > 2.5 then
                        v22.Transparency = 0.4
                    end
                end)
                return
            else
                v27 = 0
                v22.Transparency = 0.4
                return
            end
        end
    end
    local v30 = v21.Changed:Connect(v29)
    v29()
    local v31 = nil
    v31 = v21:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 137 ]]
        if v21.Parent ~= l_Model_2 then
            v31:Disconnect()
            game:GetService("Debris"):AddItem(v22, 0)
            return v30:Disconnect()
        else
            return
        end
    end)
end)
local l_Humanoid_0 = Instance.new("Humanoid")
l_Humanoid_0.EvaluateStateMachine = false
l_Humanoid_0.Parent = l_Model_1
local l_Part_0 = Instance.new("Part")
l_Part_0.Name = "GroupSelectionHighlight"
l_Part_0.Transparency = 0.99
l_Part_0.Material = Enum.Material.SmoothPlastic
l_Part_0.CastShadow = false
l_Part_0.Anchored = true
l_Part_0.CanCollide = false
l_Part_0.CanQuery = false
l_Part_0.Parent = l_Model_1
local l_Handles_0 = Instance.new("Handles")
l_Handles_0.Faces = Faces.new(Enum.NormalId.Front, Enum.NormalId.Left, Enum.NormalId.Top, Enum.NormalId.Right, Enum.NormalId.Back, Enum.NormalId.Bottom)
l_Handles_0.Style = Enum.HandlesStyle.Resize
l_Handles_0.Parent = l_PlayerGui_0.MobileJunk
local l_ArcHandles_0 = Instance.new("ArcHandles")
l_ArcHandles_0.Axes = Axes.new(Enum.Axis.X, Enum.Axis.Y, Enum.Axis.Z)
l_ArcHandles_0.Parent = l_PlayerGui_0.MobileJunk
local v36 = RaycastParams.new()
v36.FilterType = Enum.RaycastFilterType.Include
local v37 = {
    none = Color3.fromRGB(255, 255, 255), 
    delete = Color3.fromRGB(255, 0, 0), 
    move = Color3.fromRGB(244, 142, 0), 
    resize = Color3.fromRGB(0, 115, 255), 
    rotate = Color3.fromRGB(0, 232, 27), 
    select = Color3.new(1, 1, 1)
}
local v38 = {
    [Enum.KeyCode.R] = CFrame.Angles(0, 1.5707963267948966, 0)
}
local v39 = {
    "move", 
    "resize", 
    "delete", 
    "place", 
    "rotate", 
    "none", 
    "select"
}
local v40 = {
    "move", 
    "resize", 
    "rotate", 
    "select"
}
local v41 = {}
local v42 = {}
shared.mouseHittableInstances = v41
local v43 = {
    move = l_Handles_0, 
    resize = l_Handles_0, 
    rotate = l_ArcHandles_0
}
local function v50(v47) --[[ Line: 201 ]] --[[ Name: createBlock ]]
    local v48 = nil
    local l_Rotation_0 = BuilderModule.base.CFrame.Rotation
    BuilderModule.ResetSelection()
    if not BuilderModule.Default then
        v48 = Instance.new("Part")
        v48.Size = Vector3.new(4, 4, 4, 0)
        v48.CanCollide = false
        v48.Anchored = true
        v48.Material = Enum.Material.SmoothPlastic
        v48:SetAttribute("Anchored", true)
        v48:SetAttribute("CanCollide", true)
        v48:SetAttribute("CastShadow", true)
    else
        v48 = BuilderModule.Default:Clone()
        v48:SetAttribute("Serial", nil)
    end
    v48.Transparency = 0.5
    v48.CFrame = v47 * l_Rotation_0 or CFrame.identity
    return v48
end
local function v56(v55) --[[ Line: 234 ]] --[[ Name: ghostInstance ]]
    v55.Transparency = 0.4
    v55.CanCollide = false
    v55.CastShadow = false
    shared.sfx({
        SoundId = "rbxassetid://9114378556", 
        Parent = v55, 
        Volume = 0.2
    }):Play()
    game:GetService("CollectionService"):RemoveTag(v55, "psbuilt2")
    if table.find(v41, v55) then
        table.remove(v41, table.find(v41, v55))
    end
end
local function v59(v57) --[[ Line: 250 ]] --[[ Name: realInstance ]]
    v57.Transparency = v57:GetAttribute("Transparency") or 0
    v57.CanCollide = false
    v57:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 253 ]]
        v57.CanCollide = false
    end)
    v57.CastShadow = true
    local l_SpecialMesh_0 = Instance.new("SpecialMesh")
    l_SpecialMesh_0.Name = "Invisible"
    l_SpecialMesh_0.Scale = Vector3.zero
    l_SpecialMesh_0.Parent = v57
    table.insert(v42, v57)
    game:GetService("CollectionService"):AddTag(v57, "psbuilt2")
end
local BuilderModule0 = {}
local function v73(BuilderModule6, BuilderModule7, BuilderModule8) --[[ Line: 283 ]] --[[ Name: resizeFrom ]]
    local l_zero_0 = Vector3.zero
    if BuilderModule7 == Enum.NormalId.Top or BuilderModule7 == Enum.NormalId.Bottom then
        l_zero_0 = Vector3.yAxis * BuilderModule8
    elseif BuilderModule7 == Enum.NormalId.Left or BuilderModule7 == Enum.NormalId.Right then
        l_zero_0 = Vector3.xAxis * BuilderModule8
    elseif BuilderModule7 == Enum.NormalId.Front or BuilderModule7 == Enum.NormalId.Back then
        l_zero_0 = Vector3.zAxis * BuilderModule8
    end
    l_zero_0 = Vector3.new(math.round(l_zero_0.X / BuilderModule.sizeSnap) * BuilderModule.sizeSnap, math.round(l_zero_0.Y / BuilderModule.sizeSnap) * BuilderModule.sizeSnap, math.round(l_zero_0.Z / BuilderModule.sizeSnap) * BuilderModule.sizeSnap)
    local v70 = BuilderModule6.Size + l_zero_0
    local v71 = Vector3.one * BuilderModule.sizeSnap
    if v70:Min(v71) - v71 ~= Vector3.zero then
        return
    else
        BuilderModule6.Size = BuilderModule6.Size + l_zero_0
        local v72 = CFrame.new(l_zero_0 * 0.5)
        if BuilderModule7 == Enum.NormalId.Bottom or BuilderModule7 == Enum.NormalId.Left or BuilderModule7 == Enum.NormalId.Front then
            v72 = v72:Inverse()
        end
        BuilderModule6.CFrame = BuilderModule6.CFrame * v72
        return
    end
end
BuilderModule.SetGridSize = function(v74) --[[ Line: 316 ]] --[[ Name: SetGridSize ]]
    v74 = math.clamp(v74, 0.01, 4)
    local _ = BuilderModule.gridSize
    local l_GridTexture_0 = BuilderModule.base:FindFirstChild("GridTexture")
    if l_GridTexture_0 then
        l_GridTexture_0.StudsPerTileU = v74
        l_GridTexture_0.StudsPerTileV = v74
    end
    BuilderModule.gridSize = v74
end
BuilderModule.GetGridSize = function() --[[ Line: 332 ]] --[[ Name: GetGridSize ]]
    return BuilderModule.gridSize
end
BuilderModule.SetResizeSnap = function(v77) --[[ Line: 334 ]] --[[ Name: SetResizeSnap ]]
    BuilderModule.sizeSnap = math.clamp(v77, 0.01, 10)
end
BuilderModule.GetResizeSnap = function() --[[ Line: 337 ]] --[[ Name: GetResizeSnap ]]
    return BuilderModule.resizeSnap
end
BuilderModule.SetMoveSnap = function(v78) --[[ Line: 339 ]] --[[ Name: SetMoveSnap ]]
    BuilderModule.moveSnap = math.clamp(v78, 0.01, 10)
end
BuilderModule.GetMoveSnap = function() --[[ Line: 342 ]] --[[ Name: GetMoveSnap ]]
    return BuilderModule.moveSnap
end
BuilderModule.SetAngleSnap = function(v79) --[[ Line: 344 ]] --[[ Name: SetAngleSnap ]]
    BuilderModule.angleSnap = math.rad(v79)
end
BuilderModule.GetAngleSnap = function() --[[ Line: 347 ]] --[[ Name: GetAngleSnap ]]
    return (math.deg(BuilderModule.angleSnap))
end
local function v84(v80) --[[ Line: 357 ]]
    local v81 = v80:Clone()
    local l_SpecialMesh_1 = Instance.new("SpecialMesh")
    l_SpecialMesh_1.Name = "Invisible"
    l_SpecialMesh_1.Scale = Vector3.zero
    l_SpecialMesh_1.Parent = v81
    v81.Parent = v80.Parent
    local v83 = {
        v80, 
        v81
    }
    table.insert(v4, v83)
    v81:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 368 ]]
        if not v81.Parent then
            table.remove(v4, table.find(v4, v83))
        end
    end)
    if not table.find(v41, v81) then
        table.insert(v41, v81)
    end
    table.insert(v42, v81)
    return v81
end
BuilderModule.AddSelection = function(v85) --[[ Line: 406 ]] --[[ Name: AddSelection ]]
    if not table.find(BuilderModule.lockedTargetObjects, v85) then
        if not table.find(v41, v85) and BuilderModule.ghostObject ~= v85 then
            table.insert(v41, v85)
        end
		v85 = v84(v85) or v85
		v85:RemoveTag("PSBuilt")
		v85:RemoveTag("Combeable")
		v85.CastShadow = false
        v85.Parent = l_Model_2
        table.insert(BuilderModule.lockedTargetObjects, v85)
    end
end
BuilderModule.ToggleSelection = function(v86) --[[ Line: 417 ]] --[[ Name: ToggleSelection ]]
    local v87 = table.find(BuilderModule.lockedTargetObjects, v86)
    if v87 then
        v86:Destroy()
        table.remove(BuilderModule.lockedTargetObjects, v87)
        if #BuilderModule.lockedTargetObjects == 0 then
            BuilderModule.ResetSelection()
            return
        end
	else
		v86 = v84(v86) or v86
		v86:RemoveTag("PSBuilt")
		v86:RemoveTag("Combeable")
		v86.CastShadow = false
        v86.Parent = l_Model_2
        table.insert(BuilderModule.lockedTargetObjects, v86)
    end
end
BuilderModule.ResetSelection = function() --[[ Line: 432 ]] --[[ Name: ResetSelection ]]
    for _, v89 in l_Model_2:GetChildren() do
        v89:Destroy()
    end
    for _, v91 in pairs(v42) do
        v91:Destroy()
    end
    l_Handles_0.Adornee = nil
    l_ArcHandles_0.Adornee = nil
    l_Highlight_0.Adornee = nil
    l_Highlight_1.Adornee = nil
    table.clear(BuilderModule.lockedTargetObjects)
end
BuilderModule.GetSelection = function() --[[ Line: 446 ]] --[[ Name: GetSelection ]]
    return BuilderModule.lockedTargetObjects
end
BuilderModule.GetSelectable = function() --[[ Line: 447 ]] --[[ Name: GetSelectable ]]
    return v41
end
BuilderModule.SetBase = function(v92, v93) --[[ Line: 449 ]] --[[ Name: SetBase ]]
    table.insert(v41, v92)
    game:GetService("CollectionService"):AddTag(v92, "gridthing")
    if v93 then
        local l_Texture_1 = Instance.new("Texture")
        l_Texture_1.Texture = "http://www.roblox.com/asset/?id=17123114275"
        l_Texture_1.StudsPerTileU = BuilderModule.gridSize
        l_Texture_1.StudsPerTileV = BuilderModule.gridSize
        l_Texture_1.Name = "GridTexture"
        l_Texture_1.Color3 = Color3.new(1, 1, 1)
        l_Texture_1.Face = "Top"
        l_Texture_1.Transparency = 0.8
        l_Texture_1.Parent = v92
    end
    BuilderModule.base = v92
end
BuilderModule.setObject = function(v95) --[[ Line: 459 ]] --[[ Name: setObject ]]
    local l_ghostObject_0 = BuilderModule.ghostObject
    if l_ghostObject_0 then
        l_ghostObject_0:Destroy()
        BuilderModule.ghostObject = nil
    end
    if v95 == "Block" then
        BuilderModule.Default = nil
        return
    elseif v95 == "Spawn Location" then
        local l_SpawnLocation_0 = Instance.new("SpawnLocation")
        l_SpawnLocation_0.CanCollide = false
        l_SpawnLocation_0.Anchored = true
        l_SpawnLocation_0.Size = Vector3.new(12, 1, 12)
        l_SpawnLocation_0.Color = Color3.fromRGB(114, 189, 255)
        l_SpawnLocation_0.Material = Enum.Material.SmoothPlastic
        l_SpawnLocation_0:SetAttribute("Anchored", true)
        l_SpawnLocation_0:SetAttribute("CanCollide", true)
        l_SpawnLocation_0:SetAttribute("CastShadow", true)
        BuilderModule.Default = l_SpawnLocation_0
        return
    else
        if v95 == "Trashcan" then
            BuilderModule.Default = game.ReplicatedStorage.Resources.Trashcan:Clone()
        end
        return
    end
end
BuilderModule.Clone = function(v98) --[[ Line: 485 ]] --[[ Name: Clone ]]
    local v99 = v98:Clone()
    v99:SetAttribute("Serial", nil)
    v99.Parent = workspace
    BuilderModule.ghostObject = v99
    v56(v99)
end
BuilderModule.FindGridPosition = function(v100, v101, v102) --[[ Line: 495 ]] --[[ Name: FindGridPosition ]]
    v102 = v102 or CFrame.identity
    local v103 = BuilderModule.base.Position + Vector3.new(0, BuilderModule.base.Size.Y / 2, 0)
    local v104 = v102:Inverse() * (v100 - v103)
    return v102 * Vector3.new(math.round(v104.X / BuilderModule.gridSize) * BuilderModule.gridSize, v100.Y + (v101 and v101.Y / 2 or BuilderModule.gridSize / 2), math.round(v104.Z / BuilderModule.gridSize) * BuilderModule.gridSize) + v103 * Vector3.new(1, 0, 1, 0)
end
BuilderModule.Activate = function(v105) --[[ Line: 511 ]] --[[ Name: Activate ]]
    local v106 = shared.gridd or Instance.new("Part")
    v106.Anchored = true
    v106.CanCollide = false
    v106.CanTouch = false
    v106.Transparency = 1
    v106.Parent = workspace.Thrown
    v106.Size = Vector3.new(2048, 0, 2048, 0)
    v106:SetAttribute("DeletionImmunity", true)
    v106.CFrame = CFrame.new(134.81929, 437.756531, 33.4901962, 0.382694274, -2.42327269E-10, -0.923876107, 1.22060517E-9, 1.00000143, 2.43416565E-10, 0.923877358, -1.22084398E-9, 0.382692665)
    BuilderModule.SetBase(v106, true)
    shared.gridd = v106
    if not shared.BUILDERfirsttime then
        game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 523 ]]
            for v107, v108 in pairs(v4) do
                local v109 = v108[1]
                local v110 = v108[2]
                if v110.Parent and v109.Parent then
                    v109.CFrame = v110.CFrame
                    v109.Size = v110.Size
                else
                    v4[v107] = nil
                end
            end
        end)
        shared.BUILDERfirsttime = true
    end
    BuilderModule.active = true
    v11 = v105
    return v106
end
BuilderModule.Deactivate = function() --[[ Line: 573 ]] --[[ Name: Deactivate ]]
    local l_gridd_0 = shared.gridd
    if l_gridd_0 then
        l_gridd_0:Destroy()
        shared.gridd = nil
    end
    BuilderModule.active = false
    BuilderModule.SetMode("none")
    if v11 then
        v11()
    end
end
local function v114(v112) --[[ Line: 584 ]]
    local v113 = v112 or BuilderModule.targetObject
    if v112 or BuilderModule.mode == "select" then

    end
    if v113 and not BuilderModule.ghostObject then
        if BuilderModule.mode ~= "select" then
            l_Handles_0.Color3 = v37[BuilderModule.mode]
            l_Handles_0.Adornee = v113
        end
        BuilderModule.lockedTargetObject = v113
        if v11 then
            v11()
        end
        if not v112 then
            shared.sfx({
                SoundId = "rbxassetid://15675059323", 
                Parent = v113, 
                Volume = 0.2
            }):Play()
            return
        end
    else
        l_Handles_0.Adornee = nil
        BuilderModule.lockedTargetObject = nil
        if v11 then
            v11()
        end
    end
end
BuilderModule.SetMode = function(v115, v116) --[[ Line: 612 ]] --[[ Name: SetMode ]]
    local l_mode_0 = BuilderModule.mode
    local l_lockedTargetObject_0 = BuilderModule.lockedTargetObject
    v115 = v115:lower()
    if not table.find(v39, v115) then
        warn("Invalid builder state: " .. v115)
    end
    BuilderModule.mode = v115
    local v119 = table.find(v40, v115)
    l_BoxSelection_0.active = v119
    if v119 then
        l_BoxSelection_0.SetColor(v37[v115])
    end
    if v11 then
        v11()
    end
    if table.find(v40, l_mode_0) and table.find(v40, v115) then
        l_Handles_0.Color3 = v37[BuilderModule.mode]
        if v115 ~= "select" then
            if v115 == "rotate" then
                l_ArcHandles_0.Adornee = l_Handles_0.Adornee
                l_Handles_0.Adornee = nil
            else
                l_Handles_0.Adornee = l_Handles_0.Adornee or l_ArcHandles_0.Adornee or BuilderModule.lockedTargetObject
                l_ArcHandles_0.Adornee = nil
            end
        end
    else
        BuilderModule.lockedTargetObject = nil
        l_Handles_0.Adornee = nil
        l_ArcHandles_0.Adornee = nil
        l_Highlight_0.Adornee = nil
    end
    if BuilderModule.ghostObject and not v116 then
        local l_ghostObject_1 = BuilderModule.ghostObject
        local _ = l_ghostObject_1:GetAttribute("BaseCF")
        l_ghostObject_1:Destroy()
        BuilderModule.ghostObject = nil
    end
    if l_mode_0 == "select" and (v115 == "rotate" or v115 == "resize" or v115 == "move") then
        v114(l_lockedTargetObject_0)
    elseif (l_mode_0 == "rotate" or l_mode_0 == "resize" or l_mode_0 == "move") and v115 == "select" then
        v114(l_lockedTargetObject_0)
    end
    if v11 then
        v11()
    end
end
function BuilderModule:GetMode()
    return BuilderModule.mode
end
RunService.Stepped:Connect(function(v122) --[[ Line: 673 ]]
    if not BuilderModule.active or BuilderModule.mode == "none" or not BuilderModule.base then
        return
    else
        local l_l_UserInputService_0_MouseLocation_1 = UserInputService:GetMouseLocation()
        local v124 = l_CurrentCamera_0:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_1.X, l_l_UserInputService_0_MouseLocation_1.Y)
        local v125 = v124.Origin + v124.Direction * 500
        v36.FilterDescendantsInstances = v41
        local v126 = workspace:Raycast(v124.Origin, v124.Direction * 500, v36)
        local l_v125_0 = v125
        l_Part_0.Size = l_Model_2:GetExtentsSize()
        l_Part_0.CFrame = l_Model_2:GetPivot()
        if BuilderModule.mode == "place" and not BuilderModule.ghostObject then
            l_l_UserInputService_0_MouseLocation_1 = v50(CFrame.new(l_l_LocalPlayer_1_Mouse_0.Hit.p))
            v56(l_l_UserInputService_0_MouseLocation_1)
            l_l_UserInputService_0_MouseLocation_1.Parent = workspace
            BuilderModule.ghostObject = l_l_UserInputService_0_MouseLocation_1
        end
        if BuilderModule.ghostObject then
            l_l_UserInputService_0_MouseLocation_1 = table.find(v41, BuilderModule.ghostObject)
            if l_l_UserInputService_0_MouseLocation_1 then
                table.remove(v41, l_l_UserInputService_0_MouseLocation_1)
            end
            v124 = BuilderModule.ghostObject
            v125 = v124:FindFirstChildOfClass("SpecialMesh")
            if v125 then
                v125:Destroy()
            end
            if v126 then
                local v128 = Vector3.new()
                local l_Instance_0 = v126.Instance
                if l_Instance_0 == BuilderModule.base and v126.Normal ~= Vector3.yAxis then
                    return
                else
                    local v130 = v126.Normal == Vector3.yAxis
                    local v131 = v126.Normal == -Vector3.yAxis
                    if l_Instance_0 ~= BuilderModule.base and not v130 then
                        if l_Instance_0.Size.Y == BuilderModule.gridSize then
                            v128 = if v131 then Vector3.new(0, -BuilderModule.gridSize, 0) else Vector3.new(0, l_Instance_0.Position.Y - v126.Position.Y - BuilderModule.gridSize / 2, 0)
                        elseif not v131 then
                            local l_Instance_1 = v126.Instance
                            local v133 = l_Instance_1.Size / 2
                            local l_Position_0 = l_Instance_1.Position
                            local v135 = l_Position_0.Y + v133.Y
                            local v136 = l_Position_0.Y - v133.Y
                            local v137 = v126.Position.Y + BuilderModule.gridSize
                            local v138 = v126.Position.Y - BuilderModule.gridSize
                            if v135 < v137 then
                                v128 = Vector3.new(0, v135 - v126.Position.Y - BuilderModule.gridSize, 0)
                            elseif v138 < v136 then
                                v128 = Vector3.new(0, v136 - v126.Position.Y, 0)
                            end
                        elseif v131 then
                            v128 = Vector3.new(0, -BuilderModule.gridSize, 0)
                        end
                    end
                    if not v130 and not v131 then
                        v128 = v128 + v126.Normal * 0.01
                    end
                    local l_Rotation_1 = BuilderModule.base.CFrame.Rotation
                    local v140 = BuilderModule.FindGridPosition(v126.Position + v128, v124.Size, l_Rotation_1)
                    local v141 = CFrame.new(v140) * l_Rotation_1 * (v124:GetAttribute("Rotation") or CFrame.identity)
                    BuilderModule.currentGoal = v141
                    v124.CFrame = v124.CFrame:lerp(v141, 1 - 0.95 ^ v122)
                end
            else
                local l_Character_0 = l_LocalPlayer_1.Character
                if l_Character_0 then
                    local l_Position_1 = l_Character_0:GetPivot().Position
                    local v144 = l_Position_1 + (l_v125_0 - l_Position_1).Unit * BuilderModule.ghostObjectSkyPlaceDist
                    v144 = Vector3.new(v144.X, math.round(v144.Y / BuilderModule.gridSize) * BuilderModule.gridSize, v144.Z)
                    local l_Rotation_2 = BuilderModule.base.CFrame.Rotation
                    local v146 = BuilderModule.FindGridPosition(v144, v124.Size, l_Rotation_2)
                    local v147 = CFrame.new(v146) * l_Rotation_2 * (v124:GetAttribute("Rotation") or CFrame.identity)
                    BuilderModule.currentGoal = v147
                    v124.CFrame = v124.CFrame:lerp(v147, 1 - 0.95 ^ v122)
                end
            end
        end
        if BuilderModule.mode == "delete" or BuilderModule.mode == "select" or BuilderModule.mode == "move" or BuilderModule.mode == "resize" or BuilderModule.mode == "rotate" then
            l_l_UserInputService_0_MouseLocation_1 = false
            if #BuilderModule.lockedTargetObjects > 0 then
                l_l_UserInputService_0_MouseLocation_1 = l_Part_0
            end
            if v126 and v126.Instance ~= BuilderModule.base and not BuilderModule.ghostObject then
                l_Highlight_0.FillColor = v37[BuilderModule.mode]
                BuilderModule.targetObject = v126.Instance
                l_Highlight_1.Adornee = v126.Instance
                if l_l_UserInputService_0_MouseLocation_1 then
                    l_Highlight_0.Adornee = l_l_UserInputService_0_MouseLocation_1.Parent
                end
                v124 = v43[BuilderModule.mode]
                if l_l_UserInputService_0_MouseLocation_1 and v124 and not table.find(BuilderModule.lockedTargetObjects, BuilderModule.ghostObject) then
                    v124.Adornee = l_l_UserInputService_0_MouseLocation_1
                    v124.Color3 = v37[BuilderModule.mode]
                    return
                end
            elseif l_l_UserInputService_0_MouseLocation_1 then
                l_Highlight_0.FillColor = v37[BuilderModule.mode]
                BuilderModule.targetObject = nil
                l_Highlight_1.Adornee = nil
                l_Highlight_0.Adornee = l_l_UserInputService_0_MouseLocation_1
                v124 = v43[BuilderModule.mode]
                if v124 and not table.find(BuilderModule.lockedTargetObjects, BuilderModule.ghostObject) then
                    v124.Adornee = l_l_UserInputService_0_MouseLocation_1
                    v124.Color3 = v37[BuilderModule.mode]
                    return
                end
            else
                BuilderModule.targetObject = nil
                l_Highlight_1.Adornee = nil
                l_Highlight_0.Adornee = nil
            end
        end
        return
    end
end)
game:GetService("CollectionService"):GetInstanceAddedSignal("PSBuilt"):Connect(function(v148) --[[ Line: 802 ]]
    if not table.find(v41, v148) then
        table.insert(v41, v148)
    end
    if (v148:GetAttribute("loaded") or not v148:GetAttribute(l_LocalPlayer_0.Name)) and shared.BUILDERfirsttime then
        return
    elseif not shared.BUILDERfirsttime then
        return
    else
        return
    end
end)
game:GetService("CollectionService"):GetInstanceAddedSignal("psbuilt2"):Connect(function(v149) --[[ Line: 834 ]]
    if not table.find(v41, v149) then
        table.insert(v41, v149)
    end
    task.wait()
    local l_v149_Attribute_0 = v149:GetAttribute("Serial")
    if not _G.builtblocks then
        _G.builtblocks = {}
    end
    if l_v149_Attribute_0 then
        _G.builtblocks[l_v149_Attribute_0] = v149
    end
end)
for _, v152 in pairs(game:GetService("CollectionService"):GetTagged("psbuilt2")) do
    local l_v152_Attribute_0 = v152:GetAttribute("Serial")
    if not _G.builtblocks then
        _G.builtblocks = {}
    end
    if l_v152_Attribute_0 then
        _G.builtblocks[l_v152_Attribute_0] = v152
    end
end
for _, v155 in pairs(game:GetService("CollectionService"):GetTagged("PSBuilt")) do
    if not table.find(v41, v155) then
        table.insert(v41, v155)
    end
    local l_v155_Attribute_0 = v155:GetAttribute("Serial")
    if not _G.builtblocks then
        _G.builtblocks = {}
    end
    if l_v155_Attribute_0 then
        _G.builtblocks[l_v155_Attribute_0] = v155
    end
end
local l_GetSerial_0 = require(game.ReplicatedStorage.Info).GetSerial
local function v160(v158) --[[ Line: 872 ]]
    local v159 = l_GetSerial_0(v158)
    if _G.builtblocks[v159] then
        repeat
            v159 = l_GetSerial_0(v158)
        until not _G.builtblocks[v159]
    end
    return v159
end
local function v163() --[[ Line: 882 ]]
    if BuilderModule.ghostObject then
        local l_ghostObject_2 = BuilderModule.ghostObject
        BuilderModule.ghostObject = nil
        l_ghostObject_2.CFrame = BuilderModule.currentGoal
        l_ghostObject_2.Parent = workspace.Built
        print(l_ghostObject_2:GetAttribute("Serial"), "a")
        v59(l_ghostObject_2)
        BuilderModule.PartCreated:Fire(l_ghostObject_2, l_ghostObject_2:GetAttribute("Serial"))
        table.insert(v41, l_ghostObject_2)
    end
end
UserInputService.InputEnded:Connect(function(v164, v165) --[[ Line: 910 ]]
    if v165 or not BuilderModule.active or BuilderModule.mode == "none" then
        return
    else
        local v166 = if not l_LocalPlayer_0.Character then nil else l_LocalPlayer_0.Character:FindFirstChild("Communicate")
        if v164.UserInputType == Enum.UserInputType.Touch and v166 then
            v163(v166)
        end
        return
    end
end)
local l_TouchEnabled_0 = game:GetService("UserInputService").TouchEnabled
UserInputService.InputBegan:Connect(function(v168, v169) --[[ Line: 919 ]]
    if v169 or not BuilderModule.active or BuilderModule.mode == "none" then
        return
    else
        local v170 = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
        if l_TouchEnabled_0 and #BuilderModule.lockedTargetObjects > 0 then
            v170 = false
        end
        if v168.UserInputType == Enum.UserInputType.MouseButton1 or v168.UserInputType == Enum.UserInputType.Touch then
            if BuilderModule.mode == "place" and v168.UserInputType ~= Enum.UserInputType.Touch and BuilderModule.ghostObject then
                local l_ghostObject_3 = BuilderModule.ghostObject
                BuilderModule.ghostObject = nil
                l_ghostObject_3.Parent = workspace.Built
                l_ghostObject_3.CFrame = BuilderModule.currentGoal
                v59(l_ghostObject_3)
                BuilderModule.PartCreated:Fire(l_ghostObject_3, l_ghostObject_3:GetAttribute("Serial"))
                table.insert(v41, l_ghostObject_3)
            end
            if BuilderModule.mode == "delete" and BuilderModule.targetObject then
                BuilderModule.PartRemoved:Fire(BuilderModule.targetObject)
                BuilderModule.targetObject:Destroy()
                l_Highlight_0.Adornee = nil
                l_Highlight_1.Adornee = nil
            end
            if BuilderModule.mode == "move" or BuilderModule.mode == "resize" or BuilderModule.mode == "select" then
                local l_targetObject_0 = BuilderModule.targetObject
                if l_TouchEnabled_0 then
                    local l_l_UserInputService_0_MouseLocation_2 = UserInputService:GetMouseLocation()
                    local v174 = l_CurrentCamera_0:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_2.X, l_l_UserInputService_0_MouseLocation_2.Y)
                    local _ = v174.Origin + v174.Direction * 500
                    v36.FilterDescendantsInstances = v41
                    local v176 = workspace:Raycast(v174.Origin, v174.Direction * 500, v36)
                    if v176 and v176.Instance and v176.Instance ~= BuilderModule.base then
                        l_targetObject_0 = v176.Instance
                    end
                end
                if l_targetObject_0 and not BuilderModule.ghostObject then
                    if v170 then
                        BuilderModule.ToggleSelection(l_targetObject_0)
                    else
                        BuilderModule.ResetSelection()
                        BuilderModule.AddSelection(l_targetObject_0)
                    end
                elseif not l_targetObject_0 and not l_TouchEnabled_0 then
                    BuilderModule.ResetSelection()
                end
                if v11 then
                    v11()
                end
            end
            if BuilderModule.mode == "rotate" then
                if BuilderModule.targetObject then
                    if v170 then
                        BuilderModule.ToggleSelection(BuilderModule.targetObject)
                    else
                        BuilderModule.ResetSelection()
                        BuilderModule.AddSelection(BuilderModule.targetObject)
                    end
                elseif not l_TouchEnabled_0 then
                    BuilderModule.ResetSelection()
                end
            end
            if BuilderModule.mode == "move" then
                if #BuilderModule.lockedTargetObjects == 1 and not BuilderModule.ghostObject and BuilderModule.targetObject then
                    local l_l_UserInputService_0_MouseLocation_3 = UserInputService:GetMouseLocation()
                    local l_targetObject_1 = BuilderModule.targetObject
                    task.wait(0.1)
                    local l_l_UserInputService_0_MouseLocation_4 = UserInputService:GetMouseLocation()
                    if table.find(UserInputService:GetMouseButtonsPressed(), v168) and (l_l_UserInputService_0_MouseLocation_3 - l_l_UserInputService_0_MouseLocation_4).Magnitude > 0 then
                        l_BoxSelection_0.active = false
                        l_targetObject_1:Destroy()
                        local v180 = l_targetObject_1:Clone()
                        local l_v180_Attribute_0 = v180:GetAttribute("Serial")
                        local v182 = v160(v180)
                        v180:SetAttribute("BaseCF", v180.CFrame)
                        v180:SetAttribute("Serial", v182)
                        v180.Parent = l_Model_0
                        BuilderModule.targetObject = nil
                        l_Handles_0.Adornee = nil
                        BuilderModule.ghostObject = v180
                        l_LocalPlayer_0.Character.Communicate:FireServer({
                            Goal = "PS Build", 
                            Todo = "Delete", 
                            NoUpdate = l_LocalPlayer_0.Name, 
                            Serial = l_v180_Attribute_0
                        })
                        v56(v180)
                    end
                elseif BuilderModule.ghostObject then
                    local l_ghostObject_4 = BuilderModule.ghostObject
                    BuilderModule.ghostObject = nil
                    BuilderModule.ResetSelection()
                    BuilderModule.AddSelection(l_ghostObject_4)
                    l_BoxSelection_0.active = true
                    l_ghostObject_4.Parent = workspace.Built
                    v59(l_ghostObject_4)
                    BuilderModule.PartCreated:Fire(l_ghostObject_4, l_ghostObject_4:GetAttribute("Serial"))
                    table.insert(v41, l_ghostObject_4)
                end
            end
        end
        if v168.UserInputType == Enum.UserInputType.Keyboard and v38[v168.KeyCode] then
            local v184 = v38[v168.KeyCode]
            if BuilderModule.ghostObject then
                local v185 = BuilderModule.ghostObject:GetAttribute("Rotation") or CFrame.identity
                BuilderModule.ghostObject:SetAttribute("Rotation", v185 * v184)
            end
        end
        return
    end
end)
local v186 = 0
local v187 = 0
local v188 = {}
local v189 = nil
if l_TouchEnabled_0 then
    v189 = require(l_LocalPlayer_0.PlayerScripts.PlayerModule.CameraModule.CameraInput)
end
l_Handles_0.MouseButton1Down:Connect(function(_) --[[ Line: 1048 ]]
    if v189 then
        v189.changePanState(false)
    end
    v187 = 0
    v186 = 0
    table.clear(v188)
    for _, v192 in BuilderModule.lockedTargetObjects do
        v188[v192] = v192.CFrame.Rotation
    end
end)
l_Handles_0.MouseButton1Up:Connect(function(_) --[[ Line: 1061 ]]
    if v189 then
        v189.changePanState(true)
    end
    v187 = 0
    v186 = 0
    table.clear(v188)
    for _, v195 in BuilderModule.lockedTargetObjects do
        v188[v195] = v195.CFrame.Rotation
    end
end)
l_Handles_0.MouseDrag:Connect(function(v196, v197) --[[ Line: 1074 ]]
    if #BuilderModule.lockedTargetObjects > 0 then
        local v198 = v197 - v187
        local v199 = if BuilderModule.mode == "resize" then BuilderModule.sizeSnap else BuilderModule.moveSnap
        local v200 = math.round(v198 / v199)
        local v201 = v200 * v199
        if v200 ~= 0 then
            if BuilderModule.mode == "resize" then
                local l_lockedTargetObjects_0 = BuilderModule.lockedTargetObjects
                for _, v204 in l_lockedTargetObjects_0 do
                    v73(v204, v196, v201)
                end
                BuilderModule.PartChanged:Fire(l_lockedTargetObjects_0, "Size")
            elseif BuilderModule.mode == "move" then
                local v205 = Vector3.fromNormalId(v196)
                local v206 = l_Part_0.CFrame.Rotation * v205 * v201
                local l_lockedTargetObjects_1 = BuilderModule.lockedTargetObjects
                for _, v209 in l_lockedTargetObjects_1 do
                    local v210 = v209.CFrame.Position + v206
                    v209.CFrame = CFrame.new(v210) * v188[v209]
                end
                BuilderModule.PartChanged:Fire(l_lockedTargetObjects_1, "CFrame")
            end
            v187 = v197
        end
    end
end)
local v211 = nil
local v212 = {}
l_ArcHandles_0.MouseButton1Down:Connect(function() --[[ Line: 1107 ]]
    if v189 then
        v189.changePanState(false)
    end
    v211 = l_Part_0.CFrame
    table.clear(v212)
    for _, v214 in BuilderModule.lockedTargetObjects do
        v212[v214] = v211:Inverse() * v214.CFrame
    end
end)
l_ArcHandles_0.MouseButton1Up:Connect(function() --[[ Line: 1119 ]]
    if v189 then
        v189.changePanState(true)
    end
end)
l_ArcHandles_0.MouseDrag:Connect(function(v215, v216) --[[ Line: 1125 ]]
    if BuilderModule.mode == "rotate" and #BuilderModule.lockedTargetObjects > 0 then
        local l_angleSnap_0 = BuilderModule.angleSnap
        v216 = math.round(v216 / l_angleSnap_0) * l_angleSnap_0
        local v218 = CFrame.fromAxisAngle(Vector3.fromAxis(v215), v216)
        local v219 = v211 * v218
        local l_lockedTargetObjects_2 = BuilderModule.lockedTargetObjects
        for _, v222 in l_lockedTargetObjects_2 do
            local v223 = v219 * v212[v222]
            if v222.CFrame ~= v223 then
                v222.CFrame = v223
            end
        end
        BuilderModule.PartChanged:Fire(l_lockedTargetObjects_2, "CFrame")
    end
end)
return BuilderModule