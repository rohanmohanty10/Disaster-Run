  

 

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

    local v11 = Sequence_V3.new({
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
            { 47, function(p7) -- Line: 58
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50, 0.13333333333333333);
                end },
            { 56, function(p8) -- Line: 61
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(56);
                end },
            { 106, function(p9) -- Line: 64
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50, 0.38333333333333336);
                end },
            { 130, function(p10) -- Line: 67
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView();
                end }
        }
    });
    v11:Play();

    while v11:IsPlaying() do
        task.wait();
    end;

    v11:Destroy();
end;