  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;

local function SetColor(p1, p2) -- Line: 6
    local v3 = {};
    local v4 = {};

    for _, v in pairs(p1.Color.Keypoints) do
        table.insert(v3, {
            Time = v.Time,
            Value = v.Value
        });
    end;

    for _, v in pairs(v3) do
        table.insert(v4, ColorSequenceKeypoint.new(v.Time, Color3.new(v.Value.R * p2.R, v.Value.G * p2.G, v.Value.B * p2.B)));
    end;

    p1.Color = ColorSequence.new(v4);
end;

return function(p5, p6) -- Line: 22
    -- upvalues: ClientAssets (copy), SetColor (copy), GenericModule (copy)
    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v7 = ClientAssets.Combat.MeterLevel:FindFirstChild("Level" .. p6);

    if not v7 then
        return;
    end;

    local u8 = v7:Clone();
    u8.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = HumanoidRootPart;
    WeldConstraint.Part1 = u8;
    WeldConstraint.Parent = u8;
    u8.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            SetColor(descendant, p5:GetAttribute("MeterColor") or Color3.new(1, 1, 1));
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(3.5, function() -- Line: 50
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;