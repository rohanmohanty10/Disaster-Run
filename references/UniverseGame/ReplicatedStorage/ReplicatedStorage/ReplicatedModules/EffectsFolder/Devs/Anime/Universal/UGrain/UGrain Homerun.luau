  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 15
    -- upvalues: u1 (copy), TweenService (copy)
    local v3 = p2 or {};
    local HumanoidRootPart = v3.Character.HumanoidRootPart;
    task.delay(v3.Delay or 0, function() -- Line: 25
        -- upvalues: HumanoidRootPart (copy), u1 (ref), TweenService (ref)
        local v4 = RaycastParams.new();
        v4.FilterType = Enum.RaycastFilterType.Include;
        v4.FilterDescendantsInstances = { workspace.Map };
        local v5 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -15, 0), v4);

        if v5 then
            for _ = 1, 10 do
                local v6 = NumberRange.new(0.45, 0.7);
                local Part = Instance.new("Part");
                local v7 = CFrame.new(v5.Position);
                local Angles = CFrame.Angles;
                local v8 = u1:NextNumber(-360, 360);
                local v9 = math.rad(v8);
                local v10 = u1:NextNumber(-360, 360);
                local v11 = math.rad(v10);
                local v12 = u1:NextNumber(-360, 360);
                Part.CFrame = v7 * Angles(v9, v11, (math.rad(v12)));
                local v13 = u1:NextNumber(v6.Min, v6.Max);
                local v14 = u1:NextNumber(v6.Min, v6.Max);
                Part.Size = Vector3.new(v13, v14, u1:NextNumber(v6.Min, v6.Max));
                Part.Anchored = false;
                Part.CanCollide = true;
                Part.CollisionGroup = "Ghosted";
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Color = v5.Instance.Color;
                Part.Material = v5.Material;
                Part.Transparency = 0;
                local v15 = u1:NextNumber(-180, 180);
                local v16 = u1:NextNumber(-180, 180);
                Part.Orientation = Vector3.new(v15, v16, u1:NextNumber(-180, 180));
                Part.Parent = workspace.Effects;
                local v17 = Part.Size.Magnitude / 2;

                for _, child in pairs(v5.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                for _, descendant in Part:GetDescendants() do
                    if descendant:IsA("Attachment") then
                        descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v17, descendant.Position.Z);
                    end;
                end;

                local Attachment = Instance.new("Attachment");
                Attachment.Parent = Part;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                LinearVelocity.VectorVelocity = 50 * (HumanoidRootPart.CFrame.LookVector * u1:NextNumber(0.2, 0.7) + HumanoidRootPart.CFrame.RightVector * u1:NextNumber(-0.4, 0.4) + HumanoidRootPart.CFrame.UpVector * u1:NextNumber(0.25, 0.45));
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.Parent = Attachment;
                task.delay(u1:NextNumber(0.8, 1.4), function() -- Line: 74
                    -- upvalues: TweenService (ref), Part (copy), u1 (ref)
                    local v18 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1, 2)), {
                        Size = Vector3.new(0, 0, 0)
                    });
                    v18:Play();
                    v18.Completed:Connect(function() -- Line: 81
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                end);
                task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
            end;
        end;
    end);
end;