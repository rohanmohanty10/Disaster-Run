  

 

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
    local Frame = u2.Frame;
    AssetHandler.GetAbilityData(Character);

    if Character:FindFirstChild("HumanoidRootPart") == nil then
        return;
    end;

    local CurrentCamera = workspace.CurrentCamera;

    if not table.find(Players, LocalPlayer) then
        return;
    end;

    if LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local function SetFieldOfView(p3, p4) -- Line: 39
        -- upvalues: LocalPlayer (ref), TweenService (ref), CurrentCamera (copy), Speed (copy)
        if LocalPlayer.Settings.CutsceneCamera.Value == false then
            return;
        end;

        if p4 == 0 then
            CurrentCamera.FieldOfView = p3 or LocalPlayer.Settings.FieldOfView.Value;

            return;
        end;

        TweenService:Create(CurrentCamera, TweenInfo.new((p4 or 0.25) / Speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            FieldOfView = p3 or LocalPlayer.Settings.FieldOfView.Value
        }):Play();
    end;

    local v11 = Sequence_V3.new({
        Validate = function() -- Line: 53, Name: Validate
            -- upvalues: u2 (copy), Character (copy)
            if not (u2.Target and u2.Target:GetAttribute("Finished")) then
                local v5 = Character and Character:IsDescendantOf(game);

                return v5;
            end;
        end,

        Speed = Speed,
        Frames = {
            { 0, function(p6) -- Line: 61
                    -- upvalues: LocalPlayer (ref), CurrentCamera (copy)
                    if LocalPlayer.Settings.CutsceneCamera.Value == false then
                        return;
                    end;

                    CurrentCamera.FieldOfView = 55;
                end },
            { 1, function(p7) -- Line: 64
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(45, 0.95);
                end },
            { 478, function(p8) -- Line: 67
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70, 1.25);
                end },
            { 553, function(p9) -- Line: 70
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(30, 1.1333333333333333);
                end },
            { 621, function(p10) -- Line: 73
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(nil, 0.65);
                end }
        }
    });
    v11:Play();

    if Frame then
        v11:MoveTo(Frame, true);
    end;

    while v11:IsPlaying() do
        task.wait();
    end;

    v11:Destroy();
end;