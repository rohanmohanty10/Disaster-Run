 

 

local l__Fiu__1 = require(script:WaitForChild("Fiu"));
local l__LuauInLuau__2 = require(script:WaitForChild("LuauInLuau"));
local function u2(p1) --[[ Line: 51 ]]
    return string.unpack(">B", p1, 1) == 3;
end;
function luau_compile(p3, p4)
    -- upvalues: l__LuauInLuau__2 (copy)
    local v5, v6 = l__LuauInLuau__2.Compile(p3);
    return v5 == true and v6 and v6 or error((p4 or "@") .. v6:sub(2), 0);
end;
function luau_load(p7, p8)
    -- upvalues: u2 (copy), l__Fiu__1 (copy)
    local v9 = u2(p7);
    assert(v9, "luau_load: Argument #1 got invalid bytecode (v3 bytecode expected)");
    local v10 = type(p8) == "table" and true or p8 == nil;
    local v11 = typeof(p8);
    assert(v10, ("luau_load: Argument #2 got \'%s\' (table expected)"):format(v11));
    return l__Fiu__1.luau_load(p7, p8 or getfenv(2));
end;
return setmetatable({
    luau_compile = luau_compile,
    luau_load = luau_load,
    luau_execute = function(p12, p13, p14) --[[ Name: luau_execute, Line 67 ]]
        -- upvalues: u2 (copy)
        if u2(p12) then
            return luau_load(p12, p13);
        else
            return luau_load(luau_compile(p12, p14), p13 or getfenv(2));
        end;
    end,
    create_env = function(u15) --[[ Name: create_env, Line 73 ]]
        local u16 = getfenv(2);
        return setmetatable({}, {
            __index = function(_, p17) --[[ Name: __index, Line 76 ]]
                -- upvalues: u15 (copy), u16 (copy)
                return u15[p17] or u16[p17];
            end
        });
    end
}, {
    __call = function(p18, p19, p20, p21) --[[ Name: __call, Line 83 ]]
        return p18.luau_execute(p19, p20 or getfenv(2), p21);
    end
});