  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Popup = require(ReplicatedStorage.Shared.Popup);

return {
    AikuSelfishCaptain = {
        sender = "Sae",
        receiver = "Aiku",
        displayName = "Selfish Captain",
        ServerArmed = true,
        CutsceneToLoad = "AikuSelfishCaptain",
        readyText = "Selfish Captain is ready! Press B as the pass arrives.",
        Cooldown = 120
    },
    SnuffyRebellion = {
        sender = "Snuffy",
        receiver = "King",
        displayName = "Rebellion",
        ServerArmed = true,
        CutsceneToLoad = "SnuffyRebellion",
        readyText = "Rebellion with Snuffy is ready!",
        Cooldown = 120
    },
    KaiserXNess = {
        sender = "Ness",
        receiver = "Kaiser",
        displayName = "Illusion Cross",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "NessXKaiserCR",
        readyText = "Chemical Reaction with Kaiser is ready!",
        Cooldown = 120
    },
    DragonDriveCR = {
        sender = "Sae",
        receiver = "Shidou",
        displayName = "Dragon Drive",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "NEL ShidouDragonDrive",
        readyText = "Chemical Reaction with Shidou is ready!",
        Cooldown = 120
    },
    ShidouXCharlesCR = {
        sender = "Charles",
        receiver = "Shidou",
        displayName = "Shidou X Charles",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "NEL ShidouCharlesCR",
        readyText = "Chemical Reaction with Shidou is ready!",
        Cooldown = 120
    },
    NELIsagiXHiori = {
        sender = "Hiori",
        receiver = "Isagi",
        displayName = "No-Look Away Cross",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "HioriNoLookAwayCross",
        readyText = "No-Look Away Cross with NEL Isagi is ready!",
        Cooldown = 0
    },
    LokiXCharles = {
        sender = "Charles",
        receiver = "Loki",
        displayName = "Rabona Cross",
        SenderAbility = nil,
        CutsceneToLoad = "CharlesLokiCR",
        readyText = "Chemical Reaction with Charles is ready!",
        Cooldown = 250,

        AcceptConditions = function(p1, p2) -- Line: 93, Name: AcceptConditions
            -- upvalues: RunService (copy), Popup (copy)
            local Character = p1.Character;

            if (p2.Character.HumanoidRootPart.Position - workspace.BallSpawn.Position).Magnitude > 100 then
                if RunService:IsClient() then
                    Popup.Popup(game.Players.LocalPlayer, "Must be near the center of the field!");
                end;

                return false;
            end;

            local v3 = p2.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away;

            if not Character.Values.IsInPenalty.Value then
                if RunService:IsClient() then
                    Popup.Popup(game.Players.LocalPlayer, "Loki must be in opponent penalty box");
                end;

                return false;
            end;

            if (v3.Position - Character.HumanoidRootPart.Position).Magnitude <= 100 then
                return true;
            end;

            if RunService:IsClient() then
                Popup.Popup(game.Players.LocalPlayer, "Loki must be in opponent penalty box");
            end;

            return false;
        end
    },
    SubzeroXGingerbread = {
        sender = "Gingerbread Charles",
        receiver = "Subzero Loki",
        displayName = "Subzero X Gingerbread",
        SenderAbility = nil,
        CutsceneToLoad = "Subzero LokiXGBCharlesCR",
        readyText = "Chemical Reaction with Subzero Loki is ready!",
        Cooldown = 120,

        AcceptConditions = function(p4, p5) -- Line: 147, Name: AcceptConditions
            -- upvalues: RunService (copy), Popup (copy)
            local Magnitude = (p4.Character.HumanoidRootPart.Position - p5.Character.HumanoidRootPart.Position).Magnitude;

            if Magnitude <= 160 then
                return true;
            end;

            if RunService:IsClient() then
                Popup.Popup(p4, "Gingerbread Charles is too far! (" .. tostring(100 - Magnitude) .. ")");
            end;

            return false;
        end
    },
    BachiraXLavinho = {
        sender = "Lavinho",
        receiver = "Bachira",
        displayName = "Bachira X Lavinho",
        SenderAbility = nil,
        CutsceneToLoad = "BachiraLavinhoCR",
        readyText = "Chemical Reaction with Bachira is ready!",
        Cooldown = 120,

        AcceptConditions = function(p6, p7) -- Line: 175, Name: AcceptConditions
            -- upvalues: RunService (copy), Popup (copy)
            local Magnitude = (p6.Character.HumanoidRootPart.Position - p7.Character.HumanoidRootPart.Position).Magnitude;

            if Magnitude <= 160 then
                return true;
            end;

            if RunService:IsClient() then
                Popup.Popup(p6, "Bachira is too far! (" .. tostring(100 - Magnitude) .. ")");
            end;

            return false;
        end
    },
    FireworkBachiraXSantaLavinho = {
        sender = "Santa Lavinho",
        receiver = "Firework Bachira",
        displayName = "Firework Bachira X Santa Lavinho",
        SenderAbility = nil,
        CutsceneToLoad = "FireworkBachiraXSantaLavinho",
        readyText = "Chemical Reaction with Firework Bachira is ready!",
        Cooldown = 120,

        AcceptConditions = function(p8, p9) -- Line: 203, Name: AcceptConditions
            -- upvalues: RunService (copy), Popup (copy)
            local Magnitude = (p8.Character.HumanoidRootPart.Position - p9.Character.HumanoidRootPart.Position).Magnitude;

            if Magnitude <= 160 then
                return true;
            end;

            if RunService:IsClient() then
                Popup.Popup(p8, "Firework Bachira is too far! (" .. tostring(100 - Magnitude) .. ")");
            end;

            return false;
        end
    },
    KaiserKiyoraCR = {
        sender = "Kiyora",
        receiver = "Kaiser",
        displayName = "Kaiser X Kiyora",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "KaiserKiyoraCR",
        readyText = "Kaiser Magnus with Kiyora is ready!",
        Cooldown = 0
    },
    IsagiBachiraCR = {
        sender = "Bachira",
        receiver = "Isagi",
        displayName = "I AM... A STRIKER!",
        SenderAbility = nil,
        ServerArmed = true,
        CutsceneToLoad = "IsagiBachiraCR",
        readyText = "Chemical Reaction with Isagi is ready!",
        Cooldown = 0
    }
};