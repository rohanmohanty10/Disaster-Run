 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["summon"] = false,
        ["target"] = false,
        ["move"] = false,
        ["recall"] = false
    }
    return v7
end
function u4.SummonBunny(p8, _) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    local function v14() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v11 = workspace.NPCs:GetChildren()
        local v12 = 0
        for v13 = 1, #v11 do
            if v11[v13].Name == u1.Name .. "\'s Bunny" then
                v12 = v12 + 1
            end
        end
        return v12
    end
    local v15 = game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name)
    if v9.summon == false and (_G.check:inspect(v10) == true and (_G.StamCheck("Summon Bunny", nil, v15.Stamina.MaxValue / 8) == true and v14() < _G.CheckItemAmmount(u1, "Mini Bunny"))) then
        local v16 = u2.GetM("Summon Bunny")
        local v17 = v16.cd
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        v9.summon = true
        if game.ReplicatedStorage.Events.Skill:InvokeServer("Summon Bunny") == true then
            v10.Humanoid:LoadAnimation(script.summon):Play()
        end
        task.wait(0.24999999999999994)
        task.wait(0.45)
        _G.keysetup:cooldown("Summon Bunny", v17)
        _G.fw(v17)
        v9.summon = false
    end
end
function u4.BunnyTarget(p18, _) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = p18.Cooldowns
    local v20 = u1.Character
    if v19.target == false and (_G.check:inspect(v20) == true and _G.StamCheck("Bunny Target") == true) then
        local v21 = u2.GetM("Bunny Target")
        local v22 = v21.cd
        if _G.StamCheck("Bunny Target") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.target = true
        local v23 = _G.getTargetNearMouse()
        if v23 then
            local u24 = v23.Parent
            v20.Humanoid:LoadAnimation(script.target):Play()
            pcall(function() --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                local v25 = game.ReplicatedStorage.MiscModels.targetParticle.Attachment:Clone()
                v25.Parent = u24.HumanoidRootPart
                v25.ParticleEmitter:Emit(1)
                v25.ParticleEmitter2:Emit(1)
                _G.destroy(v25, 0.25)
            end)
            local v26 = {
                ["target"] = u24
            }
            game.ReplicatedStorage.Events.Skill:InvokeServer("Bunny Target", v26)
        end
        _G.keysetup:cooldown("Bunny Target", v22)
        _G.fw(v22)
        v19.target = false
    end
end
function u4.BunnyMove(u27, p28) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v29 = u27.Cooldowns
    local v30 = u1.Character
    if v29.move == false and (_G.check:inspect(v30) == true and _G.StamCheck("Bunny Move") == true) then
        local v31 = u2.GetM("Bunny Move")
        local v32 = v31.cd
        if _G.StamCheck("Bunny Move") == false then
            return
        end
        if v31.statreq and _G.MeetReq(v31.statreq) == false then
            return
        end
        v29.move = true
        local v33 = _G.MouseTarget
        local u34 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bunny Move")
        if v33 and u34 then
            local u35 = 0
            u27:ChargeSkill(p28, {
                ["Key"] = Enum.KeyCode.Z,
                ["EndFunction"] = function() --[[ Name: EndFunction, Line 124 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u34
                        [3] = u27
                    --]]
                    if tick() - u35 >= 0.016666666666666666 then
                        u34:FireServer({
                            ["pos"] = u27:GetMouseCFrame().Position
                        })
                        u35 = tick()
                    end
                end
            })
        end
        if u34 then
            u34:FireServer()
        end
        _G.keysetup:cooldown("Bunny Move", v32)
        _G.fw(v32)
        v29.move = false
    end
end
function u4.BunnyRecall(p36, _) --[[ Line: 142 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v37 = p36.Cooldowns
    local v38 = u1.Character
    if v37.recall == false and (_G.check:inspect(v38) == true and _G.StamCheck("Bunny Recall") == true) then
        local v39 = u2.GetM("Bunny Recall")
        local v40 = v39.cd
        if _G.StamCheck("Bunny Recall") == false then
            return
        end
        if v39.statreq and _G.MeetReq(v39.statreq) == false then
            return
        end
        v37.recall = true
        v38.Humanoid:LoadAnimation(script.recall):Play()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Bunny Recall", {
            ["pos"] = p36:GetMouseCFrame().Position
        })
        _G.keysetup:cooldown("Bunny Recall", v40)
        _G.fw(v40)
        v37.recall = false
    end
end
return u4