  

 

local function CreateInstance(p1, p2) -- Line: 1
    local function CheckProperty(p3, p4) -- Line: 3
        local _ = p3[p4];
    end;

    local u5 = Instance.new(p1);

    for i, v in pairs(p2) do
        if pcall(function() -- Line: 10
            -- upvalues: u5 (copy), i (copy)
            local _ = u5[i];
        end) then
            u5[i] = v;
        end;
    end;

    return u5;
end;

local function FetchUserQualityLevel() -- Line: 19
    local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel;

    return (SavedQualityLevel == Enum.SavedQualitySetting.Automatic and 5 or SavedQualityLevel.Value) / 10;
end;

local function _HandleParticle(p6, p7) -- Line: 30
    -- upvalues: CreateInstance (copy)
    local v8 = p6:Clone();
    local Origin = p7.Origin;

    if typeof(Origin) == "Vector3" then
        Origin = CFrame.new(Origin);
    elseif typeof(Origin) == "Instance" then
        Origin = Origin.CFrame;
    end;

    v8.CFrame = Origin;

    if p7.WeldToOrigin then
        v8.Anchored = false;
        CreateInstance("Motor6D", {
            Part0 = p7.Origin,
            Part1 = v8,
            Parent = v8,
            C0 = p7.Offset or CFrame.new()
        });
    end;

    if p7.LookAtAttacker and p7.AttackerToLook then
        v8.CFrame = CFrame.lookAt(v8.Position, p7.AttackerToLook.PrimaryPart.Position);
    end;

    v8.Parent = workspace.Effects;
    local v9 = 3;

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            if p7.Properties then
                for i, v in pairs(p7.Properties) do
                    descendant[i] = v;
                end;
            end;

            if v9 < descendant.Lifetime.Max then
                v9 = descendant.Lifetime.Max;
            end;

            if p7.Type == "Emit" then
                local v10, v11, v12;

                if descendant:GetAttribute("EmitCount") then
                    local v13 = descendant:GetAttribute("EmitCount");
                    local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel;
                    v10 = v13 * ((SavedQualityLevel == Enum.SavedQualitySetting.Automatic and 5 or SavedQualityLevel.Value) / 10);

                    if not v10 then
                        if p7.EmitCount then
                            v11 = p7.EmitCount;
                            v12 = UserSettings().GameSettings.SavedQualityLevel;
                            v10 = v11 * ((v12 == Enum.SavedQualitySetting.Automatic and 5 or v12.Value) / 10) or 1;
                        else
                            v10 = 1;
                        end;
                    end;
                elseif p7.EmitCount then
                    v11 = p7.EmitCount;
                    v12 = UserSettings().GameSettings.SavedQualityLevel;
                    v10 = v11 * ((v12 == Enum.SavedQualitySetting.Automatic and 5 or v12.Value) / 10) or 1;
                else
                    v10 = 1;
                end;

                descendant:Emit(v10);
            elseif p7.Type == "Enable" then
                local Rate = descendant.Rate;
                local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel;
                descendant.Rate = Rate * ((SavedQualityLevel == Enum.SavedQualitySetting.Automatic and 5 or SavedQualityLevel.Value) / 10);
                descendant.Enabled = true;
                task.delay(p7.EnableDuration, function() -- Line: 79
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end;

    game.Debris:AddItem(v8, p7.DestroyTime or v9);
end;

return function(...) -- Line: 88
    -- upvalues: _HandleParticle (copy)
    local v14 = { ... };

    if typeof(v14[1]) ~= "Instance" or not v14[1]:FindFirstChild("HumanoidRootPart") then
        if typeof(v14[1]) == "Instance" then
            local v15, v16 = unpack(v14);
            _HandleParticle(v15, v16);
        end;

        return;
    end;

    local v17, v18, v19, v20 = unpack(v14);
    v20.Origin = v18:FindFirstChild(v20.CustomParent or "HumanoidRootPart");
    v20.AttackerToLook = v17;
    _HandleParticle(v19, v20);
end;