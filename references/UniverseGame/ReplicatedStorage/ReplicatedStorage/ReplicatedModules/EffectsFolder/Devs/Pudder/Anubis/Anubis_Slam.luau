  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local _ = workspace.CurrentCamera;
local u1 = Random.new();

return function(p2) -- Line: 11
    -- upvalues: ParticleHandler (copy), TweenService (copy), u1 (copy), RunService (copy)
    local v3 = ParticleHandler.TranslateToCFrame(p2.Origin);
    local Object = p2.Object;
    local v4 = p2.Amount or 8;
    local Attachment1 = Object:FindFirstChild("Attachment1");
    local Player = p2.Player;
    local v5 = p2.Scale or 1;

    if not (Object and (Attachment1 and v3)) then
        return;
    end;

    local u6 = Object:Clone();
    u6.CFrame = v3;
    u6.Parent = workspace.Effects;
    local Attachment12 = u6:FindFirstChild("Attachment1");
    ParticleHandler.EnableParticle(u6, true);
    local v7 = {
        Width0 = 0,
        Width1 = 0
    };

    if Player then
        local v8 = not Player and "" or Player.Data.Skin:GetAttribute("SkinName");
        local v9 = ParticleHandler.GetSkinInfo(v8);

        if v9 and v9.Metadata then
            if v9.Metadata.HueShift then
                ParticleHandler.HueShiftParticles(u6, v9.Metadata.HueShift);
            end;

            if v9.Metadata.HSVShift then
                ParticleHandler.HSVShiftParticles(u6, v9.Metadata.HSVShift);
            end;
        end;

        local v10 = 0;

        if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
            v10 = v10 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v10 > 0 and (v9 and (v9.Metadata and v9.Metadata.SaturationThreshold)) then
            ParticleHandler.HSVShiftParticles(u6, {
                SaturationThreshold = v9.Metadata.SaturationThreshold
            });
        end;

        if v10 > 0 then
            ParticleHandler.HSVShiftParticles(u6, {
                HueShift = v10
            });
        end;
    end;

    for _, child in pairs(Attachment12:GetChildren()) do
        if child:IsA("Beam") then
            TweenService:Create(child, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), v7):Play();
        end;
    end;

    local v11 = {
        CFrame = CFrame.new(0, 10 * v5, 0)
    };
    local v12 = TweenService:Create(Attachment12, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), v11);
    v12:Play();
    v12.Completed:Connect(function() -- Line: 78
        -- upvalues: ParticleHandler (ref), u6 (ref)
        ParticleHandler.EnableParticle(u6, false);
        ParticleHandler.DestroyEmit(u6);
    end);
    local u13 = RaycastParams.new();
    u13.FilterType = Enum.RaycastFilterType.Include;
    u13.FilterDescendantsInstances = { workspace.Map };
    local v14 = workspace:Raycast(v3.Position + Vector3.new(0, 1, 0), Vector3.new(0, -10, 0), u13);

    if not (v14 and (v14.Position and v14.Instance)) then
        return;
    end;

    for _ = 1, v4 do
        local Part = Instance.new("Part");
        Part.CFrame = v3;
        local v15 = u1:NextNumber(1, 3);
        local v16 = u1:NextNumber(1, 3);
        Part.Size = Vector3.new(v15, v16, u1:NextNumber(1, 3));
        Part.Anchored = false;
        Part.CanCollide = true;
        Part.CollisionGroup = "Ghosted";
        Part.BottomSurface = Enum.SurfaceType.Smooth;
        Part.TopSurface = Enum.SurfaceType.Smooth;
        Part.Parent = workspace.Effects;
        Part.Color = v14.Instance.Color;
        Part.Material = v14.Material;
        local v17 = u1:NextNumber(-180, 180);
        local v18 = u1:NextNumber(-180, 180);
        Part.Orientation = Vector3.new(v17, v18, u1:NextNumber(-180, 180));

        for _, child in pairs(v14.Instance:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Clone().Parent = Part;
            end;
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Parent = Part;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        local v19 = u1:NextNumber(-15, 15);
        local v20 = u1:NextNumber(5, 15);
        LinearVelocity.VectorVelocity = Vector3.new(v19, v20, u1:NextNumber(-15, 15)) * 3;
        LinearVelocity.Attachment0 = Attachment;
        LinearVelocity.Parent = Attachment;
        task.delay(5, Part.Destroy, Part);
        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
        local u21 = nil;

        local function Clean() -- Line: 127
            -- upvalues: u21 (ref), TweenService (ref), Part (copy)
            if u21 then
                u21:Disconnect();
                u21 = nil;
                local v22 = TweenService:Create(Part, TweenInfo.new(3), {
                    Size = Vector3.new(0, 0, 0)
                });
                v22:Play();
                v22.Completed:Connect(function() -- Line: 138
                    -- upvalues: Part (ref)
                    Part:Destroy();
                end);
            end;
        end;

        u21 = RunService.Heartbeat:Connect(function(p23) -- Line: 146
            -- upvalues: Part (copy), Clean (copy), u13 (copy)
            if not Part.Parent then
                Clean();
            end;

            if not workspace:Raycast(Part.Position, Part.AssemblyLinearVelocity.Unit * Part.AssemblyLinearVelocity.Magnitude * Part.Size.Magnitude * p23, u13) then
                return;
            end;

            Clean();
        end);
    end;
end;