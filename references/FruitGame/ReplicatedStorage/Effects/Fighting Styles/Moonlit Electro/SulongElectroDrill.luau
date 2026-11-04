 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(v1.Modules.CraterHandler)
require(v1.Modules.LightningBolt)
local u3 = v2.LocalPlayer
local u4 = workspace.Effects
local u5 = {}
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 35 ]]
    local function v20(u15, p16, p17) --[[ Line: 36 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local u23 = RaycastParams.new()
u23.FilterType = Enum.RaycastFilterType.Include
u23.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p24, p25, p26, p27, u28, p29) --[[ Name: start, Line 71 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u22
            [4] = u23
            [5] = u3
        --]]
        if _G.checkRenderDistance(p25.PrimaryPart.Position) == false then
            return
        elseif p24 == "Start" then
            local v30 = Random.new()
            u5[p25] = {}
            local u31 = p25.HumanoidRootPart
            u31.CFrame = u28
            local v32 = script.Startup:Clone()
            v32.CFrame = u31.CFrame
            v32.Parent = u4
            _G.customEmit(v32)
            _G.destroy(v32, 0.45)
            for _ = 1, 5 do
                _G.PlayEffect("DeadLightning", nil, {
                    ["StartPosition"] = u31.Position,
                    ["EndPosition"] = u31.Position + v30:NextUnitVector() * v30:NextNumber(15, 35),
                    ["Points"] = 3,
                    ["Size"] = math.random(100, 200) / 100,
                    ["Branches"] = true,
                    ["NoHighlight"] = true,
                    ["RandomSize"] = NumberRange.new(0.15, 1),
                    ["Offset"] = NumberRange.new(-35, 35),
                    ["MainColor"] = Color3.fromRGB(230, 255, 255),
                    ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                    ["LightningDuration"] = 0.1,
                    ["WaitFunction"] = function(p33, _) --[[ Name: WaitFunction, Line 107 ]]
                        if p33 % 2 == 0 then
                            task.wait()
                        end
                    end
                })
            end
            local v34 = Instance.new("Highlight")
            v34.FillColor = Color3.fromRGB(235, 249, 255)
            v34.FillTransparency = 1
            v34.OutlineTransparency = 1
            v34.Parent = p25
            _G.tween(v34, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                ["FillTransparency"] = 0
            })
            task.wait(0.3)
            local v35 = script.BodyVFX:Clone()
            v35:PivotTo(CFrame.new(p26.Position, p27.Position) * CFrame.Angles(1.5707963267948966, 0, 0))
            v35.Parent = u4
            u22(v35.BodyVFX, true)
            local v36 = Instance.new("WeldConstraint")
            v36.Part0 = v35.BodyVFX
            v36.Part1 = u31
            v36.Part1.CFrame = u31.CFrame
            v36.Parent = v35.BodyVFX
            _G.customEmit(v35.Emit)
            _G.PlayEffect("AfterImage", nil, {
                ["Character"] = p25,
                ["Duration"] = p29,
                ["MaxClones"] = 50,
                ["Interval"] = p29 / 50,
                ["Material"] = Enum.Material.Neon,
                ["Transparency"] = -5,
                ["Colour"] = Color3.new(0, 0, 0),
                ["Fade"] = true
            })
            _G.tween(u31, {
                p29,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = p27
            })
            _G.PlaySound(p25.PrimaryPart, script.SLSlamBlast).Parent = p25.PrimaryPart
            local u37 = tick()
            local u38 = nil
            u38 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 150 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u31
                    [3] = u38
                --]]
                if tick() - u37 <= 0.2 then
                    local v39 = u31.CFrame * CFrame.new(0, -10, 0)
                    local v40 = {
                        ["WorldPosition"] = (v39 * CFrame.new(math.random(-25, 25), math.random(20, 100), math.random(-25, 25))).Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = v39.Position,
                        ["EndPosition"] = v40.WorldPosition,
                        ["Points"] = 3,
                        ["Size"] = 1,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-2, 2),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = 0.1,
                        ["WaitFunction"] = function(p41, _) --[[ Name: WaitFunction, Line 170 ]]
                            if p41 % 2 == 0 then
                                task.wait()
                            end
                        end
                    })
                else
                    u38:Disconnect()
                    u38 = nil
                end
            end)
            task.wait(p29)
            u22(v35, false)
            _G.destroy(v35, 0.58)
            local v42 = workspace:Raycast(p27.Position, p27.UpVector * -15, u23)
            if v42 then
                local v43 = script["Lightning Floor"]:Clone()
                v43.CFrame = CFrame.new(v42.Position, v42.Position + v42.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                v43.Parent = u4
                _G.customEmit(v43)
                _G.destroy(v43, 4)
                _G.customEmit(v43)
                _G.destroy(v43, 6)
            end
            local u44 = script.Explosion:Clone()
            u44.CFrame = CFrame.new(p27.Position)
            if v42 then
                _G.PlaySound(u44.CFrame, script.Hit)
                u44.Impact["Dust 2"].Color = ColorSequence.new(v42.Instance.Color)
                u44.CFrame = CFrame.new(v42.Position, v42.Position + v42.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
            else
                u44.Impact["Dust 2"]:Destroy()
                u44.PointLight.Brightness = 5
            end
            u44.Parent = u4
            _G.tween(u44.PointLight, {
                0.4,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 60,
                ["Brightness"] = 0
            })
            _G.customEmit(u44)
            _G.destroy(u44, 3)
            _G.tween(v34, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                ["FillTransparency"] = 1
            })
            _G.destroy(v34, 0.25)
            if u3.Character == p25 then
                _G.camShake:ShakeOnce(7, 22, 0.2, 0.6)
            end
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 25,
                ["Position"] = p27.Position,
                ["DistanceRandomness"] = Vector2.new(0.1, 1),
                ["Duration"] = 2,
                ["TweenDuration"] = 2,
                ["Radius"] = 40,
                ["Direction"] = p27.UpVector * -15
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 10,
                ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                ["Position"] = p27.Position,
                ["Direction"] = p27.UpVector * 35 + Vector3.new(0, 15, 0),
                ["RaycastDirection"] = p27.UpVector * -15,
                ["Size"] = Vector3.new(1, 1, 1),
                ["TrailEnabled"] = true
            }, true)
            Color3.fromRGB(142, 161, 255)
            local v45 = CFrame.new(u44.Position)
            local _ = {
                ["WorldPosition"] = v45.Position,
                ["WorldAxis"] = Vector3.new(0, 1, 0)
            }
            task.spawn(function() --[[ Line: 264 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u28
                --]]
                for _ = 1, 5 do
                    local v46 = CFrame.new(u44.Position, u28.Position)
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = v46.Position,
                        ["EndPosition"] = (v46 * CFrame.new(math.random(-25, 25), math.random(-25, 25), -math.random(55, 125))).Position,
                        ["Points"] = 5,
                        ["Size"] = 1,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-2, 2),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = math.random(250, 400) / 1000,
                        ["WaitFunction"] = function(p47, _) --[[ Name: WaitFunction, Line 283 ]]
                            if p47 % 2 == 0 then
                                task.wait(0.05)
                            end
                        end
                    })
                    task.wait()
                end
            end)
            for _ = 1, 5 do
                _G.PlayEffect("DeadLightning", nil, {
                    ["StartPosition"] = v45.Position,
                    ["EndPosition"] = v45.Position + v30:NextUnitVector() * v30:NextNumber(35, 55),
                    ["Points"] = 10,
                    ["Size"] = math.random(100, 200) / 100,
                    ["Branches"] = true,
                    ["NoHighlight"] = true,
                    ["RandomSize"] = NumberRange.new(0.15, 1),
                    ["Offset"] = NumberRange.new(-50, 50),
                    ["MainColor"] = Color3.fromRGB(230, 255, 255),
                    ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                    ["LightningDuration"] = math.random(100, 200) / 1000,
                    ["WaitFunction"] = function(p48, _) --[[ Name: WaitFunction, Line 309 ]]
                        if p48 % 2 == 0 then
                            task.wait(math.random(100, 300) / 10000)
                        end
                    end
                })
                task.wait(0.025)
            end
        elseif p24 == "Jump" then
            local v49 = p25.HumanoidRootPart
            local v50, v51, _ = _G.getRayFloor(p25.PrimaryPart.CFrame, 15)
            if v50 then
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 10,
                    ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
                    ["Position"] = v51 + Vector3.new(0, 3, 0),
                    ["Direction"] = v49.CFrame.UpVector * 130,
                    ["RaycastDirection"] = Vector3.new(0, -10, 0),
                    ["Size"] = Vector3.new(0.5, 0.5, 0.5),
                    ["TrailEnabled"] = true
                }, true)
            end
            local v52 = script.Jump:Clone()
            v52.CFrame = v49.CFrame
            if v50 == nil then
                v52.Dust:Destroy()
            else
                v52.Dust["Dust 2"].Color = ColorSequence.new(v50.Color)
                v52.Dust.Rock.Color = ColorSequence.new(v50.Color)
            end
            v52.Parent = u4
            _G.customEmit(v52)
            _G.destroy(v52, 3)
            _G.PlaySound(p25.PrimaryPart, script.SLSlamStart)
        end
    end
}