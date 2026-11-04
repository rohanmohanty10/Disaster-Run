 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = script:WaitForChild("Animations")
script:WaitForChild("Models")
local u5 = script:WaitForChild("SFX")
local u6 = script:WaitForChild("VFX")
local u7 = v3.LocalPlayer
workspace:WaitForChild("Effects")
require(script.Parent:WaitForChild("Shared"))
require(script.Parent.SoulLightningModule)
Random.new()
local u8 = RaycastParams.new()
u8.FilterType = Enum.RaycastFilterType.Include
u8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, u9, p10, u11, u12, u13, u14) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
        [3] = u5
        [4] = u4
        [5] = u2
        [6] = u8
    --]]
    local u15 = u9.PrimaryPart
    local v16 = u9 == u7.Character
    local v17 = u6.FX_Charge.Attachment:Clone()
    v17.Parent = u9.RightHand
    local function v20(p18, p19) --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        _G.PlayEffect("Homie Scale", nil, {
            ["Homie"] = u11,
            ["EasingStyle"] = Enum.EasingStyle.Circular,
            ["EasingDirection"] = Enum.EasingDirection.InOut,
            ["Time"] = p19,
            ["Interval"] = 0,
            ["Scale"] = p18
        })
    end
    local u21 = u11:GetAttribute("CustomMover") == true
    u11:SetAttribute("CustomMovement", true)
    if u21 == false then
        u11:ScaleTo(0.01)
    end
    local v22 = u5.SoulZeusLightningBoltHoldLoop:Clone()
    v22.Parent = v17
    v22:Play()
    task.wait(0.1)
    local u23 = u11.PrimaryPart.RealRoot.Value
    local v24, v25, _ = _G.getRayFloor(CFrame.new(p10), -45)
    local v26 = not v24 and 45 or (v25 - p10).Magnitude - 3
    if u21 == false then
        u23.CFrame = CFrame.new(p10 + Vector3.new(0, v26, 0), u15.Position)
    end
    local u27 = _G.PlaySound(u23, script.SoulZeusLightningBoltStart).Parent
    local u28 = os.clock()
    local u29 = nil
    local u30 = script.VFX.StrikeIndicator:Clone()
    u30.Parent = workspace.Effects
    local v31 = script.SoulZeusGroundSparks:Clone()
    v31.Parent = u30
    v31:Play()
    local v32 = u11.AnimationController:LoadAnimation(u4.ZeusLoop)
    v32:Play()
    local u33 = 0
    u29 = u2.Heartbeat:Connect(function(p34) --[[ Line: 109 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u29
            [3] = u13
            [4] = u23
            [5] = u8
            [6] = u9
            [7] = u28
            [8] = u15
            [9] = u12
            [10] = u21
            [11] = u33
            [12] = u11
            [13] = u30
            [14] = u27
        --]]
        if u14 and u14:GetAttribute("Released") then
            u29:Disconnect()
        else
            if u13 then
                local v35 = u13
                if typeof(v35) == "Instance" and u13:GetAttribute("Released") then
                    u29:Disconnect()
                    return
                end
            end
            local v36 = u23.CFrame
            local v37 = workspace:Raycast(v36.Position, Vector3.new(0, -250, 0), u8)
            if not (v37 and CFrame.new(v37.Position, v37.Position + v37.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296)) then
                local _ = v36 * CFrame.new(0, -250, 0)
            end
            local v38 = u9:GetAttribute("ZeusThunderAimPosition")
            local v39 = os.clock() - u28
            local v40 = math.clamp(v39, 0, 1)
            if u12 < (v38 - u15.Position).Magnitude then
                v38 = CFrame.new(u15.Position, v38) * CFrame.new(0, 0, -u12).Position
            end
            local v41, v42, _ = _G.getRayFloor(CFrame.new(v38), -45)
            local v43 = not v41 and 45 or (v42 - v38).Magnitude - 3
            if u21 == false then
                u23.CFrame = u23.CFrame:Lerp(CFrame.new(v38 + Vector3.new(0, v43, 0), u15.Position), 10 * p34)
                if tick() - u33 >= 0.016666666666666666 then
                    u11:ScaleTo(v40 / 2 * 2 + 1)
                    u33 = tick()
                end
            end
            local v44, v45, v46 = _G.getRayFloor(CFrame.new(u23.Position), 125)
            if v44 then
                u30.CFrame = CFrame.new(v45, v45 + v46) * CFrame.Angles(1.5707963267948966, 0, 0)
                _G.particleEnabled(u30, true)
            else
                _G.particleEnabled(u30, false)
            end
            u27.WorldCFrame = u23.CFrame
        end
    end)
    local v47
    if v16 == true then
        task.spawn(function() --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u14
                [3] = u29
            --]]
            repeat
                u2.RenderStepped:Wait()
            until u14:GetAttribute("Released") == true
            if u29 then
                u29:Disconnect()
            end
        end)
        v47 = u29
    else
        v47 = u29
    end
    repeat
        u2.RenderStepped:Wait()
    until u9:GetAttribute("ZeusThunderGoalPosition")
    v47:Disconnect()
    u29 = nil
    _G.tween(v17.PointLight, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Brightness"] = 0
    })
    _G.tween(v22, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Volume"] = 0
    })
    _G.tween(v31, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Volume"] = 0
    })
    _G.destroy(v17, 2)
    _G.particleEnabled(v17, false)
    _G.PlaySound(u23, script.SFX["ZeusShoot" .. math.random(1, 3)])
    local v48 = game:GetService("HttpService"):JSONDecode(u9:GetAttribute("ZeusThunderGoalPosition"))
    local v49 = v48.serverTime
    local v50 = workspace:GetServerTimeNow() - v49
    task.wait(0.2 - v50)
    if v32 then
        v32:Stop()
    end
    u11.AnimationController:LoadAnimation(u4.ZeusRelease):Play()
    _G.particleEnabled(u30, false)
    _G.destroy(u30, 2)
    local v51 = v48.GoalPosition
    local v52 = CFrame.new(v51[1], v51[2], v51[3])
    _G.PlayEffect("Homie Scale", nil, {
        ["Homie"] = u11,
        ["EasingStyle"] = Enum.EasingStyle.Back,
        ["EasingDirection"] = Enum.EasingDirection.Out,
        ["Time"] = 0.2,
        ["Interval"] = 0,
        ["Scale"] = 2.5
    })
    _G.PlayEffect("SoulThunderBolt", nil, v52, u11.PrimaryPart.CFrame)
    task.wait(0.1)
    task.wait(0.3)
    if u21 == false then
        v20(0.01, 0.1)
        task.wait(0.1)
        u23.CFrame = u15.CFrame
        u11:SetAttribute("CustomMovement", nil)
        u11:SetPrimaryPartCFrame(u15.CFrame)
        v20(1, 0.2)
    else
        v20(1, 0.2)
        u23.CFrame = u15.CFrame
        u11:SetAttribute("CustomMovement", nil)
        u11:SetPrimaryPartCFrame(u15.CFrame)
    end
end
return v1