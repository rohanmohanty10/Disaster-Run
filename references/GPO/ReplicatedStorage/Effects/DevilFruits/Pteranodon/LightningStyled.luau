 

local u1 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u2 = game:GetService("TweenService")
local u3 = require(script.Signal)
require(script.TableUtils)
local u4 = {}
u4.__index = u4
function u4.new(p5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    local v6 = u4
    local v7 = setmetatable(p5, v6)
    if v7.NodeConstructor then
        v7:NodeConstructor()
    end
    v7.Next = nil
    v7.RunService = nil
    local v8 = v7.Position
    v7.Position = Instance.new("Vector3Value")
    v7.Position.Value = v8
    v7.PartCreated = u3.new()
    v7.Destroyed = u3.new()
    v7:_main()
    return v7
end
function u4._createPart(p9) --[[ Line: 32 ]]
    local v10 = p9.Position.Value
    local v11 = p9.Next.Position.Value
    local v12 = Instance.new("Part")
    v12.Anchored = true
    v12.CanCollide = false
    v12.Size = Vector3.new(0, 0, 0)
    v12.CFrame = CFrame.new(v10, v11)
    v12.Transparency = 0
    v12.Color = p9.OutlineColour
    v12.Material = Enum.Material.Neon
    v12.CastShadow = false
    v12.Parent = p9.Model
    p9.Part = v12
    local v13 = p9.Parent
    v13:_addParts(v12)
    p9.PartCreated:Fire()
    if p9.Iteration == 0 and p9.Delay == 0 or p9.Delay > 0 and p9.Iteration + 1 == (v13.Points - 1) * v13.BezierPoints then
        v13.PartsLoaded:Fire(v13.Parts)
    end
    return p9.Part
end
function u4._main(u14) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local u15 = os.clock()
    local u16 = u14.Delay * u14.Iteration
    local u17 = u14.Duration + u16
    if u14.NodeUpdate then
        local u18 = 0.03333333333333333
        u14.RunService = u1.RenderStepped:Connect(function() --[[ Line: 109 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u18
                [3] = u17
                [4] = u14
                [5] = u16
                [6] = u2
            --]]
            local v19 = os.clock() - u15
            if v19 <= u18 then
                return
            else
                u18 = u18 + 0.03333333333333333
                if u17 <= v19 then
                    u14:Destroy()
                    return
                else
                    u14:NodeUpdate(0.03333333333333333, v19, u17)
                    if u14.Next then
                        local v20 = u14.Part
                        if v20 or u16 > v19 then
                            if v20 and v20.Parent then
                                local v21 = v19 - u16
                                local v22 = u14.Position.Value
                                local v23 = u14.Next.Position.Value
                                local v24 = v21 / u14.Delay
                                local v25 = math.min(v24, 1)
                                local v26 = u14.Width
                                local v27 = v21 / u14.Duration
                                local v28 = v26 * (1 - math.min(1, v27))
                                local v29 = u2
                                local v30 = TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear)
                                local v31 = {}
                                local v32 = (v22 - v23).Magnitude * v25
                                v31.Size = Vector3.new(v28, v28, v32)
                                v31.CFrame = CFrame.new(v22, v23) * CFrame.new(0, 0, -(v22 - v23).Magnitude / 2 * v25)
                                v29:Create(v20, v30, v31):Play()
                            end
                        else
                            u14:_createPart()
                        end
                    else
                        return
                    end
                end
            end
        end)
    else
        task.delay(u16, function() --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u2
            --]]
            if u14.Next then
                local v33 = u14:_createPart()
                local v34 = u14.Position.Value
                local v35 = u14.Next.Position.Value
                local v36 = u14.Width
                local v37 = u2
                local v38 = TweenInfo.new(u14.Delay)
                local v39 = {}
                local v40 = (v34 - v35).Magnitude
                v39.Size = Vector3.new(v36, v36, v40)
                v39.CFrame = CFrame.new(v34, v35) * CFrame.new(0, 0, -(v34 - v35).Magnitude / 2)
                v37:Create(v33, v38, v39):Play()
                task.wait(u14.Delay)
                local v41 = u2
                local v42 = TweenInfo.new(u14.Duration)
                local v43 = {}
                local v44 = (v34 - v35).Magnitude
                v43.Size = Vector3.new(0, 0, v44)
                v41:Create(v33, v42, v43):Play()
                task.wait(u14.Duration)
                u14:Destroy()
            end
        end)
    end
end
function u4.Destroy(p45) --[[ Line: 150 ]]
    p45.Destroyed:Fire()
    if p45.RunService then
        p45.RunService:Disconnect()
        p45.RunService = nil
    end
    p45.Position:Destroy()
    if p45.Part then
        p45.Part:Destroy()
    end
    setmetatable(p45, nil)
