 

local v1 = {}
local u2 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u3 = script.Parent.Puddles.Purple
local u4 = require(script.Parent.VenomSplash)
local u5 = script.Animations
game.Players.LocalPlayer:GetMouse()
local function u11(p6) --[[ Line: 15 ]]
    local v7 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v8 = math.clamp(v7, 1, 10)
    for _, v9 in p6:GetDescendants() do
        if v9:IsA("ParticleEmitter") then
            local v10 = v9:GetAttribute("EmitCount") * (v8 / 10)
            v9:Emit((math.clamp(v10, 1, v9:GetAttribute("EmitCount"))))
        end
    end
end
function PlayAnim(p12, p13)
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v14 = (p12:FindFirstChild("Humanoid") or p12:FindFirstChild("AnimationController")).Animator:LoadAnimation(u5[p13])
    v14:Play(0, 1, 1)
    return v14
end
function NewPuddle(p15, p16, p17, p18)
    --[[
    Upvalues:
        [1] = u3
        [2] = u11
    --]]
    local v19 = u3:GetChildren()
    local u20 = v19[math.random(1, #v19)]:Clone()
    u20:PivotTo(CFrame.new(p15, p16 + p15) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0))
    u20.Parent = workspace.Effects
    for _, v21 in u20:GetChildren() do
        local v22 = v21:FindFirstChildOfClass("MeshPart")
        local v23 = v22.Size * 2.5
        v22.Size = Vector3.new()
        if v21.Name == "Out" then
            v23 = v23 * 1.02
        end
        local v24 = v23 * p17
        if p18 then
            v22.Color = ({
                ["In"] = Color3.fromRGB(136, 27, 47),
                ["Out"] = Color3.fromRGB(0, 0, 0)
            })[v21.Name]
            v22.Transparency = v21.Name == "Out" and 0.65 or 0
        end
        _G.tween(v22, {
            0.25,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = v24
        }, nil, true)
    end
    local v25 = script.SplashPuddle:Clone()
    v25.CFrame = CFrame.new(p15, p16 + p15) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v25.Parent = workspace.Effects
    u11(v25)
    _G.destroy(v25, 2)
    task.delay(2, function() --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        _G.destroy(u20, 1)
        for _, v26 in u20:GetChildren() do
            local v27 = v26:FindFirstChildOfClass("MeshPart")
            _G.tween(v27, { 0.95, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }, {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Transparency"] = 1
            }, nil, true)
        end
    end)
end
local function u53(p28, p29, p30) --[[ Line: 106 ]]
    local u31
    if p30 then
        u31 = script.CylinderR:Clone()
    else
        u31 = script.Cylinder:Clone()
    end
    local v32 = (p28.Position - p29.Position).Magnitude
    local v33 = next
    local v34, v35 = u31:GetChildren()
    for _, v36 in v33, v34, v35 do
        local v37 = v36.Size.Y * 1.25
        local v38 = v36.Size.Z * 1.25
        v36.Size = Vector3.new(v32, v37, v38)
    end
    local v39 = CFrame.new(p28.Position, p29.Position) * CFrame.new(0, 0, -v32 / 2) * CFrame.Angles(0, -1.5707963267948966, 0)
    local v40 = CFrame.Angles
    local v41 = math.random(-360, 360)
    u31:PivotTo(v39 * v40(math.rad(v41), 0, 0))
    u31.Parent = workspace.Effects
    _G.destroy(u31, 0.4)
    local u42 = u31:GetPivot()
    local v43 = next
    local v44, v45 = u31:GetChildren()
    for _, u46 in v43, v44, v45 do
        local u47 = u46.Name == "Glass" and 0.3 or 0.25
        task.delay(0.125, function() --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u46
                [2] = u47
                [3] = u42
            --]]
            local v48 = _G.tween
            local v49 = u46
            local v50 = {
                u47,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v51 = {}
            local v52 = u46.Size.X
            v51.Size = Vector3.new(v52, 0, 0)
            v51.CFrame = u42 + u42:inverse() * u46.Position * 0
            v48(v49, v50, v51, nil, true)
        end)
    end
    task.delay(0.125, function() --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u42
        --]]
        _G.tween(u31.PrimaryPart, {
            0.25,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u42 + u42:inverse() * u42.Position * 0
        }, nil, true)
    end)
