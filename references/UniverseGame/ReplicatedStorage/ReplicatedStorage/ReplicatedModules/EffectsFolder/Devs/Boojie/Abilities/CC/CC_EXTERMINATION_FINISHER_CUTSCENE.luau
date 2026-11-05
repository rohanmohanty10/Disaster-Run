  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), TweenService (copy), Sequence_V3 (copy)
    local v2 = p1 or {};
    local Speed = v2.Speed;
    local Character = v2.Character;
    local _ = v2.Player;
    local Players = v2.Players;
    AssetHandler.GetAbilityData(Character);
    local _ = Character.HumanoidRootPart;
    local CurrentCamera = workspace.CurrentCamera;

    if not table.find(Players, LocalPlayer) then
        return;
    end;

    if LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    local function SetFieldOfView(p3, p4) -- Line: 36
        -- upvalues: LocalPlayer (ref), TweenService (ref), CurrentCamera (copy), Speed (copy)
        if LocalPlayer.Settings.CutsceneCamera.Value == false then
            return;
        end;

        TweenService:Create(CurrentCamera, TweenInfo.new((p4 or 0.25) / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = p3 or LocalPlayer.Settings.FieldOfView.Value
        }):Play();
    end;

    local v19 = Sequence_V3.new({
        Validate = function() -- Line: 46, Name: Validate
            -- upvalues: Character (copy)
            local v5 = Character and Character:IsDescendantOf(game);

            return v5;
        end,

        Speed = Speed,
        Frames = {
            { 0, function(p6) -- Line: 51
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70);
                end },
            { 16, function(p7) -- Line: 54
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(40);
                end },
            { 27, function(p8) -- Line: 57
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 56, function(p9) -- Line: 60
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70, 2.283333333333333);
                end },
            { 203, function(p10) -- Line: 63
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 248, function(p11) -- Line: 66
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(30);
                end },
            { 254, function(p12) -- Line: 69
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70);
                end },
            { 290, function(p13) -- Line: 72
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(80);
                end },
            { 311, function(p14) -- Line: 75
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50, 1.2666666666666666);
                end },
            { 405, function(p15) -- Line: 78
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(20, 0.7833333333333333);
                end },
            { 539, function(p16) -- Line: 81
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(50);
                end },
            { 570, function(p17) -- Line: 84
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView(70);
                end },
            { 653, function(p18) -- Line: 87
                    -- upvalues: SetFieldOfView (copy)
                    SetFieldOfView();
                end }
        }
    });
    v19:Play();

    while v19:IsPlaying() do
        task.wait();
    end;

    v19:Destroy();
end;