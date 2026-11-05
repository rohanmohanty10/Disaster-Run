  

 

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
            Frames = { "rbxassetid://116541480588913", "rbxassetid://76820735732216", "rbxassetid://97548599983805", "rbxassetid://80883148816574" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u2,
            Frames = { "rbxassetid://115124151350212", "rbxassetid://79237064025177", "rbxassetid://135678935416212", "rbxassetid://111564573223037", "rbxassetid://71541650879102", "rbxassetid://123391749397218", "rbxassetid://134654623578615", "rbxassetid://117365123251040", "rbxassetid://114058613649389", "rbxassetid://134150723869615", "rbxassetid://128567943916200", "rbxassetid://114134827178108", "rbxassetid://93694553761376", "rbxassetid://122877291844202", "rbxassetid://125936293550391", "rbxassetid://87862336423491", "rbxassetid://107064156997747", "rbxassetid://134597645695879", "rbxassetid://131662323207326", "rbxassetid://131662323207326", "rbxassetid://130967118139957", "rbxassetid://97682129823204", "rbxassetid://105725311248660" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u3,
            Frames = { "rbxassetid://125432518665425", "rbxassetid://99162505405414", "rbxassetid://121808352118972", "rbxassetid://73264062782116", "rbxassetid://74089275038397" }
        });

        return;
    end;

    local Speed = v5.Speed;
    local Character = v5.Character;
    local Target = v5.Target;
    local u6 = table.find(v5.Players, LocalPlayer);
    local u7 = Sequence_V2.new();
    u7:SetValidate(function(p8) -- Line: 85
        -- upvalues: Character (copy), Target (copy)
        local v9;

        if Character.Parent == nil then
            v9 = false;
        else
            v9 = Target.Parent ~= nil;
        end;

        return v9;
    end);
    u7:SetSpeed(Speed);
    u7:AddFrame(1, function(p10) -- Line: 91
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
    u7:AddFrame(692, function(p11) -- Line: 103
        -- upvalues: u6 (copy), EffectsHandler (ref), u2 (ref)
        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.5,
                Identifier = u2
            });
        end;
    end);
    u7:AddFrame(754, function(p12) -- Line: 115
        -- upvalues: u6 (copy), EffectsHandler (ref), u3 (ref)
        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.4,
                Identifier = u3
            });
        end;
    end);
    u7:BindCallback("Ended", function() -- Line: 127
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
    u7:Play();
end;