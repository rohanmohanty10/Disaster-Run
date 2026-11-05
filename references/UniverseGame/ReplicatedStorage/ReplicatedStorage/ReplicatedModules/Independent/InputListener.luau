  

 

local PathShortcuts = require(game.ServerScriptService.ServerLibrary.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Signal = require(PathShortcuts.KnitPath.Signal);
local clear = table.clear;
local u1 = {
    Listeners = {},
    MainListener = {}
};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 12
    -- upvalues: u1 (copy), Signal (copy)
    if not u1.Listeners[p2] then
        u1.Listeners[p2] = {};
    end;

    if u1.Listeners[p2][p3] then
        return u1.Listeners[p2][p3];
    end;

    local v4 = Signal.new();
    local v5 = {
        Signal = v4,
        ListenToInput = v4,
        Player = p2,
        Key = p3
    };
    u1.Listeners[p2][p3] = v5;
    setmetatable(v5, u1);

    return v5;
end;

function u1.AddToMainListener(u6) -- Line: 31
    -- upvalues: u1 (copy), Trove (copy)
    if typeof(u6) == "Instance" and not u1.MainListener[u6] then
        local u7 = Trove.new();
        u7:Connect(u6.AncestryChanged, function(p8, p9) -- Line: 34
            -- upvalues: u7 (copy)
            if not p9 then
                u7:Destroy();
            end;
        end);
        u7:Add(function() -- Line: 37
            -- upvalues: u1 (ref), u6 (copy)
            u1.MainListener[u6] = nil;
        end);
        u1.MainListener[u6] = {
            Trove = u7
        };
    end;
end;

function u1.RemoveFromMainListener(p10) -- Line: 46
    -- upvalues: u1 (copy)
    if u1.MainListener[p10] then
        u1.MainListener[p10].Trove:Destroy();
    end;
end;

function u1.HasListener(p11, p12) -- Line: 52
    -- upvalues: u1 (copy)
    return u1.Listeners[p11] and u1.Listeners[p11][p12] ~= nil;
end;

function u1.FireInput(p13, p14) -- Line: 56
    -- upvalues: u1 (copy)
    if type(p14) == "string" then
        if u1.Listeners[p13] then
            for _, v in pairs(u1.Listeners[p13]) do
                v.Signal:Fire(p14);
            end;
        end;

        if u1.MainListener[p13] and p14 ~= "Trove" then
            if p14:find("END-") then
                local v15 = p14:split("-")[2];
                u1.MainListener[p13][v15] = nil;

                return;
            end;

            u1.MainListener[p13][p14] = true;
        end;
    end;
end;

function u1.HasKeyDown(p16, p17) -- Line: 74
    -- upvalues: u1 (copy)
    if u1.MainListener[p16] then
        local v18 = type(p17) == "table" and p17 and p17 or { p17 };

        for _, v in ipairs(v18) do
            if not u1.MainListener[p16][v] then
                return;
            end;
        end;

        return true;
    end;
end;

function u1.Destroy(p19) -- Line: 84
    -- upvalues: u1 (copy)
    p19.Signal:Destroy();

    if u1.Listeners[p19.Player] and u1.Listeners[p19.Player][p19.Key] == p19 then
        u1.Listeners[p19.Player][p19.Key] = nil;
    end;
end;

game.Players.PlayerAdded:Connect(u1.AddToMainListener);
game.Players.PlayerRemoving:Connect(function(p20) -- Line: 92
    -- upvalues: u1 (copy), clear (copy)
    if u1.Listeners[p20] then
        clear(u1.Listeners[p20]);
        u1.Listeners[p20] = nil;
    end;

    u1.RemoveFromMainListener(p20);
end);

for _, v in ipairs(game.Players:GetPlayers()) do
    u1.AddToMainListener(v);
end;

workspace:WaitForChild("Living").ChildAdded:Connect(function(p21) -- Line: 104
    -- upvalues: u1 (copy)
    if not p21:GetAttribute("NPC") then
        return;
    end;

    u1.AddToMainListener(p21);
end);
workspace.Living.ChildRemoved:Connect(function(p22) -- Line: 108
    -- upvalues: u1 (copy), clear (copy)
    if u1.Listeners[p22] then
        clear(u1.Listeners[p22]);
        u1.Listeners[p22] = nil;
    end;

    u1.RemoveFromMainListener(p22);
end);
task.spawn(function() -- Line: 115
    -- upvalues: u1 (copy)
    for _, child in ipairs(workspace.Living:GetChildren()) do
        if not child:GetAttribute("NPC") then
            return;
        end;

        u1.AddToMainListener(child);
    end;
end);

return u1;