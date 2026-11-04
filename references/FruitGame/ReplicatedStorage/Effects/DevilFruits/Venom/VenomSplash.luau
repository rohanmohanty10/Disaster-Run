 

local v1 = {}
game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u2 = script.Parent.Puddles.Purple
local u3 = script.Parent.Puddles.Red
local u4 = {}
local u5 = Random.new()
local function u11(p6) --[[ Line: 12 ]]
    local v7 = UserSettings().GameSettings.SavedQualityLevel.Value
    local v8 = math.clamp(v7, 1, 10)
    for _, v9 in p6:GetDescendants() do
        if v9:IsA("ParticleEmitter") then
            local v10 = v9:GetAttribute("EmitCount") * (v8 / 10)
            v9:Emit((math.clamp(v10, 1, v9:GetAttribute("EmitCount"))))
        end
    end
end
local function u16(p12, p13, _) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v14 = u3:GetChildren()
    local u15 = v14[math.random(1, #v14)]:Clone()
    u15.CFrame = CFrame.new(p12, p13 + p12) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
    u15.Parent = workspace.Effects
    u15.Size = Vector3.new(0, 0, 0)
    _G.tween(u15, { 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out }, {
        ["Size"] = Vector3.new(16, 2.4, 16),
        ["CFrame"] = CFrame.new(p12, p13 + p12) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0)
    })
    task.delay(2, function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        _G.destroy(u15, 1)
        _G.tween(u15, { 0.95, "Cubic", Enum.EasingDirection.Out }, {
            ["Size"] = Vector3.new(),
            ["Transparency"] = 1
        })
    end)
end
local function u30(p17, p18, p19, p20) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u11
    --]]
    local v21 = u2:GetChildren()
    local u22 = v21[math.random(1, #v21)]:Clone()
    u22:PivotTo(CFrame.new(p17, p18 + p17) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0))
    _G.scaleParticle(u22, p19)
    u22.Parent = workspace.Effects
    for _, v23 in u22:GetChildren() do
        local v24 = v23:FindFirstChildOfClass("MeshPart")
        local v25 = v24.Size * 2.5
        v24.Size = Vector3.new()
        if v23.Name == "Out" then
            v25 = v25 * 1.02
        end
        local v26 = v25 * p19
        if p20 then
            v24.Color = ({
                ["In"] = Color3.fromRGB(106, 9, 50),
                ["Out"] = Color3.fromRGB(106, 9, 50)
            })[v23.Name]
        end
        v24.Transparency = v23.Name == "Out" and 0.45 or 0
        if p20 == true and v23.Name == "Out" then
            v24.Transparency = 0.65
        end
        if p20 == false then
            if v23.Name == "Out" then
                v24.Material = Enum.Material.Glacier
            else
                v24.Material = Enum.Material.Neon
            end
        end
        _G.tween(v24, { 0.25, "Back", Enum.EasingDirection.Out }, {
            ["Size"] = v26
        })
    end
    local v27 = script.SplashPuddle:Clone()
    v27.CFrame = CFrame.new(p17, p18 + p17) * CFrame.Angles(-1.5707963267948966, 0, 0)
    if p20 then
        v27.Attachment.Drops.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    end
    _G.scaleParticle(v27.Attachment, 0.5 + p19)
    v27.Parent = workspace.Effects
    u11(v27)
    _G.destroy(v27, 2)
    _G.PlaySound(CFrame.new(p17), script["VenomDrip" .. math.random(1, 2)])
    task.delay(2, function() --[[ Line: 87 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        _G.destroy(u22, 1)
        for _, v28 in u22:GetChildren() do
            local v29 = v28:FindFirstChildOfClass("MeshPart")
            _G.tween(v29, { 0.95, "Cubic", Enum.EasingDirection.Out }, {
                ["Size"] = Vector3.new(),
                ["Transparency"] = 1
            })
        end
    end)
end
function Quad(p31, p32, p33, p34)
    return (1 - p34) * (1 - p34) * p31 + 2 * (1 - p34) * p34 * p32 + p34 * p34 * p33
end
function v1.Default(p35, p36, p37, p38) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u4
    --]]
    if _G.checkRenderDistance(p35) ~= false then
        local v39 = Random.new()
        local _ = p38 == nil
        for _ = 1, v39:NextInteger(5, 9) do
            local v40 = RaycastParams.new()
            local v41 = { workspace.Islands, workspace.Env, workspace.Ships }
            local v42 = Enum.RaycastFilterType.Whitelist
            v40.FilterDescendantsInstances = v41
            v40.FilterType = v42
            local v43 = p35 + Vector3.new(0, 1, 0) + v39:NextUnitVector() * (Vector3.new(1, 0, 1) * v39:NextNumber(12, 32))
            workspace:Raycast(v43, Vector3.new(0, -1000, 0), v40)
            local v44, v45, v46 = _G.getRayFloor(CFrame.new(v43), 100)
            if not v44 then
                v45 = v43
            end
            local v47
            if p36 then
                v47 = script.DropR:Clone()
            else
                v47 = script.Drop:Clone()
            end
            v47.CFrame = CFrame.new(p35)
            v47.Parent = workspace.Effects
            local v48 = (p35 - v45).Magnitude / 60
            task.delay(v48, u30, v45, v46 or Vector3.new(0, 1, 0), p37 or v39:NextNumber(1.1, 1.6), p36)
            u4[v47] = {
                p35,
                v45,
                0,
                v48,
                false
            }
        end
    end
end
function v1.Red(p49, p50) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u4
    --]]
    if _G.checkRenderDistance(p49) ~= false then
        local v51 = Random.new()
        for _ = 1, v51:NextInteger(5, 9) do
            local v52 = RaycastParams.new()
            local v53 = { workspace.Islands, workspace.Env, workspace.Ships }
            local v54 = Enum.RaycastFilterType.Whitelist
            v52.FilterDescendantsInstances = v53
            v52.FilterType = v54
            local v55 = p49 + v51:NextUnitVector() * Vector3.new(1, 0, 1) * v51:NextNumber(12, 32)
            local v56 = workspace:Raycast(v55, Vector3.new(0, -1000, 0), v52)
            if v56 then
                v55 = v56.Position
            end
            local v57 = script.DropR:Clone()
            v57.Parent = workspace.Effects
            v57.Position = p49
            local v58 = (p49 - v55).Magnitude / 60
            task.delay(v58, u16, v55, (v56 or {
                ["Normal"] = Vector3.new(0, 1, 0)
            }).Normal, p50 or v51:NextNumber(1.1, 1.6), IsVenom)
            u4[v57] = {
                p49,
                v55,
                0,
                v58,
                false
            }
        end
    end
