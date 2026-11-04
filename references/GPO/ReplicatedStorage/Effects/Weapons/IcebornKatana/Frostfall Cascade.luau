 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u2 = script
local v3 = {}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
local u6 = {
    "rbxassetid://15465037590",
    "rbxassetid://15465037456",
    "rbxassetid://15465037253",
    "rbxassetid://15465037090",
    "rbxassetid://15465029763",
    "rbxassetid://15465029624",
    "rbxassetid://15465029478",
    "rbxassetid://15465029361",
    "rbxassetid://15465029186",
    "rbxassetid://15465028989",
    "rbxassetid://15465022187",
    "rbxassetid://15465022009",
    "rbxassetid://15465021824",
    "rbxassetid://15465021708",
    "rbxassetid://15465021545",
    "rbxassetid://15465021331",
    ""
}
local u7 = {
    "rbxassetid://15440280688",
    "rbxassetid://15440280460",
    "rbxassetid://15440272935",
    "rbxassetid://15440272740",
    "rbxassetid://15440272599",
    "rbxassetid://15440272476",
    "rbxassetid://15440272306",
    "rbxassetid://15440265943",
    "rbxassetid://15440265760",
    "rbxassetid://15440265510",
    "rbxassetid://15440265305",
    "rbxassetid://15440264989",
    ""
}
local function u11(p8, p9) --[[ Line: 52 ]]
    for _, v10 in pairs(p8:GetDescendants()) do
        if v10:IsA("ParticleEmitter") then
            if p9 == nil then
                _G.customEmit(v10)
            else
                v10.Enabled = p9
            end
        end
    end
end
local function u30(u12, p13, p14, p15) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u4
        [4] = u6
        [5] = u11
    --]]
    local u16 = u2.SlashesProjectile:Clone()
    u16.CFrame = p13
    u16.Parent = u12
    _G.PlaySound(u16, script["Audio/IceKatanaMultiShotSlash"], {
        ["Pitch"] = math.random(90, 110) / 100
    }).Parent = u16
    local u17 = p15 / p14
    task.spawn(function() --[[ Line: 73 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u2
            [3] = u5
            [4] = u16
            [5] = u12
            [6] = u4
            [7] = u6
        --]]
        local v18 = tick()
        while tick() - v18 <= u17 do
            local u19 = u2.Cylinder:Clone()
            local v20 = u5:NextNumber(5, 9)
            u19.CFrame = u16.CFrame * CFrame.Angles(0, 0, u5:NextNumber(0, 6.283185307179586))
            local v21 = u5
            u19.Mesh.Scale = Vector3.new(v20, v20, v21:NextNumber(7, 12))
            u19.Parent = u12
            local u22 = u4:Create(u19.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            })
            task.spawn(function() --[[ Line: 85 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u22
                    [3] = u19
                --]]
                for v23, v24 in pairs(u6) do
                    local v25 = #u6 * 0.4
                    if v23 == math.round(v25) then
                        u22:Play()
                    end
                    u19.Decal.Texture = v24
                    task.wait(0.015)
                end
                u22:Destroy()
                u19:Destroy()
            end)
            task.wait(u5:NextNumber(0.01, 0.08))
        end
    end)
    local u26 = u4:Create(u16, TweenInfo.new(u17, Enum.EasingStyle.Linear), {
        ["CFrame"] = u16.CFrame * CFrame.new(0, 0, -p15)
    })
    u26:Play()
    task.delay(u17, function() --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u26
            [3] = u2
            [4] = u12
            [5] = u11
        --]]
        local v27 = u16
        for _, v28 in pairs(v27:GetDescendants()) do
            if v28:IsA("ParticleEmitter") then
                v28.Enabled = false
            end
        end
        u26:Destroy()
        local v29 = u2.Explosion:Clone()
        v29.CFrame = u16.CFrame
        v29.Parent = u12
        u11(v29)
        _G.PlaySound(v29, script["Audio/IceKatanaMultiShotBoom"])
        u16.box:Destroy()
    end)
