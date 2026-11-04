 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = v1("Maid")
local u3 = v1("SoftShutdownTranslator")
local u4 = v1("SoftShutdownUI")
local u5 = v1("ServiceBag")
return function(p6) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u3
        [4] = u4
    --]]
    local u7 = u2.new()
    local v8 = u5.new()
    u7:GiveTask(v8)
    local v9 = v8:GetService(u3)
    local u10 = u4.new()
    u7:GiveTask(u10)
    u7:GivePromise(v9:PromiseFormatByKey("shutdown.lobby.title")):Then(function(p11) --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        u10:SetTitle(p11)
    end)
    u7:GivePromise(v9:PromiseFormatByKey("shutdown.lobby.subtitle")):Then(function(p12) --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        u10:SetSubtitle(p12)
    end)
    u10:Show()
    u10.Gui.Parent = p6
    return function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:DoCleaning()
    end
end