 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.TaskScheduler)
local function u18(p3, p4, p5, p6, p7, p8) --[[ Line: 4 ]]
    if p3.BurningPart.Enabled == true then
        local v9 = Instance.new("Attachment")
        v9.Parent = p3
        local v10 = v9:Clone()
        local v11 = script.Beam:Clone()
        if p8 then
            v11.Color = ColorSequence.new(p8)
        end
        v11.Parent = p3
        local v12 = (p3.CFrame * CFrame.new(0, 0, p6)).Position
        local v13 = math.random(-p7, p7)
        local v14 = math.random(-p7, p7)
        local v15 = math.random
        local v16 = -p7
        local v17 = v12 + Vector3.new(v13, v14, v15(v16, p7))
        v11.Width0 = math.random(p4, p5)
        v11.Attachment0 = v9
        v11.Attachment1 = v10
        v10.Parent = p3
        _G.tween(v10, {
            0.25,
            Enum.EasingStyle.Exponential,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["WorldPosition"] = v17
        })
        _G.tween(v11, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Width0"] = 0,
            ["Width1"] = 0
        })
        _G.destroy(v11, 0.25)
    end
end
function v1.start(_, p19, u20) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u18
    --]]
    local u21 = _G.awaitObject(p19)
    if u21 == nil then
        return
    end
    if _G.checkRenderDistance(u21.Position) == false then
        return
    end
    local v22 = u2:CreateScheduler(25)
    task.spawn(function() --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u20
        --]]
        for v23 = 1, 10 do
            task.wait()
            if u21.Name ~= "Fist" or (u21.Parent == nil or (not u21:FindFirstChild("BurningPart") or u21.BurningPart.Enabled ~= true)) then
                break
            end
            local v24 = 10 - v23
            local v25 = u21.Attachment.BurningPart:Clone()
            if u20 then
                _G.PlayEffect("3SSRecolor", nil, v25, u20, "isRed")
            end
            v25.Name = "b"
            v25.Parent = u21.Attachment
            v25.Drag = 5
            v25.Size = NumberSequence.new(v24 * 2, 0)
            v25.Speed = NumberRange.new(v24 * 25)
            v25:SetAttribute("EmitCount", 75)
            _G.customEmit(v25)
        end
    end)
    local u26 = 30
    local u27 = 40
    local u28 = 50
    local u29 = 50
    if u21.Name == "Fist" then
        for _ = 1, 100 do
            if u21:FindFirstChild("BurningPart") == nil then
                break
            end
            u18(u21, u26, u27, u28, u29, u20)
            game["Run Service"].RenderStepped:Wait()
        end
    else
        local v30 = u21:FindFirstChild("BurningPart")
        while true do
            game["Run Service"].RenderStepped:Wait()
            if (u21.Position - workspace.CurrentCamera.CFrame.Position).Magnitude > 1000 or u21:FindFirstChild("BurningPart") == nil then
                break
            end
            v22:QueueTask(function() --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u21
                    [3] = u27
                    [4] = u26
                    [5] = u28
                    [6] = u18
                    [7] = u20
                --]]
                if _G.fastmodee ~= true or math.random(1, 2) ~= 1 then
                    u29 = u21.Size.X * 2
                    u27 = u21.Size.X * 2
                    u26 = u21.Size.X / 2
                    u28 = u21.Size.X * 2
                    u18(u21, u26, u27, u28, u29, u20)
                end
            end)
            if v30 == nil or v30 and v30.Enabled == false then
                break
            end
        end
    end
    v22:Destroy()
end
return v1