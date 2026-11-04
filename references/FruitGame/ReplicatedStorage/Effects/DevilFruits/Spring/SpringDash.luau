 

local v1 = {}
game:GetService("TweenService")
local u2 = script.Animations
local _ = _G.customEmit
local function u9(p3, p4) --[[ Line: 21 ]]
    local v5 = p3:GetDescendants()
    local v6 = {}
    for v7 = 1, #v5 do
        if v5[v7]:IsA("Humanoid") or v5[v7]:IsA("AnimationController") and v5[v7].Parent.Name:match("Spring") then
            local v8 = v5[v7]:LoadAnimation(p4)
            v8:Play()
            v8:AdjustWeight(2)
            v8.Priority = Enum.AnimationPriority.Action
            table.insert(v6, v8)
        end
    end
    return v6
end
function v1.start(_, u10, p11) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
    --]]
    if _G.checkRenderDistance(u10.PrimaryPart.Position) then
        if not p11 or p11 ~= game.Players.LocalPlayer then
            local v12
            if u10.Humanoid.MoveDirection.Magnitude > 0 then
                v12 = u10.Humanoid.MoveDirection
            else
                v12 = u10:GetPivot().LookVector
            end
            local v13 = u10:GetPivot().LookVector:Dot(v12)
            local v14 = u10:GetPivot().RightVector:Dot(v12)
            local v15 = script.SpringEffect:Clone()
            v15.CFrame = CFrame.new(u10:GetPivot().Position, u10:GetPivot().Position + v12.Unit) * CFrame.new(0, -1, 0)
            v15.Parent = workspace.Effects
            _G.customEmit(v15)
            _G.destroy(v15, 2)
            _G.PlaySound(u10.PrimaryPart, script.SpringDash, {
                ["Pitch"] = math.random(90, 110) / 100
            })
            if u10 == game.Players.LocalPlayer.Character then
                u10.Humanoid.AutoRotate = false
                if math.abs(v14) > math.abs(v13) then
                    local v16 = math.sign(v14)
                    local _ = u10:GetPivot().RightVector * v16
                    u9(u10, u2[({
                        [-1] = "Left",
                        [1] = "Right"
                    })[v16]])
                else
                    local v17 = math.sign(v13)
                    local _ = u10:GetPivot().LookVector * v17
                    u9(u10, u2[({
                        [-1] = "Back",
                        [1] = "Front"
                    })[v17]])
                end
                local v18 = _G.ScaleWithHP(1)
                local v19 = Instance.new("BodyVelocity")
                v19.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                v19.Velocity = v15.CFrame.LookVector * _G.ScaleWithHP(85)
                v19.Parent = u10.PrimaryPart
                _G.destroy(v19, 0.25 * v18)
                task.delay(0.25 * v18, function() --[[ Line: 90 ]]
                    --[[
                    Upvalues:
                        [1] = u10
                    --]]
                    u10.Humanoid.AutoRotate = true
                end)
            end
        end
    else
        return
    end
end
return v1