end
function SingularShoot(p54, p55, p56, p57)
    --[[
    Upvalues:
        [1] = u11
        [2] = u2
        [3] = u53
        [4] = u4
    --]]
    local u58 = nil
    local u59 = RaycastParams.new()
    u59.FilterDescendantsInstances = p57
    u59.FilterType = Enum.RaycastFilterType.Include
    local u60 = script.DokuDragon:Clone()
    u60:PivotTo(p54 * CFrame.new(0, 0.75, 0))
    u60.Parent = workspace.Effects
    PlayAnim(u60, "Idle")
    _G.destroy(u60, 7)
    local u61 = Instance.new("NumberValue")
    u61.Value = p56
    u61.Parent = u60
    local u62 = u60:GetPrimaryPartCFrame()
    _G.PlaySound(p54, script.Sounds["HydraShoot" .. math.random(1, 2)])
    local u63 = script.Sounds.HydraLoop:Clone()
    u63.Parent = u60.PrimaryPart
    u63:Play()
    local v64 = script.SingleBurst:Clone()
    v64.CFrame = p55.PrimaryPart.CFrame * CFrame.new(0, 0, -3)
    v64.Parent = workspace.Effects
    _G.customEmit(v64)
    _G.destroy(v64, 3)
    local function u67() --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u60
            [3] = u63
            [4] = u11
        --]]
        if u58 ~= nil then
            local v65 = script.Explosion:Clone()
            v65.CFrame = u60:GetPrimaryPartCFrame() * CFrame.new(0, -1, -4)
            v65.Parent = workspace.Effects
            u63:Destroy()
            _G.PlaySound(u60.PrimaryPart.CFrame, script.Sounds["HydraBoom" .. math.random(1, 2)])
            u11(v65)
            _G.destroy(v65, 1.5)
            for _, v66 in u60:GetDescendants() do
                if v66:IsA("BasePart") then
                    _G.tween(v66, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                        ["Size"] = Vector3.new(),
                        ["Transparency"] = 1
                    })
                elseif v66:IsA("ParticleEmitter") then
                    v66.Enabled = false
                end
            end
            _G.destroy(u60, 1)
            u58:Disconnect()
            u58 = nil
        end
    end
    task.delay(5, u67)
    local u68 = 0
    local u69 = 0
    local u70 = u60.PrimaryPart.CFrame
    u58 = u2.Heartbeat:Connect(function(p71) --[[ Line: 207 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u61
            [3] = u62
            [4] = u53
            [5] = u69
            [6] = u4
            [7] = u68
            [8] = u70
            [9] = u59
            [10] = u67
        --]]
        u60.PrimaryPart.CFrame = u60:GetPrimaryPartCFrame() * CFrame.new(0, 0, -u61.Value * p71)
        local v72 = u60:GetPrimaryPartCFrame()
        local _ = (workspace.CurrentCamera.CFrame.Position - v72.Position).Magnitude
        if (u62.Position - v72.Position).Magnitude >= 3 and _G.checkRenderDistance(v72.Position, 500) then
            u53(u62, v72, false)
            u69 = tick()
            u62 = v72
        end
        if Random.new():NextInteger(0, 24) == 1 then
            u4.Droplet(u60:GetPrimaryPartCFrame())
        end
        if tick() - u68 > 0.125 then
            u68 = tick()
            local v73 = script.CurvedImage:Clone()
            v73.CFrame = v72 * CFrame.Angles(0, -1.5707963267948966, 0)
            v73.Parent = workspace.Effects
            v73.Mesh.Scale = Vector3.new(0, 0, 0)
            _G.tween(v73, { 0.4, "Linear", Enum.EasingDirection.Out }, {
                ["CFrame"] = v73.CFrame * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
            })
            _G.tween(v73.Mesh, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                ["Scale"] = Vector3.new(0.508, 0.295, 0.278)
            })
            _G.tween(v73.Decal, { 0.35, "Linear", Enum.EasingDirection.Out }, {
                ["Transparency"] = 1
            })
            _G.destroy(v73, 0.5)
        end
        local v74 = (u70.Position - v72.Position).Magnitude
        local v75 = CFrame.new(u70.Position, v72.Position)
        local v76 = workspace:Blockcast(v75, Vector3.new(2, 2, 2), v75.LookVector * v74, u59)
        if v76 and v76.Instance ~= nil then
            u67()
        else
            u70 = v72
        end
    end)
