 

local u1 = {}
local u2 = false
local u3 = false
local u4 = require(script.Parent.VictimManager)
local u5 = script.Parent.DoorHinge.DoorConnector.C0
local u6 = script.Parent.DoorHinge.DoorConnector
local _ = nil
local u7 = false
function u1.Open(_) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
        [3] = u6
        [4] = u5
        [5] = u3
    --]]
    if u7 == true then
        return
    elseif u2 ~= true then
        _G.tween(u6, {
            2,
            Enum.EasingStyle.Bounce,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["C0"] = u5 * CFrame.Angles(0, 3.490658503988659, 0)
        })
        _G.PlaySound(script.Parent.DoorHinge, game.ReplicatedStorage.Assets.JailSFX.open)
        u7 = true
        task.spawn(function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u7
            --]]
            task.wait(2)
            u2 = true
            u7 = false
        end)
        u3 = true
    end
end
function u1.Close(_) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
        [3] = u6
        [4] = u5
    --]]
    if u7 == true then
        return
    elseif u2 ~= false then
        local v8 = {
            ["C0"] = u5
        }
        _G.tween(u6, {
            2,
            Enum.EasingStyle.Bounce,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, v8)
        _G.PlaySound(script.Parent.DoorHinge, game.ReplicatedStorage.Assets.JailSFX.close)
        u7 = true
        task.spawn(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u7
            --]]
            task.wait(2)
            u2 = false
            u7 = false
        end)
    end
end
function u1.Jail(_, u9) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u3
        [4] = u2
    --]]
    u4:Add(u9)
    if _G.Teleport == nil then
        repeat
            task.wait(1)
        until _G.Teleport ~= nil
    end
    local v10 = script.Parent.Center.CFrame
    local _, v11, _ = _G.getRayFloor(v10, 15)
    local v12 = v10.Y - v11.Y
    local v13 = v10 * CFrame.new(0, -v12 + (u9.Humanoid.HipHeight + u9.PrimaryPart.Size.Y / 2), 0)
    _G.Teleport(u9, v13, 3)
    u1:Close()
    u3 = false
    local u14 = game.ReplicatedStorage:WaitForChild("Stats" .. u9.Name, 60)
    if u14.Stats.JailTime.Value > 600 then
        u14.Stats.JailTime.Value = 0
    end
    task.spawn(function() --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u9
            [3] = u4
            [4] = u3
            [5] = u2
            [6] = u1
        --]]
        local v15 = not u14 and 100 or u14.Stats.JailTime.Value
        u9:WaitForChild("Cuffed", 3)
        local v16 = tick()
        local v17 = Instance.new("ForceField", u9)
        local v18 = false
        while u4:Check(u9) == true do
            if u9:FindFirstChild("HumanoidRootPart") == nil then
                warn("NO HUMANOID ROOT PART BROKE LOOP")
                break
            end
            local v19 = (script.Parent.Center.Position - u9.HumanoidRootPart.Position).magnitude
            local v20 = game.Players:GetPlayerFromCharacter(u9)
            if v20 and v20.PlayerGui:FindFirstChild("JailTimer") then
                v20.PlayerGui.JailTimer.TextLabel.Pause.Value = false
                v18 = false
            end
            if v19 >= 10 and (u3 == false and u2 == false) then
                u9:PivotTo(script.Parent.Center.CFrame)
            end
            if v18 == false and tick() - v16 >= 1 then
                v15 = v15 - 1
                u14.Stats.JailTime.Value = u14.Stats.JailTime.Value - 1
                v16 = tick()
            end
            if u9 and u9:FindFirstChild("Cuffed") == nil then
                warn("NO CUFF BROKE")
                break
            end
            if u9:IsDescendantOf(workspace) == false then
                warn("NTO IN WORKSPACE")
                break
            end
            if v15 <= 0 or u14.Stats.JailTime.Value <= 0 then
                warn("OUT OF TIME")
                break
            end
            game["Run Service"].Heartbeat:Wait()
        end
        if v15 and (u14 and u14.Stats.JailTime.Value <= 0) then
            v17:Destroy()
            u1:SetFree(u9)
        end
        u4:Remove(u9)
    end)
end
function u1.SetFree(_, p21) --[[ Line: 142 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    u4:Remove(p21)
    local v22 = game.Players:GetPlayerFromCharacter(p21)
    local v23 = game.ReplicatedStorage:FindFirstChild("Stats" .. p21.Name)
    u1:Open()
    require(game.ServerScriptService.MarineFunctions.Script.Handcuffs):UnCuff(nil, p21, true)
    if v22 and v23.Stats.JailTime.Value == 0 then
        v22:LoadCharacter()
    end
    if v22 then
        v23.Stats.JailTime.Value = 0
        if v22.PlayerGui:FindFirstChild("JailTimer") then
            v22.PlayerGui.JailTimer.TextLabel.Done.Value = true
            _G.destroy(v22.PlayerGui.JailTimer, 2)
        end
    end
    v22:LoadCharacter()
end
function u1.CheckInter(_) --[[ Line: 165 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3
end
return u1