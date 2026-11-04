 

local u1 = {}
local u2 = require(script.ConfigReader)
u1.__index = u1
local u3 = {
    ["diameter"] = 120,
    ["padding"] = 4,
    ["count"] = 64,
    ["size"] = 1024
}
local u4 = require(game.ReplicatedStorage.Modules.ScriptSet)
game:GetService("PhysicsService")
local u5, _, u6, u7 = u4.get()
local u8 = require(game.ReplicatedStorage.Modules.FastWait)
local v9 = game.Players.LocalPlayer
local v10 = require(v9.PlayerScripts:WaitForChild("PlayerModule"))
local u11 = require(game.ReplicatedStorage.Modules.MaidClass)
local u12 = v10:GetControls()
local function u19(p13) --[[ Line: 18 ]]
    local v14 = p13.normal
    local v15 = p13.position
    local v16 = p13.object
    local v17 = (Vector3.new(0, 1, 0)):Cross(v14).Unit
    local v18 = v14:Cross(v17).Unit
    return v16.CFrame:inverse() * CFrame.new(v15.x, v15.y, v15.z, v17.x, v18.x, v14.x, v17.y, v18.y, v14.y, v17.z, v18.z, v14.z)
end
local function u22(p20) --[[ Line: 35 ]]
    local v21, _, _ = _G.raycastWhitelist(p20, {
        workspace.Islands,
        workspace.Env,
        workspace.Ships,
        workspace.Jails
    })
    return v21
