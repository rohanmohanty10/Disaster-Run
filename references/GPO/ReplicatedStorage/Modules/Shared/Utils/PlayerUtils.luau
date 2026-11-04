 

local u1 = game:GetService("Players")
local v2 = script.Parent.Parent.Promises
local u3 = require(v2.Promise)
local v4 = {}
local u5 = {}
function v4.PromiseUserThumbnail(u6) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u1
    --]]
    return u3.spawn(function(p7, p8) --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u1
        --]]
        if u5[u6] == nil then
            local u9 = nil
            local v10, v11 = pcall(function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u1
                    [3] = u6
                --]]
                u9 = u1:GetUserThumbnailAsync(u6, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            end)
            if not v10 then
                p8(v11)
            end
            if u5[u6] ~= nil then
                u5[u6] = u9
            end
            p7(u9)
        else
            p7(u5[u6])
        end
    end)
end
function v4.Initialize() --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    u1.PlayerRemoving:Connect(function(p12) --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        if u5[p12.UserId] ~= nil then
            u5[p12.UserId] = nil
        end
    end)
end
return v4