  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), Popup (copy)
    if ReplicatedStorage.Football.Value.Char.Value == nil then
        Popup.Popup(p2, "Can\'t use skill on immediate reset!");

        return;
    end;

    if game:GetService("ReplicatedStorage").Football.Value.Anchored then
        return;
    end;

    if p1.AbilityOne > tick() then
        return;
    end;

    if p1.ABC then
        p1.ABC:Clean();
    end;

    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Vector2_new_ret = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2 - game:GetService("GuiService"):GetGuiInset().Y / 2);
    local v4 = nil;
    local v5 = nil;

    for _, v in game.CollectionService:GetTagged("PlayingTeam") do
        if p2.Team ~= v then
            local v6 = v;

            for _, v2 in v:GetPlayers() do
                local Character = v2.Character;
                local v7;

                if Character then
                    v7 = Character:FindFirstChild("HumanoidRootPart");
                else
                    v7 = Character;
                end;

                if v2.Team == v6 and (v2 ~= p2 and v7) then
                    if Character:GetAttribute("INFDRIBBLE") then
                        return;
                    end;

                    if Character:GetAttribute("CLONE") then
                        return;
                    end;

                    if not (Character.Values.Goalie.Value and Character.Values.IsInPenalty.Value) then
                        local v8, v9 = workspace.CurrentCamera:WorldToScreenPoint(Character.HumanoidRootPart.Position);

                        if v9 then
                            local Magnitude = (Vector2.new(v8.X, v8.Y) - Vector2_new_ret).Magnitude;

                            if v4 == nil or Magnitude < v5 and Character.Values.HasBall.Value == true then
                                v5 = Magnitude;
                                v4 = v2;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local v10 = v4 and v4.Character or workspace:FindFirstChild("PassRig");
    local v11;

    if v10 then
        v11 = v10:FindFirstChild("HumanoidRootPart");
    else
        v11 = v10;
    end;

    if not v11 or (v11 and ((HumanoidRootPart.Position - v11.Position).Magnitude or 9e99) or 9e99) > 20 then
        return Popup.Popup(p2, "Must be close and looking at an enemy!");
    end;

    if v10:GetAttribute("IFrames") then
        return;
    end;

    p1:AbilityCooldown("1", 40);
    p1.Animations:StopAnims();
    p1.Animations.Abilities.BodyBlockR.Priority = Enum.AnimationPriority.Action4;
    p1.Animations.Abilities.BodyBlockR:Play();
    p1.Animations.Abilities.BodyBlockR:AdjustSpeed(1.5);
    p1.AbilityService.Ability:Fire("ArmSwipe", { v10 });
end;