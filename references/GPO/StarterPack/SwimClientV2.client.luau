 

local u1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("UserInputService")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("SoundService")
local u4, u5, v6, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u7 = u1.Util
local v8 = u1.Modules.Shared
local v9 = game.Players.LocalPlayer
local u10 = v9.Character or v9.CharacterAdded:Wait()
local u11 = u10:WaitForChild("HumanoidRootPart")
local u12 = u10.Humanoid
_G.swimmingAscension = false
_G.swimmingDecension = false
local v13 = u10.Humanoid.Animator
local u14 = {
    ["Idle"] = v13:LoadAnimation(u7.Swim.Idle),
    ["Dive"] = v13:LoadAnimation(u7.Swim.Dive),
    ["Down"] = v13:LoadAnimation(u7.Swim.Down),
    ["Swim"] = v13:LoadAnimation(u7.Swim.Swim),
    ["Drown"] = v13:LoadAnimation(u7.Swim.Drowning),
    ["Jump"] = v13:LoadAnimation(u7.Swim.waterJump)
}
for v15, v16 in pairs(u14) do
    v16.Priority = Enum.AnimationPriority.Action2
    if v15 == "Idle" or v15 == "Jump" then
        v16.Priority = Enum.AnimationPriority.Action
    end
end
local v17 = u1:WaitForChild("Stats" .. v9.Name)
local u18 = v17.Stats.DF
local _ = workspace.CurrentCamera
local u19 = os.clock()
local u20 = u7.Swim.Underwater
local u21 = u7.Swim.Swimming
local u22 = u7.Swim.SwimmingUnder
local v23 = OverlapParams.new()
v23.FilterDescendantsInstances = { workspace.Water }
v23.FilterType = Enum.RaycastFilterType.Include
local v24 = RaycastParams.new()
v24.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
v24.FilterType = Enum.RaycastFilterType.Include
_G.swimming = false
_G.SeaLevel = workspace.Env.WaterStuff.Falls.Position.Y
local v25 = workspace.Env.WaterStuff:WaitForChild("Sand")
require(v8.Signals.GoodSignal)
require(v8.Maids.Maid)
local v26 = require(v9.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local u27 = require(u1.Modules.CameraShaker)
local u28 = workspace.CurrentCamera
local u29 = false
local u30 = 0
local u31 = 15
for _, v32 in u28:GetChildren() do
    v32:Destroy()
end
u7.Swim.Drown:Stop()
local u33 = Instance.new("BodyPosition")
u33.MaxForce = Vector3.new(0, 1000000, 0)
local v34 = _G.SeaLevel
u33.Position = Vector3.new(0, v34, 0)
u33.P = 500000
u33.D = 5000
local u35 = Instance.new("BlurEffect")
u35.Size = 0
u35.Name = "WaterBlur"
u35.Parent = u28
local u36 = Instance.new("ColorCorrectionEffect")
u36.Brightness = 0
u36.Contrast = 0
u36.Saturation = 0
u36.TintColor = Color3.new(1, 1, 1)
u36.Name = "WaterColorContrast"
u36.Parent = u28
local u37 = game.ReplicatedStorage.Util.Swim.BillboardGui:Clone()
u37.StudsOffset = Vector3.new(0, 2, 0)
local u40 = u27.new(Enum.RenderPriority.Camera.Value + 1, function(p38) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u28
    --]]
    local v39 = u28
    v39.CFrame = v39.CFrame * p38
end)
u40:Start()
u10.ChildAdded:Connect(function(p41) --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u31
    --]]
    if p41.Name == "coatBubble" then
        u31 = 100
        p41.Destroying:Connect(function() --[[ Line: 125 ]]
            --[[
            Upvalues:
                [1] = u31
            --]]
            u31 = 15
        end)
    end
