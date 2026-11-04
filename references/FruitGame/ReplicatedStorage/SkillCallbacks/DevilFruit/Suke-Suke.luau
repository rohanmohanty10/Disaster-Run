 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
local u5 = require(game.ReplicatedStorage.ClientImpacts.SukeTrans)
u1:GetMouse()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["selfTrans"] = false,
        ["aoeTrans"] = false,
        ["rockThrow"] = false
    }
    return v9
end
function u6.SelfInvisibility(u10, p11) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    local v14 = u10.Cooldowns
    if u12:FindFirstChild("Suke") == nil and (v14.selfTrans == false and (_G.check:inspect(u12) == true and _G.StamCheck("Self Invisibility") == true)) then
        local v15 = u3.GetM("Self Invisibility")
        local v16 = v15.cd
        if _G.StamCheck("Self Invisibility") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v14.selfTrans = true
        u12.Humanoid:LoadAnimation(script.selft):Play()
        task.wait(0.25)
        local v17 = u5:start(u12)
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Self Invisibility")
        local u19 = tick()
        local u20, u21, v22
        if v18 then
            u20, u21, v22 = unpack(v18)
        else
            v22 = nil
            u21 = nil
            u20 = nil
        end
        local u23 = v22 == nil and 0 or v22
        if u20 == nil then
            v17:Fire()
        end
        local u24 = false
        task.wait(0.5)
        u10:DoubleCastSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["Button"] = p11,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 70 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24 = true
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 73 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u12
                --]]
                return u10.Tool.Parent == u12
            end,
            ["CancelFunction"] = function() --[[ Name: CancelFunction, Line 76 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u19
                    [3] = u23
                    [4] = u21
                    [5] = u12
                    [6] = u24
                    [7] = u13
                --]]
                return (u20 == nil or (u23 <= tick() - u19 or u21 ~= nil and u21.Parent ~= u12)) and true or ((u24 == true or (u12.Parent == nil or u12.Parent ~= workspace.PlayerCharacters)) and true or u13.Stamina.Value <= 0)
            end
        })
        repeat
            task.wait()
        until u24 == true
        if u20 then
            if v17 then
                v17:Fire()
            end
            u20:InvokeServer()
        end
        task.wait(0.25)
        _G.keysetup:cooldown("Self Invisibility", v16)
        _G.fw(v16)
        v14.selfTrans = false
    end
end
function u6.AreaInvisibility(u25, p26) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local u27 = u1.Character
    local u28 = u2["Stats" .. u1.Name]
    local v29 = u25.Cooldowns
    if u27:FindFirstChild("Suke") == nil and (v29.aoeTrans == false and (_G.check:inspect(u27) == true and _G.StamCheck("Area Invisibility") == true)) then
        local v30 = u3.GetM("Area Invisibility")
        local v31 = v30.cd
        if _G.StamCheck("Area Invisibility") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        v29.aoeTrans = true
        u27.Humanoid:LoadAnimation(script.aoe):Play()
        task.wait(0.3)
        local v32 = u5:start(u27)
        local v33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Area Invisibility")
        local u34 = false
        local u35, u36, v37
        if v33 then
            u35, u36, v37 = unpack(v33)
        else
            v37 = nil
            u36 = nil
            u35 = nil
        end
        local u38 = v37 == nil and 0 or v37
        if u35 == nil then
            v32:Fire()
        end
        task.wait(0.5)
        local u39 = tick()
        u25:DoubleCastSkill(p26, {
            ["Key"] = Enum.KeyCode.R,
            ["Button"] = p26,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 138 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34 = true
            end,
            ["SkipTap"] = true,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 142 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u27
                --]]
                return u25.Tool.Parent == u27
            end,
            ["CancelFunction"] = function() --[[ Name: CancelFunction, Line 145 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u39
                    [3] = u38
                    [4] = u36
                    [5] = u27
                    [6] = u34
                    [7] = u28
                --]]
                return (u35 == nil or (u38 <= tick() - u39 or u36 ~= nil and u36.Parent ~= u27)) and true or (u34 == true or not u27:FindFirstChild("Suke-Suke") or ((u27.Parent == nil or u27.Parent ~= workspace.PlayerCharacters) and true or u28.Stamina.Value <= 0))
            end
        })
        repeat
            task.wait()
        until u34 == true
        if u35 then
            if v32 then
                v32:Fire()
            end
            u35:InvokeServer()
        end
        task.wait(0.25)
        _G.keysetup:cooldown("Area Invisibility", v31)
        _G.fw(v31)
        v29.aoeTrans = false
    end
end
function u6.InvisibleRockThrow(p40, p41) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u42 = u1.Character
    local u43 = u2["Stats" .. u1.Name]
    local v44 = p40.Cooldowns
    if v44.rockThrow == false and (_G.check:inspect(u42) == true and _G.StamCheck("Invisible Rock Throw") == true) then
        local v45 = u3.GetM("Invisible Rock Throw")
        local v46 = v45.cd
        if _G.StamCheck("Invisible Rock Throw") == false then
            return
        end
        if v45.statreq and _G.MeetReq(v45.statreq) == false then
            return
        end
        local v47 = Ray.new(u42.HumanoidRootPart.CFrame.Position, u42.HumanoidRootPart.CFrame.upVector * -10)
        local v48, _, _ = _G.raycastIgnoreList(v47, {
            workspace.Effects,
            workspace.Projectiles,
            workspace.PlayerCharacters,
            workspace.NPCs,
            workspace.Ragdolls
        })
        if v48 == nil then
            return
        end
        v44.rockThrow = true
        _G.canuse = false
        local v49 = u42.Humanoid:LoadAnimation(script.rockthrow)
        v49:Play()
        v49:AdjustWeight(2)
        local u50 = nil
        spawn(function() --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u50
            --]]
            task.wait(0.1)
            u50 = game.ReplicatedStorage.Events.Skill:InvokeServer("Invisible Rock Throw")
        end)
        _G.PauseAnim(v49, 0.55, 1)
        _G.FaceMouse = true
        tick()
        p40:ChargeSkill(p41, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 206 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u43
                --]]
                return not u42:FindFirstChild("Suke-Suke") or ((u42.Parent == nil or u42.Parent ~= workspace.PlayerCharacters) and true or u43.Stamina.Value <= 0)
            end
        })
        _G.FaceMouse = false
        u42.HumanoidRootPart.Anchored = true
        v49:AdjustSpeed(1)
        task.wait(0.19999999999999996)
        if u50 then
            u50:InvokeServer(p40:GetMouseCFrame().Position)
        end
        task.wait(0.1)
        u42.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Invisible Rock Throw", v46)
        _G.fw(v46)
        v44.rockThrow = false
    end
end
return u6