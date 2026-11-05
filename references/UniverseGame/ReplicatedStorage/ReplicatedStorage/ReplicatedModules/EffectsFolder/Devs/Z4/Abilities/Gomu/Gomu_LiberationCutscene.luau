  

 

game:GetService("CollectionService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = script.Name .. "1";
local u2 = script.Name .. "2";
local u3 = script.Name .. "3";

return function(p4) -- Line: 14
    -- upvalues: EffectsHandler (copy), u1 (copy), u2 (copy), u3 (copy), LocalPlayer (copy), Sequence_V2 (copy)
    local v5 = p4 or {};

    if v5 == "Preload" then
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u1,
            Frames = { "rbxassetid://18526251803", "rbxassetid://18526251506", "rbxassetid://18526251164" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u2,
            Frames = { "rbxassetid://18885068453", "rbxassetid://18885068336", "rbxassetid://18885068119", "rbxassetid://18885067883", "rbxassetid://18885067883", "rbxassetid://18885067190", "rbxassetid://18885066911" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = u3,
            Frames = { "rbxassetid://18885092340", "rbxassetid://18885092066", "rbxassetid://18885091542", "rbxassetid://18885090898", "rbxassetid://18885090635", "rbxassetid://18885090383", "rbxassetid://18885090116", "rbxassetid://18885089807", "rbxassetid://18885089571" }
        });

        return;
    end;

    local Speed = v5.Speed;
    local Character = v5.Character;
    local u6 = table.find(v5.Players, LocalPlayer);
    local u7 = Sequence_V2.new();
    u7:SetValidate(function(p8) -- Line: 68
        -- upvalues: Character (copy)
        return Character.Parent ~= nil;
    end);
    u7:SetSpeed(Speed);
    u7:AddFrame(145, function(p9) -- Line: 74
        -- upvalues: u6 (copy), EffectsHandler (ref), u1 (ref)
        p9:GetCache("Cache");

        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.4,
                Identifier = u1
            });
        end;
    end);
    u7:AddFrame(242, function(p10) -- Line: 87
        -- upvalues: u6 (copy), EffectsHandler (ref), u2 (ref)
        p10:GetCache("Cache");

        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.3,
                Identifier = u2
            });
        end;
    end);
    u7:AddFrame(327, function(p11) -- Line: 100
        -- upvalues: u6 (copy), EffectsHandler (ref), u3 (ref)
        p11:GetCache("Cache");

        if u6 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.4,
                Identifier = u3
            });
        end;
    end);
    u7:BindCallback("Ended", function() -- Line: 113
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
    u7:Play();
end;