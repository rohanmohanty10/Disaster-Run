 

local u1 = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local v2 = require(script.Parent.Parent.Signal)
local u3 = require(script.Parent.Parent.Janitor)
local u4 = {}
u4.__index = u4
local u5 = {}
u4.trackers = u5
u4.itemAdded = v2.new()
u4.itemRemoved = v2.new()
u4.bodyPartsToIgnore = {
    ["UpperTorso"] = true,
    ["LowerTorso"] = true,
    ["Torso"] = true,
    ["LeftHand"] = true,
    ["RightHand"] = true,
    ["LeftFoot"] = true,
    ["RightFoot"] = true
}
function u4.getCombinedTotalVolumes() --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v6 = 0
    for v7, _ in pairs(u5) do
        v6 = v6 + v7.totalVolume
    end
    return v6
end
function u4.getCharacterSize(p8) --[[ Line: 32 ]]
    local v9
    if p8 then
        v9 = p8:FindFirstChild("Head")
    else
        v9 = p8
    end
    if p8 then
        p8 = p8:FindFirstChild("HumanoidRootPart")
    end
    if not (p8 and v9) then
        return nil
    end
    if not v9:IsA("BasePart") then
        v9 = p8
    end
    local v10 = v9.Size.Y
    local v11 = p8.Size
    return v11 * Vector3.new(2, 2, 1) + Vector3.new(0, v10, 0), p8.CFrame * CFrame.new(0, v10 / 2 - v11.Y / 2, 0)
end
function u4.new(p12) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u1
        [4] = u5
    --]]
    local u13 = {}
    local v14 = u4
    setmetatable(u13, v14)
    u13.name = p12
    u13.totalVolume = 0
    u13.parts = {}
    u13.partToItem = {}
    u13.items = {}
    u13.whitelistParams = nil
    u13.characters = {}
    u13.baseParts = {}
    u13.exitDetections = {}
    u13.janitor = u3.new()
    if p12 == "player" then
        local function u18() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u13
            --]]
            local v15 = {}
            for _, v16 in pairs(u1:GetPlayers()) do
                local v17 = v16.Character
                if v17 then
                    v15[v17] = true
                end
            end
            u13.characters = v15
        end
        local function v25(p19) --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u13
            --]]
            local function v23(p20) --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u13
                --]]
                local v21 = p20:WaitForChild("Humanoid", 3)
                if v21 then
                    u18()
                    u13:update()
                    for _, v22 in pairs(v21:GetChildren()) do
                        if v22:IsA("NumberValue") then
                            v22.Changed:Connect(function() --[[ Line: 81 ]]
                                --[[
                                Upvalues:
                                    [1] = u13
                                --]]
                                u13:update()
                            end)
                        end
                    end
                end
            end
            if p19.Character then
                v23(p19.Character)
            end
            p19.CharacterAdded:Connect(v23)
            p19.CharacterRemoving:Connect(function(p24) --[[ Line: 92 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.exitDetections[p24] = nil
            end)
        end
        u1.PlayerAdded:Connect(v25)
        for _, v26 in pairs(u1:GetPlayers()) do
            v25(v26)
        end
        u1.PlayerRemoving:Connect(function(_) --[[ Line: 102 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u13
            --]]
            u18()
            u13:update()
        end)
    elseif p12 == "item" then
        u4.itemAdded:Connect(function(p27) --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            if p27.isCharacter then
                u13.characters[p27.item] = true
            elseif p27.isBasePart then
                u13.baseParts[p27.item] = true
            end
            u13:update()
        end)
        u4.itemRemoved:Connect(function(p28) --[[ Line: 120 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13.exitDetections[p28.item] = nil
            if p28.isCharacter then
                u13.characters[p28.item] = nil
            elseif p28.isBasePart then
                u13.baseParts[p28.item] = nil
            end
            u13:update()
        end)
    end
    u5[u13] = true
    task.defer(u13.update, u13)
    return u13
end
function u4._preventMultiFrameUpdates(u29, u30, ...) --[[ Line: 131 ]]
    u29._preventMultiDetails = u29._preventMultiDetails or {}
    local u31 = u29._preventMultiDetails[u30]
    if not u31 then
        u31 = {
            ["calling"] = false,
            ["callsThisFrame"] = 0,
            ["updatedThisFrame"] = false
        }
        u29._preventMultiDetails[u30] = u31
    end
    u31.callsThisFrame = u31.callsThisFrame + 1
    if u31.callsThisFrame ~= 1 then
        return true
    end
    local u32 = table.pack(...)
    task.defer(function() --[[ Line: 148 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u29
            [3] = u30
            [4] = u32
        --]]
        local v33 = u31.callsThisFrame
        u31.callsThisFrame = 0
        if v33 > 1 then
            local v34 = u32
            u29[u30](u29, unpack(v34))
        end
    end)
    return false
end
function u4.update(u35) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    if not u35:_preventMultiFrameUpdates("update") then
        u35.totalVolume = 0
        u35.parts = {}
        u35.partToItem = {}
        u35.items = {}
        for u36, _ in pairs(u35.characters) do
            local v37 = u4.getCharacterSize(u36)
            if v37 then
                local v38 = v37.X * v37.Y * v37.Z
                u35.totalVolume = u35.totalVolume + v38
                local v39 = u35.janitor:add(u3.new(), "destroy", "trackCharacterParts-" .. u35.name)
                local u40 = v39
                for _, u41 in pairs(u36:GetChildren()) do
                    if u41:IsA("BasePart") and not u4.bodyPartsToIgnore[u41.Name] then
                        u35.partToItem[u41] = u36
                        local v42 = u35.parts
                        table.insert(v42, u41)
                        u40:add(u41.AncestryChanged:Connect(function() --[[ Line: 182 ]]
                            --[[
                            Upvalues:
                                [1] = u41
                                [2] = u40
                                [3] = u35
                            --]]
                            if not u41:IsDescendantOf(game) and (u41.Parent == nil and u40 ~= nil) then
                                u40:destroy()
                                u40 = nil
                                u35:update()
                            end
                        end), "Disconnect")
                    end
                end
                u40:add(u36.AncestryChanged:Connect(function() --[[ Line: 182 ]]
                    --[[
                    Upvalues:
                        [1] = u36
                        [2] = u40
                        [3] = u35
                    --]]
                    if not u36:IsDescendantOf(game) and (u36.Parent == nil and u40 ~= nil) then
                        u40:destroy()
                        u40 = nil
                        u35:update()
                    end
                end), "Disconnect")
                local v43 = u35.items
                table.insert(v43, u36)
            end
        end
        for v44, _ in pairs(u35.baseParts) do
            local v45 = v44.Size
            local v46 = v45.X * v45.Y * v45.Z
            u35.totalVolume = u35.totalVolume + v46
            u35.partToItem[v44] = v44
            local v47 = u35.parts
            table.insert(v47, v44)
            local v48 = u35.items
            table.insert(v48, v44)
        end
        u35.whitelistParams = OverlapParams.new()
        u35.whitelistParams.FilterType = Enum.RaycastFilterType.Include
        u35.whitelistParams.MaxParts = #u35.parts
        u35.whitelistParams.FilterDescendantsInstances = u35.parts
    end
end
return u4