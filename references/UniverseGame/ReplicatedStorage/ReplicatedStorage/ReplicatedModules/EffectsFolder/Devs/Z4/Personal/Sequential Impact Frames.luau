  

 

game:GetService("CollectionService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

return function(p2) -- Line: 11
    -- upvalues: u1 (copy), EffectsHandler (copy), LocalPlayer (copy), Sequence_V2 (copy)
    local v3 = p2 or {};
    local v4 = v3.Frames or {};
    local Character = v3.Character;
    local v5 = v3.Players or {};
    local Speed = v3.Speed;
    local Identifier = v3.Identifier;
    local BypassSettings = v3.BypassSettings;
    local v6 = #v4;

    if not (Character and Identifier) then
        return;
    end;

    if v3.Preload or false then
        u1[Identifier] = {};

        for i = 1, v6 do
            local v7 = v4[i] or {};
            local v8 = v7[2] or {};
            local v9 = v8.Time or 0.25;
            local u10 = v8.Decals or {};
            u1[Identifier][i] = {
                Frame = v7[1],
                Serializer = os.clock(),
                Time = v9
            };
            task.spawn(function() -- Line: 43
                -- upvalues: EffectsHandler (ref), BypassSettings (copy), u1 (ref), Identifier (copy), i (copy), u10 (copy)
                EffectsHandler.CallEffect("Impact Frame", {
                    Type = "Image",
                    State = "Load",
                    BypassSettings = BypassSettings,
                    Identifier = u1[Identifier][i].Serializer,
                    Frames = u10
                });
            end);
        end;

        return;
    end;

    local u11 = table.find(v5, LocalPlayer);
    local u12 = Sequence_V2.new();
    u12:SetValidate(function(p13) -- Line: 60
        -- upvalues: Character (copy)
        return Character.Parent ~= nil;
    end);
    u12:SetSpeed(Speed);

    if not u1[Identifier] then
        u12:Destroy();

        return;
    end;

    for i = 1, v6 do
        local v14 = u1[Identifier][i];

        if v14 then
            local Serializer = v14.Serializer;
            local Time = v14.Time;
            u12:AddFrame(v14.Frame, function(p15) -- Line: 79
                -- upvalues: u11 (copy), EffectsHandler (ref), BypassSettings (copy), Time (copy), Serializer (copy)
                p15:GetCache("Cache");

                if u11 then
                    EffectsHandler.CallEffect("Impact Frame", {
                        Type = "Image",
                        State = "Play",
                        BypassSettings = BypassSettings,
                        Time = Time,
                        Identifier = Serializer
                    });
                end;
            end);
        else
            print("not found");
        end;
    end;

    u12:BindCallback("Ended", function() -- Line: 94
        -- upvalues: u12 (copy), u1 (ref), Identifier (copy)
        u12:Destroy();

        if u1[Identifier] then
            u1[Identifier] = nil;
        end;
    end);
    u12:BindCallback("Failed", function() -- Line: 102
        -- upvalues: u12 (copy), u1 (ref), Identifier (copy)
        u12:Destroy();

        if u1[Identifier] then
            u1[Identifier] = nil;
        end;
    end);
    u12:Play();
end;