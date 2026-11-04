 

local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("ServerScriptService")
local u3 = game:GetService("RunService")
local u4 = require(script.LegacyLoader)
local v5 = require(script.StaticLegacyLoader)
local u6 = require(script.LoaderUtils)
local u7, v8
if u3:IsRunning() then
    u7 = u4.new(script)
    v8 = {
        ["__call"] = function(_, p9) --[[ Name: __call, Line 28 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            return u7:Require(p9)
        end,
        ["__index"] = function(_, p10) --[[ Name: __index, Line 31 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            return u7:Require(p10)
        end
    }
else
    local u11 = v5.new()
    v8 = {
        ["__call"] = function(_, p12) --[[ Name: __call, Line 38 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            return u11:Require(getfenv(2).script, p12)
        end,
        ["__index"] = function(_, p13) --[[ Name: __index, Line 42 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            return u11:Require(getfenv(2).script, p13)
        end
    }
    u7 = u11
end
local v26 = {
    ["load"] = function(p14) --[[ Name: handleLoad, Line 127 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        local v15 = typeof(p14) == "Instance"
        assert(v15, "Bad moduleScript")
        return u7:GetLoader(p14)
    end,
    ["bootstrapGame"] = function(p16) --[[ Name: bootstrapGame, Line 70 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u7
            [3] = u6
            [4] = u1
            [5] = u2
        --]]
        local v17 = typeof(p16) == "Instance"
        assert(v17, "Bad instance")
        local v18 = u3:IsRunning()
        assert(v18, "Game must be running")
        u7:Lock()
        local v19, v20, v21 = u6.toWallyFormat(p16, false)
        v19.Parent = u1
        v21.Parent = u1
        v20.Parent = u2
        return v20
    end,
    ["bootstrapPlugin"] = function(p22) --[[ Name: bootstrapPlugin, Line 85 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u6
        --]]
        local v23 = typeof(p22) == "Instance"
        assert(v23, "Bad instance")
        u7 = u4.new(script)
        u7:Lock()
        local u24 = u6.toWallyFormat(p22, true)
        u24.Parent = p22
        return function(p25) --[[ Line: 93 ]]
            --[[
            Upvalues:
                [1] = u24
            --]]
            if type(p25) ~= "string" then
                return require(p25)
            end
            if u24:FindFirstChild(p25) then
                return require(u24:FindFirstChild(p25))
            end
            error(("Unknown module %q"):format((tostring(p25))))
        end
    end
}
return setmetatable(v26, v8)