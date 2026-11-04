 
 

game:GetService("TweenService");

local function createClone(p1: userdata) -- Line: 3
    p1.Archivable = true;
    local u2 = p1:Clone();
    u2.Parent = workspace.Debris;
    local Color3_fromRGB_ret = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if descendant:GetAttribute("Invis") and (descendant.Name ~= "BALL" and descendant.Name ~= "Model") then
                descendant.Transparency = 0;
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("UIStroke"))) then
            descendant:Destroy();
        elseif not descendant:IsA("Decal") then
            descendant:IsA("TextLabel");
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = Color3_fromRGB_ret;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = u2;
    Highlight.Enabled = true;
    task.delay(1, function() -- Line: 53
        -- upvalues: u2 (copy)
        if u2 then
            u2:Destroy();
        end;
    end);

    return u2, Color3_fromRGB_ret;
end;

return function(p3, p4) -- Line: 61
    -- upvalues: createClone (copy)
    local Char = p4.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p4.Task ~= "Clones" then
        if p4.Task == "ColorCorrection" then
            local u5 = script.ColorCorrection:Clone();
            u5.Parent = game.Lighting;
            u5.Enabled = true;
            task.delay(p4.MaxTime, function() -- Line: 100
                -- upvalues: u5 (copy)
                if u5 then
                    u5:Destroy();
                end;
            end);
        end;

        return;
    end;

    local ClonesTime = p4.ClonesTime;
    local u6 = {};
    task.spawn(function() -- Line: 75
        -- upvalues: HumanoidRootPart (copy), ClonesTime (copy), createClone (ref), Char (copy), u6 (ref)
        local os_clock_ret = os.clock();

        while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < ClonesTime do
            local v7 = createClone(Char);
            table.insert(u6, v7);
            task.wait(0.1);
        end;

        if Char then
            Char.Archivable = false;
        end;
    end);
    task.delay(ClonesTime + 5, function() -- Line: 93
        -- upvalues: u6 (ref)
        u6 = nil;
    end);
end;