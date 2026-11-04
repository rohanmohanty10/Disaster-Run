 

local v1 = {}
game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local _ = script
local u3 = workspace.Effects
local u4 = require(game.ReplicatedStorage.Modules.ParticleEmit)
local u5 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v6 = RaycastParams.new()
v6.RespectCanCollide = true
v6.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v6.FilterType = Enum.RaycastFilterType.Include
local function u10(p7, p8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v9 = Random.new():NextNumber(540, 720)
    p7.CFrame = p8 * CFrame.new(0, 0, -2) * CFrame.Angles(-1.5707963267948966, math.rad(v9), 0)
    p7.Mesh.Scale = Vector3.new(0, 0, 0)
    p7.Parent = u3
    p7.Decal.Transparency = 0.95
    u2:Create(p7, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In, math.random(5, 7)), {
        ["CFrame"] = p7.CFrame * CFrame.Angles(0, 30, 0)
    }):Play()
    u2:Create(p7.Mesh, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        ["Scale"] = Vector3.new(8, 15, 8)
    }):Play()
    u2:Create(p7.Decal, TweenInfo.new(0.75), {
        ["Transparency"] = 1
    }):Play()
    task.delay(0.75, p7.Destroy, p7)
    return p7
end
function v1.start(_, u11, p12, u13, u14, p15) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u10
        [4] = u4
        [5] = u2
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) == false then
        return
    end
    local v16 = script
    local _ = u11.Humanoid
    local v17 = u11.HumanoidRootPart
    if p12 ~= "Charge" then
        u14.PrimaryPart.CFrame = CFrame.new(u14.PrimaryPart.Position, u13.Position)
        u14.PrimaryPart:WaitForChild("chainAttach")
        local v18 = v16.throw:Clone()
        u5.apply(v18, u11)
        v18.CFrame = v17.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 7.5)
        v18.Parent = u3
        u4:EmitHandler(v18)
        u4:ParticleDestroy(v18)
        local u19 = v16.projectile:Clone()
        u5.apply(u19, u11)
        u19.CFrame = u14.PrimaryPart.CFrame
        u19.Parent = u3
        u19.Beam.Attachment0 = u11.RightHand.RightGripAttachment
        u19.Beam.Attachment1 = u14.PrimaryPart.chainAttach
        u2:Create(u14.PrimaryPart, TweenInfo.new(0.3), {
            ["CFrame"] = u13
        }):Play()
        local u20 = (u14.PrimaryPart.Position - u13.Position).Magnitude
        local function v21() --[[ Line: 136 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u20
            --]]
            u19.Beam.CurveSize1 = u20 / 40
            if math.random(1, 2) == 1 then
                u19.Beam.CurveSize1 = -u19.Beam.CurveSize1
            end
            _G.tween(u19.Beam, {
                1,
                "Bounce",
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = 0,
                ["CurveSize1"] = 0
            })
        end
        v21()
        _G.PlaySound(u19, script["Audio/TojISpearChainSpinShoot"]).Parent = u19
        _G.customWeld(u19, u14.PrimaryPart, CFrame.Angles(0, 0, 0), u19)
        if p15 then
            local v22 = v16.hit:Clone()
            u5.apply(v22, u11)
            v22.CFrame = p15:GetPivot()
            v22.Parent = u3
            u4:EmitHandler(v22)
            u4:ParticleDestroy(v22)
        end
        task.wait(0.3)
        u4:ToggleEmit(u19.Attachment, false)
        if p15 and _G.canTargetCFrame(p15) == true then
            local v23 = {
                ["CFrame"] = v17.CFrame * CFrame.new(0, 0, -3)
            }
            u2:Create(p15.PrimaryPart, TweenInfo.new(0.3), v23):Play()
        end
        local u24 = u11:FindFirstChild("Inverted Spear of HeavenSword")
        tick()
        if u24 then
            v21()
            local u25 = nil
            u25 = game["Run Service"].RenderStepped:Connect(function(p26) --[[ Line: 170 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u24
                    [3] = u25
                    [4] = u13
                --]]
                if u14.PrimaryPart == nil or u24.PrimaryPart == nil then
                    u25:Disconnect()
                    u25 = nil
                    return
                elseif (u14.PrimaryPart.Position - u24.PrimaryPart.Position).Magnitude <= 1 then
                    u14.PrimaryPart.CFrame = u24.PrimaryPart.CFrame
                else
                    u14.PrimaryPart.CFrame = u14.PrimaryPart.CFrame:Lerp(u24.PrimaryPart.CFrame, 25 * p26)
                    u14.PrimaryPart.CFrame = CFrame.new(u14.PrimaryPart.Position, u13.Position)
                end
            end)
        end
        task.delay(0.3, function() --[[ Line: 189 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u19
            --]]
            u4:ParticleDestroy(u19)
        end)
        return
    end
    local u27 = v16.spin:Clone()
    u5.apply(u27, u11)
    u27.CFrame = v17.CFrame * CFrame.new(2, 0, 0.1) * CFrame.Angles(0, 1.5707963267948966, 0)
    u27.Orientation = u27.Orientation * Vector3.new(1, 1, 1)
    u27.Parent = u3
    local v28 = script.chain:Clone()
    u5.apply(v28, u11)
    v28.CFrame = u11.PrimaryPart.CFrame
    v28.Parent = workspace.Effects
    v28.Beam.Attachment0 = u11.RightHand.RightGripAttachment
    _G.customWeld(v28, u14.PrimaryPart, CFrame.Angles(0, 0, 0), v28)
    local v31 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u11
        --]]
        local v29, v30, _ = _G.getRayFloor(u27.smokeOrg.WorldCFrame + Vector3.new(0, 3, 0), 7)
        if v29 == nil then
            _G.particleEnabled(u27.smoke, false)
        else
            u27.smoke.WorldCFrame = CFrame.new(v30, u27.smokeOrg.WorldCFrame * CFrame.new(0, -30, 0).Position)
            _G.particleEnabled(u27.smoke, true)
        end
        u27.CFrame = CFrame.new(u11.RightHand.Position, u11.PrimaryPart.CFrame * CFrame.new(0, 0, 100).Position) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(0, 0, 0.75)
    end)
    local v32 = 0
    local v33 = {}
    while true do
        if tick() - v32 >= 0.2 then
            local v34 = v16.BeanWind:Clone()
            u5.apply(v34, u11)
            u10(v34, u27.CFrame)
            v32 = tick()
        end
        task.wait()
        if u11:GetAttribute("InvertedSpearThrowCharge") == nil then
            v31:Disconnect()
            u4:ParticleDestroy(u27)
            for _, u35 in pairs(v33) do
                u2:Create(u35:GetChildren()[1], TweenInfo.new(1.5), {
                    ["Transparency"] = 1
                }):Play()
                task.delay(1.5, function() --[[ Line: 108 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                    --]]
                    u35:Destroy()
                end)
            end
            v28:Destroy()
            return
        end
    end
end
return v1