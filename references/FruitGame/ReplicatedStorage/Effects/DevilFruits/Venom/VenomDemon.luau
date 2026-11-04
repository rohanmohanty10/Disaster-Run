 

local v1 = {}
local u2 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
require(script.Parent.VenomSplash)
local u3 = script.Parent.Puddles.Purple
local u4 = script.Animations
function PlayAnim(p5, p6, p7)
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v8 = (p5:FindFirstChild("Humanoid") or p5:FindFirstChild("AnimationController")).Animator:LoadAnimation(u4[p6])
    v8:Play(p7 or 0, 1, 1)
    warn("loading aniamtion track!!!!")
    return v8
end
function Quad(p9, p10, p11, p12)
    return (1 - p12) * (1 - p12) * p9 + 2 * (1 - p12) * p12 * p10 + p12 * p12 * p11
end
function AlignCFrame(p13, p14, _)
    local v15 = p13.Position
    local v16 = p13.LookVector:Cross(p14).Unit
    local v17 = (v16.Magnitude > 0.001 and v16 and v16 or p13.RightVector).Unit
    local v18 = v17:Cross(p14).Unit.Unit
    return CFrame.fromMatrix(v15, v17, p14, v18)
end
function v1.start(_, u19, u20, u21) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(u19.PrimaryPart.Position) == false then
        return
    elseif u19 then
        warn("venom demon model: " .. u20:GetFullName())
        local u22 = Random.new()
        local u23 = nil
        local u24 = 0
        local _ = game.Players.LocalPlayer == game.Players:GetPlayerFromCharacter(u19)
        local u25 = tick()
        local u26 = nil
        task.delay(0.75, function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u20
            --]]
            u26 = PlayAnim(u20, "VenomIdle", 0.4)
        end)
        task.delay(0.8, function() --[[ Line: 86 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u23
                [3] = u26
                [4] = u19
                [5] = u2
                [6] = u25
                [7] = u24
                [8] = u21
                [9] = u3
                [10] = u22
            --]]
            u20.AnimationController:WaitForChild("Animator", 5)
            u23 = {
                ["Forward"] = PlayAnim(u20, "Forward"),
                ["Backward"] = PlayAnim(u20, "Backward"),
                ["Left"] = PlayAnim(u20, "Left"),
                ["Right"] = PlayAnim(u20, "Right"),
                ["Idle"] = u26
            }
            local v27 = u19
            local v28 = nil
            local v29 = v28 == nil and "lowJaw" or v28
            local v30 = v27:GetDescendants()
            local u31 = nil
            for v32 = 1, #v30 do
                if v30[v32].Name == v29 then
                    u31 = v30[v32]
                    break
                end
            end
            local u33 = 0
            local u34 = nil
            u34 = u2.Stepped:Connect(function(_, _) --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u20
                    [3] = u25
                    [4] = u19
                    [5] = u34
                    [6] = u24
                    [7] = u21
                    [8] = u33
                    [9] = u3
                    [10] = u22
                    [11] = u23
                --]]
                if u31 and (u20 and u20:FindFirstChild("mouthSmoke")) then
                    u20.mouthSmoke.Attachment.WorldCFrame = u31.TransformedWorldCFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-0.5, 0.5, 0)
                end
                if tick() - u25 < 0.09090909090909091 or not u19.PrimaryPart then
                    return
                elseif u19:GetAttribute("VenomDemonActive") == false then
                    u34:Disconnect()
                    return
                else
                    u25 = tick()
                    if u19.Humanoid.Health <= 0 then
                        u34:Disconnect()
                        return
                    elseif u19.Parent == nil then
                        u34:Disconnect()
                    else
                        if u19.Humanoid.MoveDirection.Magnitude > 0 then
                            local v35 = u24 + 0.05
                            u24 = math.clamp(v35, 0, 1)
                        else
                            local v36 = u24 - 0.05
                            u24 = math.clamp(v36, 0, 1)
                        end
                        u21.Volume = u24 * 0.5
                        if tick() - u33 >= 0.1 then
                            local v37 = CFrame.new(u19.PrimaryPart.Position)
                            local v38 = Ray.new(v37.Position + Vector3.new(0, 4, 0), v37.upVector * -35)
                            local v39, v40, v41 = _G.raycastWhitelist(v38, { workspace.Islands, workspace.Env, workspace.Ships })
                            if v39 then
                                local u42 = u3:GetChildren()[math.random(1, #u3:GetChildren())]:Clone()
                                local v43 = u22:NextNumber(-5, 5)
                                local v44 = u22
                                local v45 = Vector3.new(v43, 0, v44:NextNumber(-5, 5))
                                u42:PivotTo(AlignCFrame(CFrame.new(Vector3.new(), u19.HumanoidRootPart.CFrame.LookVector) + v40, v41) * CFrame.new(v45) * CFrame.Angles(0, u22:NextNumber(-3.141592653589793, 3.141592653589793), 0))
                                local v46 = u42:GetPivot().Position + u19.Humanoid.MoveDirection * 12
                                u42:PivotTo(CFrame.new(v46, v46 + u42:GetPivot().LookVector))
                                u42.Parent = workspace.Effects
                                local v47 = Vector3.new(25.658, 5, 24.736) * u22:NextNumber(1, 1.4)
                                local v48 = u42:GetPivot() * CFrame.Angles(0, 1.0471975511965976 * u22:NextNumber(-1, 1), 0)
                                for _, v49 in u42:GetChildren() do
                                    local v50 = v49:FindFirstChildOfClass("MeshPart")
                                    v50.Size = Vector3.new(0, 0, 0)
                                    local v51
                                    if v49.Name == "Out" then
                                        v51 = v47 * 1.01
                                    else
                                        v51 = v47
                                    end
                                    v50.Color = ({
                                        ["In"] = Color3.fromRGB(106, 9, 50),
                                        ["Out"] = Color3.fromRGB(106, 9, 50)
                                    })[v49.Name]
                                    v50.Transparency = v49.Name == "Out" and 0.65 or 0
                                    _G.tween(v50, { 0.2, "EntranceExpressive", Enum.EasingDirection.Out }, {
                                        ["Size"] = v51
                                    })
                                    _G.tween(v50, { 1.3, "EntranceExpressive", Enum.EasingDirection.Out }, {
                                        ["CFrame"] = v48
                                    })
                                end
                                task.delay(0.8, function() --[[ Line: 154 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u42
                                    --]]
                                    _G.destroy(u42, 0.5)
                                    for _, v52 in u42:GetChildren() do
                                        local v53 = v52:FindFirstChildOfClass("MeshPart")
                                        _G.tween(v53, { 0.5, "Linear", Enum.EasingDirection.Out }, {
                                            ["Size"] = Vector3.new()
                                        })
                                    end
                                end)
                            end
                            u33 = tick()
                        end
                        local v54 = u19.PrimaryPart.CFrame.LookVector:Dot(u19.Humanoid.MoveDirection)
                        local v55 = u19.PrimaryPart.CFrame.RightVector:Dot(u19.Humanoid.MoveDirection)
                        u23.Forward:AdjustWeight((math.clamp(v54, 0, 2)))
                        local v56 = u23.Backward
                        local v57 = -v54
                        v56:AdjustWeight((math.clamp(v57, 0, 2)))
                        u23.Right:AdjustWeight((math.clamp(v55, 0, 2)))
                        local v58 = u23.Left
                        local v59 = -v55
                        v58:AdjustWeight((math.clamp(v59, 0, 2)))
                        if u23 then
                            if u19.Humanoid.MoveDirection == Vector3.new() then
                                if u23 and (u23.Idle and u23.Idle.IsPlaying == false) then
                                    u23.Idle:Play()
                                    return
                                end
                            elseif u23 and (u23.Idle and u23.Idle.IsPlaying == true) then
                                u23.Idle:Stop()
                            end
                        end
                    end
                end
            end)
        end)
    end
end
return v1