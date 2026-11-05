  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Signal = require(Knit.Util.Signal);
local v1 = {};

if Core.Context ~= "Client" then
    return v1;
end;

function v1.Init(u2) -- Line: 23
    -- upvalues: Signal (copy)
    u2.StunTable = {};
    u2.Stunned = Signal.new();
    u2.StunEnded = Signal.new();

    function u2.GetStunTable(p3) -- Line: 28
        -- upvalues: u2 (copy)
        return u2.StunTable[p3];
    end;

    function u2.IsStunned(p4, p5) -- Line: 32
        -- upvalues: u2 (copy)
        local v6;

        if p5 then
            v6 = p5.MinPriority or p5.Priority;
        else
            v6 = p5;
        end;

        if p5 then
            p5 = p5.MaxPriority;
        end;

        local v7 = u2.GetStunTable(p4);

        if v7 then
            for i, _ in pairs(v7) do
                if (not v6 or v6 <= i) and (not p5 or i <= p5) then
                    return true;
                end;
            end;
        end;

        return false;
    end;
end;

function v1.Start(u8) -- Line: 49
    -- upvalues: PathShortcuts (copy)
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
    u8.Remotes.Stunned:Connect(function(p9) -- Line: 52
        -- upvalues: u8 (copy)
        local Character = p9.Character;
        local Data = p9.Data;

        if not Character then
            return;
        end;

        local v10 = u8.GetStunTable(Character);

        if not v10 then
            v10 = {};
            u8.StunTable[Character] = v10;
        end;

        v10[Data.Priority or 0] = Data;
        u8.Stunned:Fire(Character, Data);
    end);
    u8.Remotes.StunEnded:Connect(function(p11) -- Line: 67
        -- upvalues: u8 (copy)
        local Character = p11.Character;
        local Data = p11.Data;
        local v12 = u8.GetStunTable(Character);

        if v12 then
            v12[Data.Priority or 0] = nil;

            if not next(v12) then
                u8.StunTable[Character] = nil;
            end;
        end;

        u8.StunEnded:Fire(Character, Data);
    end);
end;

return v1;