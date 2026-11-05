  

 

local RunService = game:GetService("RunService");
require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsFolder = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("EffectsFolder");
local u1 = {
    Cache = {}
};

function u1.GetEffect(p2) -- Line: 17
    -- upvalues: u1 (copy), EffectsFolder (copy)
    if u1.Cache[p2] then
        return u1.Cache[p2];
    end;

    for _, descendant in EffectsFolder:GetDescendants() do
        if descendant:IsA("ModuleScript") and descendant.Name == p2 then
            local v3 = require(descendant);

            if type(v3) == "function" then
                u1.Cache[p2] = v3;
            elseif type(v3) == "table" then
                if v3.Init and not v3.Inited then
                    v3.Init(u1);
                    v3.Inited = true;
                end;

                u1.Cache[p2] = v3;
            end;
        end;
    end;

    return u1.Cache[p2];
end;

function u1.CallEffect(p4, ...) -- Line: 39
    -- upvalues: u1 (copy)
    local v5 = u1.GetEffect(p4);

    if type(v5) == "function" then
        return v5(...);
    end;

    warn(p4, "is not an effect function");
end;

function u1.CallEffects(p6) -- Line: 45
    -- upvalues: u1 (copy)
    for _, v in p6 or {} do
        task.spawn(u1.CallEffect, v.Name, unpack(v.Data or {}));
    end;
end;

function u1.Wait(p7) -- Line: 56
    -- upvalues: RunService (copy)
    local v8 = 0;

    repeat
        v8 = v8 + RunService.Heartbeat:Wait();
    until (p7 or 0.016666666666666666) <= v8;

    return v8;
end;

u1.GetEffect("UmbraVFX");
u1.GetEffect("VergilVFX");
u1.GetEffect("MirageBladesVFX");
u1.GetEffect("Sharm Rocks");
task.delay(5, function() -- Line: 71
    -- upvalues: EffectsFolder (copy), u1 (copy)
    for _, descendant in EffectsFolder:GetDescendants() do
        if descendant:IsA("ModuleScript") and descendant:GetAttribute("RunImmediate") ~= nil then
            task.delay(2, function() -- Line: 75
                -- upvalues: descendant (copy), u1 (ref)
                local v9 = require(descendant);

                if type(v9) == "table" and not v9.Inited then
                    v9.Init(u1);
                    v9.Inited = true;
                end;
            end);
        end;
    end;
end);

return u1;