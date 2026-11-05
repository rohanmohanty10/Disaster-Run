  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local CFrame2 = Character.HumanoidRootPart.CFrame;
    local v3 = v2.TweenDelay or 0;
    local v4 = v2.Lifetime or 0.5;
    local v5;

    if v2.Origin then
        v5 = typeof(v2.Origin) == "Vector3" and CFrame.new(v2.Origin, v2.Origin, CFrame2.LookVector) or (v2.Origin or CFrame2);
    else
        v5 = CFrame2;
    end;

    local Model = Instance.new("Model");
    task.delay(v4 + v3, Model.Destroy, Model);
    local v6 = next;
    local v7, v8 = Character:GetChildren();

    for _, v in v6, v7, v8 do
        if not v:IsA("Model") and (not v:IsA("LuaSourceContainer") and (not v:IsA("Folder") and v.Archivable)) then
            local v9 = v:Clone();
            local v10 = next;
            local v11, v12 = v9:GetDescendants();

            for _, v13 in v10, v11, v12 do
                if v13:IsA("Sound") or (v13:IsA("ParticleEmitter") or (v13:IsA("Trail") or (v13:IsA("LuaSourceContainer") or (v13:IsA("Folder") or (v13:IsA("Motor6D") or (v13:IsA("Weld") or v13:IsA("BillboardGui"))))))) then
                    v13:Destroy();
                end;
            end;

            if v9:IsA("Humanoid") then
                v9.DisplayDistanceType = "None";
                v9.HealthDisplayType = "AlwaysOff";
                v9.BreakJointsOnDeath = false;
                v9.EvaluateStateMachine = false;
                v9.RequiresNeck = false;
                v9.AutomaticScalingEnabled = false;
            end;

            if v9:IsA("Accessory") then
                v9 = v9:FindFirstChild("handle") or v9:FindFirstChild("Handle");
                local v = v:FindFirstChild("handle") or v:FindFirstChild("Handle");
            end;

            if v9:IsA("BasePart") and v9.Transparency < 1 then
                v9.CollisionGroup = "FX";
                v9.CanCollide = false;
                v9.CanQuery = false;
                v9.Anchored = true;
                v9.CastShadow = false;
                v9.CFrame = v5 * CFrame2:ToObjectSpace(v.CFrame);
            end;

            v9.Parent = Model;
        end;
    end;

    Model.Parent = workspace.Effects;

    for _, descendant in Model:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and descendant.Transparency < 1 then
            descendant.Transparency = descendant.Transparency <= 0.2 and 0.5 or descendant.Transparency;
            local v13 = TweenService:Create(descendant, TweenInfo.new(v4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = 1
            });
            task.delay(v3, v13.Play, v13);

            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;
    end;
end;