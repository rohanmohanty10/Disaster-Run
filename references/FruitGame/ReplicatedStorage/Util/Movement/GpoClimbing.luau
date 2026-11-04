 

local u1 = {}
u1.__index = u1
local u2 = require(script.ConfigReader)
local u3 = require(game.ReplicatedStorage.Modules.ScriptSet)
local u4 = require(game.ReplicatedStorage.Modules.FastWait)
local u5 = require(game.ReplicatedStorage.Modules.MaidClass)
local u6 = game:GetService("RunService")
local v7 = game.Players.LocalPlayer
local u8 = require(v7.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local u9 = {
    ["diameter"] = 120,
    ["padding"] = 4,
    ["count"] = 64,
    ["size"] = 1024
}
local u10, _, u11, u12 = u3.get()
local u13 = { workspace.Islands, workspace.Ships, workspace.Env }
local function u20(p14) --[[ Line: 27 ]]
    local v15 = p14.normal
    local v16 = p14.position
    local v17 = p14.object
    local v18 = (Vector3.new(0, 1, 0)):Cross(v15).Unit
    local v19 = v15:Cross(v18).Unit
    return v17.CFrame:inverse() * CFrame.new(v16.x, v16.y, v16.z, v18.x, v19.x, v15.x, v18.y, v19.y, v15.y, v18.z, v19.z, v15.z)
end
local function u23(p21) --[[ Line: 45 ]]
    local v22, _, _ = _G.raycastWhitelist(p21, {
        workspace.Islands,
        workspace.Env,
        workspace.Ships,
        workspace.Jails
    })
    return v22
end
local function u28(p24, p25) --[[ Line: 65 ]]
    local v26 = p24:GetChildren()
    for v27 = 1, #v26 do
        if v26[v27]:IsA("BasePart") then
            v26[v27].CollisionGroup = p25
        end
    end
end
function u1.setup(_, _) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u11
        [3] = u12
        [4] = u3
        [5] = u5
        [6] = u2
        [7] = u9
        [8] = u1
        [9] = u6
        [10] = u23
        [11] = u4
    --]]
    local v29, v30, v31, v32 = u3.get()
    u10 = v29
    u11 = v31
    u12 = v32
    local u33 = v30
    local u34 = u33:WaitForChild("HumanoidRootPart")
    local v35 = u5.new()
    local u36 = {
        ["Part"] = nil,
        ["AO"] = script.AlignOrientation:Clone(),
        ["AP"] = script.AlignPosition:Clone(),
        ["Attachment"] = Instance.new("Attachment"),
        ["char"] = u33
    }
    u36.AP.Parent = u34
    u36.AO.Parent = u34
    u36.AP.Attachment0 = u34.ClimbCenter
    u36.AO.Attachment0 = u34.ClimbCenter
    u36.Enabled = false
    u36.Anims = {
        ["Up"] = u33.Humanoid:LoadAnimation(script.Up),
        ["Left"] = u33.Humanoid:LoadAnimation(script.Left),
        ["Right"] = u33.Humanoid:LoadAnimation(script.Right),
        ["Down"] = u33.Humanoid:LoadAnimation(script.Down)
    }
    u36.fakepart = nil
    u36.currentdirection = {
        ["Up"] = false,
        ["Down"] = false,
        ["Right"] = false,
        ["Left"] = false
    }
    u36.AlreadyStopped = false
    u36.prenor = nil
    u36.ledge = false
    u36.bill = script.BillboardGui:Clone()
    u36.bill.ImageLabel.ImageLabel.ImageRectSize = Vector2.new(u2.GetSize(u9))
    u36.connection = nil
    u36.LengthScan = 2 + u33.PrimaryPart.Size.Y * 2
    u36.serverClimbGrace = 0
    u36.climbingtime = 20
    v35:AttachToInstance(u33.PrimaryPart)
    local v37 = u1
    setmetatable(u36, v37)
    for _, v38 in pairs(u36.Anims) do
        v38.Looped = true
    end
    local function u40() --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        for _, v39 in pairs(u36.Anims) do
            if v39.IsPlaying == true then
                v39:Stop()
                v39.Looped = true
                v39:AdjustSpeed(0)
            end
        end
    end
    local u41 = tick()
    local u42 = 0
    local u43 = Vector2.new
    local u44 = {
        ["Rain"] = true,
        ["Snow"] = true
    }
    local u45 = {
        ["Rain"] = 0.05,
        ["Snow"] = 0.06
    }
    v35:GiveTask(u6.RenderStepped:Connect(function(p46) --[[ Line: 143 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u40
            [3] = u41
            [4] = u43
            [5] = u2
            [6] = u9
            [7] = u44
            [8] = u34
            [9] = u45
            [10] = u23
            [11] = u33
            [12] = u42
            [13] = u4
        --]]
        if u36.Attachment then
            local v47 = u36.Attachment.Position.Y
            if v47 ~= v47 then
                u36.Attachment:Destroy()
                u36.Attachment = Instance.new("Attachment")
            end
        end
        if u36.Enabled == false then
            u40()
            u36.climbingtime = u36.climbingtime + p46
            if u36.climbingtime >= 20 then
                u36.climbingtime = 20
                u36.bill.Parent = nil
            end
            u41 = tick()
        else
            u36.climbingtime = u36.climbingtime - p46
            u41 = tick()
            if u36.climbingtime <= 0 then
                u36.climbingtime = 0
                warn("stopped because ran out of time")
                u36:stop()
            end
        end
        local v48 = u36.climbingtime / 20
        local v49 = u36.bill.ImageLabel.ImageLabel
        v49.ImageRectSize = u43(u2.GetSize(u9))
        local v50 = v48 * 64
        v49.ImageRectOffset = u43(u2.GetOffset(u9, v50))
        v49.ImageColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(85, 255, 127), v48)
        if u36.Enabled == true then
            local v51 = workspace.Islands:FindFirstChild(_G.currentisland)
            if v51 and u44[v51.Settings.Weather.Value] then
                local v52 = u34.CFrame
                local _ = u45[v51.Settings.Weather.Value]
                if u23(Ray.new(v52.p, v52.upVector * -(u33.Humanoid.HipHeight * 2))) == nil and tick() - u42 >= u4() then
                    u42 = tick()
                end
            end
            u36:step()
        end
        if u36.Part ~= nil and u36.Part:IsDescendantOf(workspace) == false then
            warn("stopped nil part")
            u36:stop()
        end
    end))
    return u36
