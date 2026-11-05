  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local _ = workspace.CurrentCamera;
local u1 = Random.new();

return function(p2) -- Line: 7
    -- upvalues: u1 (copy), TweenService (copy), RunService (copy)
    local v3 = p2.Amount or 12;
    local v4 = p2.RockSizeMultiplier or 1;
    local v5 = p2.VelocityMultiplier or 1;
    local Size = p2.Size;
    local Origin = p2.Origin;
    local Delay = p2.Delay;
    local u6 = RaycastParams.new();
    u6.FilterType = Enum.RaycastFilterType.Include;
    u6.FilterDescendantsInstances = { workspace.Map };
    local v7 = Size.X / 2;
    local v8 = Size.Z / 2;
    local v9 = {};

    for _ = 1, v3 do
        local v10 = workspace:Raycast(Origin * CFrame.new(u1:NextNumber(-v7, v7), 0, u1:NextNumber(-v8, v8)).Position, Vector3.new(0, -10, 0), u6);

        if v10 then
            table.insert(v9, v10);
        end;
    end;

    for _, v in v9 do
        local Part = Instance.new("Part");
        Part.Position = v.Position;
        local v11 = u1:NextNumber(1, 3);
        local v12 = u1:NextNumber(1, 3);
        Part.Size = Vector3.new(v11, v12, u1:NextNumber(1, 3)) * v4;
        Part.Anchored = false;
        Part.CanCollide = true;
        Part.CollisionGroup = "Ghosted";
        Part.BottomSurface = Enum.SurfaceType.Smooth;
        Part.TopSurface = Enum.SurfaceType.Smooth;
        Part.Parent = workspace.Effects;
        Part.Color = v.Instance.Color;
        Part.Material = v.Material;
        local v13 = u1:NextNumber(-180, 180);
        local v14 = u1:NextNumber(-180, 180);
        Part.Orientation = Vector3.new(v13, v14, u1:NextNumber(-180, 180));

        for _, child in pairs(v.Instance:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Clone().Parent = Part;
            end;
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Parent = Part;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        local v15 = u1:NextNumber(15, 30);
        LinearVelocity.VectorVelocity = Vector3.new(0, v15, 0) * 3 * v5;
        LinearVelocity.Attachment0 = Attachment;
        LinearVelocity.Parent = Attachment;
        task.delay(5, Part.Destroy, Part);
        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
        local u16 = nil;

        local function Clean() -- Line: 64
            -- upvalues: u16 (ref), TweenService (ref), Part (copy)
            if u16 then
                u16:Disconnect();
                u16 = nil;
                local v17 = TweenService:Create(Part, TweenInfo.new(3), {
                    Size = Vector3.new(0, 0, 0)
                });
                v17:Play();
                v17.Completed:Connect(function() -- Line: 75
                    -- upvalues: Part (ref)
                    Part:Destroy();
                end);
            end;
        end;

        u16 = RunService.Heartbeat:Connect(function(p18) -- Line: 81
            -- upvalues: Part (copy), Clean (copy), u6 (copy)
            if not Part.Parent then
                Clean();
            end;

            if not workspace:Raycast(Part.Position, Part.AssemblyLinearVelocity.Unit * Part.AssemblyLinearVelocity.Magnitude * Part.Size.Magnitude * p18, u6) then
                return;
            end;

            Clean();
        end);

        if Delay then
            task.wait(Delay);
        end;
    end;
end;