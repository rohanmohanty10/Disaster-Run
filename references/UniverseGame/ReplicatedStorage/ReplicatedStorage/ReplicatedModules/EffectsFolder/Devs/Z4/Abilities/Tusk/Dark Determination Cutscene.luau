  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 9
    -- upvalues: LocalPlayer (copy), EffectsHandler (copy), Sequence_V2 (copy)
    local v2 = p1 or {};
    local Speed = v2.Speed;
    local Character = v2.Character;
    local Player = v2.Player;
    local u3 = Player == LocalPlayer;
    local u4 = {
        AbilityName = "Tusk ACT1",
        Path = "Particles/DarkDetermination/Slam",
        AutoSerialize = true,
        Player = Player,
        Origin = Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(-1.85, -3, -2.5)
    };

    local function Slam() -- Line: 27
        -- upvalues: EffectsHandler (ref), u4 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", u4);
    end;

    local function SlamImpactFrame(u5) -- Line: 31
        -- upvalues: u3 (copy), EffectsHandler (ref)
        return function(p6) -- Line: 32
            -- upvalues: u3 (ref), EffectsHandler (ref), u5 (copy)
            local v7 = p6:GetCache("Cache");

            if v7.Identifier and u3 then
                EffectsHandler.CallEffect("Impact Frame", {
                    Type = "Image",
                    State = "Play",
                    Time = 0.12,
                    Identifier = v7.Identifier + u5
                });
            end;
        end;
    end;

    local u8 = Sequence_V2.new();
    u8:SetValidate(function(p9) -- Line: 49
        -- upvalues: Character (copy)
        return Character.Parent ~= nil;
    end);
    u8:SetSpeed(Speed);
    u8:AddFrame(0, function(p10) -- Line: 54
        -- upvalues: u3 (copy), EffectsHandler (ref)
        local v11 = p10:GetCache("Cache");
        v11.Identifier = os.clock();

        if u3 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Load",
                Identifier = v11.Identifier,
                Frames = { "rbxassetid://111990283023288", "rbxassetid://123282176340703", "rbxassetid://97590918359238", "rbxassetid://139182574044020", "rbxassetid://133457539031739", "rbxassetid://96895258750049", "rbxassetid://85997201950588", "rbxassetid://131069510117176" }
            });
        end;

        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = v11.Identifier + 2,
            Frames = { "rbxassetid://85597073866792", "rbxassetid://86655864790708" }
        });
        EffectsHandler.CallEffect("Impact Frame", {
            Type = "Image",
            State = "Load",
            Identifier = v11.Identifier + 1,
            Frames = { "rbxassetid://82275541571101", "rbxassetid://139176394774011", "rbxassetid://101733468639532" }
        });
    end);
    local u12 = 1;
    u8:AddFrame(136, function(p13) -- Line: 32
        -- upvalues: u3 (copy), EffectsHandler (ref), u12 (copy)
        local v14 = p13:GetCache("Cache");

        if v14.Identifier and u3 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.12,
                Identifier = v14.Identifier + u12
            });
        end;
    end);
    local u15 = 2;
    u8:AddFrame(169, function(p16) -- Line: 32
        -- upvalues: u3 (copy), EffectsHandler (ref), u15 (copy)
        local v17 = p16:GetCache("Cache");

        if v17.Identifier and u3 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.12,
                Identifier = v17.Identifier + u15
            });
        end;
    end);
    u8:AddFrame(138, Slam);
    u8:AddFrame(171, Slam);
    u8:AddFrame(240, function(p18) -- Line: 110
        -- upvalues: u3 (copy), EffectsHandler (ref)
        local v19 = p18:GetCache("Cache");

        if v19.Identifier and u3 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.35,
                Identifier = v19.Identifier
            });
        end;
    end);
    u8:BindCallback("Ended", function() -- Line: 124
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
    u8:Play();
end;