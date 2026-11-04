 

game:GetService("ReplicatedStorage")
return {
    ["start"] = function(_, u1) --[[ Name: start, Line 5 ]]
        task.delay(0.05, function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u2 = script.bloodBite.qqwq:Clone()
            u2.Parent = u1.PrimaryPart
            if u1:FindFirstChild("UpperTorso") then
                u2.Parent = u1.UpperTorso
            end
            task.defer(function() --[[ Line: 12 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                _G.customEmit(u2)
            end)
            _G.destroy(u2, 5)
        end)
    end
}