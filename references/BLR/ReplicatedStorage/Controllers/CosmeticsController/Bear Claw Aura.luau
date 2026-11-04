  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Essentials = require(ReplicatedStorage.Shared.Essentials);

function v1.SetupCosmetic(p2: userdata, p3: any) -- Line: 11
    -- upvalues: Essentials (copy), CollectionService (copy)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local u4 = p2:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and u4) then
        return;
    end;

    local script_HumanoidRootPart = script.HumanoidRootPart;
    local v5 = script.Bear:Clone();
    local v6 = HumanoidRootPart.CFrame * script_HumanoidRootPart.CFrame:ToObjectSpace(v5:GetPivot());
    v5.Parent = p2;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
        end;
    end;

    local u7 = Essentials:WeldOffset(HumanoidRootPart, v5.PrimaryPart, CFrame.new());
    local u8 = HumanoidRootPart.CFrame:ToObjectSpace(v6);
    u7.C0 = u8;
    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://81158152207079";
    local v9 = v5.AnimationController.Animator:LoadAnimation(Animation);
    v9.Looped = true;
    v9:Play();
    local v10 = script.VFX:Clone();
    v10:PivotTo(HumanoidRootPart.CFrame * script_HumanoidRootPart.CFrame:ToObjectSpace(v10:GetPivot()));

    for _, descendant in v10:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
        end;
    end;

    v10.Parent = p2;
    Essentials:Weld(HumanoidRootPart, v10.HumanoidRootPart, v10.HumanoidRootPart);

    for _, descendant in v10:GetDescendants() do
        if descendant:IsA("BasePart") and descendant ~= v10.HumanoidRootPart then
            Essentials:Weld(v10.HumanoidRootPart, descendant, descendant);
        end;
    end;

    CollectionService:AddTag(v10, (`Cosmetic{p3}`));
    local HipHeight = u4.HipHeight;
    u7.C0 = u8 * CFrame.new(0, -(u4.HipHeight - HipHeight), 0);
    local u11 = u4:GetPropertyChangedSignal("HipHeight"):Connect(function() -- Line: 68, Name: updateWeldForHipHeight
        -- upvalues: u4 (copy), HipHeight (copy), u7 (copy), u8 (copy)
        u7.C0 = u8 * CFrame.new(0, -(u4.HipHeight - HipHeight), 0);
    end);
    v5.Destroying:Connect(function() -- Line: 76
        -- upvalues: u11 (copy)
        if u11 then
            u11:Disconnect();
        end;
    end);
end;

return v1;