 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = script:WaitForChild("Models")
script:WaitForChild("SFX")
local u5 = script:WaitForChild("VFX")
script:WaitForChild("Other")
local u6 = workspace:WaitForChild("Effects")
local u7 = require(script.Parent:WaitForChild("SharedDiamondUtils"))
Charges = {}
require(game.ReplicatedStorage.Modules.BoatTween)
local u8 = Random.new()
local u9 = RaycastParams.new()
u9.FilterType = Enum.RaycastFilterType.Include
u9.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local u10 = require(script.ExplodePrismaticRock)
local u84 = {
    ["Start"] = function(u11, p12) --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u9
            [3] = u5
            [4] = u6
            [5] = u8
            [6] = u2
        --]]
        local u13 = u11:FindFirstChild("BusoMelee") ~= nil
        local u14 = nil
        local u15 = nil
        task.delay(0.35 / p12, function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u15
                [3] = u7
                [4] = u11
                [5] = u13
            --]]
            local v16 = {
                ["PartialTorso1"] = u13 and true or false,
                ["PartialTorso2"] = u13 and true or false,
                ["LeftUpperArm"] = u13 and true or false,
                ["LeftLowerArm"] = u13 and true or false,
                ["LeftHand"] = u13 and true or false,
                ["RightUpperArm"] = u13 and true or false,
                ["RightLowerArm"] = u13 and true or false,
                ["RightHand"] = u13 and true or false
            }
            local v17, v18 = u7.DiamondFunctions.DiamondMorph(u11, v16, "RockTossDiamondRig")
            u14 = v17
            u15 = v18
        end)
        _G.PlaySound(u11, script.DiamondRockThrowStart)
        task.wait(0.75 / p12)
        local u19 = workspace:Raycast(u11.PrimaryPart.CFrame * CFrame.new(0, 0, -2).Position, Vector3.new(0, -12.5, 0), u9)
        if u19 then
            local v20 = u5.DigBoulderDig:Clone()
            v20.Position = u19.Position + Vector3.new(0, 0.15, 0)
            if u19 and u19.Instance then
                _G.recolorParticles(v20, u19.Instance.Color)
            end
            v20.Parent = u6
            _G.customEmit(v20)
            task.delay(2, v20.Destroy, v20)
            task.delay(0.25, function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u19
                    [3] = u6
                    [4] = u8
                    [5] = u2
                --]]
                local v21 = u5.DigBoulderPull:Clone()
                v21.Position = u19.Position + Vector3.new(0, 0.15, 0)
                if u19 and u19.Instance then
                    _G.recolorParticles(v21, u19.Instance.Color)
                end
                v21.Parent = u6
                _G.customEmit(v21)
                task.delay(3, v21.Destroy, v21)
                local v22 = u5.ImpactRingMesh:Clone()
                local v23 = CFrame.new(u19.Position + Vector3.new(0, 5, 0))
                local v24 = CFrame.Angles
                local v25 = u8:NextNumber(-180, 180)
                v22.CFrame = v23 * v24(3.141592653589793, math.rad(v25), 0)
                v22.Mesh.Scale = Vector3.new(-0, -15, -0)
                v22.Mesh.VertexColor = Vector3.new(2, 2, 2)
                u2:Create(v22, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v22.CFrame * CFrame.new(0, 7, 0),
                    ["Transparency"] = 1
                }):Play()
                u2:Create(v22.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Scale"] = Vector3.new(-25, -0, -25)
                }):Play()
                v22.Parent = u6
                task.delay(0.25, v22.Destroy, v22)
            end)
        end
        task.wait(0.25 / p12)
        local v26 = u5.RockBoulderHold:Clone()
        local v27 = Instance.new("Weld")
        v27.Part0 = u11.LeftHand
        v27.Part1 = v26
        local v28 = CFrame.new(0, -2, 0)
        local v29 = CFrame.Angles
        local v30 = u8:NextNumber(-180, 180)
        local v31 = math.rad(v30)
        local v32 = u8:NextNumber(-180, 180)
        local v33 = math.rad(v32)
        local v34 = u8:NextNumber(-180, 180)
        v27.C0 = v28 * v29(v31, v33, (math.rad(v34)))
        v27.Parent = v26
        if u19 and u19.Instance then
            _G.matchMaterial(v26, u19.Instance)
            _G.recolorParticles(v26, u19.Instance.Color)
        end
        v26.Parent = u6
        local v35 = u15
        local v36 = u14
        while u11:GetAttribute("RockTossHold") do
            task.wait()
        end
        v36.Name = "RockTossRigDestroying"
        pcall(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            u11.Boosts.currentDiamondMorph:Destroy()
        end)
        task.wait(0.25)
        v27:Destroy()
        v26.Anchored = true
        v26.Transparency = 1
        _G.particleEnabled(v26, false)
        for _, v37 in v36:GetChildren() do
            u7.DiamondFunctions.BreakDiamond(v37, u13)
        end
        _G.destroy(v36, 1.5)
        _G.destroy(v26, 2)
        task.wait(0.2)
        if v35 then
            v35()
        end
    end,
    ["End"] = function(u38, u39, u40, p41, p42) --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u2
            [4] = u8
            [5] = u4
            [6] = u3
            [7] = u10
        --]]
        local _ = u38:FindFirstChild("BusoMelee") == nil
        task.wait(p42 - workspace:GetServerTimeNow())
        local u43, _, _ = _G.getRayFloor(u38.PrimaryPart.CFrame, 8)
        local v44 = u38.HumanoidRootPart.CFrame
        local u45 = u5.ThrownEffect:Clone()
        u45.CFrame = v44 * CFrame.new(0, 0, -4)
        if u43 then
            _G.recolorParticles(u45, u43.Color)
        end
        u45.Parent = u6
        local v46 = u5.ThrowingEffect:Clone()
        v46.CFrame = u45.CFrame
        if u43 then
            _G.recolorParticles(v46, u43.Color)
        end
        v46.Parent = u6
        _G.customEmit(v46)
        task.delay(1, v46.Destroy, v46)
        local v47 = u5.ImpactRingMesh:Clone()
        v47.CFrame = u45.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
        v47.Mesh.Scale = Vector3.new(-5, -0, -5)
        v47.Mesh.VertexColor = Vector3.new(5, 5, 5)
        u2:Create(v47, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["CFrame"] = v47.CFrame * CFrame.new(0, -10, 0),
            ["Transparency"] = 1
        }):Play()
        u2:Create(v47.Mesh, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(-12.5, -20, -12.5)
        }):Play()
        v47.Parent = u6
        task.delay(0.25, v47.Destroy, v47)
        local u48 = u8:NextNumber(-1.5, 1.5)
        local u49 = u8:NextNumber(-1.5, 1.5)
        local u50 = u8:NextNumber(-1.5, 1.5)
        local u51 = CFrame.new(u39.Position, u40.Position)
        local u52 = u4.RockBoulder:Clone()
        local v53 = CFrame.Angles
        local v54 = u8:NextNumber(-180, 180)
        local v55 = math.rad(v54)
        local v56 = u8:NextNumber(-180, 180)
        local v57 = math.rad(v56)
        local v58 = u8:NextNumber(-180, 180)
        u52.CFrame = u39 * v53(v55, v57, (math.rad(v58)))
        u52.Anchored = true
        if u43 then
            _G.matchMaterial(u52, u43)
            _G.recolorParticles(u52, u43.Color)
        end
        u52.Parent = u6
        local v59 = CFrame.new(u52.Position)
        local u60 = os.clock()
        local u61 = nil
        local u62 = RaycastParams.new()
        u62.FilterType = Enum.RaycastFilterType.Include
        u62.FilterDescendantsInstances = p41
        u62.RespectCanCollide = true
        _G.PlaySound(u38.PrimaryPart, script.DiamondRockThrowShoot)
        local u63 = v59.Position
        u61 = u3.Heartbeat:Connect(function(p64) --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u52
                [2] = u51
                [3] = u48
                [4] = u49
                [5] = u50
                [6] = u45
                [7] = u39
                [8] = u60
                [9] = u61
                [10] = u10
                [11] = u38
                [12] = u63
                [13] = u40
                [14] = u62
                [15] = u4
                [16] = u6
                [17] = u43
                [18] = u2
                [19] = u5
            --]]
            u52.Position = u52.Position + u51.LookVector * (4 * p64 * 60)
            local v65 = u52
            local v66 = u52.Rotation
            local v67 = 1 * u48 * (p64 * 60)
            local v68 = 1 * u49 * (p64 * 60)
            local v69 = 1 * u50 * (p64 * 60)
            v65.Rotation = v66 + Vector3.new(v67, v68, v69)
            u45.CFrame = CFrame.new(u52.Position, u39.Position) * CFrame.Angles(3.141592653589793, 0, 0)
            if os.clock() - u60 >= 1 then
                u61:Disconnect()
                u52:Destroy()
                _G.particleEnabled(u45, false)
                _G.destroy(u45, 3)
            else
                local v70 = u10:scan(u38, u52.Position, 5)
                local v71 = (u63 - u52.Position).Magnitude + u52.Size.Z / 2
                local v72 = workspace:Blockcast(CFrame.new(u63, u52.Position), u52.Size, CFrame.new(u52.Position, u40.Position).LookVector * v71, u62)
                u63 = u52.Position
                if v72 and v72.Instance or v70 == true then
                    local v73 = u4.RockDebris:Clone()
                    v73:PivotTo(u52.CFrame)
                    v73.Parent = u6
                    for _, v74 in v73:GetChildren() do
                        local v75 = u51.LookVector * Random.new():NextNumber(50, 150)
                        local v76 = Random.new():NextNumber(-50, 50)
                        local v77 = Random.new():NextNumber(25, 50)
                        local v78 = Random.new()
                        v74.Velocity = v75 + Vector3.new(v76, v77, v78:NextNumber(-50, 50))
                        local v79 = Random.new():NextNumber(-10, 10)
                        local v80 = Random.new():NextNumber(-10, 10)
                        local v81 = Random.new()
                        v74.RotVelocity = Vector3.new(v79, v80, v81:NextNumber(-10, 10))
                        if u43 then
                            _G.matchMaterial(v74, u43)
                        end
                        local v82 = Random.new():NextNumber(0.75, 1.5)
                        u2:Create(v74, TweenInfo.new(v82, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                    end
                    task.delay(1.5, v73.Destroy, v73)
                    _G.PlaySound(u52.CFrame, script.DiamondRockThrowGroundHit, {
                        ["RandomPitch"] = true
                    })
                    u61:Disconnect()
                    u52:Destroy()
                    _G.particleEnabled(u45, false)
                    _G.destroy(u45, 2)
                    local v83 = u5.RockHitEffect:Clone()
                    if v72 and v72.Instance then
                        v83.CFrame = CFrame.new(v72.Position)
                    else
                        v83.CFrame = u52.CFrame
                    end
                    _G.recolorParticles(v83, u43.Color)
                    v83.Parent = u6
                    _G.customEmit(v83)
                    _G.destroy(v83, 3)
                end
            end
        end)
    end
}
function v1.start(_, p85, p86, ...) --[[ Line: 278 ]]
    --[[
    Upvalues:
        [1] = u84
    --]]
    if u84[p86] then
        u84[p86](p85, ...)
    end
end
return v1