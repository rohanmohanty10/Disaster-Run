  

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local u1 = TweenInfo.new(1.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

return function(p2) -- Line: 10
    -- upvalues: Players (copy), LocalPlayer (copy), SoundGroups (copy), TweenService (copy), u1 (copy)
    local Target = p2.Target;
    local v3;

    if Target then
        v3 = Players:GetPlayerFromCharacter(Target);
    else
        v3 = Target;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and (Target and (Target:IsDescendantOf(workspace) and Target.PrimaryPart))) then
        return;
    end;

    Target:FindFirstChild("Humanoid");
    local v4 = Target:FindFirstChild("HumanoidRootPart") or (Target.PrimaryPart or Target:FindFirstChildWhichIsA("BasePart"));

    if p2.PartName then
        v4 = Target:FindFirstChild(p2.PartName);
    end;

    if not v4 or (Character.CFrame.Position - v4.CFrame.Position).Magnitude > 200 then
        return;
    end;

    local u5 = Instance.fromExisting(script[v3 == LocalPlayer and "Receiver" or "Attacker"]);
    SoundGroups:AssignSoundTag(u5);
    u5.Parent = v4;
    local u6 = script.Indicator:Clone();
    u6.Name = "TF2CritIndicator";
    u6.Enabled = true;
    u6.Adornee = workspace.Terrain;
    u6.Parent = Target;
    u5:Play();
    local u7 = TweenService:Create(u6, u1, {
        StudsOffset = Vector3.new(0, 2.5, 0)
    });
    local u8 = TweenService:Create(u6.Image, u1, {
        ImageTransparency = 1,
        ImageColor3 = Color3.new(0.5, 0.5, 0.5)
    });
    u6.StudsOffsetWorldSpace = v4.CFrame.Position + Vector3.new(0, 0.5, 0);
    u7:Play();
    u8:Play();
    u7.Completed:Once(function() -- Line: 61
        -- upvalues: u5 (copy), u7 (copy), u8 (copy), u6 (copy)
        if u5 then
            u5:Destroy();
        end;

        u7:Destroy();
        u8:Destroy();
        u6:Destroy();
    end);
end;