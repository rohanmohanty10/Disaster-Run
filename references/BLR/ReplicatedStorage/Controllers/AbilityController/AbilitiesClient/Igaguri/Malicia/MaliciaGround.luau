  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local GuiService = game:GetService("GuiService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local MaliciaGround = require(ReplicatedStorage.AbilityBalancing).MaliciaGround;

return function(u1, p2, p3) -- Line: 17, Name: Ground
    -- upvalues: Popup (copy), GuiService (copy), MaliciaGround (copy)
    if p3.Values.HasBall.Value == true then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if p3.HumanoidRootPart.CFrame:VectorToObjectSpace(p3.Humanoid.MoveDirection) == Vector3.new(0, 0, 0) then
        Popup.Popup(p2, "Must be moving!");

        return;
    end;

    local v4 = {};

    for _, v in game.CollectionService:GetTagged("PlayingTeam") do
        if p2.Team ~= v then
            for _, v2 in v:GetPlayers() do
                if v2.Character ~= nil and (v2.Team ~= p2.Team and (v2 ~= p2 and not (v2.Character.Values.Goalie.Value and v2.Character.Values.IsInPenalty.Value))) then
                    table.insert(v4, v2.Character);
                end;
            end;
        end;
    end;

    local v5 = nil;
    local v6 = 9999;

    for _, v in v4 do
        if v:FindFirstChild("HumanoidRootPart") then
            local v7, v8 = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position);

            if v8 then
                local Magnitude = (Vector2.new(v7.X, v7.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - GuiService:GetGuiInset().Y / 2)).Magnitude;

                if v5 == nil then
                    v6 = Magnitude;
                    v5 = v;
                elseif Magnitude < v6 then
                    v6 = Magnitude;
                    v5 = v;
                end;
            end;
        end;
    end;

    local v9 = v5 or workspace:FindFirstChild("PassRig");

    if not (v9 and ((not v9 and 80 or (p3.HumanoidRootPart.Position - v9.HumanoidRootPart.Position).Magnitude) <= MaliciaGround.ActivationRangePlayer or v9:GetAttribute("IFrames"))) then
        Popup.Popup(p2, "Must be close and looking at an enemy!");

        return;
    end;

    u1:AbilityCooldown("1", 50);
    u1.StatesController.States.Ability = true;
    task.delay(0.35, function() -- Line: 82
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.BodyBlockR.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.BodyBlockR:Play();
    u1.Animations.Abilities.BodyBlockR:AdjustSpeed(1.5);
    u1.Animations.Ball.BodyBlockR.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.BodyBlockR:Play();
    u1.Animations.Ball.BodyBlockR:AdjustSpeed(1.5);
    u1.AbilityService.Ability:Fire("Malicia", {
        Type = "Ground",
        Enemy = v9
    });
end;