 

local u1 = game:GetService("TweenService")
local u3 = {
    ["SineMode"] = function(p2) --[[ Line: 6 ]]
        return TweenInfo.new(p2, Enum.EasingStyle.Sine)
    end
}
local function u4(...) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1:Create(...)
end
return {
    ["Shrink"] = function(p5, p6) --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local u7 = u4(p5, u3.SineMode(p6), {
            ["Size"] = Vector3.new(0, 0, 0)
        })
        u7:Play()
        task.spawn(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7.Completed:Wait()
            u7:Destroy()
        end)
    end,
    ["Melt"] = function(p8, p9) --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local v10 = u4
        local v11 = u3.SineMode(p9)
        local v12 = {}
        local v13 = p8.Position
        local v14 = -p8.Size.X * 1.5
        v12.Position = v13 + Vector3.new(0, v14, 0)
        local u15 = v10(p8, v11, v12)
        u15:Play()
        task.spawn(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15.Completed:Wait()
            u15:Destroy()
        end)
    end,
    ["FadeOut"] = function(p16, p17) --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local u18 = u4(p16, u3.SineMode(p17), {
            ["Transparency"] = 1
        })
        u18:Play()
        task.spawn(function() --[[ Line: 47 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18.Completed:Wait()
            u18:Destroy()
        end)
    end,
    ["Enlarge"] = function(p19, p20, p21) --[[ Line: 54 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local v22 = p19.Size
        p19.CFrame = p21.CFrame
        p19.Size = Vector3.new(0, 0, 0)
        local u23 = u4(p19, u3.SineMode(p20), {
            ["Size"] = v22
        })
        u23:Play()
        task.spawn(function() --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u23
            --]]
            u23.Completed:Wait()
            u23:Destroy()
        end)
    end,
    ["Grow"] = function(p24, p25, p26) --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        p24.CFrame = p24.CFrame * CFrame.new(0, -p24.Size.X / 1.5, 0)
        local u27 = u4(p24, u3.SineMode(p25), p26)
        u27:Play()
        task.spawn(function() --[[ Line: 70 ]]
            --[[
            Upvalues:
                [1] = u27
            --]]
            u27.Completed:Wait()
            u27:Destroy()
        end)
    end,
    ["FadeIn"] = function(p28, p29, p30) --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        p28.CFrame = p30.CFrame
        local v31 = p28.Transparency
        p28.Transparency = 1
        local u32 = u4(p28, u3.SineMode(p29), {
            ["Transparency"] = v31
        })
        u32:Play()
        task.spawn(function() --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u32
            --]]
            u32.Completed:Wait()
            u32:Destroy()
        end)
    end
}