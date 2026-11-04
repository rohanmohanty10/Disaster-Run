 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("LocalizationService")
local u3 = game:GetService("RunService")
local u4 = v1("Promise")
return {
    ["promiseTranslator"] = function(u5) --[[ Name: promiseTranslator, Line 15 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u3
        --]]
        local u13 = u4.spawn(function(p6, p7) --[[ Line: 16 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u5
            --]]
            local u8 = nil
            local v9, v10 = pcall(function() --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u5
                --]]
                u8 = u2:GetTranslatorForPlayerAsync(u5)
            end)
            if v9 then
                if u8 then
                    local v11 = u8
                    local v12 = typeof(v11) == "Instance"
                    assert(v12, "Bad translator")
                    p6(u8)
                else
                    p7("Translator was not returned")
                end
            else
                p7(v10 or "Failed to GetTranslatorForPlayerAsync")
                return
            end
        end)
        local u14 = u3:IsStudio() and 0.5 or 20
        task.delay(u14, function() --[[ Line: 43 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u14
            --]]
            if u13:IsPending() then
                u13:Reject(("GetTranslatorForPlayerAsync is still pending after %f, using local table"):format(u14))
            end
        end)
        return u13:Catch(function(p15) --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u5
            --]]
            if p15 ~= "Publishing the game is required to use GetTranslatorForPlayerAsync API." then
                warn(("[LocalizationServiceUtils.promiseTranslator] - %s"):format((tostring(p15))))
            end
            return u2:GetTranslatorForPlayer(u5)
        end)
    end
}