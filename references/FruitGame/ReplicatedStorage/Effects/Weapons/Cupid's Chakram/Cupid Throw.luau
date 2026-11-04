 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(game.ReplicatedStorage.Modules.Trove)
local u5 = require(v1.Modules.Client.WeaponVFXRecolor)
local u6 = require(script.Parent.VFXHandler)
local u7 = RaycastParams.new()
u7.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u7.FilterType = Enum.RaycastFilterType.Include
local _ = v3.LocalPlayer
local _ = workspace.Effects
return {
    ["start"] = function(_, u8) --[[ Name: start, Line 24 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u4
            [4] = u2
            [5] = u7
        --]]
        local u9 = u8.Character
        local u10 = u8.Start
        local v11 = u8.Prestige and script.Prestige or script.Normal
        local v12 = u8.Prestige and script.Parent.Prestige or script.Parent.Normal
        local u13 = u8.Origin
        local u14 = u8.Goal
        local u15 = u8.Speed
        local u16 = u8.ThrownDuration
        local u17 = u8.IdleDuration
        local u18 = u8.dt
        local u19 = u9.HumanoidRootPart
        local v20 = u8.RightVector
        local v21 = v11.ThrowWindFX:Clone()
        u5.apply(v21, u9)
        v21.WorldCFrame = u19.CFrame * v21.CFrame
        v21.Parent = workspace.Terrain
        _G.customEmit(v21)
        _G.destroy(v21, 5)
        local v22 = v11.Wind1Beam:Clone()
        u5.apply(v22, u9)
        v22.CFrame = u19.CFrame * CFrame.new(-0.300000012, 0, -9.68699932, 0.939692616, 0.342020184, 0, -0.342020184, 0.939692616, 0, 0, 0, 1)
        v22.Parent = workspace.Effects
        u6.TweenBeams(v22.Beams, {
            ["Properties"] = {
                ["Brightness"] = 0,
                ["TextureSpeed"] = 2,
                ["Width0"] = 0,
                ["Width1"] = 0
            },
            ["RotationSpeed"] = 0.5,
            ["Rotation"] = true,
            ["Offset"] = CFrame.new(0, 0, 2),
            ["Duration"] = 0.35,
            ["Easing"] = "Quad",
            ["EasingDirection"] = "In"
        })
        _G.destroy(v22, 4)
        local u23 = v12.ChakramClone:Clone()
        u5.apply(u23, u9)
        u23:PivotTo(CFrame.fromMatrix(u13, v20, Vector3.new(0, 1, 0)))
        u23.Parent = workspace.Effects
        u23.AnimationController.Animator:LoadAnimation(script.Parent.Spin):Play()
        local u24 = u23:GetPivot().Rotation
        local u25 = 0
        local u26 = -(Vector3.new(0, 1, 0)):Cross(v20)
        local u27 = nil
        local u42 = {
            ["Thrown"] = function(p28) --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u16
                    [3] = u13
                    [4] = u14
                    [5] = u23
                    [6] = u24
                --]]
                local v29 = u4
                local v30 = p28 / u16
                u23:PivotTo(u24 + u13:Lerp(u14, (v29:GetValue(math.min(v30, 1), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out))))
            end,
            ["Idling"] = function(p31) --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u18
                --]]
                local v32 = p31 / u18
                u25 = math.floor(v32)
            end,
            ["Returning"] = function(p33) --[[ Line: 96 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u25
                    [3] = u23
                    [4] = u26
                    [5] = u19
                    [6] = u15
                    [7] = u27
                --]]
                local v34 = p33 / u18
                local v35 = math.floor(v34)
                if u25 ~= v35 then
                    for _ = u25 + 1, v35 do
                        local v36 = u23:GetPivot()
                        u26 = u26:Lerp((u19.Position - v36.Position).Unit, u18 * 10)
                        local v37 = u26
                        local v38 = v37 * u15 * u18
                        local v39 = v36.Position + v38
                        u23:PivotTo(CFrame.fromMatrix(v39, (Vector3.new(0, 1, 0)):Cross(v37), Vector3.new(0, 1, 0)))
                        u25 = u25 + 1
                        if (v39 - u19.Position).Magnitude <= 5 then
                            if u27 then
                                u27:Disconnect()
                                u27 = nil
                            end
                            for _, v40 in u23:QueryDescendants("BasePart") do
                                v40.Transparency = 1
                            end
                            for _, v41 in u23:QueryDescendants("Trail, ParticleEmitter") do
                                v41.Enabled = false
                            end
                            _G.destroy(u23, 5)
                        end
                    end
                end
            end
        }
        local u43 = false
        (function() --[[ Line: 134 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            local v44 = {}
            for _, v45 in game.Players:GetPlayers() do
                if v45.Character and v45.Character ~= u9 then
                    local v46 = v45.Character
                    table.insert(v44, v46)
                end
            end
            return v44
        end)()
        local u47 = OverlapParams.new()
        u47.FilterType = Enum.RaycastFilterType.Include
        u47.FilterDescendantsInstances = _G.getTargets(u9, nil, nil, true)
        local u48 = u15
        u27 = u2.Heartbeat:Connect(function(p49) --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u27
                [3] = u23
                [4] = u7
                [5] = u43
                [6] = u10
                [7] = u16
                [8] = u17
                [9] = u42
                [10] = u26
                [11] = u8
                [12] = u47
                [13] = u15
                [14] = u48
            --]]
            if u9:FindFirstChild("PB") then
                u27:Disconnect()
                u27 = nil
                u23:Destroy()
                return
            else
                local v50 = workspace:Raycast(u23:GetPivot().Position, Vector3.new(-0, -5, -0), u7)
                for _, v51 in u23.Root:QueryDescendants(">Attachment") do
                    local v52 = v50 ~= nil
                    if v52 ~= u43 then
                        _G.particleEnabled(v51, v52, true)
                    end
                    if v50 then
                        v51.WorldPosition = v50.Position + v50.Normal * 0.15
                        _G.recolorParticles(v51, v50.Instance.Color)
                    end
                end
                u43 = v50 ~= nil
                local v53 = workspace:GetServerTimeNow() - u10
                local v54 = u42[v53 <= u16 and "Thrown" or (v53 <= u17 and "Idling" or "Returning")]
                if v54 then
                    u15 = #workspace:GetPartBoundsInBox(CFrame.fromMatrix(u23:GetPivot().Position, (Vector3.new(0, 1, 0)):Cross(u26), Vector3.new(0, 1, 0)), u8.HitboxSize, u47) > 1 and u48 * 0.2 or u48
                    v54(v53, p49)
                end
            end
        end)
    end
}