end
function v1.Droplet(p59, p60) --[[ Line: 165 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u4
    --]]
    if _G.checkRenderDistance(p59.Position) ~= false then
        local v61
        if type(p59) == "vector" then
            v61 = p59
        else
            v61 = p59.Position
        end
        Random.new()
        local v62
        if p60 then
            v62 = script.DropR:Clone()
        else
            v62 = script.Drop:Clone()
        end
        v62.Position = v61
        v62.Parent = workspace.Effects
        local v63 = RaycastParams.new()
        local v64 = { workspace.Islands, workspace.Env, workspace.Ships }
        local v65 = Enum.RaycastFilterType.Whitelist
        v63.FilterDescendantsInstances = v64
        v63.FilterType = v65
        local v66 = workspace:Raycast(v61, Vector3.new(0, -1000, 0), v63)
        local v67
        if v66 then
            v67 = v66.Position
        else
            v67 = v61
        end
        local v68 = (p59.Position - v67).Magnitude / 60
        local v69 = task.delay
        local v70 = u30
        if not v66 then
            v66 = {
                ["Normal"] = Vector3.new(0, 1, 0)
            }
        end
        v69(v68, v70, v67, v66.Normal, 0.25)
        u4[v62] = {
            v61,
            v67,
            0,
            v68,
            true
        }
    end
end
function v1.RedDroplet(_, p71, p72) --[[ Line: 197 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u4
    --]]
    if type(p71) ~= "vector" then
        p71 = p71.Position
    end
    local v73 = script.BigDrop:Clone()
    v73.Parent = workspace.Effects
    v73.Position = p71
    local v74 = RaycastParams.new()
    local v75 = { workspace.Islands, workspace.Env, workspace.Ships }
    local v76 = Enum.RaycastFilterType.Whitelist
    v74.FilterDescendantsInstances = v75
    v74.FilterType = v76
    local v77 = workspace:Raycast(p71, Vector3.new(0, -1000, 0), v74)
    local v78
    if v77 then
        v78 = v77.Position
    else
        v78 = p71
    end
    local v79 = (p71 - v78).Magnitude / 60
    local v80 = task.delay
    local v81 = u16
    if not v77 then
        v77 = {
            ["Normal"] = Vector3.new(0, 1, 0)
        }
    end
    v80(v79, v81, v78, v77.Normal, p72 or 0.65)
    u4[v73] = {
        p71,
        v78,
        0,
        v79,
        true
    }
end
function v1.start(_, p82, p83, p84, p85, p86, p87, p88, _) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u5
        [3] = u4
    --]]
    if _G.checkRenderDistance(p83) then
        local v89
        if p85 then
            v89 = script.DropR:Clone()
        else
            v89 = script.Drop:Clone()
        end
        v89.CFrame = CFrame.new(p82)
        v89.Parent = workspace.Effects
        local v90 = p88 or (p82 - p83).Magnitude / 60
        task.delay(v90, u30, p83, p84 or Vector3.new(0, 1, 0), p86 or u5:NextNumber(1.1, 1.6), p85)
        u4[v89] = {
            p82,
            p83,
            0,
            v90,
            p87 == true
        }
    end
end
game["Run Service"].Stepped:Connect(function(_, p91) --[[ Line: 237 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v92 = {}
    local v93 = {}
    for v94, v95 in u4 do
        local v96, v97, v98, v99, v100 = unpack(v95)
        if v94 then
            if v98 > 1 then
                _G.destroy(v94, 0.25)
                v94.Transparency = 1
                u4[v94] = nil
            else
                local v101 = v98 + p91 / v99
                u4[v94][3] = v101
                table.insert(v92, v94)
                if v100 == false then
                    local v102 = (CFrame.new(v96, v97) * CFrame.new(0, (v96 - v97).Magnitude, -(v96 - v97).Magnitude / 2)).Position
                    local v103 = CFrame.new
                    local v104 = Quad(v96, v102, v97, v101)
                    local v105 = Quad
                    local v106 = v101 + 0.001
                    table.insert(v93, v103(v104, v105(v96, v102, v97, v106)))
                else
                    local v107 = CFrame.new
                    local v108 = v96 + (v97 - v96) * v101
                    local v109 = v96 + (v97 - v96) * (v101 + 0.01)
                    table.insert(v93, v107(v108, v109))
                end
            end
        else
            u4[v94] = nil
        end
    end
    if #v92 > 0 then
        workspace:BulkMoveTo(v92, v93, Enum.BulkMoveMode.FireCFrameChanged)
    end
end)
return v1