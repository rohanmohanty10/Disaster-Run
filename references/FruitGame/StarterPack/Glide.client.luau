 

local _, u1, u2, _, u3 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u4 = game:GetService("RunService")
local u5 = game:GetService("HttpService")
local u6 = game.ReplicatedStorage
local u7 = u1.Humanoid:LoadAnimation(u6.Util.Glide.Glide)
local u8 = u6.Events.glide
local u9 = nil
local u10 = {}
local u11 = false
_G.canGlide = true
local function u21() --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v12 = u1.HumanoidRootPart.CFrame
    local v13 = workspace.Env.WaterStuff.Falls
    local v14 = workspace.Env.WaterStuff.Sand
    if v12.Y <= v13.Position.Y and v12.Y > v14.Position.Y then
        return true
    end
    local v15 = u1.Humanoid.HipHeight * 3
    local v16 = CFrame.new(v12.p)
    local v17 = Ray.new(v16.p, v16.upVector * -v15)
    local v18, _, _ = _G.raycastWhitelist(v17, { workspace.Islands, workspace.Ships, workspace.Env })
    if v18 and v18.CanCollide == true or v18 and v18.Name == "gravRock" then
        return true
    end
    local v19 = Ray.new(v12.p, v12.LookVector * v15)
    local v20, _, _ = _G.raycastWhitelist(v19, { workspace.Islands, workspace.Ships, workspace.Env })
    return (v20 and v20.CanCollide == true or v20 and v20.Name == "gravRock") and true or false
end
local function u23(p22) --[[ Line: 77 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    if p22 then
        return false
    elseif _G.canGlide == true then
        if _G.canuse == true then
            if _G.check:inspect(u1) == true then
                if u3.Skills.SkypianFlight.Value == true then
                    return u3.Customization.Race.Value:match("Skypian") ~= nil
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end
local function u65() --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u1
        [4] = u2
        [5] = u21
        [6] = u11
        [7] = u4
        [8] = u7
        [9] = u8
        [10] = u6
        [11] = u10
    --]]
    local v24 = u5:GenerateGUID(true)
    u9 = v24
    if u1.HumanoidRootPart:FindFirstChild("geppo") then
        return
    end
    if u9 ~= v24 then
        return
    end
    if u2:IsKeyDown(Enum.KeyCode.Space) == false or u21() == true then
        return
    end
    local v25 = tick()
    u11 = true
    repeat
        u4.Heartbeat:Wait()
    until u2:IsKeyDown(Enum.KeyCode.Space) == true and u1.HumanoidRootPart:FindFirstChild("geppo") == nil
    if u21() == true then
        u11 = false
        return
    end
    u7:Play()
    _G.canuse = false
    local u26 = nil
    u26 = u2.InputEnded:Connect(function(p27, _) --[[ Line: 137 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        if p27.KeyCode == Enum.KeyCode.Space then
            u26:Disconnect()
            u26 = nil
        end
    end)
    local u28 = nil
    task.spawn(function() --[[ Line: 145 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u8
        --]]
        u28 = u8:InvokeServer()
    end)
    local v29 = Instance.new("BodyVelocity")
    v29.MaxForce = Vector3.new(inf, inf, inf)
    v29.Velocity = Vector3.new(0, -5, 0)
    v29.Parent = u1.HumanoidRootPart
    v29.Name = "geppo"
    local v30 = workspace.CurrentCamera
    local v31 = u1.HumanoidRootPart.Velocity.magnitude / 2
    local v32 = math.abs(v31) + 10
    local v33 = math.clamp(v32, 1, 150)
    tick()
    local v34 = u1.HumanoidRootPart.CFrame
    u1.Humanoid.PlatformStand = true
    local v35 = tick()
    local v36 = _G.PlaySound(u1.Head, u6.Util.Glide.start)
    _G.tween(v36, {
        6,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Volume"] = 0
    })
    local v37 = u6.Util.Glide.loop:Clone()
    v37.Parent = u1.Head
    v37:Play()
    local v38 = v33 / 12 + 5
    _G.PlayEffect("GlideTrail", nil, nil, u1, v29)
    local v39 = u26
    local v40 = 0
    while true do
        local v41 = tick() - v35
        v35 = tick()
        u1.Humanoid.PlatformStand = true
        u1.Humanoid.AutoRotate = false
        local v42 = v34:Lerp(v30.CoordinateFrame, 0.05)
        local v43 = v42.lookVector * v33
        local v44 = v43.Y / 50
        math.clamp(v44, -10, 0.4)
        u1.HumanoidRootPart.RotVelocity = Vector3.new()
        local v45 = 1 - (tick() - v25) / v38
        local v46 = math.clamp(v45, 0, 1)
        local v47 = v43.Y * (1 + (1 - v30.CoordinateFrame.YVector.Y) + v40)
        if v30.CoordinateFrame.YVector.Y < 0.6 then
            v40 = v40 + v41
        else
            local v48 = v40 - v41
            v40 = math.clamp(v48, 0, (1 / 0))
        end
        local v49 = u1.Humanoid.Health / u1.Humanoid.MaxHealth
        local v50 = v29.Velocity
        local v51 = v43.X * v46
        local v52 = math.clamp(v47, -5000, 2)
        local v53 = v43.Z * v46
        v29.Velocity = v50:Lerp(Vector3.new(v51, v52, v53), 1) * math.clamp(v49, 0.1, 1)
        local _, _, _, v54, v55, v56, v57, v58, v59, v60, v61, v62 = v42:components()
        local v63 = u1.HumanoidRootPart.CFrame
        u1.HumanoidRootPart.CFrame = CFrame.new(v63.x, v63.y, v63.z, v54, v55, v56, v57, v58, v59, v60, v61, v62)
        v34 = CFrame.new(v63.x, v63.y, v63.z, v54, v55, v56, v57, v58, v59, v60, v61, v62)
        local v64 = v29.Velocity.Magnitude
        v37.Pitch = v64 / 40
        v37.Volume = 0.5 + v64 / 40
        u7:AdjustSpeed(v64 / 25)
        _G.canuse = false
        if v64 < 5 or (u1.Parent ~= workspace.PlayerCharacters or (u1:FindFirstChild("Stun") or (v38 <= tick() - v25 or (u1:GetAttribute("flyMode") or u1:FindFirstChild("Blocking"))))) then
            break
        end
        u4.Stepped:Wait()
        if u21() == true or v39 == nil then
            break
        end
    end
    if v36 and v36.Parent ~= nil then
        _G.tween(v36, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v36, 0.25)
    end
    if v37 and v37.Parent ~= nil then
        _G.tween(v37, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v37, 1)
    end
    u1.Humanoid.PlatformStand = false
    u1.Humanoid.AutoRotate = true
    table.clear(u10)
    v29:Destroy()
    _G.canuse = true
    u7:Stop()
    task.spawn(function() --[[ Line: 255 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        task.wait(3)
        u11 = false
    end)
    repeat
        u4.Heartbeat:Wait()
    until u28 ~= nil
    if u28 then
        u8:InvokeServer(u28)
    end
end
u2.InputBegan:Connect(function(p66, p67) --[[ Line: 269 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u21
        [3] = u11
        [4] = u65
    --]]
    if p66.KeyCode == Enum.KeyCode.Space then
        if u23(p67) then
            if u21() == false and u11 == false then
                u65()
            end
        end
    else
        return
    end
end)