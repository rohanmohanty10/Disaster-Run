  

 

local v1;

if game:GetService("RunService"):IsServer() then
    v1 = require(game.ServerScriptService.ServerLibrary.PathShortcuts);
else
    v1 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
end;

local Knit = require(v1.KnitPath.Knit);
local u2 = {};
local Trove = require(Knit.Util.Trove);
local Promise = require(Knit.Util.Promise);

function u2.new() -- Line: 9
    -- upvalues: Trove (copy), u2 (copy)
    local u3 = {
        Trove = Trove.new(),
        __Modules = {},
        __Started = false
    };
    u3.Trove:Add(function() -- Line: 16
        -- upvalues: u3 (copy)
        task.delay(1, u3.Destroy, u3);
    end);

    for i, v in pairs(u2) do
        u3[i] = v;
    end;

    return u3;
end;

function u2.AddHandler(u4, u5, u6) -- Line: 27
    -- upvalues: Promise (copy)
    if u6 == nil then
        u6 = u5;
        u5 = u6:GetAttribute("Name") or u6.Name;
    end;

    if u6:IsA("ModuleScript") then
        Promise.new(function(p7, p8) -- Line: 40
            -- upvalues: u6 (ref)
            local v9 = require(u6);

            if v9 then
                p7(v9);
            end;
        end):andThen(function(p10) -- Line: 45
            -- upvalues: u6 (ref), u4 (copy), u5 (ref)
            local v11, v12;

            if typeof(p10) == "table" then
                local v13 = u6:GetAttribute("Name") or p10.Name;

                for _, v in ipairs(p10) do
                    if typeof(v) == "Instance" and v:IsA("ModuleScript") then
                        if v13 then
                            u4:AddHandler(v13 .. "_" .. v.Name, v);
                        else
                            u4:AddHandler(v);
                        end;
                    end;
                end;

                v11 = p10.Init;
                v12 = p10.Start;
            else
                v11 = p10;
                v12 = nil;
            end;

            if not u4.__Modules[u5] and (v11 or v12) then
                local v14 = {
                    Name = u5,
                    Module = u6,
                    Init = v11,
                    Start = v12,
                    Trove = u4.Trove
                };
                u4.__Modules[u5] = v14;

                if u5 == "Aim" then
                    print(v14);
                end;

                if v14.Init then
                    v14.Init(u4, v14.Trove, v14);
                end;

                if v14.Start and u4.__Started then
                    v14.Start(u4, v14.Trove, v14);
                end;
            end;
        end):catch(function(p15) -- Line: 92
            warn(p15);
        end):await();

        return;
    end;

    for _, child in pairs(u6:GetChildren()) do
        u4:AddHandler(child);
    end;
end;

function u2.Remove(p16, p17) -- Line: 97
    if typeof(p17) == "Instance" then
        for i, v in pairs(p16.__Modules) do
            if v.Module == p17 then
                v.Trove:Destroy();
                p16.__Modules[i] = nil;

                return;
            end;
        end;

        return;
    end;

    local v18 = p16.__Modules[p17];

    if v18 then
        v18.Trove:Destroy();
        p16.__Modules[p17] = nil;
    end;
end;

function u2.Start(p19) -- Line: 117
    if p19.__Started then
        return;
    end;

    p19.__Started = true;

    for _, v in pairs(p19.__Modules) do
        if v.Start then
            v.Start(p19, v.Trove, v);
        end;
    end;
end;

function u2.Clear(p20) -- Line: 131
    for i, v in pairs(p20.__Modules) do
        if v.Trove and getmetatable(v.Trove) then
            v.Trove:Destroy();
            p20.__Modules[i] = nil;
        end;
    end;
end;

function u2.Destroy(p21) -- Line: 140
    p21:Clear();

    if p21.Trove and getmetatable(p21.Trove) then
        p21.Trove:Destroy();
    end;
end;

return u2;