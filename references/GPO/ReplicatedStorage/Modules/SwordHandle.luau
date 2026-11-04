 

local u1 = {}
u1.__index = u1
local u2 = require(game.ReplicatedStorage.Modules.MaidClass).new()
local v3 = {
    "Firework Daggers",
    "Firework Rocket Launcher",
    "Inferno Rocket Blade",
    "Candy Cane",
    "Firework Lancer",
    "Dark Blade",
    "Cupid\'s Bow",
    "Mega-Pow",
    "World Ender",
    "Cupid\'s Chakram"
}
script:SetAttribute("PrestigeWeapons", game:GetService("HttpService"):JSONEncode(v3))
local u4 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u5, u6, u7, u8, u9, u10
if game:GetService("RunService"):IsServer() == false then
    u5 = require(game.ReplicatedStorage.Modules.ScriptSet)
    u6, u7, u8, u9, u10 = u5.get()
else
    u7 = nil
    u6 = nil
    u8 = nil
    u9 = nil
    u10 = nil
    u5 = nil
end
local function u27(p11, p12) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p11.currentSword ~= p12 then
        if p11 and p11.Anims then
            for _, v13 in p11.Anims do
                if v13 then
                    if typeof(v13) == "table" then
                        for v14 = 1, #v13 do
                            v13[v14]:Stop()
                        end
                    else
                        v13:Stop()
                    end
                end
            end
        end
        if p11.footStepConnection then
            p11.footStepConnection:Disconnect()
            p11.footStepConnection = nil
        end
        if p11.offhandFootStepConnection then
            p11.offhandFootStepConnection:Disconnect()
            p11.offhandFootStepConnection = nil
        end
        local v15 = u7.Humanoid:WaitForChild("Animator")
        local v16 = script.Swords:FindFirstChild(p12)
        local v17 = nil
        local v18 = nil
        local v19 = v15:LoadAnimation(v16.Idle)
        v19.Priority = Enum.AnimationPriority.Idle
        local v20
        if v16:FindFirstChild("holdAnim") then
            v20 = v15:LoadAnimation(v16.holdAnim)
        else
            v20 = nil
        end
        local v21
        if v16:FindFirstChild("runAnim") then
            v18 = v15:LoadAnimation(v16.runAnim)
            v18:AdjustSpeed(p11.runSpeed)
            v18.Priority = Enum.AnimationPriority.Movement
            v21 = v16.runAnim.AnimationId
        else
            v21 = nil
        end
        if v16:FindFirstChild("walkAnim") then
            v17 = v15:LoadAnimation(v16.walkAnim)
        end
        if v18 then
            p11.footStepConnection = v18.KeyframeReached:Connect(function(p22) --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                if u7.PrimaryPart.Anchored ~= true then
                    if p22:match("step") and (p22 ~= "step" and _G.footstep) then
                        _G.footstep(p22)
                    end
                end
            end)
        end
        local v23 = nil
        local v24
        if v16:FindFirstChild("offhandwalkAnim") then
            v24 = v15:LoadAnimation(v16.offhandwalkAnim)
        else
            v24 = nil
        end
        if v16:FindFirstChild("offhandrunAnim") then
            v23 = v15:LoadAnimation(v16.offhandrunAnim)
            v23:AdjustSpeed(p11.runSpeed)
            v23.Priority = Enum.AnimationPriority.Movement
            p11.offhandFootStepConnection = v23.KeyframeReached:Connect(function(p25) --[[ Line: 95 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                if u7.PrimaryPart.Anchored ~= true then
                    if p25:match("step") and (p25 ~= "step" and _G.footstep) then
                        _G.footstep(p25)
                    end
                end
            end)
        end
        p11.Anims = {
            ["idle"] = { v19 },
            ["walk"] = { v17 },
            ["run"] = { v18 },
            ["hold"] = { v20 },
            ["offhandWalk"] = { v24 },
            ["offhandRun"] = { v23 }
        }
        if v16 and v16:FindFirstChild("ConstantIdle") then
            local v26 = v15:LoadAnimation(v16.ConstantIdle)
            v26.Priority = Enum.AnimationPriority.Idle
            p11.Anims.constantIdles = { v26 }
        end
        p11.runId = v21
        p11.currentSword = p12
    end
end
function u1.New(u28, u29) --[[ Line: 130 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u8
        [4] = u9
        [5] = u10
        [6] = u5
        [7] = u4
        [8] = u27
        [9] = u1
        [10] = u2
    --]]
    if script.Swords:FindFirstChild(u28) ~= nil then
        local v30, v31, v32, v33, v34 = u5.get()
        u6 = v30
        u7 = v31
        u8 = v32
        u9 = v33
        u10 = v34
        u6.Character:WaitForChild("Humanoid"):WaitForChild("Animator")
        local u35 = nil
        u35 = {
            ["Ready"] = true,
            ["Equiped"] = true,
            ["EqId"] = nil,
            ["Name"] = u28,
            ["currentSword"] = nil,
            ["Tool"] = u29,
            ["runSpeed"] = u4[u28].runSpeed or 2,
            ["updateAnims"] = function() --[[ Name: updateAnims, Line 147 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u27
                    [3] = u35
                    [4] = u28
                --]]
                if u29 and u29:FindFirstChild("weaponOverride") then
                    u27(u35, u29:FindFirstChild("weaponOverride").Value)
                elseif u35.currentSword ~= u28 then
                    u27(u35, u28)
                end
            end
        }
        u27(u35, u28)
        local v36 = u1
        local v37 = u35
        setmetatable(v37, v36)
        u2[u35] = u35
        task.spawn(function() --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u4
            --]]
            local v38 = script.Swords:FindFirstChild(u28)
            if v38 then
                local v39 = { v38 }
                for _, v40 in pairs(u4[u28].hitSounds) do
                    table.insert(v39, v40)
                end
                for _, v41 in pairs(u4[u28].swingSFX) do
                    table.insert(v39, v41)
                end
                game:GetService("ContentProvider"):PreloadAsync(v39)
            end
        end)
        return u35
    end
