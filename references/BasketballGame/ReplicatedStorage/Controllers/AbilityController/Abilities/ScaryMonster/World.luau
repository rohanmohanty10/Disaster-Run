 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u6) -- Line: 19
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), LocalPlayer (copy), Effects (copy), Cooldowns (copy), RunService (copy)
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.Network;
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u7 = LocalPlayer.Style.Value == "Copycat" and 4 or 3;

    if u6.World then
        if u6.MovementController.States.PumpFake then
            u6:ResetCD(u7);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            local v8 = LocalPlayer.Zone.Value == "Vampiric" and u5.CharValues.InZone and 0.75 or 1;
            u6.CDS[u7] = tick() + v8 * 0.5;
        end;

        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        RaycastParams_new_ret.CollisionGroup = "Player";
        local v9 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
        local v10 = (v9.X > 0.01 and HumanoidRootPart.CFrame.RightVector or v9.X < -0.01 and -HumanoidRootPart.CFrame.RightVector or (v9.Z > 0.01 and -HumanoidRootPart.CFrame.LookVector or HumanoidRootPart.CFrame.LookVector)) * 50;
        local v11 = workspace:Raycast(HumanoidRootPart.Position, v10, RaycastParams_new_ret);

        if v11 then
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v11.Position - HumanoidRootPart.Position).Unit * (v11.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        else
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v10) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        end;

        u1.Ability:Fire("World", {
            State = "Time Skip",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(4.45, function() -- Line: 73
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("World", {
        State = "Cutscene",
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(4.45);
    u6.World = true;
    u6:ResetCD(u7);
    local u12 = nil;
    task.delay(5, function() -- Line: 87
        -- upvalues: u12 (ref)
        u12 = true;
    end);
    local u13 = 1;
    local u14 = false;
    local u15 = nil;

    local function End() -- Line: 96
        -- upvalues: LocalPlayer (ref), u6 (copy), u5 (ref), u7 (copy), Cooldowns (ref), u15 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            local v16 = LocalPlayer.Zone.Value == "Vampiric" and u5.CharValues.InZone and 0.75 or 1;
            u6.CDS[u7] = tick() + Cooldowns.Abilities.ScaryMonster[1] * v16;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u7 == 3 and 3 or 1}`].Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u7 == 3 and 3 or 1}`].AbilityName.Text = "World";
        u15:Disconnect();
        u6.World = nil;
        u6:ResetCopy();
    end;

    u15 = RunService.Heartbeat:Connect(function(p17) -- Line: 115
        -- upvalues: u6 (copy), u12 (ref), End (copy), LocalPlayer (ref), u7 (copy), u13 (ref), u14 (ref)
        if not u6.World or u12 then
            End();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u7 == 3 and 3 or 1}`].Flash.BackgroundTransparency = u13;

        if u13 > 0.5 and not u14 then
            p17 = -p17 or p17;
        end;

        u13 = u13 + p17;

        if u13 <= 0.5 then
            u14 = true;
        end;

        if u13 >= 1 then
            u14 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u7 == 3 and 3 or 1}`].AbilityName.Text = "Time Skip";
    end);
end;