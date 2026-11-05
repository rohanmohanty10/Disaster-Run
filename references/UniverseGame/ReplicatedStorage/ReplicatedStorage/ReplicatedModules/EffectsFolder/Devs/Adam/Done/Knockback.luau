  

 

local LocalPlayer = game.Players.LocalPlayer;

local function findRelativePart(p1, p2) -- Line: 2
    local v3 = string.split(p2, ".");

    for _, v in ipairs(v3) do
        p1 = p1:FindFirstChild(v) or error(v .. " is not found within directory");
    end;

    return p1;
end;

return function(p4, p5) -- Line: 11
    -- upvalues: LocalPlayer (copy), findRelativePart (copy)
    local v6 = p5[1];
    local v7 = p5[2];
    local v8 = p5[3];
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    game:GetService("CollectionService"):AddTag(Character, "AirBypass");
    local PrimaryPart = Character.PrimaryPart;
    local PrimaryPart2 = p4.PrimaryPart;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.P = (1 / 0);

    if v6.Knockback and (v6.Knockback[4] and not v7) then
        PrimaryPart2 = findRelativePart(p4, v6.Knockback[4]);
    end;

    if v6.PilotKnockback then
        local v9 = game.Workspace.Effects:FindFirstChild(p4.Name .. "_Pilot");

        if v9 then
            PrimaryPart2 = v9.PrimaryPart or (v9:FindFirstChild("HumanoidRootPart") or PrimaryPart2);
        end;
    end;

    if not v6.Knockback then
        v6.Knockback = { 0 };
    end;

    if v7 then
        BodyVelocity.Velocity = v7 * (v8 or v6.Knockback[1]);
    else
        BodyVelocity.Velocity = (PrimaryPart.CFrame.Position - PrimaryPart2.CFrame.Position).Unit * (v8 or v6.Knockback[1]);
    end;

    if v6.Knockback[3] then
        BodyVelocity.Velocity = BodyVelocity.Velocity + v6.Knockback[3];
    end;

    game:GetService("Debris"):AddItem(BodyVelocity, v6.Knockback[2] or 0.2);
    BodyVelocity.Parent = PrimaryPart;
    game:GetService("CollectionService"):RemoveTag(Character, "AirBypass");
end;