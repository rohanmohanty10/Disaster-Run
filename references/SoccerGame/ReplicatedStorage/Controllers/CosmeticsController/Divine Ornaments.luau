  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Children = script.Orbs:GetChildren();

function v1.SetupCosmetic(u2, p3) -- Line: 9
    -- upvalues: CollectionService (copy), Children (copy), RunService (copy)
    if u2:FindFirstChild("FollowingPlanets") then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "FollowingPlanets";
    Folder.Parent = u2;
    CollectionService:AddTag(Folder, (`Cosmetic{p3}`));
    local v4 = 6.283185307179586 / #Children;
    local HumanoidRootPart = u2.HumanoidRootPart;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local v5 = HumanoidRootPart.Position - LookVector * 1.5;
    local CFrame_lookAt_ret = CFrame.lookAt(v5, v5 + LookVector);
    local u6 = {};

    for i, v in ipairs(Children) do
        local v7 = v:Clone();
        v7.Anchored = true;
        v7.CanCollide = false;
        local v8 = {
            Model = v7,
            TargetAngle = (i - 1) * v4,
            TimeOffset = math.random(1, 100),
            WaveLength = math.random(-10, 10) / 10,
            Rotation = CFrame.Angles(0, 0, 0),
            RotationSpeed = math.random(5, 15) / 50
        };
        local TargetAngle = v8.TargetAngle;
        local v9 = math.sin(TargetAngle) * 2.5;
        local v10 = math.cos(TargetAngle) * 2.5;
        local Vector3_new_ret = Vector3.new(v9, v10, 0);
        local v11 = CFrame_lookAt_ret * CFrame.new(Vector3_new_ret);
        local v12 = tick() + v8.TimeOffset + v8.WaveLength;
        v8.YOffset = math.sin(v12) / 3;
        v7.CFrame = v11 + Vector3.new(0, v8.YOffset, 0);
        v7.Parent = Folder;
        table.insert(u6, v8);
    end;

    local u13 = nil;
    local u14 = 0;
    u13 = RunService.RenderStepped:Connect(function(p15) -- Line: 71
        -- upvalues: Folder (copy), u13 (ref), u2 (copy), u14 (ref), u6 (copy)
        if not Folder.Parent then
            u13:Disconnect();

            return;
        end;

        local HumanoidRootPart2 = u2.HumanoidRootPart;
        local LookVector2 = HumanoidRootPart2.CFrame.LookVector;
        local v16 = HumanoidRootPart2.Position - LookVector2 * 1.5;
        u14 = u14 + 0.5 * p15;

        for _, v in ipairs(u6) do
            local v17 = v.TargetAngle + u14;
            local v18 = math.sin(v17) * 2.5;
            local v19 = math.cos(v17) * 2.5;
            local Vector3_new_ret = Vector3.new(v18, v19, 0);
            local v20 = CFrame.lookAt(v16, v16 + LookVector2) * CFrame.new(Vector3_new_ret);
            local v21 = tick() + v.TimeOffset + v.WaveLength;
            v.YOffset = math.sin(v21) / 3;
            v.Rotation = v.Rotation * CFrame.Angles(0, v.RotationSpeed * p15, 0);
            local CFrame_lookAt_ret2 = CFrame.lookAt(v20.Position, HumanoidRootPart2.Position);
            v.Model.CFrame = (v20 + Vector3.new(0, v.YOffset, 0)) * CFrame_lookAt_ret2.Rotation * v.Rotation;
        end;
    end);
end;

return v1;