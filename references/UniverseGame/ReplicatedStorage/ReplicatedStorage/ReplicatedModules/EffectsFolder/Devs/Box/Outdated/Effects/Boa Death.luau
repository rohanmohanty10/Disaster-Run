  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

local function OutlineObject(p2) -- Line: 5
    -- upvalues: u1 (copy)
    local _ = p2.HumanoidRootPart;
    local _ = p2.Humanoid;
    local v3 = u1.CloneFlash:Clone();
    v3.Parent = workspace.Effects;
    local Head = v3:FindFirstChild("Head");
    local Torso = v3:FindFirstChild("Torso");
    local v4 = v3:FindFirstChild("Left Arm");
    local v5 = v3:FindFirstChild("Right Arm");
    local v6 = v3:FindFirstChild("Left Leg");
    local v7 = v3:FindFirstChild("Right Leg");

    for _, child in pairs(v3:GetChildren()) do
        child.Size = child.Size + Vector3.new(0.1, 0.1, 0.1);
    end;

    Head.CFrame = p2.Head.CFrame;
    Torso.CFrame = p2.Torso.CFrame;
    v4.CFrame = p2["Left Arm"].CFrame;
    v5.CFrame = p2["Right Arm"].CFrame;
    v6.CFrame = p2["Left Leg"].CFrame;
    v7.CFrame = p2["Right Leg"].CFrame;
    local Weld = Instance.new("Weld");
    Weld.Part0 = p2.Head;
    Weld.Part1 = Head;
    Weld.Parent = Head;
    local Weld2 = Instance.new("Weld");
    Weld2.Part0 = p2.Torso;
    Weld2.Part1 = Torso;
    Weld2.Parent = Torso;
    local Weld3 = Instance.new("Weld");
    Weld3.Part0 = p2["Left Arm"];
    Weld3.Part1 = v4;
    Weld3.Parent = v4;
    local Weld4 = Instance.new("Weld");
    Weld4.Part0 = p2["Right Arm"];
    Weld4.Part1 = v5;
    Weld4.Parent = v5;
    local Weld5 = Instance.new("Weld");
    Weld5.Part0 = p2["Left Leg"];
    Weld5.Part1 = v6;
    Weld5.Parent = v6;
    local Weld6 = Instance.new("Weld");
    Weld6.Part0 = p2["Right Leg"];
    Weld6.Part1 = v7;
    Weld6.Parent = v7;

    return v3;
end;

return function(p8) -- Line: 64
    -- upvalues: OutlineObject (copy), TweenService (copy), u1 (copy), Debris (copy)
    local _ = p8.Humanoid;
    local HumanoidRootPart = p8.HumanoidRootPart;
    p8.HumanoidRootPart.Anchored = true;

    for _, child in pairs(p8:GetChildren()) do
        if child:IsA("BasePart") then
            child.Anchored = true;
        end;
    end;

    local v9 = OutlineObject(p8);

    for _, child in pairs(v9:GetChildren()) do
        if child:IsA("BasePart") then
            TweenService:Create(child, TweenInfo.new(0.5), {
                Size = child.Size + Vector3.new(0.01, 0.01, 0.01)
            }):Play();
            TweenService:Create(child, TweenInfo.new(0.5), {
                Color = Color3.fromRGB(150, 153, 173)
            }):Play();
            child.Material = Enum.Material.Slate;
        end;
    end;

    wait(3);
    local v10 = u1.Kur.ground:Clone();
    v10.CFrame = HumanoidRootPart.CFrame;
    v10.Particle1:Emit(v10.Particle1.Rate / 35);
    v10.Particle2:Emit(v10.Particle2.Rate / 35);
    v10.Particle3:Emit(v10.Particle3.Rate / 35);
    v10.Particle4:Emit(v10.Particle4.Rate / 35);
    v10.Attachment.vroom:Emit(v10.Attachment.vroom.Rate / 4);
    v10.Parent = workspace.Effects;
    Debris:AddItem(v10, 3);
    p8:Destroy();
    v9:Destroy();
end;