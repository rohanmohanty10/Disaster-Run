  

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: Players (copy), LocalPlayer (copy), u1 (copy), TweenService (copy)
    local Target = p2.Target;

    if Target then
        Players:GetPlayerFromCharacter(Target);
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and (Target and (Target:IsDescendantOf(workspace) and Target.PrimaryPart))) then
        return;
    end;

    Target:FindFirstChild("Humanoid");
    local v3 = Target:FindFirstChild("HumanoidRootPart") or (Target.PrimaryPart or Target:FindFirstChildWhichIsA("BasePart"));

    if p2.PartName then
        v3 = Target:FindFirstChild(p2.PartName);
    end;

    if not v3 or (Character.CFrame.Position - v3.CFrame.Position).Magnitude > 200 then
        return;
    end;

    local u4 = script.Indicator:Clone();
    u4.Name = "ResistIndicator";
    u4.Enabled = true;
    u4.Adornee = workspace.Terrain;
    u4.Parent = Target;
    local v5 = TweenInfo.new(u1:NextNumber(0.85, 1.75), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    local v6 = u1:NextNumber(1, 3);
    local v7 = u1:NextNumber(-1.5, 1.5);
    local v8 = u1:NextInteger(1, 2) == 1 and 1 or -1;
    local TextLabel = u4.TextLabel;
    TextLabel.Rotation = TextLabel.Rotation * v8;
    local UIGradient = u4.TextLabel.UIGradient;
    UIGradient.Rotation = UIGradient.Rotation * v8;
    local u9 = TweenService:Create(u4, v5, {
        StudsOffset = Vector3.new(v6 * v8, 2.5, v7)
    });
    local u10 = TweenService:Create(u4.TextLabel, v5, {
        TextTransparency = 1,
        TextColor3 = Color3.new(0.25, 0.25, 0.25)
    });
    local Position = v3.CFrame.Position;
    local v11 = u1:NextNumber(-0.25, 0.25);
    local v12 = u1:NextNumber(0.25, 0.75);
    u4.StudsOffsetWorldSpace = Position + Vector3.new(v11, v12, u1:NextNumber(-0.25, 0.25));
    u9:Play();
    u10:Play();
    u9.Completed:Once(function() -- Line: 65
        -- upvalues: u9 (copy), u10 (copy), u4 (copy)
        u9:Destroy();
        u10:Destroy();
        u4:Destroy();
    end);
end;