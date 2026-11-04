 

local function u1(...) --[[ Line: 1 ]]
    return ("[Forge Emit API]: %*"):format((table.concat({ ... }, " ")))
end
return {
    ["error"] = function(...) --[[ Name: error, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        error(u1(..., "\n"))
    end,
    ["warn"] = function(...) --[[ Name: warn, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        warn(u1(...))
        warn(u1(debug.traceback("stack trace:")))
    end,
    ["info"] = function(...) --[[ Name: info, Line 16 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        print(u1(...))
    end
}