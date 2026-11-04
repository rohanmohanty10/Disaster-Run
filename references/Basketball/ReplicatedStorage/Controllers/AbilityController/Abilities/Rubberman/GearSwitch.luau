 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20, Name: GearSwitch
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), RunService (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if not u6.RubberGear then
        u6.RubberGear = "Defensive";
    end;

    local v7 = u6.RubberGear == "Defensive" and "Offensive" or "Defensive";
    u6.RubberGear = v7;
    Effects:Popup(`You've swapped gears, new gear: {v7}`, 3);

    if v7 == "Offensive" then
        local u8 = nil;
        u8 = RunService.Heartbeat:Connect(function() -- Line: 36
            -- upvalues: u6 (copy), LocalPlayer (ref), u8 (ref), u5 (ref)
            if u6.RubberGear == "Defensive" or LocalPlayer.Style.Value ~= "Rubberman" then
                if u8 then
                    u8:Disconnect();
                    u8 = nil;
                end;

                return;
            end;

            if u5.CharValues.InAwakening then
                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Observe";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability3.AbilityName.Text = "Undetermined Shot";
        end);
    end;
end;