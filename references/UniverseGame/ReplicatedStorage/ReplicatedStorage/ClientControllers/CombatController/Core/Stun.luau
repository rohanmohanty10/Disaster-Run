  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(Knit.Util.Signal);

return {
    Init = function(u1) -- Line: 18, Name: Init
        -- upvalues: Signal (copy)
        u1.StunTable = {};
        u1.Stunned = Signal.new();
        u1.StunEnded = Signal.new();

        function u1.GetStunTable(p2) -- Line: 23
            -- upvalues: u1 (copy)
            return u1.StunTable[p2];
        end;

        function u1.IsStunned(p3, p4) -- Line: 27
            -- upvalues: u1 (copy)
            local v5;

            if p4 then
                v5 = p4.MinPriority or p4.Priority;
            else
                v5 = p4;
            end;

            if p4 then
                p4 = p4.MaxPriority;
            end;

            local v6 = u1.GetStunTable(p3);

            if v6 then
                for i, _ in pairs(v6) do
                    if (not v5 or v5 <= i) and (not p4 or i <= p4) then
                        return true;
                    end;
                end;
            end;

            return false;
        end;
    end,

    Start = function(u7) -- Line: 44, Name: Start
        -- upvalues: PathShortcuts (copy)
        local v8 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
        v8:GetRemote("Stunned").OnClientEvent:Connect(function(p9) -- Line: 48
            -- upvalues: u7 (copy)
            local Character = p9.Character;
            local Data = p9.Data;
            local v10 = u7.GetStunTable(Character);

            if not v10 then
                v10 = {};
                u7.StunTable[Character] = v10;
            end;

            v10[Data.Priority or 0] = Data;
            u7.Stunned:Fire(Character, Data);
        end);
        v8:GetRemote("StunEnded").OnClientEvent:Connect(function(p11) -- Line: 60
            -- upvalues: u7 (copy)
            local Character = p11.Character;
            local Data = p11.Data;
            local v12 = u7.GetStunTable(Character);

            if v12 then
                v12[Data.Priority or 0] = nil;

                if not next(v12) then
                    u7.StunTable[Character] = nil;
                end;
            end;

            u7.StunEnded:Fire(Character, Data);
        end);
    end
};