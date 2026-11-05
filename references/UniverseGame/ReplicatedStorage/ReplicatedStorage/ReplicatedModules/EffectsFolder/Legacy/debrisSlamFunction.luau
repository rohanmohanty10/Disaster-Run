  

 

local LocalPlayer = game.Players.LocalPlayer;
local CameraShaker = require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local EffectsHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.EffectsHandler);
local u1 = {
    camShake = EffectsHandler.CallEffect("Init"),
    RayCastOnMap = EffectsHandler.GetEffect("RayCastOnMap")
};

return function(p2, p3, p4) -- Line: 8
    -- upvalues: LocalPlayer (copy), u1 (copy), CameraShaker (copy)
    if typeof(p3) == "Instance" then
        p3 = p3.CFrame;
    end;

    if (LocalPlayer.Character.PrimaryPart.Position - (p3 or p2.PrimaryPart.CFrame).p).Magnitude < 15 and not p4 then
        if LocalPlayer.Settings.CameraShake.Value == false then
            return;
        end;

        u1.camShake:Shake(CameraShaker.Presets.Explosion2);
    end;

    local v5 = game.ReplicatedStorage["Client Assets"]["The World"].DebrisImpact:Clone();
    v5.Parent = game.Workspace.Effects;

    if not p3 then
        local v6 = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
        local Angles = CFrame.Angles;
        local v7 = math.random(-360, 360);
        p3 = v6 * Angles(0, math.rad(v7), 0);
    end;

    v5:SetPrimaryPartCFrame(p3);
    local v8 = u1.RayCastOnMap(v5.PrimaryPart.Position, Vector3.new(0, -10, 0), true);

    if not v8 then
        v5:Destroy();

        return;
    end;

    local v9 = v5.PrimaryPart.CFrame - v5.PrimaryPart.Position;
    v5:SetPrimaryPartCFrame(CFrame.new(v8.Position + Vector3.new(0, 3, 0)) * v9);

    for _, child in ipairs(v5:GetChildren()) do
        if child.Name ~= "Primary" and child.Name ~= "Crack" then
            if v8 and v8.Instance then
                child.Material = v8.Material;

                if v8.Instance.Parent.Name == "LeftToStart" then
                    child.Color = Color3.new(0.0235294, 0.0235294, 0.0235294);
                else
                    child.Color = v8.Instance.Color;
                end;
            end;

            local v10 = math.random(1, 2);

            if v10 ~= 1 then
                local _ = v10 == 2;
            end;

            local u11 = child:Clone();
            u11.Parent = game.Workspace.Effects;
            local CFrame2 = v5.Primary.CFrame;
            local Angles = CFrame.Angles;
            local v12 = math.random(-360, 360);
            local v13 = math.rad(v12);
            local v14 = math.random(-360, 360);
            local v15 = math.rad(v14);
            local v16 = math.random(-360, 360);
            u11.CFrame = CFrame2 * Angles(v13, v15, (math.rad(v16)));
            local v17 = math.random(1, 2);
            local v18 = math.random(1, 2);
            u11.Size = Vector3.new(v17, v18, math.random(1, 2));
            u11.Anchored = false;
            u11.CanCollide = false;
            local BodyPosition = Instance.new("BodyPosition");
            BodyPosition.Parent = u11;
            BodyPosition.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyPosition.Position = v5.Primary.CFrame * CFrame.new(math.random(-2, 2), math.random(-1, 1), math.random(-2, 2)) * CFrame.new(math.random(-25, 25), math.random(1, 25), math.random(-25, 25)).Position;
            coroutine.wrap(function() -- Line: 58
                -- upvalues: BodyPosition (copy), u11 (copy)
                wait(0.25);
                BodyPosition:Destroy();
                u11.CanCollide = true;
                wait(5);
                u11:Destroy();
            end)();
        end;
    end;

    wait(5);

    for _, child in ipairs(v5:GetChildren()) do
        child.Anchored = false;
        child.CanCollide = false;
        wait(0.1);
        coroutine.wrap(function() -- Line: 73
            -- upvalues: child (copy)
            wait(2);
            child:Destroy();
        end)();
    end;

    v5:Destroy();
end;