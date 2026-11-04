 

local u1 = game.Players.LocalPlayer
if not u1.Character then
    u1.CharacterAdded:Wait()
end
local u2 = workspace:WaitForChild("Ragdolls", 5)
local u3 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
local u4 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u5 = game.ReplicatedStorage:WaitForChild("CombatAnimations", 1)
local v6 = require(game.ReplicatedStorage.Modules.ScriptSet)
local v7 = game:GetService("ReplicatedStorage")
local u8 = require(v7.Modules.VFXUtility.highlight_emit)
local u9, u10, _, _, u11 = v6.get()
local u12 = {
    ["Fishman"] = u11.Customization.Race.Value:match("Fishman")
}
local u13 = nil
local u14 = { "2SS", "3SS" }
u12.Utils = {
    ["trail"] = function(p15) --[[ Name: trail, Line 22 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u14
            [3] = u13
        --]]
        local v16 = u10:FindFirstChildWhichIsA("Tool")
        if u10:FindFirstChild(v16.Name .. "Sword") ~= nil or table.find(u14, v16.Name) ~= nil then
            if u10:FindFirstChild(v16.Name .. "Sword") and u10:FindFirstChild(v16.Name .. "Sword"):FindFirstChild("Blade") or table.find(u14, v16.Name) ~= nil then
                local v17 = u10:GetChildren()
                local u18 = {}
                for v19 = 1, #v17 do
                    if v17[v19]:IsA("Model") and (v17[v19]:FindFirstChild("Blade") and v17[v19].Name:match("Sword")) then
                        local v20 = v17[v19].Blade:GetChildren()
                        for v21 = 1, #v20 do
                            local v22 = v20[v21]
                            table.insert(u18, v22)
                        end
                    end
                end
                local u23 = game:GetService("HttpService"):GenerateGUID(true)
                u13 = u23
                for u24 = 1, #u18 do
                    if (u18[u24]:IsA("Trail") or u18[u24]:IsA("ParticleEmitter")) and (u18[u24].Name ~= "notTrail" and u18[u24]:GetAttribute("trailBypass") == nil) then
                        u18[u24].Enabled = true
                        task.delay(p15, function() --[[ Line: 51 ]]
                            --[[
                            Upvalues:
                                [1] = u13
                                [2] = u23
                                [3] = u18
                                [4] = u24
                            --]]
                            if u13 == u23 then
                                u18[u24].Enabled = false
                            end
                        end)
                    end
                end
            end
        end
    end,
    ["getHitBox"] = function() --[[ Name: getHitBox, Line 62 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u4
            [3] = u12
        --]]
        local v25 = u10:FindFirstChildWhichIsA("Tool")
        u10:GetAttribute("customM1")
        local v26 = not v25 and "" or v25.Name
        if v25 and v25:FindFirstChild("weaponOverride") then
            v26 = v25:FindFirstChild("weaponOverride").Value
        end
        if u4[v26] then
            u12.Utils.trail(u4[v26].trailTime)
        end
        return _G.getHitBox(u10)
    end,
    ["getAnimation"] = function(p27, p28, p29) --[[ Name: getAnimation, Line 79 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u10
            [3] = u9
            [4] = u11
            [5] = u5
            [6] = u4
        --]]
        local v30 = u12.PunchCombo
        local v31 = u10.Humanoid
        local v32 = u10:FindFirstChildWhichIsA("Tool")
        local v33 = nil
        local v34 = nil
        local v35 = u10:GetAttribute("customM1")
        local v36 = u10:GetAttribute("customM1Model")
        if v32 then
            if v35 and (_G.toolLockedCustomM1s[v35] and v32.Name ~= _G.toolLockedCustomM1s[v35]) then
                v35 = nil
            end
            if _G.isFruitSupressed(u9) and (v32 and v32.Name == u11.Stats.DF.Value) then
                local v37
                if p29 < v30 then
                    v37 = v31:LoadAnimation(u5.Melee[p27 .. "Punch" .. v30])
                elseif p28 == true then
                    v37 = v31:LoadAnimation(u5.Melee.Dash)
                else
                    v37 = v31:LoadAnimation(u5.Melee:FindFirstChild("Punch" .. v30))
                end
                return v37, "Melee", v37.Animation
            end
            local v38 = v32:FindFirstChild("weaponOverride")
            local _ = v32.Name
            local v39
            if v38 and v35 == nil then
                v39 = v38.Value
            else
                v39 = nil
            end
            if v32 and (u11.Stats.FightingStyle.Value ~= "" and (game.ReplicatedStorage.CombatAnimations:FindFirstChild(u11.Stats.FightingStyle.Value) and (v32:GetAttributes().MeleeTool ~= nil and (v32:GetAttribute("customM1") == nil and v35 == nil)))) then
                v32 = u9.Backpack:FindFirstChild(u11.Stats.FightingStyle.Value) or v32
            end
            local v40 = v35 or v39
            if v35 and v36 then
                v34 = u10:FindFirstChild(v36)
            end
            local v41 = v32.Name
            if not v34 then
                if u4[v32.Name] or v40 then
                    local v42 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v32.Name)
                    if v42 == nil then
                        v42 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v40)
                    end
                    if v32:GetAttribute("Offhand") == true and u4[v32.Name].hasOffhand == true then
                        v42 = v42:FindFirstChild("OffhandSlashes")
                    elseif v42 then
                        v42 = v42.Slashes
                    end
                    if v33 == nil then
                        if p29 < v30 then
                            v33 = v31:LoadAnimation(v42[p27 .. "Slash" .. v30])
                        elseif p28 == true then
                            v33 = v31:LoadAnimation(v42.Dash)
                        else
                            v33 = v31:LoadAnimation(v42:FindFirstChild("Slash" .. v30))
                        end
                    end
                    v41 = "Sword"
                elseif v32.Name == "BlackLeg" then
                    if u10:FindFirstChild("Diable") == nil then
                        if p29 < v30 then
                            v33 = v31:LoadAnimation(u5.BlackLeg[p27 .. "Punch" .. v30])
                        elseif p28 == true then
                            v33 = v31:LoadAnimation(u5.BlackLeg.Dash)
                        else
                            v33 = v31:LoadAnimation(u5.BlackLeg:FindFirstChild("Punch" .. v30))
                        end
                    elseif p29 < v30 then
                        v33 = v31:LoadAnimation(u5.Diable[p27 .. "Punch" .. v30])
                    elseif p28 == true then
                        v33 = v31:LoadAnimation(u5.Diable.Dash)
                    else
                        v33 = v31:LoadAnimation(u5.Diable:FindFirstChild("Punch" .. v30))
                    end
                    v41 = "BlackLeg"
                elseif v32.Name == "FishmanKarate" then
                    if p29 < v30 then
                        v33 = v31:LoadAnimation(u5.FishmanKarate[p27 .. "Punch" .. v30])
                    elseif p28 == true then
                        v33 = v31:LoadAnimation(u5.FishmanKarate.Dash)
                    else
                        v33 = v31:LoadAnimation(u5.FishmanKarate:FindFirstChild("Punch" .. v30))
                    end
                    v41 = "FishmanKarate"
                elseif v32.Name == "DragonClaw" then
                    if p29 < v30 then
                        v33 = v31:LoadAnimation(u5.DragonClaw[p27 .. "Punch" .. v30])
                    elseif p28 == true then
                        v33 = v31:LoadAnimation(u5.DragonClaw.Dash)
                    else
                        v33 = v31:LoadAnimation(u5.DragonClaw:FindFirstChild("Punch" .. v30))
                    end
                    v41 = "DragonClaw"
                elseif u5:FindFirstChild(v41) then
                    local v43 = u5:FindFirstChild(v41)
                    if p29 < v30 then
                        v33 = v31:LoadAnimation(v43[p27 .. "Punch" .. v30])
                    elseif p28 == true then
                        v33 = v31:LoadAnimation(v43.Dash)
                    else
                        v33 = v31:LoadAnimation(v43:FindFirstChild("Punch" .. v30))
                    end
                else
                    if p29 < v30 then
                        v33 = v31:LoadAnimation(u5.Melee[p27 .. "Punch" .. v30])
                    elseif p28 == true then
                        v33 = v31:LoadAnimation(u5.Melee.Dash)
                    else
                        v33 = v31:LoadAnimation(u5.Melee:FindFirstChild("Punch" .. v30))
                    end
                    v41 = "Melee"
                end
                return v33, v41, v33.Animation
            end
            local v44 = game.ReplicatedStorage.Modules.SwordHandle.Swords:FindFirstChild(v35).Slashes
            local v45
            if p29 < v30 then
                v45 = v34.AnimationController:LoadAnimation(v44[p27 .. "Slash" .. v30])
            elseif p28 == true then
                v45 = v34.AnimationController:LoadAnimation(v44.Dash)
            else
                v45 = v34.AnimationController:LoadAnimation(v44:FindFirstChild("Slash" .. v30))
            end
            return v45, "Sword", v45.Animation
        end
    end,
    ["getAnimSpeed"] = function() --[[ Name: getAnimSpeed, Line 233 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
            [3] = u11
            [4] = u4
        --]]
        local v46 = u10:FindFirstChildWhichIsA("Tool")
        local v47 = u10:FindFirstChild("VenomDemonModel")
        local v48 = u10:GetAttribute("customM1")
        if v47 then
            return 1
        end
        if _G.isFruitSupressed(u9) and (v46 and v46.Name == u11.Stats.DF.Value) then
            v48 = nil
        end
        return v48 and 1 or (not (v46 and u4[v46.Name]) and (v46 and v46.Name == "BlackLeg" and 1.75 or (v46 and v46:GetAttributes().MeleeTool ~= nil and 1.75 or 1.75)) or u4[v46.Name].animspeed)
    end,
    ["checkHoldingWeapon"] = function() --[[ Name: checkHoldingWeapon, Line 259 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v49 = u10:FindFirstChildWhichIsA("Tool")
        return v49 and v49:GetAttribute("customRun") and true or (_G.currentSword and (_G.currentSword.Anims and (_G.currentSword.Anims.run and #_G.currentSword.Anims.run >= 1)) and true or false)
    end,
    ["hitStunned"] = function() --[[ Name: hitStunned, Line 270 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        if u10:GetAttribute("Dazed") then
            return 0
        end
        local v50 = u10:GetChildren()
        local v51 = 0
        local v52 = false
        for v53 = 1, #v50 do
            if v50[v53]:IsA("ObjectValue") then
                if v50[v53]:GetAttribute("isStun") == nil then
                    v52 = true
                    break
                end
                v51 = v51 + 1
            end
        end
        return v52 == true and 0 or v51
    end,
    ["getinregion"] = function(_, p54) --[[ Name: getinregion, Line 295 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v55 = u3.new(unpack(p54))
        local v56 = u2:GetChildren()
        local v57 = {}
        for v58 = 1, #v56 do
            if v56[v58]:FindFirstChild("Humanoid") then
                local v59 = v56[v58].PrimaryPart
                table.insert(v57, v59)
            end
        end
        return v55:FindPartsInRegion3WithWhiteList(v57, 100)
    end,
    ["inCombatCheck"] = function() --[[ Name: inCombatCheck, Line 308 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v60 = u10:GetAttribute("bossCombat")
        return v60 and workspace:GetServerTimeNow() - v60 <= 2 and true or ((u10:FindFirstChild("inCombat") or (game.ReplicatedStorage:FindFirstChild("raidMode") or game.ReplicatedStorage:FindFirstChild("Matchinfo"))) and true or false)
    end,
    ["holdingValidMelee"] = function() --[[ Name: holdingValidMelee, Line 323 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u4
        --]]
        local v61 = u1.Character:FindFirstChildWhichIsA("Tool")
        if v61 == nil or v61 and (v61:GetAttributes().MeleeTool == nil and u4[v61.Name] == nil) then
            return false
        else
            return v61 == nil or v61:GetAttribute("fullCustomM1") == nil
        end
    end
}
u12.Callbacks = {}
for _, v62 in pairs(script:GetChildren()) do
    u12.Callbacks[v62.Name] = require(v62).new(u12)
end
function _G.resetM1() --[[ Line: 343 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12.Callbacks.Attack:ResetM1()
end
function game.ReplicatedStorage.Events.CombatRegister.OnClientInvoke(p63) --[[ Line: 347 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u10
        [3] = u12
    --]]
    if p63.Type == "M1Endlag" then
        u8.tweenHighlight(u10, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 1, Enum.HighlightDepthMode.Occluded, "In", 0.5)
        u12.Callbacks.Attack:M1Endlag()
    end
end
return u12