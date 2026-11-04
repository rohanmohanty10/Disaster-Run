  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(u2, p3) -- Line: 5
    -- upvalues: CollectionService (copy), RunService (copy)
    local v4 = script.Part:Clone();
    v4.CanCollide = false;
    v4.CanTouch = false;
    v4.CanQuery = false;
    v4.Massless = true;
    v4.Anchored = false;
    v4.Transparency = 1;
    v4:PivotTo(u2.HumanoidRootPart.CFrame);
    v4.Parent = u2.HumanoidRootPart;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u2.HumanoidRootPart;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    local u5 = script.Model:Clone();
    u5.Parent = u2.HumanoidRootPart;

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
        end;
    end;

    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    local u6 = 0;
    local u7 = nil;
    u7 = RunService.Heartbeat:Connect(function(p8) -- Line: 38
        -- upvalues: u5 (copy), u2 (copy), u7 (ref), u6 (ref)
        if not (u5.Parent and u2.Parent) then
            u7:Disconnect();

            return;
        end;

        u6 = u6 + 1 * p8;
        u5:PivotTo(u2.HumanoidRootPart.CFrame * CFrame.Angles(0, u6, 0));
    end);
end;

return v1;