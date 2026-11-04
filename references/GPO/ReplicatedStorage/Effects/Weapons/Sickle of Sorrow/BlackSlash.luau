 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Include
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local v5 = OverlapParams.new()
v5.FilterType = Enum.RaycastFilterType.Include
v5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, p6, p7, p8, p9) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
    --]]
    local v10 = p6.Humanoid:LoadAnimation(script.WindupAnim)
    v10:Play()
    _G.PlaySound(p6.PrimaryPart, script.windup)
    task.wait(0.3 - (workspace:GetServerTimeNow() - p7))
    v10:Stop()
    local v11 = p6.Humanoid:LoadAnimation(script.Hold)
    v11:Play()
    local v12 = Instance.new("Model")
    v12.Parent = workspace.Effects
    local v13 = script.ChargeFx:Clone()
    u3.apply(v13, p6)
    v13.Parent = v12
    local v14 = Instance.new("Motor6D")
    v14.Part0 = p6.PrimaryPart
    v14.Part1 = v13
    v14.Parent = v13
    local v15 = nil
    local v16 = nil
    for _, v17 in pairs(v13:GetDescendants()) do
        if v17:IsA("Beam") then
            local v18 = v17.Width0
            local v19 = v17.Width1
            v17.Width0 = 0
            v17.Width1 = 0
            _G.tween(v17, {
                0.4,
                "Circular",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Width0"] = v18,
                ["Width1"] = v19
            })
        end
    end
    local u20 = p6:FindFirstChild("Sickle of SorrowSword")
    local u21
    if u20 then
        v16 = script.ChargeFx_Scythe:Clone()
        u3.apply(v16, p6)
        v16.Parent = u20
        local v22 = Instance.new("Motor6D")
        v22.Part0 = u20.Middle
        v22.Part1 = v16
        v22.Parent = v16
        for _, v23 in pairs(v16:GetDescendants()) do
            if v23:IsA("Beam") then
                local v24 = v23.Width0
                local v25 = v23.Width1
                v23.Width0 = 0
                v23.Width1 = 0
                v23.TextureSpeed = v23.TextureSpeed * 5
                _G.tween(v23, {
                    0.6,
                    "Circular",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Width0"] = v24,
                    ["Width1"] = v25,
                    ["TextureSpeed"] = v23.TextureSpeed * 0.2
                })
            end
        end
        u21 = u20:FindFirstChild("SafeScale", true)
    else
        u21 = nil
    end
    local v26 = script.auraLoop:Clone()
    v26.Parent = p6.PrimaryPart
    v26:Play()
    local v27 = 2 + (p6.PrimaryPart.Size.Y + p6.Humanoid.HipHeight / 2)
    local u28 = nil
    local v29 = false
    while true do
        local v30 = workspace
        local v31 = p6.PrimaryPart.Position
        local v32 = -v27
        local v33 = v30:Raycast(v31, Vector3.new(0, v32, 0), u4)
        if v33 then
            if not v15 then
                v15 = script.ChargeFx_Floor:Clone()
                u3.apply(v15, p6)
                v15.Parent = v12
            end
            local v34 = v33.Position
            local v35 = v33.Normal
            v15.CFrame = CFrame.new(v34, v34 + v35) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            _G.particleEnabled(v15, true)
        elseif v15 then
            _G.particleEnabled(v15, false)
        end
        if p8 <= workspace:GetServerTimeNow() - p7 and v29 == false then
            v29 = true
            v11:Stop()
            v11 = p6.Humanoid:LoadAnimation(script.chargedHold)
            v11:Play()
            v12:ScaleTo(1.3)
            if u20 then
                _G.customEmit(v16)
                local v36 = script.Highlight:Clone()
                u3.apply(v36, p6)
                v36.Parent = p6
                _G.destroy(v36, 0.8)
                _G.tween(v36, {
                    0.8,
                    "Cubic",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["FillTransparency"] = 1,
                    ["FillColor"] = v36.FillColor,
                    ["OutlineColor"] = v36.OutlineColor,
                    ["OutlineTransparency"] = 1
                })
                u28 = u20:GetScale()
                if u21 then
                    u21:Invoke(true)
                end
                u20:ScaleTo(u28 * 1.5)
            end
            _G.tween(v26, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v26, 0.25)
            v26 = script.chargedAuraLoop:Clone()
            v26.Parent = p6.PrimaryPart
            v26:Play()
            local v37 = script.ChargeEmit:Clone()
            v37.CFrame = CFrame.new(p6.UpperTorso.Position)
            v37.Parent = workspace.Effects
            u3.apply(v37, p6)
            _G.customEmit(v37)
            _G.destroy(v37, 5)
            _G.PlaySound(p6.PrimaryPart, script.chargedIndicator)
        end
        task.wait()
        if p6:GetAttribute("BlackSlashHold") == nil then
            v11:Stop()
            if v29 == false then
                p6.Humanoid:LoadAnimation(script.Release):Play()
            else
                p6.Humanoid:LoadAnimation(script.chargedRelease):Play()
            end
            _G.tween(v26, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v26, 0.25)
            _G.PlaySound(p6.PrimaryPart, script.weave)
            _G.particleEnabled(v13, false)
            _G.destroy(v13, 1.5)
            _G.destroy(v12, 5)
            for _, v38 in pairs(v13:GetDescendants()) do
                if v38:IsA("Beam") then
                    _G.tween(v38, {
                        0.25,
                        "Circular",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
            if v15 then
                _G.particleEnabled(v15, false)
                _G.destroy(v15, 2)
            end
            if v16 then
                _G.particleEnabled(v16, false)
                _G.destroy(v16, 1)
                for _, v39 in pairs(v16:GetDescendants()) do
                    if v39:IsA("Beam") then
                        _G.tween(v39, {
                            0.25,
                            "Circular",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        })
                    end
                end
            end
            if v29 == false then
                task.wait(p9.Normal)
                _G.PlaySound(p6.PrimaryPart, script.normalShot)
            else
                task.wait(p9.Charged)
                _G.PlaySound(p6.PrimaryPart, script.chargedShot)
                task.delay(0.25, function() --[[ Line: 204 ]]
                    --[[
                    Upvalues:
                        [1] = u20
                        [2] = u28
                        [3] = u21
                    --]]
                    if u20 and u28 then
                        u20:ScaleTo(u28)
                        if u21 then
                            u21:Invoke(false)
                        end
                    end
                end)
            end
            local v40 = script.SlashShoot:Clone()
            u3.apply(v40, p6)
            v40.CFrame = p6:GetPivot() * CFrame.Angles(0, 0, 0.08726646259971647)
            v40.Parent = workspace.Effects
            _G.destroy(v40, 2)
            _G.customEmit(v40)
            local u41 = v40.beamslashrot
            local u42 = u41.CFrame
            local u43 = 0
            local u44 = nil
            u44 = u2.Heartbeat:Connect(function(p45) --[[ Line: 232 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u41
                    [3] = u42
                    [4] = u44
                --]]
                u43 = u43 + p45
                local v46 = u43 / 0.5
                local v47 = math.min(v46, 1)
                local v48 = 1 - (1 - v47) ^ 2
                local v49 = math.sqrt(v48)
                u41.CFrame = u42 * CFrame.Angles(0, v49 * -3.7524578917878086, 0)
                if v47 >= 1 then
                    u44:Disconnect()
                end
            end)
            _G.tween(v40.beamslash, {
                0.5,
                "Circular",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Width0"] = 0,
                ["Width1"] = 0
            })
            return
        end
    end
end
return v1