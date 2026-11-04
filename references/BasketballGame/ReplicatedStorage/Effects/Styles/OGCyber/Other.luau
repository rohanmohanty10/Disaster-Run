 
 

game:GetService("TweenService");

local function createClone(p1: userdata) -- Line: 3
    p1.Archivable = true;
    local u2 = p1:Clone();
    u2.Parent = workspace.Debris;
    local v3 = ({
        Color3.fromRGB(66, 252, 255),
        Color3.fromRGB(65, 141, 255),
        Color3.fromRGB(255, 248, 43),
        Color3.fromRGB(255, 200, 61)
    })[math.random(1, 4)];

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
    Highlight.FillColor = v3;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = v3;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = u2;
    Highlight.Enabled = true;
    task.delay(1, function() -- Line: 59
        -- upvalues: u2 (copy)
        if u2 then
            u2:Destroy();
        end;
    end);

    return u2, v3;
end;

return function(p4, p5) -- Line: 67
    -- upvalues: createClone (copy)
    local Char = p5.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p5.Task ~= "Clones" then
        if p5.Task == "ColorCorrection" then
            local u6 = script.ColorCorrection:Clone();
            u6.Parent = game.Lighting;
            u6.Enabled = true;
            task.delay(p5.MaxTime, function() -- Line: 106
                -- upvalues: u6 (copy)
                if u6 then
                    u6:Destroy();
                end;
            end);
        end;

        return;
    end;

    local ClonesTime = p5.ClonesTime;
    local u7 = {};
    task.spawn(function() -- Line: 81
        -- upvalues: HumanoidRootPart (copy), ClonesTime (copy), createClone (ref), Char (copy), u7 (ref)
        local os_clock_ret = os.clock();

        while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < ClonesTime do
            local v8 = createClone(Char);
            table.insert(u7, v8);
            task.wait(0.1);
        end;

        if Char then
            Char.Archivable = false;
        end;
    end);
    task.delay(ClonesTime + 5, function() -- Line: 99
        -- upvalues: u7 (ref)
        u7 = nil;
    end);
end;