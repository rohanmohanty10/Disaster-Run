  

 

local wallyInstanceManager = require(script.Parent.Parent.Parent.wallyInstanceManager);
require(script.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Utilities.Output);
local u1 = nil;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};

function u5.start() -- Line: 13
    -- upvalues: u1 (ref), wallyInstanceManager (copy), u2 (copy), u3 (copy), u5 (copy)
    u1 = wallyInstanceManager.waitForInstance(script.Parent.Parent.Parent, "identifierStorage", 1);

    for i, v in u1:GetAttributes() do
        u2[i] = v;
        u3[v] = i;
        u5.loadIdentifier(i, v);
    end;

    u1.AttributeChanged:Connect(function(p6) -- Line: 25
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u5 (ref)
        local v7 = u1:GetAttribute(p6);

        if v7 then
            u2[p6] = v7;
            u3[v7] = p6;
            u5.loadIdentifier(p6, v7);

            return;
        end;

        local v8 = u2[p6];
        u2[p6] = nil;
        u3[v8] = nil;
    end);
    u5.ref("NIL_VALUE", 3, false);
    u5.ref("REQUEST", 3, false);
end;

function u5.loadIdentifier(p9, p10) -- Line: 47
    -- upvalues: u4 (copy)
    if not u4[p9] then
        return;
    end;

    local v11 = {};

    for i, v in u4[p9] do
        task.spawn(v, p10);
        table.insert(v11, i);
    end;

    for _, v in v11 do
        table.remove(u4[p9], v);
    end;
end;

function u5.waitForIdentifier(u12, p13, u14) -- Line: 70
    -- upvalues: u2 (copy), u4 (copy), Output (copy)
    local v15 = u2[u12];

    if v15 then
        return v15;
    end;

    if not u4[u12] then
        u4[u12] = {};
    end;

    local u16 = coroutine.running();
    table.insert(u4[u12], u16);
    task.delay(p13 or 1, function() -- Line: 86
        -- upvalues: u4 (ref), u12 (copy), u16 (copy), Output (ref), u14 (copy)
        if table.find(u4[u12], u16) then
            Output.fatal((`reached max wait time for {u14 and "bridge" or "identifier"} {u12}, broke yield. Did you forget to implement it on the server?`));
        end;
    end);

    return coroutine.yield();
end;

function u5.ref(p17, p18, p19) -- Line: 98
    -- upvalues: Output (copy), u2 (copy), u5 (copy)
    Output.typecheck("string", "ReferenceIdentifier", "identifierName", p17);

    if p18 ~= nil then
        Output.typecheck("number", "ReferenceIdentifier", "maxWaitTime", p18);
    end;

    return u2[p17] or u5.waitForIdentifier(p17, p18 or 1, p19);
end;

function u5.deser(p20) -- Line: 114
    -- upvalues: Output (copy), u3 (copy)
    Output.fatalAssert(typeof(p20) == "string", string.format("Deserialize takes string, got %*", (typeof(p20))));

    return u3[p20];
end;

function u5.ser(p21) -- Line: 122
    -- upvalues: Output (copy), u2 (copy)
    Output.fatalAssert(typeof(p21) == "string", string.format("Serialize takes string, got %*", (typeof(p21))));

    return u2[p21];
end;

return u5;