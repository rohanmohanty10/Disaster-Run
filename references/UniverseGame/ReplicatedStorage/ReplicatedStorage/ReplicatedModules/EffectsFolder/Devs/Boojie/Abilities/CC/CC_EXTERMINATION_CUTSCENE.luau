  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), TweenService (copy), Sequence_V3 (copy)
    local u2 = p1 or {};
    local Speed = u2.Speed;
    local Character = u2.Character;
    local _ = u2.Target;
    local _ = u2.Player;
    local Players = u2.Players;
    AssetHandler.GetAbilityData(Character);
    local _ = Character.HumanoidRootPart;
    local CurrentCamera = workspace.CurrentCamera;

    if not table.find(Players, LocalPlayer) then
        return;
    end;

    if LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local function SetFieldOfView(p3, p4) -- Line: 37
        -- upvalues: LocalPlayer (ref), TweenService (ref), CurrentCamera (copy), Speed (copy)
        if LocalPlayer.Settings.CutsceneCamera.Value == false then
            return;
        end;

        TweenService:Create(CurrentCamera, TweenInfo.new((p4 or 0.25) / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = p3 or LocalPlayer.Settings.FieldOfView.Value
        }):Play();
    end;

    local v18 = Sequence_V3.new({
        Validate = function() -- Line: 47, Name: Validate
            -- upvalues: u2 (copy), Character (copy)
            if not (u2.Target and u2.Target:GetAttribute("Finished")) then
                local v5 = Character and Character:IsDescendantOf(game);

                return v5;
            end;
        end,

        Speed = Speed,
        Frames = {
            { 0, function(p6) -- Line: 55
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70);
                end },
            { 49, function(p7) -- Line: 58
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(40);
                end },
            { 90, function(p8) -- Line: 61
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 98, function(p9) -- Line: 64
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70, 0.5666666666666667);
                end },
            { 150, function(p10) -- Line: 67
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 204, function(p11) -- Line: 70
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70);
                end },
            { 222, function(p12) -- Line: 73
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50, 1.2833333333333334);
                end },
            { 319, function(p13) -- Line: 76
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(80);
                end },
            { 444, function(p14) -- Line: 79
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(90);
                end },
            { 469, function(p15) -- Line: 82
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(40);
                end },
            { 480, function(p16) -- Line: 85
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 584, function(p17) -- Line: 88
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView();
                end }
        }
    });
    v18:Play();

    while v18:IsPlaying() do
        task.wait();
    end;

    v18:Destroy();
end;