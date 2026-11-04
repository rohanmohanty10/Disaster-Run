 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
local u4 = game.Players.LocalPlayer
local u5 = game.ReplicatedStorage:FindFirstChild("Stats" .. u4.Name)
require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, _) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    local u6 = game.Players.LocalPlayer.Character
    local v7 = u6:GetAttribute("GEAR2Active") ~= nil and "Gear2Dash" or (u5.Stats.FightingStyle.Value == "Kamishiki" and "KamishikiSoru" or "Soru")
    local v8 = u2.GetM(v7)
    if v8.stamreq and _G.StamCheck(v8.stamreq, true) == false then
        return
    end
    if v8.statreq and (_G.MeetReq(u2.GetM(v7).statreq, nil, true) == false and u6:GetAttribute("GEAR2Active") == nil) or u6:FindFirstChild("Blocking") then
        require(script.Parent.Regular):start()
        return
    end
    _G.soruDashing = true
    u4:SetAttribute("soruDash", true)
    local v9 = u6.Humanoid.Health / u6.Humanoid.MaxHealth
    local v10 = v9 > 0.3 and 1 or v9
    u6.Humanoid.WalkSpeed = 75 * v10
    task.spawn(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u3
        --]]
        if u6:GetAttribute("GEAR2Active") == nil then
            if u5.Stats.FightingStyle.Value == "Kamishiki" then
                _G.PlayEffect("KamishikiSoru", nil, u6)
                local v11 = {
                    ["char"] = u6
                }
                game.ReplicatedStorage.Events.Skill:InvokeServer("KamishikiSoru", v11)
            else
                u3:start({
                    ["char"] = u6
                })
                local v12 = {
                    ["char"] = u6
                }
                game.ReplicatedStorage.Events.Skill:InvokeServer("Soru", v12)
            end
        else
            _G.PlayEffect("KamishikiSoru", nil, u6)
            local v13 = {
                ["char"] = u6
            }
            game.ReplicatedStorage.Events.Skill:InvokeServer("Gear2Dash", v13)
            return
        end
    end)
    local v14 = tick()
    while true do
        if _G.check:inspect(u6, true) == false or _G.blocking == true then
            warn("stopped cause stun or blocking")
            break
        end
        u6.Humanoid.WalkSpeed = 75 * v10
        game["Run Service"].RenderStepped:Wait()
        if tick() - v14 >= 0.4 then
            break
        end
    end
    u4:SetAttribute("soruDash", nil)
    _G.soruDashing = nil
    if _G.running == false then
        u6.Humanoid.WalkSpeed = 16
    else
        u6.Humanoid.WalkSpeed = 25
    end
    _G.keysetup:cooldown("Soru", 0.5)
    task.wait(1)
    return true
end
return v1