 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("Players")
local u3 = v1("Promise")
return {
    ["promiseUserThumbnail"] = function(u4, p5, p6) --[[ Name: promiseUserThumbnail, Line 31 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v7 = type(u4) == "number"
        assert(v7, "Bad userId")
        local u8 = p5 or Enum.ThumbnailType.HeadShot
        local u9 = p6 or Enum.ThumbnailSize.Size100x100
        local u10 = nil
        u10 = u3.spawn(function(p11, p12) --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
                [3] = u8
                [4] = u9
                [5] = u10
            --]]
            local v13 = 0
            while true do
                v13 = v13 + 1
                local u14 = nil
                local u15 = nil
                local v18, v19 = pcall(function() --[[ Line: 42 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u15
                        [3] = u2
                        [4] = u4
                        [5] = u8
                        [6] = u9
                    --]]
                    local v16, v17 = u2:GetUserThumbnailAsync(u4, u8, u9)
                    u14 = v16
                    u15 = v17
                end)
                if not v18 then
                    break
                end
                if u15 then
                    return p11(u14)
                end
                task.wait(0.05)
                if v13 >= 5 or not u10:IsPending() then
                    p12()
                    return
                end
            end
            return p12(v19)
        end)
        return u10
    end,
    ["promiseUserName"] = function(u20) --[[ Name: promiseUserName, Line 68 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v21 = type(u20) == "number"
        assert(v21, "Bad userId")
        local u22 = nil
        u22 = u3.spawn(function(p23, p24) --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u20
                [3] = u22
            --]]
            local v25 = 0
            while true do
                v25 = v25 + 1
                local u26 = nil
                local v27, v28 = pcall(function() --[[ Line: 77 ]]
                    --[[
                    Upvalues:
                        [1] = u26
                        [2] = u2
                        [3] = u20
                    --]]
                    u26 = u2:GetNameFromUserIdAsync(u20)
                end)
                if not v27 then
                    break
                end
                local v29 = u26
                if type(v29) == "string" then
                    return p23(u26)
                end
                task.wait(0.05)
                if v25 >= 5 or not u22:IsPending() then
                    p24()
                    return
                end
            end
            return p24(v28)
        end)
        return u22
    end
}