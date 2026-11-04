 

local v1 = {}
game:GetService("Players")
game:GetService("TweenService")
local _ = workspace.CurrentCamera
local u2 = script
local u3 = workspace.Effects
local u4 = require(game.ReplicatedStorage.Modules.ParticleEmit)
local u5 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u6 = {
    [0.32] = "Hit1",
    [1.11] = "ArmSwing",
    [1.45] = "Hit2",
    [1.51] = "Hit3",
    [1.68] = "Hit4",
    [2.26] = "Sweep",
    [2.375] = "Shake2",
    [2.7] = "Flashstep",
    [2.9] = "FlashstepReturn",
    [3.25] = "GroundSlam"
}
local u7 = RaycastParams.new()
u7.RespectCanCollide = true
u7.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u7.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, u8, u9, p10, u11) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u4
        [4] = u7
        [5] = u2
        [6] = u6
    --]]
    if _G.checkRenderDistance(u8.PrimaryPart.Position) ~= false then
        local v12 = u8.Humanoid:LoadAnimation(script.player)
        v12:Play()
        v12:AdjustWeight(2)
        local v13 = u9.Humanoid:LoadAnimation(script.victim)
        v13:Play()
        v13:AdjustWeight(2)
        v12.Priority = Enum.AnimationPriority.Action4
        v13.Priority = Enum.AnimationPriority.Action4
        local u55 = {
            ["Shake1"] = function(p14, _, p15) --[[ Name: Shake1, Line 59 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v16 = p15.shake:Clone()
                u5.apply(v16, p14)
                v16.CFrame = CFrame.new(p14.UpperTorso.Position)
                v16.Parent = u3
                u4:WeldToPart(v16, p14.Head).C0 = CFrame.new(0, 2, 0)
                u4:EmitHandler(v16)
                u4:Destroy(v16)
            end,
            ["Shake2"] = function(p17, _, p18) --[[ Name: Shake2, Line 70 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u11
                    [3] = u3
                    [4] = u4
                --]]
                local v19 = p18.shake:Clone()
                u5.apply(v19, p17)
                v19.CFrame = CFrame.new(p17.UpperTorso.Position)
                for _, v20 in pairs(v19:GetDescendants()) do
                    if v20:IsA("ParticleEmitter") then
                        v20:SetAttribute("EmitDuration", 0.15 / u11)
                    end
                end
                v19.Parent = u3
                u4:WeldToPart(v19, p17.UpperTorso).C0 = CFrame.new(0, -2, 0)
                u4:EmitHandler(v19)
                u4:Destroy(v19)
            end,
            ["Flashstep"] = function(p21, _, p22) --[[ Name: Flashstep, Line 86 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v23 = p22.flashstep:Clone()
                u5.apply(v23, p21)
                v23.CFrame = CFrame.new(p21.UpperTorso.Position) * CFrame.Angles(0, 1.5707963267948966, 0)
                v23.Parent = u3
                u4:EmitHandler(v23)
                u4:Destroy(v23)
            end,
            ["FlashstepReturn"] = function(p24, _, p25) --[[ Name: FlashstepReturn, Line 95 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v26 = p25.flashstepReturn:Clone()
                u5.apply(v26, p24)
                v26.CFrame = CFrame.new(p24.UpperTorso.Position) * CFrame.new(0, 2.5, 0)
                v26.Parent = u3
                u4:EmitHandler(v26)
                u4:Destroy(v26)
            end,
            ["Hit1"] = function(u27, u28, u29) --[[ Name: Hit1, Line 104 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v30 = u29.blood1:Clone()
                u5.apply(v30, u27)
                v30.CFrame = u28.Head.CFrame
                v30.Parent = u3
                u4:EmitHandler(v30)
                u4:Destroy(v30)
                task.delay(0.1, function() --[[ Line: 112 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u5
                        [3] = u27
                        [4] = u4
                        [5] = u28
                        [6] = u3
                    --]]
                    local v31 = u29["blood1 Enabled"]:Clone()
                    u5.apply(v31, u27)
                    u4:Resize(v31, 0.5)
                    v31.Anchored = false
                    v31.CFrame = u28.Head.CFrame
                    u4:WeldToPart(v31, u28.Head)
                    v31.Parent = u3
                    u4:EmitHandler(v31)
                    task.wait(1.75)
                    u4:Destroy(v31)
                end)
            end,
            ["Hit2"] = function(p32, p33, p34) --[[ Name: Hit2, Line 127 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v35 = p34.blood1:Clone()
                u5.apply(v35, p32)
                v35.CFrame = p33.UpperTorso.CFrame * CFrame.Angles(-1, 0, 0)
                v35.Parent = u3
                u4:EmitHandler(v35)
                u4:Destroy(v35)
            end,
            ["Hit3"] = function(p36, p37, p38) --[[ Name: Hit3, Line 136 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v39 = p38.blood1:Clone()
                u5.apply(v39, p36)
                v39.CFrame = p37.UpperTorso.CFrame * CFrame.new(0, -0.5, 0) * CFrame.Angles(0.08726646259971647, 0, 0)
                v39.Parent = u3
                u4:EmitHandler(v39)
                u4:Destroy(v39)
            end,
            ["Hit4"] = function(p40, p41, p42) --[[ Name: Hit4, Line 145 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v43 = p42.blood1:Clone()
                u5.apply(v43, p40)
                v43.CFrame = p41.UpperTorso.CFrame * CFrame.new(0, -2.5, -0.5) * CFrame.Angles(0.4363323129985824, 0, 0)
                v43.Parent = u3
                u4:EmitHandler(v43)
                u4:Destroy(v43)
            end,
            ["Sweep"] = function(p44, p45, p46) --[[ Name: Sweep, Line 154 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                    [3] = u4
                --]]
                local v47 = p46.sweep:Clone()
                u5.apply(v47, p44)
                local v48 = p45.UpperTorso.CFrame
                v47.CFrame = CFrame.new(v48.Position) * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, v48.LookVector.Y - 1.5707963267948966, 1.5707963267948966)
                v47.Parent = u3
                u4:EmitHandler(v47)
                u4:Destroy(v47)
            end,
            ["GroundSlam"] = function(p49, p50, p51) --[[ Name: GroundSlam, Line 164 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u7
                    [3] = u3
                    [4] = u4
                --]]
                local v52 = p51.hitGround:Clone()
                u5.apply(v52, p49)
                v52.CFrame = CFrame.new(p50.UpperTorso.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v53 = workspace:Raycast(p50.UpperTorso.Position, Vector3.new(0, -10, 0), u7)
                if v53 then
                    v52.CFrame = v52.CFrame * CFrame.new(0, 0, v53.Distance)
                end
                v52.Parent = u3
                u4:EmitHandler(v52)
                u4:Destroy(v52)
                local u54 = p51["blood1 Enabled"]:Clone()
                u5.apply(u54, p49)
                u4:Resize(u54, 1.5)
                u54.CFrame = v52.CFrame
                u54.Parent = u3
                u4:EmitHandler(u54)
                task.delay(0.5, function() --[[ Line: 184 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u54
                    --]]
                    u4:Destroy(u54)
                end)
                local _ = v52.Position + Vector3.new(0, 1, 0)
            end
        }
        local v56 = workspace:GetServerTimeNow() - p10
        task.spawn(function() --[[ Line: 215 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u8
                [3] = u9
                [4] = u2
            --]]
            u55.Shake1(u8, u9, u2)
        end)
        local v57 = u8 == game.Players.LocalPlayer.Character
        if v57 == true then
            workspace.CurrentCamera.CameraSubject = u8.UpperTorso
        end
        _G.PlaySound(u8.UpperTorso, script["Audio/TojiSpearMassacre"]).Parent = u8.UpperTorso
        for v58, u59 in pairs(u6) do
            task.delay(v58 / u11 + 0.15 / u11 - v56, function() --[[ Line: 225 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u59
                    [3] = u8
                    [4] = u9
                    [5] = u2
                --]]
                local v60 = u55[u59]
                if v60 then
                    v60(u8, u9, u2)
                end
            end)
        end
        _G.PlayEffect("AfterImage", nil, {
            ["Character"] = u8,
            ["Duration"] = 3.25 / u11 - v56,
            ["MaxClones"] = 10,
            ["Interval"] = 0.01,
            ["Material"] = Enum.Material.Neon,
            ["Transparency"] = 0.5,
            ["Colour"] = Color3.new(0, 0, 0),
            ["Fade"] = true
        })
        task.wait(3.25 / u11 - v56)
        if v57 == true then
            workspace.CurrentCamera.CameraSubject = u8.Humanoid
        end
    end
end
return v1