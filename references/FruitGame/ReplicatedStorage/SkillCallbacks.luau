 

local u1 = game.Players.LocalPlayer
require(u1.PlayerScripts:WaitForChild("InputHandler"))
local u2 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local function u7(p3, p4) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not p4[p3] then
        p4[p3] = true
        if p3.Destroy then
            local v5 = p3.Destroy
            if typeof(v5) == "function" then
                p3:Destroy()
            end
        end
        for _, v6 in p3 do
            if typeof(v6) == "table" and v6.Destroy then
                v6:Destroy()
            elseif typeof(v6) == "RBXScriptConnection" then
                v6:Disconnect()
            elseif typeof(v6) == "table" then
                u7(v6, p4)
            elseif typeof(v6) == "Instance" then
                if v6:IsA("AnimationTrack") then
                    v6:Stop()
                end
                if v6:IsA("Tool") == false then
                    v6:Destroy()
                end
            end
        end
    end
end
local u8 = {}
u8.__index = u8
function u8.new() --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u1
    --]]
    local v9 = u8
    local u10 = setmetatable({}, v9)
    u10.Skills = {}
    local u11 = nil
    u11 = u1.CharacterRemoving:Once(function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
        --]]
        for v12, _ in u10.Skills do
            u10:CleanSkill(v12)
        end
        u11 = nil
    end)
    return u10
end
function u8.CleanSkill(p13, p14) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p13.Skills[p14] then
        u7(p13.Skills[p14], {})
        table.clear(p13.Skills[p14])
        local v15 = p13.Skills[p14]
        setmetatable(v15, nil)
        p13.Skills[p14] = nil
    end
end
({})["3SS"] = { "1SS", "2SS" }
function u8.GetSkillCallback(u16, p17, p18) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v19 = typeof(p17) == "string" and p17 or p17.Name
    local u20 = not u2[v19] or u2[v19].style or (u2[v19].baseWeapon or v19)
    local v21 = u16.Skills[u20]
    if v21 then
        if u20 == "1SS" and (v21.Tool ~= p17 and (p17 ~= nil and typeof(p17) == "Instance")) then
            v21.Tool = p17
        end
        if p18 then
            v21.Tool = p18
        end
    else
        local u22 = script:FindFirstChild(u20, true)
        if not u22 then
            return
        end
        task.spawn(function() --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u20
            --]]
            local v23 = { u22 }
            game:GetService("ContentProvider"):PreloadAsync(v23)
            if _G.preloadFolderName then
                _G.preloadFolderName(u20)
            end
        end)
        local u24 = p18 or p17
        local u25 = require(u22).new(u16, u24)
        u16.Skills[u20] = u25
        if typeof(u24) == "Instance" and u24:IsA("Tool") then
            local function u28(u26) --[[ Line: 98 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u1
                    [3] = u28
                    [4] = u20
                    [5] = u16
                --]]
                u25.Destroyed = u26.Destroying:Connect(function() --[[ Line: 99 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u26
                        [3] = u25
                        [4] = u28
                        [5] = u20
                        [6] = u16
                    --]]
                    local v27 = u1.Backpack:FindFirstChild(u26.Name) or u1.Character:FindFirstChild(u26.Name)
                    if v27 and v27 ~= u26 then
                        warn("found new tool", v27)
                        u25.Tool = v27
                        u28(v27)
                    else
                        warn("cleaning ", u20)
                        u16:CleanSkill(u20)
                    end
                end)
            end
            u25.Destroyed = u24.Destroying:Connect(function() --[[ Line: 99 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u24
                    [3] = u25
                    [4] = u28
                    [5] = u20
                    [6] = u16
                --]]
                local v29 = u1.Backpack:FindFirstChild(u24.Name) or u1.Character:FindFirstChild(u24.Name)
                if v29 and v29 ~= u24 then
                    warn("found new tool", v29)
                    u25.Tool = v29
                    u28(v29)
                else
                    warn("cleaning ", u20)
                    u16:CleanSkill(u20)
                end
            end)
            v21 = u25
        else
            warn(u24, " not a tool")
            v21 = u25
        end
    end
    return v21
end
return u8