end)
local u42 = true
local v44 = {
    [true] = function() --[[ Line: 139 ]]
        --[[
        Upvalues:
            [1] = u42
            [2] = u7
            [3] = u2
            [4] = u36
            [5] = u35
            [6] = u40
            [7] = u27
            [8] = u20
        --]]
        if not u42 then
            u42 = true
            local v43 = u7.Swim.ColorCorrection
            local _ = u7.Swim.Blur
            u2:Create(u36, TweenInfo.new(0.25), {
                ["Brightness"] = v43.Brightness,
                ["Contrast"] = v43.Contrast,
                ["Saturation"] = v43.Saturation,
                ["TintColor"] = v43.TintColor
            }):Play()
            u2:Create(u35, TweenInfo.new(0.25), {
                ["Size"] = u35.Size
            }):Play()
            u40:ShakeSustain(u27.Presets.Underwater)
            if u20.IsPlaying == false then
                u20:Play()
            end
            game.ReplicatedStorage.Util.Swim.Submerge:GetChildren()[math.random(1, #game.ReplicatedStorage.Util.Swim.Submerge:GetChildren())]:Play()
        end
    end,
    [false] = function() --[[ Line: 175 ]]
        --[[
        Upvalues:
            [1] = u42
            [2] = u2
            [3] = u36
            [4] = u35
            [5] = u40
            [6] = u20
        --]]
        if u42 ~= false then
            u42 = false
            u2:Create(u36, TweenInfo.new(0.25), {
                ["Brightness"] = 0,
                ["Contrast"] = 0,
                ["Saturation"] = 0,
                ["TintColor"] = Color3.new(1, 1, 1)
            }):Play()
            u2:Create(u35, TweenInfo.new(0.25), {
                ["Size"] = 0
            }):Play()
            u40:StopSustained(1)
            u20:Stop()
            warn("stop embetge")
        end
    end
}
v44[false]()
local function u47() --[[ Line: 209 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u11
        [3] = u10
    --]]
    local v45 = u1.Events.swim
    local v46 = _G.clientimpacts[u1.ClientImpacts.WaterSplash]
    pcall(v46.start, v46, {
        ["cf"] = u11.CFrame,
        ["char"] = u10
    })
    v45:FireServer("splash", u11.CFrame)
end
local u48 = false
local u49 = 0
local function v51() --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u14
        [3] = u19
        [4] = u11
        [5] = u30
        [6] = u33
        [7] = u5
        [8] = u49
        [9] = u47
        [10] = u22
    --]]
    if u12.MoveDirection.Magnitude > 0 then
        u14.Swim:Play()
    end
    u19 = os.clock()
    u14.Idle:Play()
    _G.swimming = true
    local v50 = _G.getWavePosition(u11.Position)
    u30 = u11.Position.Y - v50
    pcall(function() --[[ Line: 232 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u5
        --]]
        u33.Parent = u5.UpperTorso
    end)
    if u11.Position.Y > v50 - 5 and tick() - u49 >= 0.1 then
        u47()
        u49 = tick()
    end
    u22:Stop()
end
local function v54(p52) --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u33
        [3] = u7
        [4] = u37
        [5] = u48
        [6] = u21
        [7] = u22
        [8] = u20
    --]]
    u14.Idle:Stop()
    if p52 == nil then
        _G.swimming = false
    end
    u33.MaxForce = Vector3.new(0, 0, 0)
    pcall(function() --[[ Line: 250 ]]
        --[[
        Upvalues:
            [1] = u33
        --]]
        u33.Parent = script
    end)
    for _, v53 in u14 do
        v53:Stop()
    end
    u7.Swim.Drown:Stop()
    u37.Parent = nil
    u48 = false
    u21:Stop()
    u22:Stop()
    u20:Stop()
end
local function v59(_) --[[ Line: 268 ]]
    --[[
    Upvalues:
        [1] = u37
        [2] = u7
        [3] = u14
        [4] = u5
        [5] = u10
        [6] = u19
        [7] = u11
        [8] = u18
        [9] = u31
        [10] = u4
        [11] = u48
    --]]
    local function v55() --[[ Line: 270 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u7
            [3] = u14
            [4] = u5
        --]]
        u37.ImageLabel.ImageColor3 = Color3.fromRGB(154, 154, 154)
        if u7.Swim.Drown.IsPlaying or u14.Drown.IsPlaying then
            u7.Swim.Drown:Stop()
            u14.Drown:Stop()
        end
        u5:SetAttribute("isDrowning", nil)
    end
    if u10:GetAttribute("underWater") == nil then
        u37.Parent = nil
        u19 = os.clock()
        v55()
        return
    else
        u37.Parent = u11
        if u18.Value ~= "" and (_G.isCustomHUB == false and u31 ~= 100) then
            local _ = _G.playerFruitPassiveEnabled(u4) == false
        end
        local _ = _G.isCustomHUB == true
        local v56 = u10:GetAttribute("timeUntilDrown")
        local v57 = u10:GetAttribute("maxUnderwater")
        if v56 == nil or v57 == nil then
            v55()
            return
        else
            local v58 = v56 / v57
            u37.ImageLabel.Frame.Size = UDim2.new(1, 0, v58, 0)
            u37.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v58, 0)
            if v58 <= 0 and (v56 ~= nil and (v57 ~= nil and (u5:FindFirstChild("iFrame") == nil and u5:FindFirstChild("GrabTag") == nil))) then
                u48 = true
                u37.ImageLabel.ImageColor3 = Color3.new(1, 0, 0)
                if not u14.Drown.IsPlaying then
                    u7.Swim.Drown:Play()
                    u14.Drown:Play()
                end
                u5:SetAttribute("isDrowning", true)
            else
                v55()
            end
        end
    end
