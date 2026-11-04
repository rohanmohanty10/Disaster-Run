
local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
local u3 = require(game.ReplicatedStorage.Modules.sBeat)
local function u7(p4, p5) --[[ Line: 8 ]]
    local v6 = Instance.new("Attachment")
    v6.Parent = workspace.Terrain
    _G.destroy(v6, 5)
    if p5 then
        v6.Parent = p5
    elseif typeof(p4) == "CFrame" then
        v6.WorldCFrame = p4
    end
    if typeof(p4) == "Vector3" then
        v6.Position = p4
    end
    return v6
end
function v1.start(_, p8, p9, _, _) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u7
        [3] = u2
    --]]
    if _G.checkRenderDistance(p8.HumanoidRootPart.Position) == false then
        return
    else
        local u10 = p8:WaitForChild("RightHand", 4)
        local u11 = u10:FindFirstChild("Tornado1") or script.Tornado.Tornado1:Clone()
        local u12 = u10:FindFirstChild("SandOrb") or script.Tornado.SandOrb:Clone()
        local u13 = p8.RightLowerArm:FindFirstChild("sandTrail1") or Instance.new("Attachment")
        local v14 = p8.RightLowerArm:FindFirstChild("sandTrail2") or Instance.new("Attachment")
        v14.Name = "sandTrail2"
        v14.Parent = p8.RightLowerArm
        u13.Name = "sandTrail1"
        u13.Parent = p8.RightLowerArm
        u13.Position = Vector3.new(0, -1.7, 0)
        v14.Position = Vector3.new(0, -1.175, 0)
        u11.Parent = p8:FindFirstChild("RightHand")
        u12.Parent = u10
        local function u23(p15, p16) --[[ Line: 41 ]]
            local v17 = p16 or 1
            for _, v18 in p15:GetChildren() do
                if v18:IsA("ParticleEmitter") then
                    local v19 = {}
                    for _, v20 in v18.Size.Keypoints do
                        local v21 = v20.Value * v17
                        local v22 = NumberSequenceKeypoint.new(v20.Time, v21)
                        table.insert(v19, v22)
                    end
                    v18.Drag = v18.Drag / v17
                    v18.Size = NumberSequence.new(v19)
                    v18.Speed = NumberRange.new(v18.Speed.Min * v17, v18.Speed.Max * v17)
                end
            end
        end
        if p9 == "Part1" then
            u11.Parent = p8:FindFirstChild("RightHand")
            u12.Parent = u10
            local v24 = script.Tornado.Trail:Clone()
            v24.Parent = u13
            v24.Attachment0 = u13
            v24.Attachment1 = v14
            coroutine.wrap(function()
                
                u23(u11, 1.5)
                task.wait(0.3)
                for v25 = 1, 10 do
                    u23(u11, 1 - v25 / 40)
                    u3()
                end
                for _, v26 in u11:GetChildren() do
                    v26.Enabled = false
                end
                local v27 = script.Tornado.Emits:Clone()
                _G.destroy(v27, 4)
                v27.Parent = u10
                _G.customEmit(v27)
                coroutine.wrap(function()
                   
                    task.wait(0.5)
                    u13.Trail.Enabled = true
                    local v28 = 0
                    while u11 and u11.Name ~= "Used1" do
                        local _ = math.random(100, 200) / 100
                        local v29 = u12.WorldCFrame
                        local v30 = u7(v29, u12.Parent)
                        v30.Position = u12.Position
                        local v31 = CFrame.Angles
                        local v32 = math.random(-360, 360)
                        local v33 = math.rad(v32)
                        local v34 = math.random(-360, 360)
                        local v35 = v29 * v31(3.141592653589793, v33, (math.rad(v34)))
                        local v36 = v35 * CFrame.new(0, math.random(500, 1000) / 100, 0)
                        local v37 = Instance.new("Attachment")
                        v37.Parent = workspace.Terrain
                        _G.destroy(v37, 5)
                        if typeof(v36) == "CFrame" then
                            v37.WorldCFrame = v36
                        end
                        if typeof(v36) == "Vector3" then
                            v37.Position = v36
                        end
                        local _ = math.random(250, 750) / 1000
						v37.WorldCFrame = v35 * CFrame.new(0, math.random(100, 300) / 100, 0)
						
						
						
                        local v38 = u2.new(v30, v37, 10)
                        v38.CurveSize0 = 0
                        v38.CurveSize1 = 0
                        v38.PulseSpeed = math.random(5, 25)
                        v38.AnimationSpeed = math.random(15, 20)
                        v38.PulseLength = math.random(1, 3)
                        v38.FadeLength = 0.1
                        v38.Thickness = math.random(25, 200) / 1000
                        v38.Color = Color3.fromRGB(148, 121, 255)
                        v38.Frequency = 0.6
                        v38.MinThicknessMultiplier = 0.1
                        v38.MaxThicknessMultiplier = 1
                        v38.MinRadius = 0
                        v38.MaxRadius = 1
                        v38.ContractFrom = 0.5
                        if tick() - v28 >= 0.25 then
                            _G.PlayEffect("Spheres", nil, {
                                ["cf"] = v29,
                                ["ti"] = 0.1,
                                ["ti2"] = 0.1,
                                ["range"] = 2,
                                ["minThick"] = 1,
                                ["maxThick"] = 2,
                                ["part"] = nil,
                                ["color"] = Color3.fromRGB(148, 121, 255),
                                ["am"] = 10
                            })
                            v28 = tick()
                        end
                        if u11:IsDescendantOf(game) == false or u11.Parent == nil then
                            break
                        end
                        u3()
                    end
                end)()
                for _, v39 in u12:GetChildren() do
                    v39.Enabled = true
                end
            end)()
        elseif p9 == "Part2" then
            u11.Name = "Used1"
            local v40 = u11.WorldCFrame
            u11.Parent = workspace.Terrain
            u11.WorldCFrame = v40
            u12.Name = "Used2"
            u13.Name = "Used3"
            v14.Name = "Used4"
            _G.destroy(u11, 4)
            _G.destroy(u12, 0.3)
            u13.Trail.Enabled = false
            _G.destroy(u13, 3)
            _G.destroy(v14, 3)
        end
    end
end
return v1