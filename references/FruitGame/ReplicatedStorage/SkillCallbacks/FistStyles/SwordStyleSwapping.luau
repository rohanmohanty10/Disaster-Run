 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u3 = require(game.ReplicatedStorage.Modules.Skills)
function v1.swap(_, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = game.Players.LocalPlayer
    local v6 = p4.Cooldowns
    local v7 = v5.Character
    local _ = game.ReplicatedStorage["Stats" .. v5.Name]
    if v6.SwordStyleSwap == nil then
        v6.SwordStyleSwap = false
    end
    local v8 = v7:GetAttribute("currentSwordStyle")
    local v9 = v8 == nil and 3 or v8
    if v6.SwordStyleSwap == false and _G.canuse == true then
        local v10 = u3.GetM("Sword Style Swap")
        local v11 = v10.cd
        if _G.StamCheck("Sword Style Swap") == false then
            return
        end
        if v10.statreq and _G.MeetReq(v10.statreq) == false then
            return
        end
        v6.SwordStyleSwap = true
        local v12 = v9 + 1
        local v13 = v12 > 3 and 1 or v12
        v7:SetAttribute("currentSwordStyle", v13)
        script[v13 .. "SS"]:Play()
        _G.keysetup:Destroy()
        local v14
        if u2[v13 .. "SS"] then
            v14 = u2[v13 .. "SS"]
        else
            v14 = u2.Katana
        end
        _G.keysetup:setup(v13 .. "SS", v14.keys)
        _G.fw(v11)
        v6.SwordStyleSwap = false
    end
end
function v1.matchCooldowns(_, p15) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v16 = game.Players.LocalPlayer
    local v17 = require(v16.Backpack:WaitForChild("SkillCallbacks"))
    local v18 = { "1SS", "2SS", "3SS" }
    local u19 = {}
    local u20 = {}
    local function u24(p21) --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u2
        --]]
        if u20[p21] then
            return u20[p21]
        end
        for _, v22 in pairs(u2) do
            if v22.keys then
                for v23 = 1, #v22.keys do
                    if v22.keys[v23][1] == p21 then
                        u20[p21] = v22.keys[v23][2]
                        return u20[p21]
                    end
                end
            end
        end
    end
    local function u33(p25, p26, p27) --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u24
        --]]
        for u28, v29 in pairs(u19) do
            local v30 = v29.Cooldowns
            for u31, v32 in pairs(v30) do
                if u24(u31) == p25 and (v32 == false and u31 ~= p27) then
                    u19[u28].Cooldowns[u31] = true
                    _G.keysetup:cooldown(u31, p26)
                    task.delay(p26, function() --[[ Line: 88 ]]
                        --[[
                        Upvalues:
                            [1] = u19
                            [2] = u28
                            [3] = u31
                        --]]
                        u19[u28].Cooldowns[u31] = false
                    end)
                end
            end
        end
    end
    for v34 = 1, #v18 do
        u19[v18[v34]] = v17:GetSkillCallback(v18[v34])
    end
    (function(p35) --[[ Name: matchCooldowns, Line 101 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u3
            [3] = u33
        --]]
        for v36, v37 in pairs(p35) do
            if v37 ~= false then
                local v38 = u24(v36)
                local v39 = u3.GetM(v36)
                if v39 ~= nil then
                    u33(v38, v39.cd, v36)
                end
            end
        end
    end)(p15)
end
return v1