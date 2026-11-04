 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u4) -- Line: 18
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Effects (copy), Cooldowns (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u4.AbilityService;
    u2 = u4.MovementController;
    u3 = u4.BallController;

    if u2.States.PumpFake then
        u4:ResetCD(3);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    local u5 = (LocalPlayer.Style.Value == "Copycat" and not u4.Network.CharValues.InAwakening or LocalPlayer.Style.Value == "Thief") and 1 or 2;

    local function ReturnToBody() -- Line: 31
        -- upvalues: u4 (copy), u1 (ref), u5 (copy), Cooldowns (ref)
        if u4.OutOfBody then
            u1.Ability:Fire("Out Of Body", {
                Task = "Despawn",
                TimeSent = workspace:GetServerTimeNow()
            });
            u4.OutOfBody = nil;
            u4.CDS[u5] = tick() + Cooldowns.Abilities.Ghost[u5];
            u4:ResetCopy();
            u4.AC:Clean();
        end;
    end;

    if u4.OutOfBody then
        ReturnToBody();

        return;
    end;

    u4.OutOfBody = true;
    u4:ResetCD(u5);
    u1.Ability:Fire("Out Of Body", {
        Task = "Spawn",
        TimeSent = workspace:GetServerTimeNow(),
        CFrame = HumanoidRootPart.CFrame
    });
    local u6 = 1;
    local u7 = false;
    local u8 = nil;
    u8 = RunService.Heartbeat:Connect(function(p9) -- Line: 54
        -- upvalues: u3 (ref), LocalPlayer (ref), ReturnToBody (copy), u4 (copy), u8 (ref), u5 (copy), u6 (ref), u7 (ref)
        if u3:GetPlayerPossessingBall() ~= LocalPlayer then
            ReturnToBody();
        end;

        if not u4.OutOfBody then
            u8:Disconnect();
            LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u5}`].Flash.BackgroundTransparency = 1;

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u5}`].Flash.BackgroundTransparency = u6;

        if u6 > 0.5 and not u7 then
            p9 = -p9 or p9;
        end;

        u6 = u6 + p9;

        if u6 <= 0.5 then
            u7 = true;
        end;

        if u6 >= 1 then
            u7 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u5}`].AbilityName.Text = "Return To Body";
    end);
    task.delay(5, function() -- Line: 78
        -- upvalues: ReturnToBody (copy)
        ReturnToBody();
    end);
    u4.AC:Connect(u1.Ability, function() -- Line: 82
        -- upvalues: ReturnToBody (copy)
        ReturnToBody();
    end);
end;