end
function u1.step(p53) --[[ Line: 197 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u23
        [3] = u13
        [4] = u20
        [5] = u28
    --]]
    local u54 = p53.char
    if u54.PrimaryPart == nil then
        return
    end
    local v55 = u54.HumanoidRootPart.CFrame
    if p53.Enabled == true then
        p53.AP.Enabled = true
        p53.AO.Enabled = true
    end
    if p53.Enabled == false then
        warn("stopped enabled = false")
        p53:stop()
        return
    end
    if u54:FindFirstChild("Stun") and p53.Enabled == true then
        warn("stopped stun")
        p53:stop()
        return
    end
    if u54.PrimaryPart == nil then
        return
    end
    local v56 = u54.HumanoidRootPart
    local v57 = u8:GetMoveVector()
    local v58 = v57.X
    local v59 = math.abs(v58)
    local v60 = v57.Y
    local v61 = math.abs(v60)
    local v62 = v57.Z
    local v63 = math.abs(v62)
    local v64
    if v61 <= v59 and v63 <= v59 then
        v64 = v57.X > 0 and "Right" or "Left"
        v63 = v59
    elseif v59 <= v63 and v61 <= v63 then
        v64 = v57.Z > 0 and "Down" or "Up"
    else
        v64 = "Up"
        v63 = 0
    end
    if p53.Enabled == true and (v64 == "Down" and (p53.Part ~= nil and u23(Ray.new(v55.p, v55.upVector * -(u54.Humanoid.HipHeight * 2))) ~= nil)) then
        warn("stopped part below")
        p53:stop()
        return
    end
    if not p53.Anims[v64].IsPlaying then
        for _, v65 in pairs(p53.Anims) do
            v65:Stop()
        end
        p53.Anims[v64]:Play()
    end
    p53.Anims[v64]:AdjustSpeed(v63)
    local v66 = v56.Size.Y * 0.5 + u54.Humanoid.HipHeight
    local u67 = u54.PrimaryPart.Position
    local function v75(p68) --[[ Line: 249 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u67
        --]]
        local v69 = p68.X < 0 or (p68.Y < 0 or p68.Z < 0)
        local v70 = (u54.PrimaryPart.CFrame * p68).Position
        local v71 = (v70 - u67).Magnitude
        local v72 = Ray.new(u67, (v70 - u67).Unit * -v71)
        local _, v73 = workspace:FindPartOnRayWithWhitelist(v72, { workspace.Islands, workspace.Ships, workspace.Env })
        local v74 = (u67 - v73).Magnitude
        if v74 ~= v74 then
            return 0
        end
        if v69 == true then
            v74 = v74 * -1
        end
        return v74
    end
    local v76 = v56.CFrame * CFrame.new(v75(CFrame.new(v57.X, 0, 0)), v75(CFrame.new(0, -v57.Z, 0)), 0)
    local v77 = Ray.new(v76.Position, v76.LookVector * 3)
    local v78 = _G.raycastWhitelist(v77, { workspace.Islands, workspace.Ships, workspace.Env })
    if v78 == nil then
        local v79 = { 0.5, -0.5, 1 }
        for v80 = 1, #v79 do
            local v81 = v76 * CFrame.new(0, v79[v80], 0)
            local v82 = Ray.new(v81.Position, v81.LookVector * 3)
            v78 = _G.raycastWhitelist(v82, { workspace.Islands, workspace.Ships, workspace.Env })
            if v78 then
                v77 = v82
                break
            end
        end
    end
    local v83 = Ray.new(v56.Position, v56.CFrame.RightVector * v57.X)
    local v84 = _G.raycastWhitelist(v83, u13)
    local v85 = v56.Size.Z * 0.5 + 0.5
    local v86 = v56.Position - v56.CFrame.LookVector * v85
    local v87 = v56.CFrame.UpVector * -v57.Z * v66 + v56.CFrame.RightVector * v57.X * 0.5
    local v88 = Ray.new(v86, v87)
    local v89, _, v90 = _G.raycastWhitelist(v88, { workspace.Islands, workspace.Ships, workspace.Env })
    if v89 and v89.CanCollide == true then
        local v91 = p53.prenor
        if v91 then
            if v90 then
                v90 = v90:Dot(-p53.prenor) > 0.7
            end
        else
            v90 = v91
        end
        if not v90 then
            return
        end
    end
    if v84 then
        v77 = v83
    elseif not v78 then
        local v92 = v56.CFrame * CFrame.new(v75(CFrame.new(v57.X, 0, 0)), 0, (v75(CFrame.new(0, 0, -1))))
        v77 = Ray.new(v92.Position, v92.RightVector * -v57.X * 3)
        if _G.raycastWhitelist(v77, { workspace.Islands, workspace.Ships, workspace.Env }) == nil then
            local v93 = { 0.5, -0.5 }
            for v94 = 1, #v93 do
                local v95 = v92.Position + v56.CFrame.UpVector * v93[v94]
                local v96 = Ray.new(v95, v92.RightVector * -v57.X * 3)
                if _G.raycastWhitelist(v96, { workspace.Islands, workspace.Ships, workspace.Env }) then
                    v77 = v96
                    break
                end
            end
        end
    end
    local u97, v98, v99 = _G.raycastWhitelist(v77, { workspace.Islands, workspace.Ships, workspace.Env })
    if u97 == nil and p53.Part ~= nil then
        local v100 = {
            0.5,
            -0.5,
            1,
            -1
        }
        for v101 = 1, #v100 do
            local v102 = v77.Origin + v56.CFrame.UpVector * v100[v101]
            local v103 = Ray.new(v102, v77.Direction)
            u97, v98, v99 = _G.raycastWhitelist(v103, { workspace.Islands, workspace.Ships, workspace.Env })
            if u97 then
                break
            end
        end
    end
    local v104 = u54.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
    local v105 = Ray.new(v104.p, v104.lookVector * 4)
    local v106, _, _ = _G.raycastWhitelist(v105, u13)
    if v106 == nil then
        local v107 = u54.HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0)
        local v108 = Ray.new(v107.p, v107.lookVector * 4)
        local v109, v110
        v106, v109, v110 = _G.raycastWhitelist(v108, u13)
    end
    if u97 and u97.CollisionGroup:match("Barrier") then
        warn("stopped barrier poart")
        p53.AlreadyStopped = false
        p53:stop()
        return
    elseif p53.Part and p53.Part.CollisionGroup:match("Barrier") then
        warn("stopped barrier poart 2")
        p53.AlreadyStopped = false
        p53:stop()
        return
    elseif p53.Part == nil or (v106 ~= nil or p53.Part.Transparency == 1) then
        if (p53.Part == nil or p53.Part.Parent ~= nil) and (p53.Part == nil or p53.Part.Transparency ~= 1) then
            if p53.Enabled == false then
                p53:stop()
                warn("not enabled so ret")
                return
            else
                p53.bill.Parent = u54.HumanoidRootPart
                u54.Humanoid.AutoRotate = false
                if u97 and p53.Enabled == true then
                    p53.Attachment.WorldPosition = v98
                    local v111 = p53.Part
                    p53.Part = u97
                    if p53.Part == u97 and p53.prenor == v99 then
                        return
                    end
                    local v112
                    if v111 == nil or (v111 == u97 or p53.prenor == nil) then
                        v112 = v99
                    else
                        v112 = p53.prenor:Lerp(v99, 0.5)
                    end
                    p53.prenor = v99
                    u54.Humanoid.AutoRotate = false
                    u54.Humanoid.Sit = true
                    if p53.Attachment == nil then
                        p53.Attachment = Instance.new("Attachment")
                    end
                    local v113 = p53.AP
                    local v114 = p53.AO
                    local u115 = p53.Attachment
                    v113.Attachment1 = u115
                    v114.Attachment1 = u115
                    pcall(function() --[[ Line: 54 ]]
                        --[[
                        Upvalues:
                            [1] = u97
                            [2] = u115
                        --]]
                        if u97 and u115 then
                            u115.Parent = u97
                        end
                    end)
                    p53.Attachment.CFrame = u20({
                        ["object"] = u97,
                        ["position"] = v98,
                        ["normal"] = v112
                    })
                    local v116 = p53.Attachment.CFrame.Y
                    if v116 ~= v116 then
                        p53.Attachment:Destroy()
                        p53.Attachment = Instance.new("Attachment")
                        warn("attachment destroyed")
                    end
                    u28(u54, "noclip")
                    if p53.Anims.Up.IsPlaying == false and p53.currentdirection.Up == true then
                        p53.Anims.Up:Play()
                        p53.Anims.Up:AdjustSpeed(0)
                    end
                elseif u97 == nil or p53.Part ~= nil and p53.Part:IsDescendantOf(workspace) == false then
                    warn("stop climb because no eldge 2", p53.Enabled, u97, p53.Part)
                    p53.AlreadyStopped = false
                    p53:stop()
                    return
                end
                if u54:GetAttribute("ServerClimb") == nil then
                    p53.serverClimbGrace = p53.serverClimbGrace + 1
                    if p53.serverClimbGrace >= 5 then
                        p53.serverClimbGrace = 0
                        p53.AlreadyStopped = false
                        warn("stop because too server not valid")
                        p53:stop()
                    end
                else
                    p53.serverClimbGrace = 0
                    if v99 then
                        local v117 = v99:Dot(Vector3.new(0, 1, 0))
                        if v117 >= 0.75 or v117 <= -0.75 then
                            warn("stop because too steep")
                            p53.AlreadyStopped = false
                            p53:stop()
                        end
                    end
                    u54 = game.Players.LocalPlayer.Character
                    return
                end
            end
        else
            warn("stop climb because no eldge")
            p53.AlreadyStopped = false
            p53:stop()
            return
        end
    else
        local _ = u54.HumanoidRootPart.Position.Y
        local _ = p53.Part.Size.Y / 2 + p53.Part.Position.Y - 2
        local v118 = Ray.new(u54.Head.Position + (Vector3.new(0, 1, 0)):Cross(u54.Head.CFrame.RightVector) * 3 + Vector3.new(0, 1, 0), Vector3.new(0, 1, 0) * -v66 * 2)
        if _G.raycastWhitelist(v118, u13) and p53.ledge == false then
            p53:stop()
            p53.ledge = true
            u54.Humanoid:LoadAnimation(script.Ledge):Play()
            local v119 = Instance.new("BodyVelocity")
            v119.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            v119.Velocity = u54.HumanoidRootPart.CFrame.upVector * 5
            v119.Parent = u54.HumanoidRootPart
            p53.Enabled = false
            u54.Humanoid.AutoRotate = false
            task.wait(1)
            u54.Humanoid.AutoRotate = true
            v119:Destroy()
            p53.Enabled = false
            p53.ledge = false
        end
        if p53.Part then
            warn("eldge detect?", p53.Part:GetFullName(), p53.Part.CollisionGroup)
        else
            warn("ledge detected no part")
        end
        p53.AlreadyStopped = false
        p53:stop()
        return
    end
end
function u1.stop(p120) --[[ Line: 522 ]]
    --[[
    Upvalues:
        [1] = u28
    --]]
    if p120.AlreadyStopped ~= true then
        local v121 = p120.char
        p120.Enabled = false
        p120.Part = nil
        p120.prenor = Vector3.new(2, 2, 2)
        p120.Attachment.Parent = v121.HumanoidRootPart
        local v122 = p120.AP
        local v123 = p120.AO
        v122.Attachment1 = nil
        v123.Attachment1 = nil
        local u124 = nil
        local u125 = nil
        pcall(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u124
                [2] = u125
            --]]
            if u124 and u125 then
                u125.Parent = u124
            end
        end)
        p120.AP.Enabled = false
        p120.AO.Enabled = false
        _G.canuse = true
        v121.Humanoid.Sit = false
        p120.AlreadyStopped = true
        p120.serverClimbGrace = 0
        v121.Humanoid.AutoRotate = true
        u28(v121, "Players")
        v121.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        v121.PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        task.spawn(function() --[[ Line: 553 ]]
            game.ReplicatedStorage.Events.climb:InvokeServer(false)
        end)
        warn("actually stopped")
    end
end
return u1