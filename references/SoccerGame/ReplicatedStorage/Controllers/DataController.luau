  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Signal = require(ReplicatedStorage.Packages.Signal);
local Promise = require(ReplicatedStorage.Packages.Promise);
local ReplicaService = require(ReplicatedStorage.Shared.ReplicaService);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = Signal.new();
local u3 = Knit.CreateController({
    Name = "DataController"
});

function u3.Get(p4: table, p5: userdata?) -- Line: 20
    return select(2, p4:GetAsync(p5):await());
end;

function u3.GetAsync(p6: table, p7: userdata?) -- Line: 24
    -- upvalues: LocalPlayer (copy), u1 (copy), Promise (copy), u2 (copy)
    local u8 = p7 or LocalPlayer;
    local v9 = u1[u8];

    return v9 and Promise.resolve(v9) or Promise.fromEvent(u2, function(p10: any, p11: userdata) -- Line: 27
        -- upvalues: u8 (copy)
        return p11 == u8;
    end);
end;

function u3.Add(p12, p13) -- Line: 32
    -- upvalues: u1 (copy), LocalPlayer (copy), u3 (copy), u2 (copy)
    local Player = p13.Tags.Player;

    if Player and Player:IsA("Player") then
        u1[Player] = p13;
        p13:AddCleanupTask(function() -- Line: 39
            -- upvalues: u1 (ref), Player (copy)
            u1[Player] = nil;
        end);

        if Player == LocalPlayer then
            u3.Instance = p13;
        end;

        return u2:Fire(p13, Player);
    end;
end;

function u3.KnitStart(u14) -- Line: 50
    -- upvalues: ReplicaService (copy)
    ReplicaService.ReplicaOfClassCreated("Profiles", function(p15) -- Line: 51
        -- upvalues: u14 (copy)
        u14:Add(p15);
    end);
    ReplicaService.RequestData();
end;

return u3;