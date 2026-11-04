 
 

local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = require("@game/ReplicatedStorage/Packages/Janitor");
require("../../Abilities");
require("../../../../Shared/Tables/Cooldowns");
local u2 = v1.new();

return function(u3) -- Line: 15
    -- upvalues: LocalPlayer (copy), u2 (copy), RunService (copy)
    local Network = u3.Network;
    local AbilityService = u3.AbilityService;
    local MovementController = u3.MovementController;
    local Animations = u3.Animations;

    if u3.NinjaTransform == true then
        u3.NinjaTransform = nil;
        AbilityService.Ability:Fire("NinjaTransform", {
            Transform = false,
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u3.NinjaTransform = true;

    if u3.NinjaTransform == true then
        u3:ResetCD(3);
        u3.CDS[3] = tick() + 10;
        local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
        local Humanoid = LocalPlayer.Character.Humanoid;
        local Ability3 = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability3;
        local Ability2 = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2;
        local Ability1 = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1;
        Animations:StopAll();
        local u4 = Animations:PlayChar("Ninja", "KuramaIdle", Enum.AnimationPriority.Action, true);
        local u5 = Animations:PlayChar("Ninja", "KuramaRun", Enum.AnimationPriority.Action, true);
        local u6 = u2:Add(Instance.new("LinearVelocity"));
        u6.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u6.MaxAxesForce = Vector3.new(40000, 0, 40000);
        u6.Attachment0 = HumanoidRootPart.RootAttachment;
        u6.Parent = HumanoidRootPart;
        MovementController.States.NoJump = true;
        u2:Add(function() -- Line: 54
            -- upvalues: MovementController (copy)
            MovementController.States.NoJump = false;
        end);
        u2:Add(RunService.Heartbeat:Connect(function(p7: number) -- Line: 58
            -- upvalues: Humanoid (copy), MovementController (copy), u6 (copy), u4 (copy), u5 (copy), LocalPlayer (ref), u2 (ref), u3 (copy), Network (copy), AbilityService (copy), Ability2 (copy), Ability3 (copy), Ability1 (copy)
            local MoveDirection = Humanoid.MoveDirection;

            if MoveDirection.X == 0 or (MoveDirection.Z == 0 or MovementController.States.NoWalk ~= false) then
                u6.VectorVelocity = Vector3.new(0, 0, 0);
            else
                u6.VectorVelocity = (MoveDirection * Vector3.new(1, 0, 1)).Unit * 60;
            end;

            if MoveDirection:Dot(MoveDirection) > 0 then
                if u4.IsPlaying == true then
                    u4:Stop();
                end;

                if u5.IsPlaying == false then
                    u5:Play();
                end;
            else
                if u5.IsPlaying == true then
                    u5:Stop();
                end;

                if u4.IsPlaying == false then
                    u4:Play();
                end;
            end;

            if MovementController.States.Ability ~= true then
                if LocalPlayer.Style.Value ~= "Ninja" then
                    u2:Cleanup();

                    return;
                end;

                if u3.NinjaTransform ~= true then
                    u2:Cleanup();

                    return;
                end;

                if Network.CharValues.InAwakening ~= true or Network.CharValues.HasBall == true then
                    u3.NinjaTransform = nil;
                    AbilityService.Ability:Fire("NinjaTransform", {
                        Transform = false,
                        TimeSent = workspace:GetServerTimeNow()
                    });

                    return;
                end;
            end;

            Ability2.Visible = false;
            Ability3.AbilityName.Text = "Ninja";
            Ability1.AbilityName.Text = "Tail Bomb";
        end));
        AbilityService.Ability:Fire("NinjaTransform", {
            Transform = true,
            TimeSent = workspace:GetServerTimeNow()
        });
        u2:Add(function() -- Line: 106
            -- upvalues: LocalPlayer (ref), u3 (copy), Ability2 (copy)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u3.TotalTheft) then
                u3.CDS[3] = tick() + 120;
            end;

            if Ability2 ~= nil then
                Ability2.Visible = true;
            end;
        end);
        u2:Add(task.delay(20, function() -- Line: 116
            -- upvalues: AbilityService (copy), u3 (copy)
            AbilityService.Ability:Fire("NinjaTransform", {
                Transform = false,
                TimeSent = workspace:GetServerTimeNow()
            });
            u3.NinjaTransform = nil;
        end));
        u2:Add(u4, "Stop");
        u2:Add(u5, "Stop");
    end;
end;