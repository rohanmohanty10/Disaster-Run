 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.BezierFormula)
local _ = v2.LocalPlayer
local u4 = workspace.Effects
local u5 = {}
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 22 ]]
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
local function u22(p12, p13, p14) --[[ Line: 36 ]]
    local function v20(u15, p16, p17) --[[ Line: 37 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 45 ]]
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
local v23 = RaycastParams.new()
v23.FilterType = Enum.RaycastFilterType.Include
v23.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
local v24 = -workspace.Gravity
local u25 = Vector3.new(0, v24, 0)
return {
    ["start"] = function(_, p26, u27, u28) --[[ Name: start, Line 95 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u22
            [4] = u3
            [5] = u25
        --]]
        local v29 = string.format("%s Meteor_Fist_Effects", u27.Name .. u28.ID)
        if p26 == "Create_Folder" then
            local v30 = u27:FindFirstChild("HumanoidRootPart")
            u27:FindFirstChild("RightHand")
            u27:FindFirstChild("LeftHand")
            local v31 = Instance.new("Folder")
            v31.Name = v29
            v31.Parent = u4
            v31:SetAttribute("Active", true)
            u5[u27] = {}
            local function v33() --[[ Line: 110 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u27
                --]]
                for _, v32 in u5[u27] do
                    v32:Disconnect()
                end
            end
            local v34 = u5[u27]
            local v35 = v31.AttributeChanged
            table.insert(v34, v35:Connect(v33))
            local v36 = u5[u27]
            local v37 = v31.Destroying
            table.insert(v36, v37:Connect(v33))
            if u28.HakiColor ~= nil then
                local v38 = script.HakiBody:Clone()
                v38.CFrame = v30.CFrame
                _G.recolorParticles(v38, u28.HakiColor)
                v38.Parent = v31
                u22(v38, true)
                local v39 = Instance.new("WeldConstraint")
                v39.Part0 = v38
                v39.Part1 = v30
                v39.Parent = v38
                return
            end
        else
            if p26 == "Spawn_Ball" then
                local v40 = u28.Hand
                local v41 = u4:FindFirstChild(v29)
                local v42 = script["Cannon Ball"]:Clone()
                v42:PivotTo(v40.CFrame * CFrame.new(0, -1, 0))
                v42.Name = v42.Name .. v40.Name
                v42.Parent = v41
                u22(v42, true)
                local v43 = v42.PrimaryPart
                local v44 = Instance.new("WeldConstraint")
                v44.Part0 = v43
                v44.Part1 = v40
                v44.Parent = v43
                for _, v45 in v42:GetDescendants() do
                    if v45:IsA("Beam") then
                        v45.Enabled = true
                        local v46 = v45.Width0
                        local v47 = v45.Width1
                        v45.Width0 = 0
                        v45.Width1 = 0
                        u3:Create(v45, TweenInfo.new(0.5), {
                            ["Width0"] = v46,
                            ["Width1"] = v47
                        }):Play()
                    end
                end
                return
            end
            if p26 == "Haki_Spawn_Ball" then
                local v48 = u28.Hand
                local _ = u28.Start
                local v49 = u4:FindFirstChild(v29)
                local v50 = script.Haki_Cannon_Ball:Clone()
                v50:PivotTo(v48.CFrame * CFrame.new(0, -1, 0))
                _G.recolorParticles(v50, u28.HakiColor)
                v50.Name = v50.Name .. v48.Name
                v50.Parent = v49
                u22(v50, true)
                local v51 = v50.PrimaryPart
                local v52 = Instance.new("WeldConstraint")
                v52.Part0 = v51
                v52.Part1 = v48
                v52.Parent = v51
                for _, v53 in v50:GetDescendants() do
                    if v53:IsA("Beam") then
                        v53.Enabled = true
                        local v54 = v53.Width0
                        local v55 = v53.Width1
                        v53.Width0 = 0
                        v53.Width1 = 0
                        u3:Create(v53, TweenInfo.new(0.5), {
                            ["Width0"] = v54,
                            ["Width1"] = v55
                        }):Play()
                    end
                end
                return
            end
            if p26 == "Ball_Shoot" then
                local v56 = u28.Hand
                local _ = u28.Start
                local _ = u28.Goal
                local v57 = u28.HakiColor
                local v58 = u4:FindFirstChild(v29)
                if v58 == nil then
                    return
                end
                local u59 = v58:FindFirstChild("Cannon Ball" .. v56.Name) or v58:FindFirstChild("Haki_Cannon_Ball" .. v56.Name)
                if u59 == nil then
                    return
                end
                u59.Name = "_"
                u59.PrimaryPart:FindFirstChild("WeldConstraint"):Destroy()
                u59.PrimaryPart.Anchored = true
                local u60 = script.Normal
                if v57 ~= nil then
                    u60 = script.Haki
                end
                _G.PlaySound(u59, u60["Toss" .. math.random(1, 3)], {
                    ["RandomPitch"] = true
                }).Parent = u59.PrimaryPart
                local u61 = false
                local function v68(p62) --[[ Line: 201 ]]
                    --[[
                    Upvalues:
                        [1] = u61
                        [2] = u59
                        [3] = u4
                        [4] = u28
                        [5] = u3
                        [6] = u60
                    --]]
                    u61 = true
                    local v63 = u59.PrimaryPart.CFrame
                    if p62 then
                        v63 = CFrame.new(p62.Position, p62.Position + p62.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
                        if _G.getTargetByPart(p62.Instance) == nil then
                            local v64 = script.Debree:Clone()
                            v64.CFrame = v63
                            v64.Parent = u4
                            _G.customEmit(v64)
                            _G.destroy(v64, 4)
                            for _, v65 in v64:GetChildren() do
                                if v65:IsA("ParticleEmitter") and string.match(v65.Name, "Colourable_") then
                                    v65.Color = ColorSequence.new(p62.Instance.Color, p62.Instance.Color)
                                end
                            end
                        end
                    end
                    local v66 = script.CannonBallExplosion:Clone()
                    v66.CFrame = v63
                    v66.Parent = u4
                    _G.customEmit(v66)
                    _G.destroy(v66, 4)
                    if u28.HakiColor ~= nil then
                        local v67 = script.HakiExplosion:Clone()
                        v67.CFrame = v63
                        _G.recolorParticles(v67, u28.HakiColor)
                        v67.Parent = u4
                        _G.customEmit(v67)
                        _G.destroy(v67, 4)
                    end
                    u3:Create(v66.PointLight, TweenInfo.new(0.25), {
                        ["Range"] = 35,
                        ["Brightness"] = 0
                    }):Play()
                    _G.PlaySound(v66, u60["Boom" .. math.random(1, 3)], {
                        ["RandomPitch"] = true
                    })
                    _G.shakenear(v66.CFrame.Position, 25, 65, 65, -1)
                    u59:Destroy()
                end
                local v69 = RaycastParams.new()
                v69.FilterDescendantsInstances = _G.getTargetsWithENV(u27)
                v69.FilterType = Enum.RaycastFilterType.Include
                local v70 = u28.Direction
                local v71 = u28.startTime
                u59.PrimaryPart.Position = u28.BallPosition
                local v72 = script.Throw:Clone()
                v72.CFrame = CFrame.new(v56.Position, u59.PrimaryPart.Position + v70)
                v72.Parent = u4
                _G.customEmit(v72)
                _G.destroy(v72, 2)
                local v73 = u59.PrimaryPart.Position
                local v74 = v70
                local v75 = u61
                while workspace:GetServerTimeNow() - v71 <= 5 do
                    v70 = v70 + u25 * task.wait()
                    local v76 = workspace:GetServerTimeNow() - v71
                    local v77 = u28.BallPosition
                    local v78 = u25 * 0.2 * v76 * v76 + v74 * v76 + v77
                    u59.PrimaryPart.Position = v78
                    local v79 = (v73 - v78).Magnitude
                    local v80 = math.clamp(v79, 1, 1000)
                    local v81 = workspace:Spherecast(v73, 1, (v73 - v78).Unit * -v80, v69)
                    if v81 then
                        v68(v81)
                        break
                    end
                    v73 = v78
                end
                if u59 and v75 == false then
                    u59:Destroy()
                end
                return
            end
            if p26 == "End" then
                u27:FindFirstChild("HumanoidRootPart")
                local v82 = u4:FindFirstChild(v29)
                if v82 then
                    v82:SetAttribute("Active", false)
                    _G.destroy(v82, 10)
                    for _, v83 in v82:GetChildren() do
                        if v83.Name == "Cannon Ball" or v83.Name == "Haki_Cannon_Ball" then
                            v83:Destroy()
                        end
                        if v83.Name == "HakiBody" then
                            u22(v83, false)
                        end
                    end
                end
            end
        end
    end
}