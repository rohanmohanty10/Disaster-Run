  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local PlanetAttachments = script:WaitForChild("PlanetAttachments");
local u2 = {
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud,
    script.Cloud
};

function v1.SetupCosmetic(u3, p4) -- Line: 22
    -- upvalues: CollectionService (copy), PlanetAttachments (copy), u2 (copy), RunService (copy)
    if not u3:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if u3:FindFirstChild("FollowingPlanets") then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "FollowingPlanets";
    Folder.Parent = u3;
    CollectionService:AddTag(Folder, (`Cosmetic{p4}`));
    local u5 = {};

    for i, child in PlanetAttachments:GetChildren() do
        local v6 = child:Clone();
        v6.Parent = u3.HumanoidRootPart;
        local v7 = u2[i]:Clone();
        v7.Position = v6.WorldPosition;
        v7.Parent = Folder;
        local v8 = {
            Model = v7,
            Attachment = v6,
            ActualPosition = v7.CFrame,
            YOffset = 0,
            TimeOffset = math.random(1, 100),
            Speed = 0.08 + math.random(-3, 3) / 100,
            WaveLength = math.random(-10, 10) / 10,
            Rotation = CFrame.Angles(0, 0, 0),
            RotationSpeed = math.random(5, 15) / 50
        };
        table.insert(u5, v8);
    end;

    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 73
        -- upvalues: u3 (copy), u9 (ref), Folder (copy), u5 (copy)
        if not (u3 and (u3.Parent and u3:FindFirstChild("HumanoidRootPart"))) then
            u9:Disconnect();

            return;
        end;

        if not Folder.Parent then
            u9:Disconnect();

            return;
        end;

        local CFrame_new_ret = CFrame.new(u3.HumanoidRootPart.Position);

        for _, v in pairs(u5) do
            local v11 = tick() + v.TimeOffset + v.WaveLength;
            v.YOffset = math.sin(v11) / 3;
            v.ActualPosition = v.ActualPosition:Lerp(v.Attachment.WorldCFrame, v.Speed);
            v.Rotation = v.Rotation * CFrame.Angles(0, v.RotationSpeed * p10, 0);
            v.Model.CFrame = (v.ActualPosition + Vector3.new(0, v.YOffset, 0)) * v.Rotation;
            local v12 = CFrame_new_ret:ToObjectSpace(v.Attachment.WorldCFrame);
            local v13 = math.abs((v.ActualPosition.Position - u3.HumanoidRootPart.Position).Magnitude) * 3;
            local v14 = CFrame_new_ret * CFrame.Angles(0, 2 * p10 / v13, 0);
            v.Attachment.WorldCFrame = v14 * v12;
        end;
    end);
end;

return v1;