end
local u60 = 0
local function v68() --[[ Line: 324 ]]
    --[[
    Upvalues:
        [1] = u60
        [2] = u14
        [3] = u12
        [4] = u11
        [5] = u33
        [6] = u29
        [7] = u30
        [8] = u10
        [9] = u5
    --]]
    if u60 == 0 then
        if u14.Dive.IsPlaying or u14.Down.IsPlaying then
            u14.Dive:Stop()
            u14.Down:Stop()
        end
        if u12.MoveDirection.Magnitude > 0 then
            if not u14.Swim.IsPlaying then
                u14.Swim:Play()
            end
        else
            u14.Swim:Stop()
        end
    else
        if u14.Swim.IsPlaying then
            u14.Swim:Stop()
        end
        local v61 = u60 > 0 and "Dive" or "Down"
        local v62 = u14[v61]
        if not v62.IsPlaying then
            u14.Dive:Stop()
            u14.Down:Stop()
            if v61 == "Down" and u12.FloorMaterial == Enum.Material.Air then
                v62:Play()
            elseif v61 == "Dive" then
                v62:Play()
            end
        end
    end
    local v63 = u12.HipHeight + u11.Size.Y / 2 + 1
    local v64, _, _ = _G.getRayFloor(u11.CFrame, v63)
    if v64 or u12.SeatPart ~= nil then
        for v65, v66 in u14 do
            if v65 ~= "Drown" then
                v66:Stop()
            end
        end
        u33.MaxForce = Vector3.new(0, 0, 0)
        u33.Position = u11.Position
        u29 = true
        _G.swimming = true
    else
        u33.MaxForce = Vector3.new(0, 1000000, 0)
        if u29 then
            u29 = false
            u30 = u11.Position.Y - _G.getWavePosition(u11.Position)
            if u14.Idle.IsPlaying == false then
                u14.Idle:Play()
            end
        end
    end
    if u33.MaxForce == Vector3.new(0, 0, 0) or _G.swimming ~= true then
        if _G.swimming == true and u29 == false then
            u33.MaxForce = Vector3.new(0, 1000000, 0)
        end
    else
        local v67 = u10.PrimaryPart:FindFirstChildWhichIsA("BodyVelocity")
        if v67 and (v67:GetAttribute("LetSwim") == nil and _G.check:inspect(u5) == true) or (u10.PrimaryPart:FindFirstChildWhichIsA("VectorForce") or u10.PrimaryPart:FindFirstChildWhichIsA("LinearVelocity")) then
            u33.MaxForce = Vector3.new(0, 0, 0)
            return
        end
    end
