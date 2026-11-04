 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
local v4 = game:GetService("ReplicatedStorage")
local u5 = require(v4.Modules.Client.WeaponVFXRecolor)
local u6 = workspace:WaitForChild("Effects")
local u7 = script:WaitForChild("Animations")
Random.new()
local v8 = RaycastParams.new()
v8.FilterType = Enum.RaycastFilterType.Include
v8.RespectCanCollide = true
v8.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
function v1.start(_, p9) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u3
        [4] = u2
        [5] = u7
    --]]
    local v10 = p9.isSpecial
    local u11 = script.VFX.Normal
    local u12 = script.SFX.Normal
    if v10 == true then
        u11 = script.VFX.Special
        u12 = script.SFX.Special
    end
    if p9.Type == "revGun" then
        local v13 = p9.Character
        local v14 = p9.gunModel
        if v14 == nil then
            return
        end
        if v14:FindFirstChild("RootPart") == nil then
            return
        end
        local u15 = v14.RootPart.Root.minigun
        local v16 = u11.MinigunShoot:Clone()
        u5.apply(v16, v13)
        v16.Weld.Part0 = v14.RootPart
        v16.Parent = u6
        local u17 = Instance.new("NumberValue")
        u17.Value = 0
        u3:Create(u17, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Value"] = 35
        }):Play()
        local u23 = u2.Heartbeat:Connect(function(p18) --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u17
            --]]
            local v19 = u15
            local v20 = v19.CFrame
            local v21 = CFrame.Angles
            local v22 = u17.Value * p18 * 60
            v19.CFrame = v20 * v21(0, math.rad(v22), 0)
        end)
        local v24 = os.clock()
        local v25 = u12.JinxGunRapidFireStartUp:Clone()
        v25.Parent = v13.PrimaryPart
        v25:Play()
        local v26 = v14:FindFirstChild("MainExit", true)
        local v27 = nil
        local v28 = nil
        local v29 = nil
        local v30 = false
        local v31 = nil
        while true do
            task.wait()
            if os.clock() - v24 >= 0.05 and u17.Value >= 35 then
                if v30 ~= true then
                    v27 = v13.Humanoid:LoadAnimation(u7.Start)
                    v27:Play()
                    v31 = v13.Humanoid:LoadAnimation(u7.Success)
                    v31:Play()
                    v29 = u12.JinxGunRapidFireShootingLoop:Clone()
                    v29.Parent = v13.PrimaryPart
                    v29:Play()
                    _G.PlaySound(v13.PrimaryPart, u12["JinxGunRapidFireShootingStart" .. math.random(1, 3)]).Parent = v13.PrimaryPart
                    v28 = u11.PointLight:Clone()
                    u5.apply(v28, v13)
                    v28.Range = 3
                    v28.Parent = v26
                    u3:Create(v28, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
                        ["Range"] = 10
                    }):Play()
                    v30 = true
                end
                _G.customEmit(v16)
                v24 = os.clock()
            end
            if v13:GetAttribute("JinxM1Holding") == nil or v14:IsDescendantOf(workspace) == false then
                if v14:IsDescendantOf(workspace) == false then
                    u23:Disconnect()
                else
                    task.delay(2, function() --[[ Line: 101 ]]
                        --[[
                        Upvalues:
                            [1] = u23
                        --]]
                        u23:Disconnect()
                    end)
                end
                if v28 then
                    v28:Destroy()
                end
                u3:Create(v25, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(v25, 0.25)
                if v29 then
                    u3:Create(v29, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Volume"] = 0
                    }):Play()
                    _G.destroy(v29, 0.25)
                end
                u3:Create(u17, TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Value"] = 0
                }):Play()
                if v30 == true then
                    _G.PlaySound(v13.PrimaryPart, u12["JinxGunRapidFireShootingEnd" .. math.random(1, 2)]).Parent = v13.PrimaryPart
                    if v31 then
                        v31:Stop()
                        v31:Destroy()
                    end
                    if v27 then
                        v27:Stop()
                        v27:Destroy()
                    end
                end
                task.wait(2)
                u17:Destroy()
                v16:Destroy()
                ::l30::
                return
            end
        end
    else
        local u32 = p9.StartPos
        local v33 = p9.Goal
        local v34 = p9.gunModel
        local v35 = p9.targets
        local u36 = p9.Character
        local u37 = p9.maxTime
        local u38 = p9.ProjectileStartTime
        local u39 = p9.ProjectileSpeed
        if not v34 then
            return
        end
        local u40 = CFrame.new(u32, v33.Position).LookVector
        local u41 = u11.Bullet:Clone()
        u5.apply(u41, u36)
        u41.Position = u32
        u41.Parent = u6
        local function u48(p42, p43) --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u48
            --]]
            local v44 = p43 or 0
            local v45 = string.rep(" ", v44)
            for v46, v47 in pairs(p42) do
                if type(v47) == "table" then
                    print(v45 .. tostring(v46) .. ":")
                    u48(v47, v44 + 4)
                else
                    print(v45 .. tostring(v46) .. " = " .. tostring(v47))
                end
            end
        end
        local u49 = RaycastParams.new()
        u49.FilterType = Enum.RaycastFilterType.Include
        u49.FilterDescendantsInstances = v35
        local u50 = u32
        local u51 = nil
        local function u55(p52, p53) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u5
                [3] = u36
                [4] = u6
                [5] = u12
            --]]
            p52.Attachment.Glow:Clear()
            p52.Attachment.Glow.Enabled = false
            local v54 = u11.BulletHit:Clone()
            u5.apply(v54, u36)
            v54.CFrame = p52.CFrame
            v54.Parent = u6
            _G.customEmit(v54.Attachment)
            _G.destroy({ p52, v54 }, 0.25)
            if p53 then
                _G.PlaySound(p52.CFrame, u12["JinxGunBulletHit" .. math.random(1, 3)])
            else
                _G.PlaySound(p52.CFrame, u12["JinxGunBulletHitGround" .. math.random(1, 3)])
            end
        end
        u51 = u2.Heartbeat:Connect(function() --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u37
                [3] = u55
                [4] = u41
                [5] = u51
                [6] = u32
                [7] = u40
                [8] = u39
                [9] = u50
                [10] = u49
            --]]
            local v56 = workspace:GetServerTimeNow() - u38
            if u37 <= v56 then
                u55(u41, false)
                u51:Disconnect()
            else
                local v57 = u32 + u40 * (u39 * v56)
                local v58 = (v57 - u50).Unit
                local v59 = (v57 - u50).Magnitude
                if v59 > 0 then
                    local v60 = workspace:Blockcast(CFrame.new(u50, u50 + v58), Vector3.new(0.1, 0.1, 0.1), v58 * v59, u49)
                    if v60 and v60.Instance then
                        u41.Position = v60.Position
                        u55(u41, (_G.getTargetByPart(v60.Instance)))
                        u51:Disconnect()
                        return
                    end
                end
                u41.Position = v57
                u50 = v57
            end
        end)
        goto l30
    end
end
return v1