end
local u46 = {}
u46.__index = u46
function u46.new(p47) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u46
        [2] = u3
    --]]
    local v48 = u46
    local u49 = setmetatable(p47, v48)
    u49.Points = u49.Points or 10
    u49.Delay = u49.Delay or 0
    u49.Seed = math.random(1000)
    u49.BezierPoints = u49.BezierPoints or 3
    u49.Model = Instance.new("Model")
    local v50 = Instance.new("Highlight")
    v50.OutlineTransparency = 1
    v50.FillTransparency = 0
    v50.FillColor = u49.Colour
    v50.DepthMode = Enum.HighlightDepthMode.Occluded
    v50.Parent = u49.Model
    task.spawn(function() --[[ Line: 187 ]]
        --[[
        Upvalues:
            [1] = u49
        --]]
        local u51 = (u49.Points - 1) * u49.BezierPoints
        local u52 = 0
        local u53 = false
        u49.Model.ChildRemoved:Connect(function() --[[ Line: 192 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u51
                [3] = u49
                [4] = u53
            --]]
            u52 = u52 + 1
            if u52 == u51 then
                u49:Destroy()
                u53 = true
            end
        end)
        task.wait(2)
        if not u53 and #u49.Model:GetChildren() == 1 then
            u49:Destroy()
        end
    end)
    u49.Model.Parent = workspace.Effects
    u49.Parts = {}
    u49.PartsLoaded = u3.new()
    u49.Sparks = not u49.Sparks and true
    u49.List = u49:_createList()
    return u49
end
function u46._addParts(p54, p55) --[[ Line: 218 ]]
    local v56 = p54.Parts
    table.insert(v56, p55)
end
function u46.GetParts(p57) --[[ Line: 222 ]]
    return p57.Parts
end
function u46._generateOffset(p58) --[[ Line: 226 ]]
    return Random.new():NextNumber(p58.Offset.Min, p58.Offset.Max)
end
function u46._createNode(p59, p60, p61) --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v62 = CFrame.new(p59.Start):ToObjectSpace(CFrame.new(p60))
    local v63 = (math.noise(v62.X, v62.Y, p59.Seed) * p59.Width + p59.Width) * (p59.CanShrink and (1 - p61 / ((p59.Points - 1) * p59.BezierPoints) or 1) or 1)
    return u4.new({
        ["Colour"] = p59.Colour,
        ["OutlineColour"] = p59.OutlineColour,
        ["Position"] = p60,
        ["Duration"] = p59.Duration,
        ["Delay"] = p59.Delay,
        ["Iteration"] = p61,
        ["Width"] = v63,
        ["NodeConstructor"] = p59.NodeConstructor,
        ["NodeUpdate"] = p59.NodeUpdate,
        ["Parent"] = p59,
        ["Model"] = p59.Model
    })
end
function u46._lerp(_, p64, p65, p66) --[[ Line: 250 ]]
    return p64 + (p65 - p64) * p66
end
function u46._createList(u67) --[[ Line: 254 ]]
    --[[
    Upvalues:
        [1] = u46
    --]]
    local v68 = u67:_createNode(u67.Start, 0)
    local v69 = v68
    local u70 = {}
    for v71 = 1, u67.Points do
        local v72 = CFrame.new(u67.Start, u67.End) * CFrame.new(u67:_generateOffset(), u67:_generateOffset(), -v71 / u67.Points * (u67.Start - u67.End).Magnitude).Position
        table.insert(u70, v72)
    end
    local v73 = (#u70 - 1) * u67.BezierPoints
    for u74 = 1, #u70 - 1 do
        for v75 = 1, u67.BezierPoints do
            local v76 = (u74 - 1) * u67.BezierPoints + v75
            local v77 = u67:_lerp(u70[u74], u70[u74 + 1], v75 / u67.BezierPoints)
            if v76 == v73 or not v77 then
                v77 = u67.End
            end
            local u78 = u67:_createNode(v77, v76)
            if u67.Sparks and math.random(5) == 1 then
                local u79 = nil
                u79 = u78.PartCreated:Connect(function() --[[ Line: 288 ]]
                    --[[
                    Upvalues:
                        [1] = u70
                        [2] = u74
                        [3] = u46
                        [4] = u78
                        [5] = u67
                        [6] = u79
                    --]]
                    local v80 = u70[u74 + 1] - u70[u74]
                    local _ = v80.Unit
                    local v81 = u46.new
                    local v82 = {
                        ["Sparks"] = false,
                        ["Start"] = u78.Position.Value,
                        ["End"] = u78.Position.Value + v80 * 2 + Random.new():NextUnitVector() * 0.5,
                        ["Offset"] = NumberRange.new(u67.Offset.Min * 0.5, u67.Offset.Max * 0.5),
                        ["Width"] = u78.Width
                    }
                    local v83 = u67.Points * 0.25
                    v82.Points = math.ceil(v83)
                    v82.Duration = u67.Duration * Random.new():NextNumber(0.25, 0.5)
                    v82.Delay = u67.Delay
                    v82.CanShrink = true
                    v82.Colour = u67.Colour
                    v82.OutlineColour = u67.OutlineColour
                    v82.NodeConstructor = u67.NodeConstructor
                    v82.NodeUpdate = u67.NodeUpdate
                    v81(v82)
                    u79:Disconnect()
                    u79 = nil
                end)
            end
            v68.Next = u78
            v68 = u78
        end
    end
    return v69
end
function u46.Destroy(p84) --[[ Line: 325 ]]
    p84.Model:Destroy()
    setmetatable(p84, nil)
end
return function(p85) --[[ Line: 330 ]]
    --[[
    Upvalues:
        [1] = u46
    --]]
    return u46.new(p85)
end