 

game:GetService("TweenService")
local u1 = false
local u2 = Color3.fromHSV(0, 1, 1)
local u5 = {
    ["_batchUpdate"] = function(_) --[[ Name: _batchUpdate, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if u1 then
            return u2
        end
        u1 = true
        task.delay(0.016666666666666666, function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            u2 = Color3.fromHSV(os.clock() % 1, 1, 1)
            u1 = false
        end)
        return u2
    end,
    ["Render"] = function(_, p3) --[[ Name: Render, Line 19 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return {
            ["TextLabel"] = p3.TextLabel,
            ["Started"] = os.clock(),
            ["Module"] = u5
        }
    end,
    ["Update"] = function(_, p4) --[[ Name: Update, Line 27 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        p4.TextLabel.TextColor3 = u5:_batchUpdate()
    end
}
return u5