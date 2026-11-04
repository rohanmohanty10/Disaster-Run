  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u2 = script:WaitForChild("Lunar Lantern");
local LanternAttachments = script:WaitForChild("LanternAttachments");

function v1.SetupCosmetic(p3, p4) -- Line: 10
    -- upvalues: CollectionService (copy), LanternAttachments (copy), u2 (copy), RunService (copy)
    if p3:FindFirstChild("FollowingLanterns") then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "FollowingLanterns";
    Folder.Parent = p3;
    CollectionService:AddTag(Folder, (`Cosmetic{p4}`));
    local u5 = {};

    for _, child in LanternAttachments:GetChildren() do
        local v6 = child:Clone();
        v6.Parent = p3.HumanoidRootPart;
        local v7 = u2:Clone();
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
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 58
        -- upvalues: Folder (copy), u9 (ref), u5 (copy)
        if Folder.Parent then
            for _, v in pairs(u5) do
                local v11 = tick() + v.TimeOffset + v.WaveLength;
                v.YOffset = math.sin(v11) / 3;
                v.ActualPosition = v.ActualPosition:Lerp(v.Attachment.WorldCFrame, v.Speed);
                v.Rotation = v.Rotation * CFrame.Angles(0, v.RotationSpeed * p10, 0);
                v.Model.CFrame = (v.ActualPosition + Vector3.new(0, v.YOffset, 0)) * v.Rotation;
            end;

            return;
        end;

        u9:Disconnect();
    end);
end;

return v1;