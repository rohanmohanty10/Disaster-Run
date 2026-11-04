 

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
local function u15(p9) --[[ Line: 13 ]]
    local v10 = p9.normal
    local v11 = p9.position
    local v12 = p9.object
    local v13 = (Vector3.new(0, 1, 0)):Cross(v10).Unit
    local v14 = v10:Cross(v13).Unit
    return v12.CFrame:inverse() * CFrame.new(v11.x, v11.y, v11.z, v13.x, v14.x, v10.x, v13.y, v14.y, v10.y, v13.z, v14.z, v10.z)
end
local function u18(p16) --[[ Line: 30 ]]
    local v17, _, _ = _G.raycastWhitelist(p16, {
        workspace.Islands,
        workspace.Env,
        workspace.Ships,
        workspace.Jails
    })
    return v17
end
function u1.setup(u19, _) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u7
        [4] = u4
        [5] = u2
        [6] = u3
        [7] = u1
        [8] = u18
        [9] = u8
    --]]
    local v20, v21, v22, v23 = u4.get()
    u5 = v20
    u6 = v22
    u7 = v23
    local u24 = v21
    warn(u24:GetFullName())
    local u25 = {
        ["Part"] = nil,
        ["AO"] = script.AlignOrientation:Clone(),
        ["AP"] = script.AlignPosition:Clone(),
        ["Attachment"] = Instance.new("Attachment"),
        ["char"] = u24
    }
    u25.AP.Parent = u24.HumanoidRootPart
    u25.AO.Parent = u24.HumanoidRootPart
    u25.AP.Attachment0 = u24.HumanoidRootPart.ClimbCenter
    u25.AO.Attachment0 = u24.HumanoidRootPart.ClimbCenter
    u25.Enabled = false
    u25.Anims = {
        ["Up"] = u24.Humanoid:LoadAnimation(script.Up),
        ["Left"] = u24.Humanoid:LoadAnimation(script.Left),
        ["Right"] = u24.Humanoid:LoadAnimation(script.Right),
        ["Down"] = u24.Humanoid:LoadAnimation(script.Down)
    }
    u25.fakepart = nil
    u25.currentdirection = {
        ["Up"] = false,
        ["Down"] = false,
        ["Right"] = false,
        ["Left"] = false
    }
    u25.AlreadyStopped = false
    u25.prenor = nil
    u25.ledge = false
    u25.bill = script.BillboardGui:Clone()
    u25.bill.ImageLabel.ImageLabel.ImageRectSize = Vector2.new(u2.GetSize(u3))
    u25.climbingtime = 10
    local v26 = u1
    setmetatable(u25, v26)
    for _, v27 in u25.Anims do
        v27.Looped = true
    end
    local function u30(p28) --[[ Line: 75 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        for _, v29 in u25.Anims do
            if p28 == v29 then
                if p28.IsPlaying == false then
                    p28:Play()
                end
                v29:AdjustWeight(1)
                p28:AdjustSpeed(1)
            else
                v29:AdjustSpeed(0)
            end
        end
    end
    local function u33(p31) --[[ Line: 88 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        for _, v32 in u25.Anims do
            if v32 ~= p31 and (v32.Speed == 1 and v32.IsPlaying == true) then
                p31:Stop()
                p31:AdjustSpeed(0)
                return
            end
        end
    end
    local function u35() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        for _, v34 in u25.Anims do
            v34:Stop()
            v34.Looped = true
            v34:AdjustSpeed(0)
        end
    end
    u6.InputBegan:Connect(function(p36, p37) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u30
            [3] = u18
            [4] = u24
            [5] = u8
            [6] = u6
            [7] = u33
        --]]
        if u25.Enabled == false then
            return
        end
        if p37 == true then
            return
        end
        if p36.KeyCode == Enum.KeyCode.W and u25.currentdirection.Up == false then
            u25.currentdirection.Up = true
            u30(u25.Anims.Up)
            while true do
                if u25.Anims.Up.IsPlaying == false then
                    u25.Anims.Up:Play()
                end
                local v38 = u18(Ray.new(u24.HumanoidRootPart.CFrame.p, u24.HumanoidRootPart.CFrame.upVector * (u24.Humanoid.HipHeight * 2)))
                if v38 == nil or v38 and v38.CanCollide == false then
                    u25.Attachment.CFrame = u25.Attachment.CFrame * CFrame.new(0, 0.25, 0)
                    u25.Anims.Up:AdjustSpeed(1)
                else
                    u25.Anims.Up:AdjustSpeed(0)
                end
                u8()
                if u6:IsKeyDown(Enum.KeyCode.W) == false or u25.Enabled == false then
                    u25.Anims.Up:AdjustSpeed(0)
                    u25.currentdirection.Up = false
                    u33(u25.Anims.Up)
                    return
                end
            end
        end
        if p36.KeyCode == Enum.KeyCode.S and u25.currentdirection.Down == false then
            u25.currentdirection.Down = true
            u30(u25.Anims.Down)
            while true do
                if u25.Anims.Down.IsPlaying == false then
                    u25.Anims.Down:Play()
                end
                u25.Anims.Down:AdjustSpeed(1)
                u25.Attachment.CFrame = u25.Attachment.CFrame * CFrame.new(0, -0.25, 0)
                u8()
                if u6:IsKeyDown(Enum.KeyCode.S) == false or u25.Enabled == false then
                    u25.currentdirection.Down = false
                    u25.Anims.Down:AdjustSpeed(0)
                    u33(u25.Anims.Down)
                    return
                end
            end
        end
        if p36.KeyCode == Enum.KeyCode.A and u25.currentdirection.Left == false then
            u25.currentdirection.Left = true
            u30(u25.Anims.Left)
            while true do
                if u25.Anims.Left.IsPlaying == false then
                    u25.Anims.Left:Play()
                end
                u25:step()
                u25.Anims.Left:AdjustSpeed(1)
                u25.Attachment.CFrame = u25.Attachment.CFrame * CFrame.new(-0.25, 0, 0)
                u8()
                if u6:IsKeyDown(Enum.KeyCode.A) == false or u25.Enabled == false then
                    u25.currentdirection.Left = false
                    u25.Anims.Left:AdjustSpeed(0)
                    u33(u25.Anims.Left)
                    return
                end
            end
        end
        if p36.KeyCode == Enum.KeyCode.D and u25.currentdirection.Right == false then
            u30(u25.Anims.Right)
            u25.currentdirection.Right = true
            while true do
                if u25.Anims.Right.IsPlaying == false then
                    u25.Anims.Right:Play()
                end
                u25:step()
                u25.Anims.Right:AdjustSpeed(1)
                u25.Attachment.CFrame = u25.Attachment.CFrame * CFrame.new(0.25, 0, 0)
                u8()
                if u6:IsKeyDown(Enum.KeyCode.D) == false or u25.Enabled == false then
                    u25.currentdirection.Right = false
                    u25.Anims.Right:AdjustSpeed(0)
                    u33(u25.Anims.Right)
                    goto l38
                end
            end
        else
            ::l38::
            return
        end
    end)
    local u39 = tick()
    local u40 = 0
    game["Run Service"].Heartbeat:Connect(function() --[[ Line: 186 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u25
            [3] = u35
            [4] = u39
            [5] = u2
            [6] = u3
            [7] = u24
            [8] = u18
            [9] = u40
            [10] = u8
        --]]
        if u19.Attachment and u19.Attachment.Position.Y ~= u19.Attachment.Position.Y then
            u19.Attachment:Destroy()
            u19.Attachment = Instance.new("Attachment")
        end
        if u25.Enabled == false then
            u35()
            u25.climbingtime = u25.climbingtime + (tick() - u39)
            if u25.climbingtime >= 10 then
                u25.climbingtime = 10
                u25.bill.Parent = nil
            end
            u39 = tick()
            u25:stop()
        else
            u25.climbingtime = u25.climbingtime - (tick() - u39)
            u39 = tick()
            if u25.climbingtime <= 0 then
                u25.climbingtime = 0
                u25:stop()
            end
        end
        local v41 = u25.climbingtime / 10
        local v42 = Vector2.new
        local v43 = u25.bill.ImageLabel.ImageLabel
        v43.ImageRectSize = v42(u2.GetSize(u3))
        local v44 = v41 * 64
        v43.ImageRectOffset = v42(u2.GetOffset(u3, v44))
        v43.ImageColor3 = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(85, 255, 127), v41)
        local v45 = {
            ["Rain"] = 0.05,
            ["Snow"] = 0.06
        }
        if u25.Enabled == true and (workspace.Islands:FindFirstChild(_G.currentisland) and ({
            ["Rain"] = true,
            ["Snow"] = true
        })[workspace.Islands:FindFirstChild(_G.currentisland).Settings.Weather.Value]) then
            local v46 = u24.HumanoidRootPart.CFrame
            local v47 = v45[workspace.Islands:FindFirstChild(_G.currentisland).Settings.Weather.Value]
            if u18(Ray.new(v46.p, v46.upVector * -(u24.Humanoid.HipHeight * 2))) == nil and tick() - u40 >= u8() then
                u25.Attachment.CFrame = u25.Attachment.CFrame * CFrame.new(0, -v47, 0)
                u40 = tick()
            end
        end
        u25:step()
        if u25.Part ~= nil and u25.Part:IsDescendantOf(workspace) == false then
            u25:stop()
        end
    end)
    return u25
end
function u1.step(p48) --[[ Line: 256 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u15
    --]]
    local v49 = p48.char
    local v50 = v49.HumanoidRootPart.CFrame
    if p48.Enabled == false then
        p48:stop()
        return
    elseif p48.Enabled == true and (p48.currentdirection.Down == true and (p48.Part ~= nil and u18(Ray.new(v50.p, v50.upVector * -(v49.Humanoid.HipHeight * 2))) ~= nil)) then
        p48:stop()
        return
    elseif v49:FindFirstChild("Stun") and p48.Enabled == true then
        p48:stop()
        return
    else
        if p48.Enabled == true then
            p48.AP.Enabled = true
            p48.AO.Enabled = true
        end
        local v51 = v49:GetChildren()
        for v52 = 1, #v51 do
            if v51[v52]:IsA("BasePart") then
                v51[v52].CollisionGroup = "noclip"
            end
        end
        local v53 = Ray.new(v50.p, v50.lookVector * 3)
        if p48.currentdirection.Left == true then
            v53 = Ray.new(v50.p, v50.rightVector * -2)
        elseif p48.currentdirection.Right == true then
            v53 = Ray.new(v50.p, v50.rightVector * 2)
        end
        local v54 = nil
        if p48.currentdirection.Left == true then
            local v55 = v49.HumanoidRootPart.CFrame * CFrame.new(-0.75, 0, 0)
            v54 = Ray.new(v55.p, v55.lookVector * 2)
        elseif p48.currentdirection.Right == true then
            local v56 = v49.HumanoidRootPart.CFrame * CFrame.new(0.75, 0, 0)
            v54 = Ray.new(v56.p, v56.lookVector * 2)
        end
        if (p48.currentdirection.Left == true or p48.currentdirection.Right == true) and u18(v53) == nil then
            if p48.currentdirection.Left == true and u18(v54) == nil then
                local v57 = v49.HumanoidRootPart.CFrame * CFrame.new(-1, 0, -0.5)
                v53 = Ray.new(v57.p, v57.rightVector * 3)
            elseif p48.currentdirection.Right == true and u18(v54) == nil then
                local v58 = v49.HumanoidRootPart.CFrame * CFrame.new(1, 0, -0.5)
                v53 = Ray.new(v58.p, v58.rightVector * -3)
            end
            local v59, v60 = _G.raycastIgnoreList(v53, { workspace.PlayerCharacters, workspace.Ragdolls, workspace.Effects })
            if v59 == nil or v60 == p48.prenor then
                v53 = Ray.new(v50.p, v50.lookVector * 3)
            end
        end
        local u61, v62, v63 = _G.raycastIgnoreList(v53, { workspace.PlayerCharacters, workspace.Ragdolls, workspace.Effects })
        local v64 = v49.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        local v65 = Ray.new(v64.p, v64.lookVector * 3)
        local v66, _, _ = _G.raycastIgnoreList(v65, { workspace.PlayerCharacters, workspace.Ragdolls, workspace.Effects })
        if p48.Part == nil or (v66 ~= nil or p48.Part.Transparency == 1) then
            if p48.Part ~= nil and p48.Part.Parent == nil or p48.Part ~= nil and p48.Part.Transparency == 1 then
                p48:stop()
            end
        elseif v49.HumanoidRootPart.Position.Y >= p48.Part.Size.Y / 2 + p48.Part.Position.Y - 2 and p48.ledge == false then
            p48.ledge = true
            v49.Humanoid:LoadAnimation(script.Ledge):Play()
            local v67 = Instance.new("BodyVelocity")
            v67.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            v67.Velocity = v49.HumanoidRootPart.CFrame.upVector * 5
            v67.Parent = v49.HumanoidRootPart
            p48.Enabled = false
            p48:stop()
            v49.Humanoid.AutoRotate = false
            task.wait(1)
            v49.Humanoid.AutoRotate = true
            v67:Destroy()
            p48.Enabled = false
            p48.ledge = false
            return
        end
        if p48.Enabled ~= false then
            p48.bill.Parent = v49.HumanoidRootPart
            v49.Humanoid.AutoRotate = false
            if u61 and p48.Enabled == true then
                if p48.Part == u61 and p48.prenor == v63 then
                    return
                end
                p48.prenor = v63
                v49.Humanoid.AutoRotate = false
                v49.Humanoid.Sit = true
                p48.Part = u61
                if p48.Attachment == nil then
                    p48.Attachment = Instance.new("Attachment")
                end
                local v68 = p48.AP
                local v69 = p48.AO
                local u70 = p48.Attachment
                v68.Attachment1 = u70
                v69.Attachment1 = u70
                pcall(function() --[[ Line: 39 ]]
                    --[[
                    Upvalues:
                        [1] = u61
                        [2] = u70
                    --]]
                    if u61 and u70 then
                        u70.Parent = u61
                    end
                end)
                p48.Attachment.CFrame = u15({
                    ["object"] = u61,
                    ["position"] = v62,
                    ["normal"] = v63
                })
                if p48.Attachment.CFrame.Y ~= p48.Attachment.CFrame.Y then
                    p48.Attachment:Destroy()
                    p48.Attachment = Instance.new("Attachment")
                end
                if p48.Anims.Up.IsPlaying == false and p48.currentdirection.Up == true then
                    p48.Anims.Up:Play()
                    p48.Anims.Up:AdjustSpeed(0)
                end
            elseif u61 == nil or p48.Part ~= nil and p48.Part:IsDescendantOf(workspace) == false then
                p48:stop()
            end
            if v63 then
                local v71 = v63:Dot(Vector3.new(0, 1, 0))
                if v71 >= 0.75 or v71 <= -0.75 then
                    p48:stop()
                end
            end
        end
    end
end
function u1.stop(p72) --[[ Line: 390 ]]
    local v73 = p72.char
    p72.Enabled = false
    p72.Part = nil
    p72.Attachment.Parent = v73.HumanoidRootPart
    local v74 = p72.AP
    local v75 = p72.AO
    v74.Attachment1 = nil
    v75.Attachment1 = nil
    local u76 = nil
    local u77 = nil
    pcall(function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u76
            [2] = u77
        --]]
        if u76 and u77 then
            u77.Parent = u76
        end
    end)
    p72.AP.Enabled = false
    p72.AO.Enabled = false
    if p72.AlreadyStopped ~= true then
        v73.Humanoid.Sit = false
        p72.AlreadyStopped = true
        v73.Humanoid.AutoRotate = true
        local v78 = v73:GetChildren()
        for v79 = 1, #v78 do
            if v78[v79]:IsA("BasePart") then
                v78[v79].CollisionGroup = "Players"
            end
        end
        game.ReplicatedStorage.Events.climb:FireServer(false)
    end
end
return u1