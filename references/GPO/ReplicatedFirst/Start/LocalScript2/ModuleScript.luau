 

local _ = xpcall
local v1 = game
local _ = debug.info
local u2 = pcall
local u3 = task.wait
local v4 = v1:GetService("Players")
local v5 = v1:GetService("ScriptContext")
local v6 = v1:GetService("ReplicatedStorage")
local u7 = v6:WaitForChild("Events"):WaitForChild("Skill")
local _ = os.clock
local u8 = script
local u9 = string.match
local v10 = error
local u11 = task.spawn
local v12 = setmetatable
local u13 = workspace
local v14 = {
    ["__len"] = v10,
    ["__tostring"] = function() --[[ Name: __tostring, Line 14 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        while true do
            u11(function() --[[ Line: 14 ]]
                while true do

                end
            end)
        end
    end,
    ["__index"] = v10,
    ["__newindex"] = v10,
    ["__call"] = v10,
    ["__namecall"] = v10
}
local v15 = v12({}, v14)
local v16 = {}
for _ = 1, 50 do
    v15 = v12(v15, v14)
end
local v17 = v12(v15, {
    ["__len"] = v10,
    ["__metatable"] = false,
    ["__tostring"] = function() --[[ Name: __tostring, Line 19 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        while true do
            u11(function() --[[ Line: 19 ]]
                while true do

                end
            end)
        end
    end,
    ["__index"] = v10,
    ["__newindex"] = v10,
    ["__call"] = v10,
    ["__namecall"] = v10
})
for v18 = 1, 50 do
    v16[v18] = v17
end
v12(v16, v17)
local u19 = v4.LocalPlayer or v4.PlayerAdded:Wait()
local u20 = {}
local u21 = v6:WaitForChild("Stats" .. u19.Name)
u21:WaitForChild("Stats")
local function u25() --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u19
        [3] = u9
    --]]
    local v22 = 26
    local v23 = game.Players.LocalPlayer.Character
    if u21 then
        local v24 = (u21.Stats.FightingStyle.Value == "Rokushiki" or (u21.Stats.FightingStyle.Value == "Kamishiki" or v23 and v23:GetAttribute("GEAR2Active") ~= nil)) and 78 or ((_G.soruDashing or u19:GetAttribute("soruDash")) and 78 or (u21.Stats.DF.Value == "Yomi-Yomi" and 36 or ((u9(u21.Customization.Race.Value, "Fishman") or _G.swimming) and 36 or (u21.Stats.DF.Value == "Venom-Venom" and 50 or v22))))
        v22 = u21.Stats.DF.Value == "Buddha-Buddha" and 160 or v24
    end
    return v22 + 100
end
local function u26() --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u11
    --]]
    u3(1.5)
    while true do
        u11(function() --[[ Line: 56 ]]
            while true do

            end
        end)
    end
end
local u27 = table.insert
local u28 = table.clear
local u29 = tick
local _ = Enum.HumanoidStateType.Jumping
local u30 = false
u21:WaitForChild("Stats"):WaitForChild("DF")
local function v31() --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u30
    --]]
    if u21.Stats.DF.Value == "Buddha-Buddha" then
        u30 = true
    end
end
if u21.Stats.DF.Value == "Buddha-Buddha" then
    u30 = true
end
u21.Stats.DF.Changed:Connect(v31)
local function v36(p32) --[[ Line: 79 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u28
        [3] = u25
        [4] = u7
        [5] = u27
        [6] = u13
        [7] = u3
        [8] = u26
    --]]
    if #u20 > 0 then
        for _, v33 in u20 do
            v33:Disconnect()
        end
        u28(u20)
    end
    local u34 = p32:WaitForChild("Humanoid", 12)
    if u34 and u34.Health > 0 then
        u27(u20, u34:GetPropertyChangedSignal("WalkSpeed"):Connect(function() --[[ Line: 90 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u34
                [3] = u7
            --]]
            if u25() <= u34.WalkSpeed then
                u7:InvokeServer("skillValid 2", "AboveMaxFIX: " .. u34.WalkSpeed)
            end
        end))
        while u34.Health > 0 and p32:IsDescendantOf(u13) do
            u3(1)
            local v35 = u34.WalkSpeed
            u34.WalkSpeed = -70
            if u34.WalkSpeed < 0 then
                u7:InvokeServer("skillValid 2", "SpoofedWalkSpeed: " .. u34.WalkSpeed)
                u26()
                return
            end
            u34.WalkSpeed = v35
        end
    end
