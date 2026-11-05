  

 

local Constants = require(script.Parent.Parent.Constants);
local wallyInstanceManager = require(script.Parent.Parent.Parent.wallyInstanceManager);
require(script.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Utilities.Output);
local u1 = {};
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = nil;

function u1.start() -- Line: 14
    -- upvalues: wallyInstanceManager (copy), u5 (ref), u1 (copy)
    local v6 = wallyInstanceManager.get(script.Parent.Parent.Parent, "identifierStorage");

    if v6 then
        u5 = v6;
    else
        u5 = Instance.new("Folder");
        u5.Name = "identifierStorage";
        wallyInstanceManager.add(script.Parent.Parent.Parent, u5);
    end;

    u1.ref("NIL_VALUE");
    u1.ref("REQUEST");
end;

function u1.ref(p7) -- Line: 28
    -- upvalues: u3 (copy), Output (copy), u2 (ref), Constants (copy), u5 (ref), u4 (copy)
    if u3[p7] ~= nil then
        return u3[p7];
    end;

    Output.fatalAssert(u2 <= Constants.IDENTIFIER_CAP, (`cannot create any more identifiers - over {Constants.IDENTIFIER_CAP_STRING} cap.`));
    local v8;

    if u2 <= 255 then
        v8 = string.pack("B", u2);
    else
        v8 = string.pack("H", u2);
    end;

    u2 = u2 + 1;
    u5:SetAttribute(p7, v8);
    u3[p7] = v8;
    u4[v8] = p7;

    return v8;
end;

function u1.deser(p9) -- Line: 52
    -- upvalues: Output (copy), u4 (copy)
    Output.fatalAssert(typeof(p9) == "string", string.format("Deserialize takes string, got %*", (typeof(p9))));

    return u4[p9];
end;

function u1.ser(p10) -- Line: 60
    -- upvalues: Output (copy), u3 (copy)
    Output.fatalAssert(typeof(p10) == "string", string.format("Serialize takes string, got %*", (typeof(p10))));

    return u3[p10];
end;

return u1;