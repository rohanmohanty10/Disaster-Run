  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(script:WaitForChild("Vignette"));
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), Sequence_V2 (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local Speed = v2.Speed;
    local Character = v2.Character;
    local Player = v2.Player;
    local Players2 = v2.Players;
    local Stand = Character.Stand;
    local u3 = AssetHandler.GetAbilityData(Character);
    local u4 = table.find(Players2, LocalPlayer);
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u5 = Sequence_V2.new();
    u5:SetValidate(function(p6) -- Line: 28
        -- upvalues: Character (copy)
        return Character.Parent ~= nil;
    end);
    u5:SetSpeed(Speed);
    u5:AddFrame(0, function(p7) -- Line: 34
        -- upvalues: u4 (copy), EffectsHandler (ref)
        local v8 = p7:GetCache("Cache");
        v8.Identifier = os.clock();

        if u4 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Load",
                Identifier = v8.Identifier,
                Frames = { "rbxassetid://14512829256", "rbxassetid://14512829558", "rbxassetid://14512829906", "rbxassetid://14512830232", "rbxassetid://14512830465", "rbxassetid://14512830758" }
            });
        end;
    end);
    u5:AddFrame(160, function() -- Line: 57
        -- upvalues: EffectsHandler (ref), Stand (copy)
        EffectsHandler.CallEffect("Anubis_Aura", {
            Value = true,
            AbilityModel = Stand
        });
    end);
    u5:AddFrame(264, function() -- Line: 77
        -- upvalues: EffectsHandler (ref), Character (copy), Player (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Teleport",
            Origin = Character.Torso,
            Player = Player,
            Character = Character
        });
    end);
    u5:AddFrame(270, function() -- Line: 99
        -- upvalues: EffectsHandler (ref), Character (copy), Player (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Teleport",
            Origin = Character.Torso,
            Player = Player,
            Character = Character
        });
    end);
    u5:AddFrame(391, function() -- Line: 131
        -- upvalues: EffectsHandler (ref), Character (copy), Player (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Slash",
            Origin = Character.Torso,
            Offset = CFrame.new(0, 3, -6.5) * CFrame.Angles(-0.7853981633974483, 1.5707963267948966, 0),
            Player = Player,
            Character = Character
        });
    end);
    u5:AddFrame(455, function(p9) -- Line: 141
        -- upvalues: Character (copy), EffectsHandler (ref), Player (copy), AssetHandler (ref), u3 (copy)
        local v10 = RaycastParams.new();
        v10.FilterType = Enum.RaycastFilterType.Include;
        v10.FilterDescendantsInstances = { workspace.Map };
        local v11 = workspace:Raycast(Character.Torso.Position, Vector3.new(0, -10, 0), v10);

        if not v11 then
            return;
        end;

        local v12 = CFrame.new(v11.Position);
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Slam",
            Origin = v12,
            Player = Player,
            Character = Character
        });
        EffectsHandler.CallEffect("Anubis_Slam", {
            Object = AssetHandler.GetAsset("Particles/Beam", u3),
            Origin = v12
        });
        EffectsHandler.CallEffect("Rock Debris", {
            Lifetime = 2.5,
            Radius = 4.5,
            Amount = 9,
            Origin = v12
        });
        EffectsHandler.CallEffect("Anubis_Bezier", {
            Radius = 6,
            Amount = 6,
            Curve = 25,
            Object = AssetHandler.GetAsset("Particles/Trail", u3),
            Duration = 2.033333333333333 / p9:GetSpeed(),
            Positions = {
                Start = Character.Torso,
                End = Character.Torso
            },
            Player = Player
        });
    end);
    u5:AddFrame(577, function(p13) -- Line: 208
        -- upvalues: EffectsHandler (ref), Character (copy), HumanoidRootPart (copy), Player (copy), u4 (copy)
        local v14 = p13:GetCache("Cache");
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Impact",
            Origin = CFrame.new(Character.Torso.Position, HumanoidRootPart.Position),
            Player = Player,
            Character = Character
        });

        if v14.Identifier and u4 then
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Play",
                Time = 0.25,
                Identifier = v14.Identifier
            });
        end;
    end);
    u5:AddFrame(747, function() -- Line: 229
        -- upvalues: EffectsHandler (ref), Stand (copy)
        EffectsHandler.CallEffect("Anubis_Aura", {
            Value = false,
            AbilityModel = Stand
        });
    end);
    u5:BindCallback("Ended", function() -- Line: 236
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
    u5:Play();
end;