end
local u37 = string.find
local u38 = string.lower
local u39 = tostring
local u40 = string.sub
v5.Error:Connect(function(u41, u42, u43) --[[ Line: 177 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u2
        [3] = u39
        [4] = u37
        [5] = u38
        [6] = u40
        [7] = u7
        [8] = u26
    --]]
    if u43 and u43 == u8 or u43 and (u2(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        u43.Archivable = u43.Archivable
    end) and (u39(u43) == "ShiftLockController" and (u43.Parent and u39(u43.Parent) == "CameraScript"))) or (u43 and (u2(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        u43.Archivable = u43.Archivable
    end) and (u39(u43) == "CameraScript" and u39(u43.Parent) == "PlayerScripts")) or (u43 and (u2(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        u43.Archivable = u43.Archivable
    end) and (u39(u43) == "ControlScript" and u39(u43.Parent) == "PlayerScripts")) or (u43 and (u2(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        u43.Archivable = u43.Archivable
    end) and u39(u43) == "ChatMain") or u43 and (u2(function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u43
        --]]
        u43.Archivable = u43.Archivable
    end) and u39(u43) == "ChatScript")))) then
        return
    elseif u37(u38(u41), "current parent") and (u37(u38(u41), "is locked") and u37(u38(u41), "new parent")) or (u37(u38(u41), "curl error") and u37(u38(u41), "timeout") or (u37(u38(u41), "coregui") and u37(u38(u41), "robloxgui") or (u37(u38(u41), "not enough memory") or (u37(u38(u41), "marketplaceservice") or (u37(u38(u41), "roact") or u37(u38(u41), "corepackages")))))) then
        return
    else
        local u44 = false
        local v45 = u40(u41, 1, 100)
        local v46 = u40(u42, 1, 32)
        if not (u37(u38(v46), "current parent") and (u37(u38(v46), "is locked") and u37(u38(v46), "new parent")) or (u37(u38(v46), "curl error") and u37(u38(v46), "timeout") or (u37(u38(v46), "coregui") and u37(u38(v46), "robloxgui") or (u37(u38(v46), "not enough memory") or (u37(u38(v46), "marketplaceservice") or (u37(u38(v46), "roact") or u37(u38(v46), "corepackages"))))))) then
            if u43 then
                u2(function() --[[ Line: 207 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u2
                        [3] = u44
                        [4] = u37
                        [5] = u38
                        [6] = u41
                        [7] = u42
                    --]]
                    local u47 = u43
                    if u2(function() --[[ Line: 168 ]]
                        --[[
                        Upvalues:
                            [1] = u47
                        --]]
                        u47.Archivable = u47.Archivable
                    end) then
                        if u37(u38(u41), "no output from") or (u37(u38(u42), "no output from") or (u37(u38(u42), "thread 0") or u37(u38(u41), "thread 0"))) then
                            u44 = true
                        end
                    else
                        u44 = true
                    end
                end)
            else
                u44 = true
            end
            if u44 then
                u7:InvokeServer("skillValid 2", "ScriptError:\nMsg: " .. v45 .. "\nStack: " .. v46)
                u26()
            end
        end
    end
end)
u19.CharacterAdded:Connect(v36)
local v48 = u19.Character
if v48 then
    v36(v48)
end
u11(function() --[[ Line: 228 ]]
    --[[
    Upvalues:
        [1] = u29
    --]]
    local _ = Instance.new("RemoteEvent").FireServer
    u29()
end)
u3()
u8:Destroy()
return nil