end
function u1.setup(_, _) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u7
        [4] = u4
        [5] = u11
        [6] = u2
        [7] = u3
        [8] = u1
        [9] = u22
        [10] = u8
    --]]
    local v23, v24, v25, v26 = u4.get()
    u5 = v23
    u6 = v25
    u7 = v26
    local u27 = v24
    local u28 = u27:WaitForChild("HumanoidRootPart")
    local v29 = u11.new()
    local u30 = {
        ["Part"] = nil,
        ["AO"] = script.AlignOrientation:Clone(),
        ["AP"] = script.AlignPosition:Clone(),
        ["Attachment"] = Instance.new("Attachment"),
        ["char"] = u27
    }
    u30.AP.Parent = u28
    u30.AO.Parent = u28
    u30.AP.Attachment0 = u28.ClimbCenter
    u30.AO.Attachment0 = u28.ClimbCenter
    u30.Enabled = false
    u30.Anims = {
        ["Up"] = u27.Humanoid:LoadAnimation(script.Up),
        ["Left"] = u27.Humanoid:LoadAnimation(script.Left),
        ["Right"] = u27.Humanoid:LoadAnimation(script.Right),
        ["Down"] = u27.Humanoid:LoadAnimation(script.Down)
    }
    u30.fakepart = nil
    u30.currentdirection = {
        ["Up"] = false,
        ["Down"] = false,
        ["Right"] = false,
        ["Left"] = false
    }
    u30.AlreadyStopped = false
    u30.prenor = nil
    u30.ledge = false
    u30.bill = script.BillboardGui:Clone()
    u30.bill.ImageLabel.ImageLabel.ImageRectSize = Vector2.new(u2.GetSize(u3))
    u30.connection = nil
    u30.LengthScan = 2 + u27.PrimaryPart.Size.Y * 2
    u30.climbingtime = 20
    v29:AttachToInstance(u27.PrimaryPart)
    local v31 = u1
    setmetatable(u30, v31)
    for _, v32 in u30.Anims do
        v32.Looped = true
    end
    local function u34() --[[ Line: 111 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        for _, v33 in u30.Anims do
            if v33.IsPlaying == true then
                v33:Stop()
                v33.Looped = true
                v33:AdjustSpeed(0)
            end
        end
    end
    local u35 = tick()
    local u36 = 0
    v29:GiveTask(game["Run Service"].RenderStepped:Connect(function(p37) --[[ Line: 125 ]]
        --[[
        Upvalues:
            [1] = u30
            [2] = u34
            [3] = u35
            [4] = u2
            [5] = u3
            [6] = u28
            [7] = u22
            [8] = u27
            [9] = u36
            [10] = u8
        --]]
        if u30.Attachment and u30.Attachment.Position.Y ~= u30.Attachment.Position.Y then
            u30.Attachment:Destroy()
            u30.Attachment = Instance.new("Attachment")
        end
        if u30.Enabled == false then
            u34()
            u30.climbingtime = u30.climbingtime + p37
            if u30.climbingtime >= 20 then
                u30.climbingtime = 20
                u30.bill.Parent = nil
            end
            u35 = tick()
        else
            u30.climbingtime = u30.climbingtime - p37
            u35 = tick()
            if u30.climbingtime <= 0 then
                u30.climbingtime = 0
                warn("stopped because ran out of time")
                u30:stop()
            end
        end
        local v38 = u30.climbingtime / 20
        local v39 = Vector2.new
        local v40 = u30.bill.ImageLabel.ImageLabel
        v40.ImageRectSize = v39(u2.GetSize(u3))
        local v41 = v38 * 64
        v40.ImageRectOffset = v39(u2.GetOffset(u3, v41))
        v40.ImageColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(85, 255, 127), v38)
        local v42 = {
            ["Rain"] = true,
            ["Snow"] = true
        }
        local v43 = {
            ["Rain"] = 0.05,
            ["Snow"] = 0.06
        }
        if u30.Enabled == true then
            if workspace.Islands:FindFirstChild(_G.currentisland) and v42[workspace.Islands:FindFirstChild(_G.currentisland).Settings.Weather.Value] then
                local v44 = u28.CFrame
                local _ = v43[workspace.Islands:FindFirstChild(_G.currentisland).Settings.Weather.Value]
                if u22(Ray.new(v44.p, v44.upVector * -(u27.Humanoid.HipHeight * 2))) == nil and tick() - u36 >= u8() then
                    u36 = tick()
                end
            end
            u30:step()
        end
        if u30.Part ~= nil and u30.Part:IsDescendantOf(workspace) == false then
            warn("stopped nil part")
            u30:stop()
        end
    end))
    return u30
end
local function u62(p45) --[[ Line: 205 ]]
    local v46 = p45.X
    local v47 = math.abs(v46)
    local v48 = p45.Y
    if math.abs(v48) <= v47 then
        local v49 = p45.X
        local v50 = math.abs(v49)
        local v51 = p45.Z
        if math.abs(v51) <= v50 then
            local v52 = p45.X > 0 and "Right" or "Left"
            local v53 = p45.X
            return v52, math.abs(v53)
        end
    end
    local v54 = p45.Z
    local v55 = math.abs(v54)
    local v56 = p45.X
    if math.abs(v56) <= v55 then
        local v57 = p45.Z
        local v58 = math.abs(v57)
        local v59 = p45.Y
        if math.abs(v59) <= v58 then
            local v60 = p45.Z > 0 and "Down" or "Up"
            local v61 = p45.Z
            return v60, math.abs(v61)
        end
    end
    return "Up", 0
end
local u63 = { workspace.Islands, workspace.Ships, workspace.Env }
function u1.step(p64) --[[ Line: 217 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u62
        [3] = u22
        [4] = u63
        [5] = u19
    --]]
    local u65 = p64.char
    if u65.PrimaryPart == nil then
        return
    else
        local v66 = u65.HumanoidRootPart.CFrame
        if p64.Enabled == true then
            p64.AP.Enabled = true
            p64.AO.Enabled = true
        end
        if p64.Enabled == false then
            warn("stopped enabled = false")
            p64:stop()
            return
        elseif u65:FindFirstChild("Stun") and p64.Enabled == true then
            warn("stopped stun")
            p64:stop()
            return
        elseif u65.PrimaryPart == nil then
            return
        else
            local v67 = u65.HumanoidRootPart
            local v68 = u12:GetMoveVector()
            local v69, v70 = u62(v68)
            if p64.Enabled == true and (v69 == "Down" and (p64.Part ~= nil and u22(Ray.new(v66.p, v66.upVector * -(u65.Humanoid.HipHeight * 2))) ~= nil)) then
                warn("stopped part below")
                p64:stop()
                return
            else
                if not p64.Anims[v69].IsPlaying then
                    for _, v71 in pairs(p64.Anims) do
                        v71:Stop()
                    end
                    p64.Anims[v69]:Play()
                end
                p64.Anims[v69]:AdjustSpeed(v70)
                local v72 = v67.Size.Y * 0.5 + u65.Humanoid.HipHeight
                local u73 = u65.PrimaryPart.Position
                local function v81(p74) --[[ Line: 269 ]]
                    --[[
                    Upvalues:
                        [1] = u65
                        [2] = u73
                    --]]
                    local v75 = p74.X < 0 or (p74.Y < 0 or p74.Z < 0)
                    local v76 = (u65.PrimaryPart.CFrame * p74).Position
                    local v77 = (v76 - u73).Magnitude
                    local v78 = Ray.new(u73, (v76 - u73).Unit * -v77)
                    local _, v79 = workspace:FindPartOnRayWithWhitelist(v78, { workspace.Islands, workspace.Ships, workspace.Env })
                    local v80 = (u73 - v79).Magnitude
                    if v80 ~= v80 then
                        return 0
                    end
                    if v75 == true then
                        v80 = v80 * -1
                    end
                    return v80
                end
                local v82 = v67.CFrame * CFrame.new(v81(CFrame.new(v68.X, 0, 0)), v81(CFrame.new(0, -v68.Z, 0)), 0)
                local v83 = Ray.new(v82.Position, v82.LookVector * 3)
                local v84 = _G.raycastWhitelist(v83, u63)
                local v85 = Ray.new(v67.Position, v67.CFrame.RightVector * v68.X)
                local v86 = _G.raycastWhitelist(v85, u63)
                local v87 = v67.Size.Z * 0.5 + 0.5
                local v88 = v67.Position - v67.CFrame.LookVector * v87
                local v89 = v67.CFrame.UpVector * -v68.Z * v72 + v67.CFrame.RightVector * v68.X * 0.5
                local v90 = Ray.new(v88, v89)
                local v91 = _G.raycastWhitelist(v90, u63)
                if v91 and v91.CanCollide == true then
                    return
                else
                    if v86 then
                        v83 = v85
                    elseif not v84 then
                        local v92 = v67.CFrame * CFrame.new(v81(CFrame.new(v68.X, 0, 0)), 0, (v81(CFrame.new(0, 0, -1))))
                        v83 = Ray.new(v92.Position, v92.RightVector * -v68.X * 3)
                    end
                    local u93, v94, v95 = _G.raycastWhitelist(v83, u63)
                    local v96 = u65.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
                    local v97 = Ray.new(v96.p, v96.lookVector * 3)
                    local v98, _, _ = _G.raycastWhitelist(v97, u63)
                    if u93 and u93.CollisionGroup:match("Barrier") then
                        warn("stopped barrier poart")
                        p64.AlreadyStopped = false
                        p64:stop()
                        return
                    elseif p64.Part and p64.Part.CollisionGroup:match("Barrier") then
                        warn("stopped barrier poart 2")
                        p64.AlreadyStopped = false
                        p64:stop()
                        return
                    elseif p64.Part == nil or (v98 ~= nil or p64.Part.Transparency == 1) then
                        if (p64.Part == nil or p64.Part.Parent ~= nil) and (p64.Part == nil or p64.Part.Transparency ~= 1) then
                            if p64.Enabled == false then
                                p64:stop()
                                warn("not enabled so ret")
                                return
                            else
                                p64.bill.Parent = u65.HumanoidRootPart
                                u65.Humanoid.AutoRotate = false
                                if u93 and p64.Enabled == true then
                                    p64.Attachment.WorldPosition = v94
                                    p64.Part = u93
                                    if p64.Part == u93 and p64.prenor == v95 then
                                        return
                                    end
                                    p64.prenor = v95
                                    u65.Humanoid.AutoRotate = false
                                    u65.Humanoid.Sit = true
                                    if p64.Attachment == nil then
                                        p64.Attachment = Instance.new("Attachment")
                                    end
                                    local v99 = p64.AP
                                    local v100 = p64.AO
                                    local u101 = p64.Attachment
                                    v99.Attachment1 = u101
                                    v100.Attachment1 = u101
                                    pcall(function() --[[ Line: 44 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u93
                                            [2] = u101
                                        --]]
                                        if u93 and u101 then
                                            u101.Parent = u93
                                        end
                                    end)
                                    p64.Attachment.CFrame = u19({
                                        ["object"] = u93,
                                        ["position"] = v94,
                                        ["normal"] = v95
                                    })
                                    if p64.Attachment.CFrame.Y ~= p64.Attachment.CFrame.Y then
                                        p64.Attachment:Destroy()
                                        p64.Attachment = Instance.new("Attachment")
                                        warn("attachment destroyed")
                                    end
                                    local v102 = u65:GetChildren()
                                    for v103 = 1, #v102 do
                                        if v102[v103]:IsA("BasePart") then
                                            v102[v103].CollisionGroup = "noclip"
                                        end
                                    end
                                    if p64.Anims.Up.IsPlaying == false and p64.currentdirection.Up == true then
                                        p64.Anims.Up:Play()
                                        p64.Anims.Up:AdjustSpeed(0)
                                    end
                                elseif u93 == nil or p64.Part ~= nil and p64.Part:IsDescendantOf(workspace) == false then
                                    warn("stop climb because no eldge 2", p64.Enabled, u93, p64.Part)
                                    p64.AlreadyStopped = false
                                    p64:stop()
                                    return
                                end
                                warn("climb step")
                                if u65:GetAttribute("ServerClimb") == nil then
                                    p64.AlreadyStopped = false
                                    warn("stop because too server not valid")
                                    p64:stop()
                                else
                                    if v95 then
                                        local v104 = v95:Dot(Vector3.new(0, 1, 0))
                                        if v104 >= 0.75 or v104 <= -0.75 then
                                            warn("stop because too steep")
                                            p64.AlreadyStopped = false
                                            p64:stop()
                                        end
                                    end
                                    u65 = game.Players.LocalPlayer.Character
                                end
                            end
                        else
                            warn("stop climb because no eldge")
                            p64.AlreadyStopped = false
                            p64:stop()
                            return
                        end
                    else
                        local _ = u65.HumanoidRootPart.Position.Y
                        local _ = p64.Part.Size.Y / 2 + p64.Part.Position.Y - 2
                        local v105 = Ray.new(u65.Head.Position + (Vector3.new(0, 1, 0)):Cross(u65.Head.CFrame.RightVector) * 3 + Vector3.new(0, 1, 0), Vector3.new(0, 1, 0) * -v72 * 2)
                        if _G.raycastWhitelist(v105, u63) and p64.ledge == false then
                            p64:stop()
                            p64.ledge = true
                            u65.Humanoid:LoadAnimation(script.Ledge):Play()
                            local v106 = Instance.new("BodyVelocity")
                            v106.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
                            v106.Velocity = u65.HumanoidRootPart.CFrame.upVector * 5
                            v106.Parent = u65.HumanoidRootPart
                            p64.Enabled = false
                            u65.Humanoid.AutoRotate = false
                            task.wait(1)
                            u65.Humanoid.AutoRotate = true
                            v106:Destroy()
                            p64.Enabled = false
                            p64.ledge = false
                        end
                        if p64.Part then
                            warn("eldge detect?", p64.Part:GetFullName(), p64.Part.CollisionGroup)
                        else
                            warn("ledge detected no part")
                        end
                        p64.AlreadyStopped = false
                        p64:stop()
                        return
                    end
                end
            end
        end
    end
end
function u1.stop(p107) --[[ Line: 488 ]]
    if p107.AlreadyStopped ~= true then
        local v108 = p107.char
        p107.Enabled = false
        p107.Part = nil
        p107.prenor = Vector3.new(2, 2, 2)
        p107.Attachment.Parent = v108.HumanoidRootPart
        local v109 = p107.AP
        local v110 = p107.AO
        v109.Attachment1 = nil
        v110.Attachment1 = nil
        local u111 = nil
        local u112 = nil
        pcall(function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u111
                [2] = u112
            --]]
            if u111 and u112 then
                u112.Parent = u111
            end
        end)
        p107.AP.Enabled = false
        p107.AO.Enabled = false
        _G.canuse = true
        v108.Humanoid.Sit = false
        p107.AlreadyStopped = true
        v108.Humanoid.AutoRotate = true
        local v113 = v108:GetChildren()
        for v114 = 1, #v113 do
            if v113[v114]:IsA("BasePart") then
                v113[v114].CollisionGroup = "Players"
            end
        end
        v108.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
        v108.PrimaryPart.AssemblyAngularVelocity = Vector3.new()
        task.spawn(function() --[[ Line: 522 ]]
            game.ReplicatedStorage.Events.climb:InvokeServer(false)
        end)
        warn("actually stopped")
    end
end
return u1