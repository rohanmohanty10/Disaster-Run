 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local _ = script.VFX
local v3 = RaycastParams.new()
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v3.FilterType = Enum.RaycastFilterType.Include
local v4 = {}
local function u8(p5, p6) --[[ Line: 15 ]]
    for _, v7 in p5:GetDescendants() do
        if v7:IsA("ParticleEmitter") or (v7:IsA("Beam") or (v7:IsA("Trail") or v7:IsA("PointLight"))) then
            v7.Enabled = p6
        end
    end
end
local u9 = RaycastParams.new()
u9.FilterType = Enum.RaycastFilterType.Include
u9.RespectCanCollide = true
u9.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
function v4.start(_, p10) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u1
        [3] = u8
        [4] = u2
    --]]
    local u11 = p10.Prometheus
    local _ = u11.PrimaryPart
    local v12 = p10.Type
    local u13 = p10.Character
    local u14 = p10.UpdateHomiesEvent
    local u15 = p10.Character == game.Players.LocalPlayer.Character
    local u16 = 45
    local u17 = p10.BodyRoot
    local u18 = p10.WindUpDuration
    if v12 == "Charge" then
        _G.customEmit(u11.AttachedPart.SkillStart)
        _G.particleEnabled(u11.AttachedPart.SkillTrail, true)
        u11:GetAttributeChangedSignal("SunBeamCharging"):Once(function() --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            _G.particleEnabled(u11.AttachedPart.SkillTrail, false)
        end)
        _G.PlaySound(u17, script.SoulPrometheusLaserStart).Parent = u17
        local u19 = u13.PrimaryPart
        local u20 = CFrame.new()
        local u21 = u17.CFrame
        local u22 = p10.Remote
        local u23 = p10.serverStartTime
        local u24 = nil
        local u25 = u13.Parent == workspace.NPCs and 6 or 2
        local u26 = p10.MaxRange
        local u27 = u21.Position.Y
        local _ = game["Run Service"].Heartbeat:Connect(function(p28) --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u24
                [3] = u23
                [4] = u19
                [5] = u26
                [6] = u9
                [7] = u18
                [8] = u16
                [9] = u20
                [10] = u21
                [11] = u17
                [12] = u27
                [13] = u25
                [14] = u15
                [15] = u22
                [16] = u14
                [17] = u11
            --]]
            local v29 = u13:GetAttribute("SunRayPos")
            if v29 == nil then
                u24:Disconnect()
                u24 = nil
            else
                local v30 = workspace:GetServerTimeNow() - u23
                local v31 = u19.Position + Vector3.new(0, 3, 0)
                local v32 = v29 - v31
                if u26 < v32.Magnitude then
                    v32 = v32.Unit * u26
                end
                local v33 = workspace:Raycast(v31, v32, u9)
                local v34
                if v33 and (v33.Position - u19.Position).Magnitude > 5 then
                    v34 = v33.Position
                else
                    v34 = v31 + v32
                end
                if v30 <= u18 then
                    local v35 = v30 / u18
                    local v36 = math.min(1, v35)
                    local _ = 1 - v36
                    u16 = v36 * 45
                    local v37 = u20
                    local v38 = CFrame.Angles(0, 6.283185307179586 * v36, 0)
                    local v39 = CFrame.new
                    local v40 = v36 * 3.141592653589793
                    u20 = v37:Lerp(v38 * v39(0, 0, math.sin(v40) * 25) + Vector3.new(0, 1, 0) * u16, v36)
                else
                    u20 = CFrame.new()
                end
                local v41 = u21 * u20
                local v42, v43, _ = _G.getRayFloor(v41 + Vector3.new(0, 1, 0), u16)
                if v42 then
                    local v44 = CFrame.new(v43)
                    local v45, v46, _ = _G.getRayFloor(v44, -(u16 + 5))
                    if v45 == nil then
                        v41 = CFrame.new(v46)
                    else
                        v41 = CFrame.new(v46 - Vector3.new(0, 2, 0))
                    end
                end
                u17.BodyPosition.Position = v41.Position
                u17.CFrame = CFrame.new(v41.Position, u19.Position)
                local v47, v48, v49 = _G.getRayFloor(CFrame.new(v34.X, u21.Position.Y + u16, v34.Z), -u16 * 2)
                local v50
                if v47 and (v49 and (v49.Y > 0.5 and v48.Y < u21.Position.Y)) then
                    v50 = v48.Y
                else
                    v50 = v34.Y
                end
                local v51 = u27
                local v52 = v50 - u27
                local v53 = 3 * p28
                u27 = v51 + v52 * math.min(1, v53)
                local v54 = v34.X
                local v55 = u27
                local v56 = v34.Z
                local v57 = Vector3.new(v54, v55, v56)
                u21 = u21:Lerp(CFrame.new(v57), u25 * p28)
                if u18 < v30 and u15 == true then
                    u22:FireServer("Position", u17.Position)
                end
                if u15 == true then
                    u14:FireServer(u11.Name, u17.Position)
                end
            end
        end)
    elseif v12 == "Beam" then
        local u58 = script.VFX.Beam:Clone()
        u58:SetPrimaryPartCFrame(u17.CFrame)
        local u59 = false
        for _, v60 in u58:GetDescendants() do
            if v60:IsA("Beam") then
                local v61 = v60.Width0
                local v62 = v60.Width1
                v60.Width0 = 0
                v60.Width1 = 0
                v60.Enabled = true
                u1:Create(v60, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Width0"] = v61,
                    ["Width1"] = v62
                }):Play()
            elseif v60:IsA("ParticleEmitter") then
                v60.Enabled = true
            end
        end
        local function u66(p63) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u58
            --]]
            local v64 = u58.Top:GetChildren()
            for v65 = 1, #v64 do
                if v64[v65]:IsA("Beam") then
                    v64[v65].Enabled = p63
                end
            end
        end
        local v67 = _G.PlaySound(u17, script.SoulPrometheusLaserShoot)
        v67.Parent = u17
        local u68 = script.SoulPrometheusLaserLoop:Clone()
        u68.Parent = u58.Floor
        u68:Play()
        local function v72() --[[ Line: 192 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u58
                [3] = u59
                [4] = u66
                [5] = u8
                [6] = u68
            --]]
            local v69, v70, v71 = _G.getRayFloor(CFrame.new(u17.Position), 100)
            if v69 then
                u58.Floor.CFrame = CFrame.new(v70, v70 + v71) * CFrame.Angles(1.5707963267948966, 0, 0) + v71
                if not u59 then
                    u59 = true
                    u66(true)
                    u8(u58.Floor, true)
                end
                _G.recolorParticles(u58.Floor, ColorSequence.new(v69.Color))
                u68.Volume = 0.5
            elseif u59 then
                u59 = false
                u8(u58.Floor, false)
                u66(false)
                u68.Volume = 0
            end
        end
        v72()
        u58.Parent = workspace.Effects
        _G.customWeld(u58.Top, u17, CFrame.new(), u58.Top)
        u1:Create(u58.Floor.PointLight, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true, 0), {
            ["Range"] = 30
        }):Play()
        local v73 = u2.Heartbeat:Connect(v72)
        repeat
            task.wait()
        until u11:GetAttribute("SunRayBeam") == nil
        if not u11:GetAttribute("SunRayBeam") then
            v73:Disconnect()
            u8(u58.Floor, false)
            for _, v74 in u58:GetDescendants() do
                if v74:IsA("Beam") then
                    u1:Create(v74, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                elseif v74:IsA("ParticleEmitter") then
                    v74.Enabled = false
                end
            end
            u1:Create(u68, TweenInfo.new(0.5), {
                ["Volume"] = 0
            }):Play()
            u1:Create(v67, TweenInfo.new(0.5), {
                ["Volume"] = 0
            }):Play()
            task.delay(0.5, function() --[[ Line: 260 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                task.wait(1)
                u58:Destroy()
            end)
        end
    end
end
return v4