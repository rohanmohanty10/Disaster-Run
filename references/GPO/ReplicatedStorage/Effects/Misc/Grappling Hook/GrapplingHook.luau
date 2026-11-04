 

local u1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
local u4 = require(u1.LocalPlayer.PlayerScripts.PlayerModule):GetControls()
local u5 = RaycastParams.new()
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u5.FilterType = Enum.RaycastFilterType.Include
function GetPosition(p6)
    local v7 = p6.InitialPosition
    local v8 = p6.InitialVelocity
    local v9 = p6.Gravity
    local v10 = p6.Time
    return v9 * 0.5 * v10 * v10 + v8 * v10 + v7
end
return {
    ["start"] = function(_, p11) --[[ Name: start, Line 26 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
            [3] = u1
            [4] = u3
            [5] = u4
        --]]
        local v12 = p11.Range
        local u13 = p11.Character
        local v14 = p11.Origin
        local v15 = p11.Goal
        local u16 = p11.Tool
        local _ = u13.Humanoid
        local u17 = u16.Model.Hook
        local v18 = (v15 - v14).Unit * v12
        local u19 = u13 == game.Players.LocalPlayer.Character
        local v20 = p11.ServerTime
        if u13 == nil then
            return
        end
        if u13.PrimaryPart == nil then
            return
        end
        local u21 = u13.HumanoidRootPart
        local u22 = u13.Humanoid
        local u23 = u22.Animator
        local v24 = u21.Position
        local u25 = u17:Clone()
        u25:ClearAllChildren()
        u25.Anchored = true
        u25.CFrame = u17.CFrame
        u25.Parent = workspace.Effects
        local u26 = Instance.new("Attachment")
        u26.Position = Vector3.new(0, 0, 0.2)
        u26.Parent = u17
        local u27 = Instance.new("Attachment")
        u27.Parent = u25
        local u28 = Instance.new("Beam")
        u28.Attachment0 = u26
        u28.Attachment1 = u27
        u28.Transparency = NumberSequence.new(0)
        u28.FaceCamera = true
        u28.TextureLength = 3
        u28.TextureMode = Enum.TextureMode.Static
        u28.Color = ColorSequence.new(Color3.new(0, 0, 0))
        u17.Transparency = 1
        _G.PlaySound(u25, script.Cast).Parent = u25
        u28.TextureSpeed = 12
        u28.Width0 = 0.5
        u28.Width1 = 0.5
        u28.Texture = "rbxassetid://88624422613401"
        local v29 = script.HookShootVFX:Clone()
        v29.CFrame = u21.CFrame.Rotation + u25.Position
        v29.Parent = u16
        local v30 = Instance.new("WeldConstraint")
        v30.Part0 = v29
        v30.Part1 = u17
        v30.Parent = v29
        _G.customEmit(v29)
        _G.destroy(v29, 3)
        local v31 = v24
        local function u33() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u19
                [3] = u16
            --]]
            for _, v32 in u23:GetPlayingAnimationTracks() do
                if v32.Animation.AnimationId == "rbxassetid://138716679714159" then
                    v32:Stop()
                end
            end
            if u19 == true then
                u16:SetAttribute("isShooting", nil)
            end
        end
        local u34 = nil
        while true do
            if u19 == true then
                _G.canuse = false
            end
            u2.RenderStepped:Wait()
            local v35 = workspace:GetServerTimeNow() - v20
            local v36 = u25.Position - u21.Position
            local v37 = workspace:Raycast(u21.Position, v36 - v36.Unit * 5, u5)
            if u16.Parent ~= u13 then
                break
            end
            local v38 = u25.Position - v31
            local v39 = v37 or workspace:Raycast(v31, v38, u5)
            if v39 then
                u34 = v39
                u25.Position = u34.Position
                break
            end
            u22.WalkSpeed = 3
            v31 = u25.Position
            u25.CFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), v38) + GetPosition({
                ["InitialPosition"] = v24,
                ["InitialVelocity"] = v18,
                ["Gravity"] = Vector3.new(-0, -1, -0) * workspace.Gravity * 0.5,
                ["Time"] = v35
            })
            if u1.LocalPlayer.Character == u13 then
                u21.CFrame = CFrame.fromMatrix(u21.Position, -(Vector3.new(0, 1, 0)):Cross(u25.Position - u21.Position), Vector3.new(0, 1, 0))
            end
            u28.Parent = u26
            if v35 >= 1 then
                break
            end
        end
        u22.WalkSpeed = 16
        u28.Width0 = 0.05
        u28.Width1 = 0.05
        u28.Texture = ""
        if u19 == true then
            _G.canuse = true
        end
        task.spawn(function() --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u13
                [3] = u34
                [4] = u28
                [5] = u25
                [6] = u2
                [7] = u3
                [8] = u17
                [9] = u33
                [10] = u27
                [11] = u26
            --]]
            if u16.Parent == u13 then
                local v40 = 0
                while u34 and v40 < 0.5 do
                    v40 = v40 + task.wait()
                end
                u28.TextureSpeed = -12
                u28.Width0 = 0.5
                u28.Width1 = 0.5
                u28.Texture = "rbxassetid://88624422613401"
                _G.PlaySound(u25, script.Reel).Parent = u25
                local v41 = os.clock()
                local _ = u25.Position
                local _ = u25.CFrame.LookVector
                while true do
                    local v42 = u2.Heartbeat:Wait()
                    local v43 = u3:GetValue((os.clock() - v41) / 1, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                    local v44 = (u25.Position - Vector3.new(0, 20, 0) * v42):Lerp(u17.Position, v43)
                    if (v44 - u17.Position).Magnitude <= 1 then
                        break
                    end
                    u25.CFrame = CFrame.lookAlong(v44, v44 - u17.Position)
                    if _G.check:inspect(u13) == false or v43 >= 1 then
                        break
                    end
                end
            end
            if not u34 then
                u33()
            end
            u17.Transparency = 0
            u25.Transparency = 1
            _G.destroy(u25, 1)
            u27:Destroy()
            u28:Destroy()
            u26:Destroy()
        end)
        if u34 then
            u33()
            _G.PlaySound(CFrame.new(u34.Position), script.HitSurface, {
                ["Pitch"] = math.random(250, 350) / 100
            })
            local v45 = script.hitWall:Clone()
            v45.CFrame = CFrame.lookAlong(u34.Position, u34.Normal) * CFrame.Angles(0, -1.5707963267948966, 0)
            if u34.Instance then
                _G.recolorParticles(v45, u34.Instance.Color)
            end
            v45.Parent = workspace.Effects
            _G.customEmit(v45)
            _G.destroy(v45, 3)
            local u46 = Instance.new("IKControl")
            u46.Type = Enum.IKControlType.Position
            u46.EndEffector = u13.RightHand
            u46.ChainRoot = u13.RightUpperArm
            u46.Target = v45
            u46.Weight = 0.2
            u46.Parent = u13
            u3:Create(u46, TweenInfo.new(0.2), {
                ["Weight"] = 1
            }):Play()
            task.delay(0.5, function() --[[ Line: 260 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u46
                    [3] = u16
                    [4] = u13
                --]]
                u3:Create(u46, TweenInfo.new(0.5), {
                    ["Weight"] = 0.2
                }):Play()
                local v47 = os.clock()
                while u16.Parent == u13 and (os.clock() - v47 <= 0.5 and (_G.check:inspect(u13) ~= false and not u13:FindFirstChild("Blocking"))) do
                    task.wait()
                end
                u46:Destroy()
            end)
            if u19 then
                local u48 = u21.Size.Y * 0.5 + u22.HipHeight
                local v49 = u34.Position - v24
                local u50 = (v49 * Vector3.new(1, 0, 1)).Unit * 15
                local v51 = v49.Magnitude
                local u52 = math.min(v51, 20) / 20
                local v53 = Vector3.new(0, 1, 0) * workspace.Gravity * 0.15 * u52 + Vector3.new(0, 1, 0) * u48
                local u54 = (u34.Position + u50 + v53 - u21.Position).Magnitude
                local u55 = u22.MaxHealth * 0.3
                local function u62() --[[ Line: 290 ]]
                    --[[
                    Upvalues:
                        [1] = u52
                        [2] = u48
                        [3] = u34
                        [4] = u50
                        [5] = u21
                        [6] = u4
                        [7] = u54
                        [8] = u22
                        [9] = u55
                    --]]
                    local v56 = Vector3.new(0, 1, 0) * workspace.Gravity * 0.15 * u52 + Vector3.new(0, 1, 0) * u48
                    local v57 = u34.Position + u50 + v56 - u21.Position
                    local v58 = (Vector3.new(0, 1, 0)):Cross(-v57.Unit) * u4:GetMoveVector().X
                    local v59 = v57.Unit * u54 + v58 * 50
                    local v60 = u22.Health
                    local v61 = u55
                    return v59 * (math.min(v60, v61) / u55)
                end
                local u63 = Instance.new("LinearVelocity")
                u63.Attachment0 = u21:FindFirstChildWhichIsA("Attachment")
                u63.MaxForce = 99999
                u63.MaxAxesForce = Vector3.new(999999, 999999, 999999)
                u63.VectorVelocity = u62()
                u63.Parent = u21
                _G.destroy(u63, 0.5)
                local u64 = script.travel:Clone()
                u64.Parent = u21
                u64:Play()
                local u65 = u23:LoadAnimation(script.Pull)
                u65.Priority = Enum.AnimationPriority.Action4
                u65:Play()
                task.spawn(function() --[[ Line: 319 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u63
                        [3] = u19
                        [4] = u62
                        [5] = u21
                        [6] = u65
                        [7] = u3
                        [8] = u64
                    --]]
                    tick()
                    local v66 = false
                    while true do
                        if _G.check:inspect(u13) == false then
                            u63.MaxForce = 0
                            u63.MaxAxesForce = Vector3.new(0, 0, 0)
                            v66 = true
                            break
                        end
                        if u19 == true and _G.canuse == false then
                            u63.MaxForce = 0
                            u63.MaxAxesForce = Vector3.new(0, 0, 0)
                            v66 = true
                            break
                        end
                        u63.VectorVelocity = u62()
                        u21.CFrame = CFrame.lookAlong(u21.Position, u63.VectorVelocity.Unit * Vector3.new(1, 0, 1))
                        task.wait()
                        if not u63.Parent then
                            break
                        end
                    end
                    u63:Destroy()
                    if v66 == false then
                        u65:Stop(0.25)
                    else
                        u65:Stop()
                    end
                    u3:Create(u64, TweenInfo.new(0.25), {
                        ["Volume"] = 0
                    }):Play()
                    _G.destroy(u64, 0.25)
                end)
            end
        else
            return
        end
    end
}