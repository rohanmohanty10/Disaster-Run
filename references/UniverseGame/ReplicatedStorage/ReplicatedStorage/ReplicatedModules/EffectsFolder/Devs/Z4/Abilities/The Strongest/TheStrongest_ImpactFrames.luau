  

 

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

return function(p3) -- Line: 16
    -- upvalues: EffectsHandler (copy), u1 (copy), u2 (copy), LocalPlayer (copy), Sequence_V2 (copy)
    local v4 = p3 or {};

    if v4 == "Preload" then
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u1,
            Frames = { "rbxassetid://129850490466487", "rbxassetid://138856097821866", "rbxassetid://77922896900014", "rbxassetid://89943383017034", "rbxassetid://112101822983609" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u2,
            Frames = { "rbxassetid://113533068706950", "rbxassetid://101299039146194", "rbxassetid://123367912632989", "rbxassetid://133610989554344", "rbxassetid://87126082944819", "rbxassetid://88546173763916" }
        });

        return;
    end;

    local Speed = v4.Speed;
    local Character = v4.Character;
    local Reference = v4.Reference;
    local u5 = table.find(v4.Players, LocalPlayer);
    local u6 = Sequence_V2.new();
    u6:SetValidate(function(p7) -- Line: 56
        -- upvalues: Character (copy), Reference (copy)
        local v8;

        if Character.Parent == nil then
            v8 = false;
        else
            v8 = Reference.Parent;
        end;

        return v8;
    end);
    u6:SetSpeed(Speed);
    u6:AddFrame(136, function(p9) -- Line: 62
        -- upvalues: u5 (copy), EffectsHandler (ref), u1 (ref)
        if u5 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.3,
                Identifier = u1
            });
        end;
    end);
    u6:AddFrame(442, function(p10) -- Line: 74
        -- upvalues: u5 (copy), EffectsHandler (ref), u2 (ref)
        if u5 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.4,
                Identifier = u2
            });
        end;
    end);
    u6:BindCallback("Ended", function() -- Line: 86
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
    u6:Play();
end;