end
local v69 = u60
local function v72() --[[ Line: 416 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v70 = workspace.Islands:FindFirstChild("Fishman Island")
    if v70 and (not v70 or v70:FindFirstChild("Shield")) then
        local v71 = u10:FindFirstChild("HumanoidRootPart")
        if v71 then
            return (v70.Shield.Position - v71.Position).Magnitude <= v70.Shield.Mesh.Scale.X
        else
            return false
        end
    else
        return false
    end
end
while true do
    if not task.wait(0.016666666666666666) then
        return
    end
    local v73 = _G.getWavePosition(u11.Position)
    local v74 = u11.Position + Vector3.new(0, 1, 0) * (_G.swimming and -1 or 1)
    local v75
    if v73 == nil then
        v75 = _G.getWavePosition(u11.Position)
    else
        v75 = v73
    end
    local v76 = v74.Y < v75
    local v77 = u28.CFrame.Position
    if v73 == nil then
        v73 = _G.getWavePosition(u11.Position)
    end
    CameraIsSubmerged = v77.Y < v73
    if not v76 then
        break
    end
    local v78
    if u18.Value == "" or (u31 == 100 or _G.playerFruitPassiveEnabled(u4) ~= true) then
        v78 = false
    else
        v78 = _G.isCustomHUB == false
    end
    local v79 = string.match(v17.Customization.Race.Value, "Fishman") and (v78 == false and (u5:FindFirstChild("inCombat") == nil and 50 or 30) or 25) or 25
    if v72() == true then
        if _G.swimming == true then
            v54()
        end
        local v80 = v25.Mesh
        local v81 = workspace.Env.WaterStuff.SandLayer2.Position.Y - v25.Position.Y
        v80.Offset = Vector3.new(0, v81, 0)
        u40:StopSustained(1)
        u20:Stop()
    else
        local v82 = v25.Mesh
        local v83 = v25.Size.Y / 2
        v82.Offset = Vector3.new(0, v83, 0)
        if _G.swimming == false then
            v51()
        end
        v68()
        local v84 = v26:GetMoveVector()
        local v85 = _G.getWavePosition(u11.Position)
        local v86 = u11.Position.Y <= v85 and v85 and v85 or _G.SeaLevel
        local v87 = v6:IsKeyDown(Enum.KeyCode.Space) or _G.swimmingAscension
        local v88 = v6:IsKeyDown(Enum.KeyCode.LeftControl) or _G.swimmingDecension
        local v89 = not v78
        if v89 then
            v89 = (v87 and 1 or 0) + (v88 and -1 or 0)
        end
        local v90 = v78 == true and -1 or v89
        local v91 = u30 + (workspace:Raycast(u11.Position, Vector3.new(0, 1, 0) * v90 * (u12.HipHeight + u11.Size.Y * 0.5), v24) and 0 or (v69 or 0))
        if u5:FindFirstChild("geppo", true) or _G.canuse == false and v78 == false then
            u60 = 0
            v91 = u11.Position.Y - v86
            u33.Position = u11.Position
            v69 = u60
            u30 = v91
        else
            u60 = v90 * v79 * 0.016666666666666666
            u33.Position = Vector3.new(0, 1, 0) * (v86 + v91)
            v69 = u60
            u30 = v91
        end
        if v84.Magnitude > 0 and u29 == false then
            if u11.Position.Y >= v86 - 4 then
                if u21.Playing == false then
                    u21:Play()
                end
                if u22.Playing == true then
                    u22:Stop()
                end
            else
                if u21.Playing == true then
                    u21:Stop()
                end
                if u22.Playing == false then
                    u22:Play()
                end
            end
        else
            if u21.Playing then
                u21:Stop()
            end
            if u22.Playing then
                u22:Stop()
            end
        end
        if v86 <= u30 - 4 then
            game.ReplicatedStorage.Util.Swim.Swimming:Stop()
            if game.ReplicatedStorage.Util.Swim.SwimmingUnder.IsPlaying == false then
                game.ReplicatedStorage.Util.Swim.SwimmingUnder:Play()
            end
        end
        v59()
        if v87 then
            local v92
            if v86 - 1 < u11.Position.Y then
                v92 = #workspace:GetPartBoundsInBox(CFrame.new(u11.Position + Vector3.new(0, 1, 0)), Vector3.new(1, 1, 1), v23) == 0
            else
                v92 = false
            end
            if v92 then
                v54()
                u11.AssemblyLinearVelocity = Vector3.new(0, 75, 0)
                local _ = os.clock()
                u7.Swim.Jumps:GetChildren()[math.random(#u7.Swim.Jumps:GetChildren())]:Play()
                u14.Jump:Play()
                u47()
            end
        end
        ::l92::
        v3.AmbientReverb = Enum.ReverbType[CameraIsSubmerged and "UnderWater" or "NoReverb"]
        v44[CameraIsSubmerged]()
        local v93 = u11.Position
        local v94 = v93.X
        local v95 = v25.Position.Y
        local v96 = v93.Z
        if (Vector3.new(v94, v95, v96) - v25.Position).Magnitude >= 400 then
            v25.CFrame = CFrame.new(v93.X, v25.Position.Y, v93.Z)
        end
    end
end
if _G.swimming == true then
    u60 = 0
    v54()
    u11.AssemblyLinearVelocity = Vector3.new()
    v69 = u60
end
u33.Position = u11.Position
goto l92