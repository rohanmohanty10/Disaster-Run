 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = {}
local u4 = workspace.Effects
require(v2.Modules.BoatTween)
local function u15(p5) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    local u6 = script.SlashMain:Clone()
    u6.CFrame = p5.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(-0.17453292519943295, 0, 1.5707963267948966)
    require(script.Parent.BusoColor):applyColors(p5.Parent, u6)
    u6.Parent = u4
    local u7 = TweenInfo.new(0.25, Enum.EasingStyle.Exponential)
    u1:Create(u6, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
        ["CFrame"] = u6.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
    }):Play()
    u1:Create(u6.Texture, u7, {
        ["Transparency"] = 1
    }):Play()
    task.delay(0.05, function() --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u6
            [3] = u7
        --]]
        local v8 = u1
        local v9 = u6
        local v10 = u7
        local v11 = {}
        local v12 = u6.CFrame
        local v13 = CFrame.Angles
        local v14 = math.random(130, 179)
        v11.CFrame = v12 * v13(0, math.rad(v14), 0)
        v8:Create(v9, v10, v11):Play()
        _G.destroy(u6, 0.5)
    end)
end
function v3.start(_, p16) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u15
        [3] = u1
    --]]
    if _G.checkRenderDistance(p16.PrimaryPart.Position) then
        local v17 = p16:WaitForChild("HumanoidRootPart")
        local v18 = script:FindFirstChild("Initial"):Clone()
        _G.customWeld(v18, v17, CFrame.new(0, 0, 3), v18)
        require(script.Parent.BusoColor):applyColors(p16, v18)
        v18.Parent = u4
        _G.customEmit(v18)
        u15(v17)
        task.wait(0.15)
        _G.customEmit(v18)
        _G.destroy(v18, 0.75)
        u15(v17)
        task.wait(0.33)
        local v19 = script:FindFirstChild("Final"):Clone()
        require(script.Parent.BusoColor):applyColors(p16, v19)
        _G.customWeld(v19, v17, CFrame.new(), v19)
        v19.Parent = u4
        _G.customEmit(v19)
        _G.destroy(v19, 1.5)
        local v20 = RaycastParams.new()
        v20.FilterType = Enum.RaycastFilterType.Whitelist
        v20.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
        local v21 = workspace:Raycast(v17.Position, Vector3.new(0, -5, 0), v20)
        if v21 then
            local v22 = v21.Normal:Dot(Vector3.new(0, 1, 0))
            local v23 = math.acos(v22)
            local v24 = math.rad(v23)
            local v25 = v21.Normal:Dot(p16.PrimaryPart.CFrame.LookVector)
            local v26 = math.sign(v25)
            local v27 = CFrame.new(v21.Position, v21.Position + p16.PrimaryPart.CFrame.LookVector) * CFrame.Angles(1.5707963267948966 - v26 * v24, 0, 0)
            local u28 = script:FindFirstChild("Upper"):Clone()
            u28.CFrame = v27 * CFrame.Angles(0, 0, -1.5707963267948966) * CFrame.new(4, 0, 0)
            u28.Size = Vector3.new(12, 5, 0.1)
            u28.Lower.Size = Vector3.new(0, 10, 0.05)
            require(script.Parent.BusoColor):applyColors(p16, u28)
            u28.Parent = u4
            local u29 = TweenInfo.new(0.75, Enum.EasingStyle.Exponential)
            _G.tween(u28, { 0.3, "MozillaCurve", "Out" }, {
                ["Size"] = Vector3.new(25, 2, 0)
            })
            _G.tween(u28.Lower, { 0.3, "MozillaCurve", "Out" }, {
                ["Size"] = Vector3.new(25, 6, 0)
            })
            if p16:FindFirstChild("BusoSword") == nil then
                u1:Create(u28.Texture, u29, {
                    ["Transparency"] = -2,
                    ["Color3"] = Color3.fromRGB(300, 400, 1000)
                }):Play()
            else
                u1:Create(u28.Texture, u29, {
                    ["Transparency"] = -2
                }):Play()
            end
            task.delay(1 + u29.Time, function() --[[ Line: 85 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u28
                    [3] = u29
                --]]
                local v30 = TweenInfo.new(1.3)
                u1:Create(u28.Texture, v30, {
                    ["Transparency"] = 1
                }):Play()
                u1:Create(u28.Lower.Texture, u29, {
                    ["Transparency"] = 1
                }):Play()
                _G.destroy(u28, v30.Time)
            end)
        end
    end
end
return v3