  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("Teams");
local GuiService = game:GetService("GuiService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local GeniusKillingMalicia = require(ReplicatedStorage.AbilityBalancing).GeniusKillingMalicia;

local function fadeOut(u1, u2) -- Line: 23
    -- upvalues: TweenService (copy)
    local v3 = TweenService:Create(u1, TweenInfo.new(1), {
        Transparency = 1
    });
    v3:Play();
    v3.Completed:Connect(function(p4) -- Line: 26
        -- upvalues: u1 (copy)
        if p4 == Enum.PlaybackState.Completed then
            u1:Destroy();
        end;
    end);
    local v5 = TweenService:Create(u2, TweenInfo.new(1), {
        Transparency = 1
    });
    v5:Play();
    v5.Completed:Connect(function(p6) -- Line: 34
        -- upvalues: u2 (copy)
        if p6 == Enum.PlaybackState.Completed then
            u2:Destroy();
        end;
    end);
end;

return function(u7, p8, p9) -- Line: 41, Name: move
    -- upvalues: GuiService (copy), GeniusKillingMalicia (copy), Popup (copy)
    if not p9.Values.HasBall.Value then
        return;
    end;

    if u7.AbilityThree > tick() then
        return;
    end;

    if p8.PlayerStats.InAwakening.Value == false then
        return;
    end;

    local v10 = {};

    for _, v in game.CollectionService:GetTagged("PlayingTeam") do
        if p8.Team ~= v then
            for _, v2 in v:GetPlayers() do
                if v2.Character ~= nil and (v2.Team ~= p8.Team and (v2 ~= p8 and not (v2.Character.Values.Goalie.Value and v2.Character.Values.IsInPenalty.Value))) then
                    table.insert(v10, v2.Character);
                end;
            end;
        end;
    end;

    local v11 = nil;
    local v12 = 9999;

    for _, v in v10 do
        if v:FindFirstChild("HumanoidRootPart") then
            local v13, v14 = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position);

            if v14 then
                local Magnitude = (Vector2.new(v13.X, v13.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - GuiService:GetGuiInset().Y / 2)).Magnitude;

                if v11 == nil then
                    v12 = Magnitude;
                    v11 = v;
                elseif Magnitude < v12 then
                    v12 = Magnitude;
                    v11 = v;
                end;
            end;
        end;
    end;

    local v15 = v11 or (workspace:FindFirstChild("PassRig") or v11);
    print("malicia");

    if not v15 or (not v15 and 80 or (p9.HumanoidRootPart.Position - v15.HumanoidRootPart.Position).Magnitude) > GeniusKillingMalicia.ActivationRangePlayer then
        Popup.Popup(p8, "Must be close and looking at an enemy!");

        return;
    end;

    print("playing ability");
    local _ = u7.Camera.Shiftlock;
    u7.Camera:SetShiftlock(false);
    u7.Camera.Cutscene = true;
    u7.InAbility = true;
    u7.StatesController.States.Ability = true;
    u7:AbilityCooldown("3", GeniusKillingMalicia.Cooldown);
    u7.AbilityService.Ability:Fire("GeniusKillingMalicia", v15);
    u7.ABC:Add(task.delay(15, function() -- Line: 108
        -- upvalues: u7 (copy)
        u7.InAbility = false;
        u7.Camera.Cutscene = false;
        u7.StatesController.States.Ability = false;
        u7.ABC:Clean();
    end));
    task.wait(8.5);
    u7.Camera.Cutscene = false;
    u7.InAbility = false;
    u7.StatesController.States.Ability = false;
    u7.ABC:Clean();
end;