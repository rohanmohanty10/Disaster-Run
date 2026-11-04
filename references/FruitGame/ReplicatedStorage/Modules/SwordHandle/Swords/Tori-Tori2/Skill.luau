 

local v1 = {}
local u2, _, u3, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = nil
local u5 = {
    ["heal"] = false,
    ["freeze"] = false
}
local u6 = require(game.ReplicatedStorage.Modules.Skills)
local u7 = nil
function v1.setup(_, u8, u9) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u5
        [4] = u2
        [5] = u3
        [6] = u6
    --]]
    if u4 then
        u4:Disconnect()
        u4 = nil
    end
    if u7 ~= u8 then
        for v10, _ in u5 do
            u5[v10] = false
        end
    end
    u7 = u8
    game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
    u4 = u3.InputBegan:Connect(function(p11, p12) --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u5
            [4] = u6
            [5] = u3
        --]]
        if u9.Parent ~= u8 or (_G.canuse == false or p12 == true) then
            return
        end
        if p11.KeyCode == Enum.KeyCode.E and (u5.heal == false and _G.check:inspect(u8) == true) then
            local v13 = u6.GetM("Sweet Treat")
            local v14 = v13.cd
            if _G.StamCheck("Sweet Treat") == false then
                return
            elseif not v13.statreq or _G.MeetReq(v13.statreq) ~= false then
                _G.canuse = false
                u5.heal = true
                game.ReplicatedStorage.Events.Skill:InvokeServer("Sweet Treat")
                _G.canuse = true
                _G.keysetup:cooldown("Sweet Treat", v14)
                _G.fw(v14)
                u5.heal = false
            end
        end
        if p11.KeyCode == Enum.KeyCode.R and (u5.freeze == false and _G.check:inspect(u8) == true) then
            local v15 = u6.GetM("Flash Freeze")
            local v16 = v15.cd
            if _G.StamCheck("Flash Freeze") == false then
                return
            end
            if v15.statreq and _G.MeetReq(v15.statreq) == false then
                return
            end
            _G.canuse = false
            local v17 = u8.Humanoid.Animator:LoadAnimation(script.freeze)
            v17:Play()
            v17:AdjustWeight(2)
            u8.Humanoid.WalkSpeed = 4
            _G.PauseAnim(v17, 0.4, 1)
            while true do
                game["Run Service"].RenderStepped:Wait()
                if _G.check:inspect(u8) == false then
                    v17:Stop()
                    break
                end
                u8.Humanoid.WalkSpeed = 4
                if u3:IsKeyDown(Enum.KeyCode.R) == false or u9.Parent ~= u8 then
                    break
                end
            end
            u5.freeze = true
            v17:AdjustSpeed(1)
            task.wait(0.2)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Flash Freeze")
            task.wait(0.2)
            u8.Humanoid.WalkSpeed = 16
            _G.canuse = true
            _G.keysetup:cooldown("Flash Freeze", v16)
            _G.fw(v16)
            u5.freeze = false
        end
    end)
    return weaponCallbacks
end
return v1