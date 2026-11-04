 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
function Distance(p3, p4)
    local v5 = (p3.X - p4.X) * (p3.X - p4.X) + (p3.Z - p4.Z) * (p3.Z - p4.Z)
    return math.sqrt(v5)
end
local function u12(p6, p7) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = false
    local v9 = workspace.Effects.Rooms:FindFirstChild(p6.Name)
    if v9 then
        local v10 = u2.Ball(v9.PrimaryPart.CFrame, v9.PrimaryPart.Size):FindPartsInRegion3WithWhiteList({ p7 })
        for v11 = 1, #v10 do
            if v10[v11] == p7 then
                v8 = true
            end
        end
        if Distance(p7.Position, v9.PrimaryPart.Position) > v9.PrimaryPart.Size.X then
            v8 = false
        end
    end
    return v8
end
function v1.isIn(_, p13, p14) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v15 = true
    if workspace.Effects.Rooms:FindFirstChild(p13.Name) then
        if u12(p13, p14) == false then
            return false
        end
    else
        v15 = false
    end
    return v15
end
function v1.filter(_, p16, p17, p18) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u2
    --]]
    if p17 == nil then
        return false
    end
    local v19 = workspace.Effects.Rooms:FindFirstChild(p16.Name)
    local v20 = not p17:IsDescendantOf(p16)
    if p17:IsDescendantOf(workspace.PlayerCharacters) or p17:IsDescendantOf(workspace.NPCs) then
        v20 = false
    end
    if v19 and p17:IsDescendantOf(v19) then
        v20 = false
    end
    if v19 == nil then
        v20 = false
    end
    if v19 and u12(p16, p17) == false then
        v20 = false
    end
    if p17.Size.Magnitude >= 75 or p17.Size.Magnitude <= 2 then
        v20 = false
    end
    if p18 and (v19 and v20 == true) then
        local v21 = Instance.new("Part")
        v21.CanCollide = false
        v21.Anchored = true
        v21.Transparency = 1
        v21.Size = Vector3.new(0, 0, 0)
        v21.CFrame = CFrame.new(p18)
        v21.Parent = workspace.Effects
        local v22 = u2.Ball(v19.PrimaryPart.CFrame, v19.PrimaryPart.Size):FindPartsInRegion3WithWhiteList({ v21 })
        v20 = false
        for v23 = 1, #v22 do
            if v22[v23] == v21 then
                v20 = true
            end
        end
        v21:Destroy()
    end
    if v19 == nil then
        v20 = false
    end
    if p17.Transparency >= 1 then
        v20 = false
    end
    return v20
end
return v1