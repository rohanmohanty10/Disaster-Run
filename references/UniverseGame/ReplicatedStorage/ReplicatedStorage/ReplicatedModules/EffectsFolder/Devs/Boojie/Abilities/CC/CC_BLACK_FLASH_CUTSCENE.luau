  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    [0] = "rbxassetid://15668157839",
    [1] = "rbxassetid://15668157546",
    [2] = "rbxassetid://15668157285",
    [3] = "rbxassetid://15668157021",
    [4] = "rbxassetid://15668156678",
    [5] = "rbxassetid://15668156466",
    [6] = "rbxassetid://15668156192",
    [7] = "rbxassetid://15668155942",
    [8] = "rbxassetid://15668155687",
    [9] = "rbxassetid://15668155549",
    [10] = "rbxassetid://15668155357",
    [11] = "rbxassetid://15668155079",
    [12] = "rbxassetid://15668154866",
    [13] = "rbxassetid://15668154650",
    [14] = "rbxassetid://15668154515",
    [15] = "rbxassetid://15668154376",
    [16] = "rbxassetid://15668154167",
    [17] = "rbxassetid://15668154068",
    [18] = "rbxassetid://15668153903",
    [19] = "rbxassetid://15668153778",
    [20] = "rbxassetid://15668153630",
    [21] = "rbxassetid://15668153399",
    [22] = "rbxassetid://15668153095",
    [23] = "rbxassetid://15668152866",
    [24] = "rbxassetid://15668152649",
    [25] = "rbxassetid://15668152416",
    [26] = "rbxassetid://15668152279",
    [27] = "rbxassetid://15668152135",
    [28] = "rbxassetid://15668151970",
    [29] = "rbxassetid://15668151864",
    [30] = "rbxassetid://15668151679",
    [31] = "rbxassetid://15668151519",
    [32] = "rbxassetid://15668151321",
    [33] = "rbxassetid://15668151043",
    [34] = "rbxassetid://15668150759",
    [35] = "rbxassetid://15668150624",
    [36] = "rbxassetid://15668150451"
};
local u2 = false;

return function(p3) -- Line: 53
    -- upvalues: u2 (ref), EffectsHandler (copy), u1 (copy), AssetHandler (copy), LocalPlayer (copy), Sequence_V3 (copy)
    if p3 == "Preload" then
        if not u2 then
            u2 = true;
            EffectsHandler.CallEffect("Impact Frame", {
                Type = "Image",
                State = "Load",
                Identifier = "CC_BLACK_FLASH",
                Frames = u1
            });
        end;

        return;
    end;

    local v4 = p3 or {};
    local Speed = v4.Speed;
    local Character = v4.Character;
    local _ = v4.Player;
    local Players2 = v4.Players;
    AssetHandler.GetAbilityData(Character);
    local u5 = table.find(Players2, LocalPlayer);
    local _ = Character.HumanoidRootPart;
    local LocalPlayer2 = game.Players.LocalPlayer;
    local v12 = Sequence_V3.new({
        Validate = function() -- Line: 84, Name: Validate
            -- upvalues: Character (copy)
            local v6 = Character and Character:IsDescendantOf(game);

            return v6;
        end,

        Speed = Speed,
        Frames = {
            { 3, function(p7) -- Line: 89
                    -- upvalues: u5 (copy), EffectsHandler (ref), Character (copy), LocalPlayer2 (copy)
                    if u5 then
                        EffectsHandler.CallEffect("Impact Frame", {
                            Time = 0.05,
                            StartBrightness = 0.75,
                            EndBrightness = -0.75,
                            Models = { Character, LocalPlayer2.Character },
                            StartFillColor = Color3.fromRGB(0, 0, 0),
                            EndFillColor = Color3.fromRGB(255, 0, 0),
                            BackgroundColor = Color3.fromRGB(255, 0, 0)
                        });
                    end;
                end },
            { 3, function(p8) -- Line: 102
                    -- upvalues: u5 (copy), LocalPlayer2 (copy), EffectsHandler (ref)
                    if u5 and LocalPlayer2.Settings.CutsceneCamera.Value == true then
                        EffectsHandler.CallEffect(
                            "Impact Frame",
                            {
                                Type = "Image",
                                State = "Play",
                                Cleanup = false,
                                Time = 1.2,
                                Identifier = "CC_BLACK_FLASH"
                            }
                        );
                    end;

                    if LocalPlayer2.Settings.CutsceneCamera.Value == false then
                        EffectsHandler.CallEffect("BoxCameraShake", "IntenseExplosion");
                    end;
                end },
            { 145, function(p9) -- Line: 117
                    -- upvalues: u5 (copy), EffectsHandler (ref)
                    if u5 then
                        EffectsHandler.CallEffect("LM_DOMAIN_END_CC", {
                            In = 0.25,
                            Out = 0.05,
                            Time = 0.4,
                            Brightness = 0,
                            Contrast = 5,
                            Saturation = -1,
                            TintColor = Color3.fromRGB(5000, 255, 255),
                            StartInfo = { Enum.EasingStyle.Sine, Enum.EasingDirection.In }
                        });
                    end;
                end },
            { 148, function(p10) -- Line: 131
                    -- upvalues: u5 (copy), EffectsHandler (ref), Character (copy), LocalPlayer2 (copy)
                    if u5 then
                        EffectsHandler.CallEffect("Impact Frame", {
                            Time = 0.05,
                            StartBrightness = 0.75,
                            EndBrightness = -0.75,
                            Models = { Character, LocalPlayer2.Character },
                            StartFillColor = Color3.fromRGB(0, 0, 0),
                            EndFillColor = Color3.fromRGB(255, 0, 0),
                            BackgroundColor = Color3.fromRGB(255, 0, 0)
                        });
                    end;

                    if LocalPlayer2.Settings.CutsceneCamera.Value == false then
                        EffectsHandler.CallEffect("BoxCameraShake", "LongerExplosion");
                    end;
                end },
            { 308, function(p11) -- Line: 147
                end }
        }
    });
    v12:Play();

    while v12:IsPlaying() do
        task.wait();
    end;

    v12:Destroy();
end;