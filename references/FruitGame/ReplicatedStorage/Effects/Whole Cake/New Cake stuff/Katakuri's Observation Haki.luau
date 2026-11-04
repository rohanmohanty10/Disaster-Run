 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local u3 = v1.LocalPlayer
local _ = script.Parent
local u4 = script["Katakuri\'s Observation Haki"]
return {
    ["start"] = function(_, p5) --[[ Name: start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v6 = p5.Duration
        local u7 = u4:Clone()
        u7.Parent = u3.PlayerGui
        local function v8() --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u7
            --]]
            u2:Create(u7.ImageLabel, TweenInfo.new(1), {
                ["ImageTransparency"] = 1
            }):Play()
            task.delay(1, function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                u7:Destroy()
            end)
        end
        task.delay(v6, v8)
        while u7.Parent do
            u7.ImageLabel.Rotation = math.random(360)
            task.wait(0.05)
        end
    end
}