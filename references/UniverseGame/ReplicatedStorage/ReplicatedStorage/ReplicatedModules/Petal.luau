  

 

local Classes = script.Classes;
local Constructors = script.Constructors;
local CoreModules = script.CoreModules;
local u1 = require;
local Types = require(CoreModules.Types);
local u2 = require(CoreModules.LazyLoading)();

for _, child in pairs(Constructors:GetChildren()) do
    u2:push(child, "Constructors");
end;

for _, child in pairs(Classes:GetChildren()) do
    u2:push(child, "Classes");
end;

return setmetatable({
    Require = u1,
    Types = Types,
    LazyLoader = u2
}, {
    __index = function(p3, p4) -- Line: 26, Name: __index
        -- upvalues: u2 (copy)
        local v5 = p4:split("/");

        return u2:pull(unpack(v5)) or nil;
    end,

    __call = function(p6, p7) -- Line: 35, Name: __call
        -- upvalues: u2 (copy), u1 (copy)
        local v8 = u2:pull(p7, "Constructors");

        if v8 then
            return u1(v8)(p6);
        end;

        return nil;
    end
});