end
function TripleShoot(p77, u78, u79, p80, p81, u82, p83)
    --[[
    Upvalues:
        [1] = u11
        [2] = u2
        [3] = u53
    --]]
    local v84 = RaycastParams.new()
    v84.FilterDescendantsInstances = p83
    v84.FilterType = Enum.RaycastFilterType.Include
    for v85 = 1, 3 do
        local u86 = nil
        local u87
        if u79 then
            u87 = script.DokuDragonR:Clone()
        else
            u87 = script.DokuDragon:Clone()
        end
        u87:PivotTo(p77 * p81[v85])
        u87.Parent = workspace.Effects
        _G.destroy(u87, 7)
        PlayAnim(u87, "Idle")
        local u88 = u87:GetPrimaryPartCFrame()
        local u89 = 0
        if u79 == true then
            _G.PlaySound(p77, script.Sounds.VenomDemonDragonShoot, {
                ["Pitch"] = math.random(90, 110) / 100
            })
        else
            _G.PlaySound(p77, script.Sounds["HydraShoot" .. math.random(1, 2)])
        end
        local u90 = script.Sounds.HydraLoop:Clone()
        u90.Parent = u87.PrimaryPart
        u90:Play()
        local u91 = typeof(u78) == "Instance"
        if not u78 then
            u87:Destroy()
            return
        end
        local u92
        if u91 == true then
            u92 = u78.PrimaryPart.Position
        else
            u92 = u78.Position
        end
        if u79 == false then
            local v93 = script.TripleBurst:Clone()
            v93.CFrame = p80.PrimaryPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(45, 0, 0)
            v93.Parent = workspace.Effects
            _G.customEmit(v93)
            _G.destroy(v93, 3)
        end
        local function u96(_) --[[ Line: 306 ]]
            --[[
            Upvalues:
                [1] = u86
                [2] = u90
                [3] = u87
                [4] = u79
                [5] = u11
            --]]
            if u86 ~= nil then
                u86:Disconnect()
                u86 = nil
                u90:Destroy()
                for _, v94 in u87:GetDescendants() do
                    if v94:IsA("BasePart") then
                        _G.tween(v94, {
                            0.25,
                            "Cubic",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Size"] = Vector3.new(),
                            ["Transparency"] = 1
                        })
                    elseif v94:IsA("ParticleEmitter") then
                        v94.Enabled = false
                    end
                end
                local v95
                if u79 then
                    v95 = script.ExplosionR:Clone()
                else
                    v95 = script.Explosion:Clone()
                end
                v95.CFrame = u87:GetPrimaryPartCFrame() * CFrame.new(0, -1, -4)
                v95.Parent = workspace.Effects
                if u79 == true then
                    _G.PlaySound(u87.PrimaryPart.CFrame, script.Sounds.VenomDemonDragonBoom, {
                        ["Pitch"] = math.random(90, 110) / 100
                    })
                else
                    _G.PlaySound(u87:GetPrimaryPartCFrame(), script.Sounds["HydraBoom" .. math.random(1, 2)])
                end
                u11(v95)
                _G.destroy(v95, 1.5)
                _G.destroy(u87, 1)
            end
        end
        task.delay(5, u96)
        local u97 = 0
        local _ = u2.Heartbeat:Connect(function(p98) --[[ Line: 343 ]]
            --[[
            Upvalues:
                [1] = u91
                [2] = u78
                [3] = u92
                [4] = u87
                [5] = u82
                [6] = u89
                [7] = u88
                [8] = u53
                [9] = u79
                [10] = u97
                [11] = u96
            --]]
            local v99
            if u91 == true then
                if u78.Parent == nil or u78.PrimaryPart == nil then
                    v99 = u92
                else
                    v99 = u78.PrimaryPart.Position
                end
            else
                v99 = u78.Position
            end
            u92 = v99
            u87.PrimaryPart.CFrame = u87:GetPrimaryPartCFrame() * CFrame.new(0, 0, -u82 * p98)
            u87.PrimaryPart.CFrame = u87:GetPrimaryPartCFrame():Lerp(CFrame.new(u87.PrimaryPart.Position, v99), u89)
            local v100 = u89 + p98 / 5
            u89 = math.clamp(v100, 0, 1)
            local v101 = u87:GetPivot()
            if (u88.Position - v101.Position).Magnitude >= 3 and _G.checkRenderDistance(v101.Position, 500) then
                u53(u88, v101, u79)
                u97 = tick()
                u88 = v101
            end
            if (u87.PrimaryPart.Position - v99).Magnitude <= 10 then
                u96()
            end
        end)
        task.wait(0.16666666666666666)
    end
end
function v1.start(_, p102, p103, p104, p105, p106, p107, p108) --[[ Line: 378 ]]
    if p102 then
        if _G.checkRenderDistance(p104.Position) == false then
            return
        else
            tick()
            tick()
            local v109 = p102:GetAttribute("VenomDemonActive") == true
            if p105 then
                task.wait(0.4)
                TripleShoot(p104, p103, v109, p102, p106, p107, p108)
            else
                SingularShoot(p104, p102, p107, p108)
            end
        end
    else
        return
    end
end
return v1