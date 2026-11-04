 

local u9 = {
    ["Emit"] = function(p1) --[[ Line: 2 ]]
        for _, u2 in p1:GetDescendants() do
            if u2:IsA("ParticleEmitter") then
                task.delay(u2:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 5 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    u2:Emit(u2:GetAttribute("EmitCount"))
                end)
            end
        end
    end,
    ["EnableEmit"] = function(u3) --[[ Line: 11 ]]
        task.spawn(function() --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            for _, u4 in u3:GetDescendants() do
                if u4:IsA("ParticleEmitter") then
                    if u4:GetAttribute("EmitCount") then
                        task.delay(u4:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 16 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                            --]]
                            u4:Emit(u4:GetAttribute("EmitCount"))
                        end)
                    end
                    if u4:GetAttribute("EmitDuration") then
                        task.delay(u4:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 21 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                            --]]
                            u4.Enabled = true
                            task.wait(u4:GetAttribute("EmitDuration"))
                            u4.Enabled = false
                        end)
                    end
                end
                if u4:IsA("Trail") and u4:GetAttribute("EmitDuration") then
                    task.delay(u4:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 30 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                        --]]
                        u4.Enabled = true
                        task.wait(u4:GetAttribute("EmitDuration"))
                        u4.Enabled = false
                    end)
                end
            end
        end)
    end,
    ["EmitTrail"] = function(u5) --[[ Line: 41 ]]
        if u5:GetAttribute("EmitDuration") then
            task.delay(u5:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                u5.Enabled = true
                task.wait(u5:GetAttribute("EmitDuration"))
                u5.Enabled = false
            end)
        end
    end,
    ["EnableEmitSingle"] = function(u6) --[[ Line: 51 ]]
        task.spawn(function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            if u6:IsA("Trail") and u6:GetAttribute("EmitDuration") then
                task.delay(u6:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 55 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    u6.Enabled = true
                    task.wait(u6:GetAttribute("EmitDuration"))
                    u6.Enabled = false
                end)
            end
            if u6:IsA("ParticleEmitter") then
                if u6:GetAttribute("EmitCount") then
                    task.delay(u6:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 64 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                        --]]
                        u6:Emit(u6:GetAttribute("EmitCount"))
                    end)
                end
                if u6:GetAttribute("EmitDuration") then
                    task.delay(u6:GetAttribute("EmitDelay") or 0.001, function() --[[ Line: 69 ]]
                        --[[
                        Upvalues:
                            [1] = u6
                        --]]
                        u6.Enabled = true
                        task.wait(u6:GetAttribute("EmitDuration"))
                        u6.Enabled = false
                    end)
                end
            end
        end)
    end,
    ["EnableEmitChildrenAndRepeatForAttachments"] = function(u7) --[[ Line: 79 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        task.spawn(function() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u9
            --]]
            for _, v8 in u7:GetChildren() do
                u9.EnableEmitSingle(v8)
                if v8:IsA("Attachment") then
                    u9.EnableEmitChildrenAndRepeatForAttachments(v8)
                end
            end
        end)
    end
}
return u9