end
function v3.start(_, u31, p32, p33, u34) --[[ Line: 195 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u5
        [4] = u4
        [5] = u7
        [6] = u30
    --]]
    local u35 = Instance.new("Folder")
    u35.Name = "EffectsFolder"
    u35.Parent = workspace.Effects
    _G.PlaySound(u31, script.IceKatanaDraw)
    task.spawn(function() --[[ Line: 122 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u31
            [3] = u2
            [4] = u35
            [5] = u5
            [6] = u4
            [7] = u7
            [8] = u34
        --]]
        u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        local u36 = workspace:Raycast(u31.Position, Vector3.new(0, -9, 0), u1)
        if u36 then
            local v37 = u2.WindEffect:Clone()
            v37.CFrame = CFrame.lookAt(u36.Position, u36.Position + u36.Normal)
            v37.Attachment.air1.Color = ColorSequence.new(u36.Instance.Color)
            v37.Attachment.air2.Color = ColorSequence.new(u36.Instance.Color)
            v37.Parent = u35
            _G.customEmit(v37)
            for _ = 1, 3 do
                task.spawn(function() --[[ Line: 137 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u36
                        [3] = u5
                        [4] = u35
                        [5] = u4
                        [6] = u7
                    --]]
                    local v38 = u2.Wind:Clone()
                    v38.CFrame = CFrame.lookAt(u36.Position, u36.Position + u36.Normal) * CFrame.Angles(-1.5707963267948966, u5:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, 1, 0)
                    local v39 = u5:NextNumber(0.5, 5)
                    local v40 = v38.Mesh
                    local v41 = u5:NextNumber(1, 3)
                    v40.Scale = Vector3.new(v39, v41, v39)
                    v38.Parent = u35
                    local v42 = u5:NextNumber(5, 15)
                    local v43 = u4
                    local v44 = v38.Mesh
                    local v45 = TweenInfo.new(u5:NextNumber(0.2, 0.5), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                    local v46 = {}
                    local v47 = u5:NextNumber(3, 5)
                    v46.Scale = Vector3.new(v42, v47, v42)
                    local v48 = v43:Create(v44, v45, v46)
                    v48:Play()
                    for _, v49 in pairs(u7) do
                        v38.Decal.Texture = v49
                        task.wait(0.015)
                    end
                    v48:Destroy()
                end)
            end
            for _ = 1, 4 do
                task.spawn(function() --[[ Line: 158 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u36
                        [3] = u5
                        [4] = u35
                        [5] = u4
                        [6] = u7
                    --]]
                    local v50 = u2.Wind:Clone()
                    v50.CFrame = CFrame.lookAt(u36.Position, u36.Position + u36.Normal) * CFrame.Angles(-1.5707963267948966, u5:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, 1, 0)
                    local v51 = u5:NextNumber(2, 4)
                    local v52 = v50.Mesh
                    local v53 = u5:NextNumber(3, 6)
                    v52.Scale = Vector3.new(v51, v53, v51)
                    v50.Parent = u35
                    local v54 = u5:NextNumber(5, 7)
                    local v55 = u4
                    local v56 = v50.Mesh
                    local v57 = TweenInfo.new(u5:NextNumber(0.2, 0.5), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                    local v58 = {}
                    local v59 = u5:NextNumber(6, 9)
                    v58.Scale = Vector3.new(v54, v59, v54)
                    local v60 = v55:Create(v56, v57, v58)
                    v60:Play()
                    for _, v61 in pairs(u7) do
                        v50.Decal.Texture = v61
                        task.wait(0.015)
                    end
                    v60:Destroy()
                end)
            end
        end
        task.wait(0.2)
        if not u34 then
            local v62 = u2.Shine:Clone()
            v62.CFrame = u31 * CFrame.new(-2, -1.25, 1.25)
            v62.Parent = u35
            _G.PlaySound(v62, script.IceKatanaStanceSheath)
            _G.customEmit(v62)
        end
    end)
    u30(u35, CFrame.lookAt(u31.Position, u31.Position + u31.LookVector), p32, p33)
    task.wait(10)
    u35:Destroy()
end
return v3