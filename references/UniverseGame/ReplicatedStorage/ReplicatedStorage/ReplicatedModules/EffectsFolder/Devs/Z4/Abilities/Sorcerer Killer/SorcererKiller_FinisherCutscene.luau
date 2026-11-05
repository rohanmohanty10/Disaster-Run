  

 

game:GetService("CollectionService");
game:GetService("TweenService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = script.Name .. "1";
local u2 = script.Name .. "2";
local u3 = script.Name .. "3";

return function(p4) -- Line: 17
    -- upvalues: EffectsHandler (copy), u1 (copy), u2 (copy), u3 (copy), LocalPlayer (copy), Sequence_V2 (copy)
    local v5 = p4 or {};

    if v5 == "Preload" then
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u1,
            Frames = { "rbxassetid://95303052770754", "rbxassetid://94834358111211", "rbxassetid://101935498748798", "rbxassetid://98159782420230" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u2,
            Frames = { "rbxassetid://83484820548637", "rbxassetid://121847850016147", "rbxassetid://126121003184405", "rbxassetid://98159782420230" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u3,
            Frames = { "rbxassetid://105269920893185", "rbxassetid://125666047026314", "rbxassetid://135887139284592", "rbxassetid://98159782420230" }
        });

        return;
    end;

    local Speed = v5.Speed;
    local Character = v5.Character;
    local u6 = table.find(v5.Players, LocalPlayer);
    local u7 = Sequence_V2.new();
    u7:SetValidate(function(p8) -- Line: 64
        -- upvalues: Character (copy)
        return Character.Parent ~= nil;
    end);
    u7:SetSpeed(Speed);
    u7:AddFrame(0, function(p9) -- Line: 70
        -- upvalues: u6 (copy), EffectsHandler (ref), u1 (ref)
        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.3,
                Identifier = u1
            });
        end;
    end);
    u7:AddFrame(76, function(p10) -- Line: 82
        -- upvalues: u6 (copy), EffectsHandler (ref), u2 (ref)
        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.3,
                Identifier = u2
            });
        end;
    end);
    u7:AddFrame(226, function(p11) -- Line: 94
        -- upvalues: u6 (copy), EffectsHandler (ref), u3 (ref)
        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.3,
                Identifier = u3
            });
        end;
    end);
    u7:BindCallback("Ended", function() -- Line: 106
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
    u7:Play();
end;