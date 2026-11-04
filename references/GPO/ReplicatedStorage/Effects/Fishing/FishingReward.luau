 

local v1 = {}
game:GetService("TweenService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = u2.Fishing.Assets
local u4 = u3.Rewards
local u5 = Random.new()
function v1.start(_, p6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u2
        [4] = u3
    --]]
    local v7 = p6.Hook
    if v7 then
        local v8 = p6.Reward
        local v9 = p6.RewardType
        local v10 = p6.Start
        local v11 = p6.Goal
        math.random(15, 30)
        u5:NextNumber(3, 5)
        local v12 = u4:FindFirstChild(v8)
        if v12 == nil then
            v12 = u2.Tools:FindFirstChild(v8)
        end
        if v12 and v12:IsA("BasePart") then
            local v13 = v12:Clone()
            v12 = Instance.new("Model")
            v12.PrimaryPart = v13
            v13.Parent = v12
        elseif v12 then
            v12 = v12:Clone()
        end
        if v12 == nil then
            return
        else
            v12:MoveTo(v10)
            if v12.PrimaryPart then
                v12.PrimaryPart.Anchored = true
            end
            v12.Parent = workspace.Effects
            local v14 = v12:FindFirstChild("AnimationController")
            local v15 = v12:FindFirstChildOfClass("Animation")
            if v14 and v15 then
                local v16 = v14:LoadAnimation(v15)
                v16:Play()
                v16:AdjustSpeed(math.random(100, 300) / 100)
            end
            v12:GetExtentsSize()
            local v17 = v12:GetAttribute("Offset") or CFrame.new()
            if v12.PrimaryPart:FindFirstChild("Hook") then
                v12.PrimaryPart.Hook.CFrame = CFrame.new(v12.PrimaryPart.Hook.CFrame.Position)
                local v18 = v12.PrimaryPart.Hook.WorldCFrame
                local v19 = v12.PrimaryPart.CFrame
                v17 = v18:Inverse() * v19
            end
            while v7.Parent do
                local _ = (v12:GetPivot().Position - v7.Position).Magnitude
                v12.PrimaryPart.Anchored = true
                v12:SetPrimaryPartCFrame(v7.CFrame * v17)
                game["Run Service"].RenderStepped:Wait()
            end
            if v9 and u3.CatchVFX:FindFirstChild(v9) then
                local v20 = u3.CatchVFX:FindFirstChild(v9):Clone()
                v20.CFrame = v11.PrimaryPart.CFrame
                _G.scaleParticle(v20, 1.5, true)
                v20.Parent = workspace.Effects
                _G.customEmit(v20)
                _G.destroy(v20, 5)
            end
            v12:Destroy()
            if v9 and v9 == "Sunken" then
                _G.PlaySound(v11.PrimaryPart, game.ReplicatedStorage.Fishing.Assets.SFX.Caught.TreasureFound, {
                    ["RandomPitch"] = true
                })
            else
                _G.PlaySound(v11.PrimaryPart, game.ReplicatedStorage.Fishing.Assets.SFX.Caught.NewFish, {
                    ["RandomPitch"] = true
                })
            end
        end
    else
        return
    end
end
return v1