 

local u1 = {
    [Enum.HumanoidRigType.R15] = {
        "LeftHand",
        "LeftWrist",
        "LeftLowerArm",
        "LeftElbow",
        "LeftUpperArm",
        "LeftShoulder",
        "RightHand",
        "RightWrist",
        "RightLowerArm",
        "RightElbow",
        "RightUpperArm",
        "RightShoulder",
        "UpperTorso",
        "Head",
        "Neck",
        "Humanoid"
    },
    [Enum.HumanoidRigType.R6] = {
        "Left Arm",
        "Right Arm",
        "Head",
        "Torso",
        "Left Shoulder",
        "Right Shoulder",
        "Neck",
        "Humanoid"
    }
}
for v2, v3 in next, u1 do
    local v4 = {}
    for v5 = 1, #v3 do
        v4[v3[v5]] = true
    end
    u1[v2] = v4
end
function u1.new(_, p6) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = p6.Archivable
    p6.Archivable = true
    local v8 = p6:Clone()
    local v9 = v8:WaitForChild("Humanoid")
    local v10 = u1[v9.RigType]
    for v11, _ in next, v10 do
        while not v8:FindFirstChild(v11, true) do
            v8.DescendantAdded:Wait()
        end
    end
    v10["Body Colors"] = v8:FindFirstChild("Body Colors")
    v10.Shirt = v8:FindFirstChild("Shirt")
    local v12 = v8:GetDescendants()
    for v13 = 1, #v12 do
        if v10[v12[v13].Name] or v12[v13]:IsA("CharacterMesh") then
            if v12[v13]:IsA("BasePart") then
                v12[v13].CanCollide = false
                v12[v13].Anchored = false
            end
        else
            v12[v13]:Destroy()
        end
    end
    v8.Head.Anchored = true
    v8.Head.Transparency = 1
    if v9.RigType == Enum.HumanoidRigType.R15 then
        v8.UpperTorso.Transparency = 1
    else
        v8.Torso.Transparency = 1
    end
    v9.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    v8.Name = "viewModel"
    p6.Archivable = v7
    return v8
end
return u1