end
local v42 = {
    "Katana",
    "Skyblue Katana",
    "Ryu\'s Katana",
    "Seabeast Katana",
    "Musashi\'s Crimson Katana",
    "Musashi\'s Rose Katana",
    "Kraken Katana",
    "Crimson Fang Katana",
    "Shattered Fang Katana",
    "Amethyst Fang Katana",
    "ODM Katana"
}
if game["Run Service"]:IsServer() then
    for v43 = 1, #v42 do
        if v42[v43] ~= "Katana" then
            if script.Swords:FindFirstChild(v42[v43]) then
                script.Swords:FindFirstChild(v42[v43]):Destroy()
            end
            local v44 = script.Swords.Katana:Clone()
            v44.Name = v42[v43]
            v44.Parent = script.Swords
        end
        local v45 = game.ReplicatedStorage.SkillCallbacks.FistStyles["1SS"]:Clone()
        v45.Name = v42[v43]
        v45.Parent = game.ReplicatedStorage.SkillCallbacks.SwordStyles
    end
    local function u54(p46, p47) --[[ Line: 199 ]]
        --[[
        Upvalues:
            [1] = u54
        --]]
        local v48
        if p47 == nil and _G.customPrestigePrefix[p46] then
            if #_G.customPrestigePrefix[p46] > 1 then
                for v49 = 1, #_G.customPrestigePrefix[p46] do
                    u54(p46, _G.customPrestigePrefix[p46][v49])
                end
                return
            end
            v48 = _G.customPrestigePrefix[p46][1]
        else
            v48 = "Prestige"
        end
        local v50 = (p47 or v48) .. " "
        local v51 = script.Swords:FindFirstChild(v50 .. p46)
        if v51 == nil then
            local v52 = script.Swords:FindFirstChild(p46):Clone()
            v52.Name = v50 .. p46
            v52.Parent = script.Swords
        else
            v51.Skill:Destroy()
            script.Swords:FindFirstChild(p46).Skill:Clone().Parent = v51
        end
        if game.ReplicatedStorage.SkillCallbacks.SwordStyles:FindFirstChild(p46) then
            local v53 = game.ReplicatedStorage.SkillCallbacks.SwordStyles:FindFirstChild(p46):Clone()
            v53.Name = v50 .. p46
            v53:SetAttribute("Prestige", true)
            v53.Parent = game.ReplicatedStorage.SkillCallbacks.SwordStyles
        end
    end
    for v55 = 1, #v3 do
        u54(v3[v55])
    end
    u54("Candy Cane", "Iceborn")
end
return u1