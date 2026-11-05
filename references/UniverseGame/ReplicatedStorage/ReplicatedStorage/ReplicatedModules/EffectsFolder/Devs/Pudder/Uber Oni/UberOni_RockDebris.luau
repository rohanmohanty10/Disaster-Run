  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = PathShortcuts.ClientAssets;
local u1 = game.ReplicatedStorage["Client Assets"].Assets.Abilities["Uber Oni"].Particles["Limb Trail"];
local _ = workspace.CurrentCamera;
local u2 = Random.new();

return function(p3) -- Line: 16
    -- upvalues: ParticleHandler (copy), u1 (copy), u2 (copy), TweenService (copy)
    local v4 = ParticleHandler.TranslateToCFrame(p3.Origin);
    local Amount = p3.Amount;
    local _ = p3.Particle;
    local v5 = p3.Size or NumberRange.new(1, 3);
    local v6 = p3.SideVelocity or NumberRange.new(-50, 50);
    local v7 = p3.UpVelocity or NumberRange.new(40, 50);
    local v8 = RaycastParams.new();
    v8.FilterType = Enum.RaycastFilterType.Include;
    v8.FilterDescendantsInstances = { workspace.Map };
    local v9 = workspace:Raycast(v4.Position, Vector3.new(0, -50, 0), v8);

    if not (v9 and (v9.Position and v9.Instance)) then
        return;
    end;

    for _ = 1, Amount do
        local u10 = p3.Trail and typeof(p3.Trail) == "Instance" and p3.Trail:Clone() or u1:Clone();
        u10.CFrame = v4;
        local v11 = u2:NextNumber(v5.Min, v5.Max);
        local v12 = u2:NextNumber(v5.Min, v5.Max);
        u10.Size = Vector3.new(v11, v12, u2:NextNumber(v5.Min, v5.Max));
        u10.Anchored = false;
        u10.CanCollide = true;
        u10.CollisionGroup = "Ghosted";
        u10.BottomSurface = Enum.SurfaceType.Smooth;
        u10.TopSurface = Enum.SurfaceType.Smooth;
        u10.Parent = workspace.Effects;
        u10.Color = v9.Instance.Color;
        u10.Material = v9.Material;
        u10.Transparency = 0;
        u10.CanQuery = true;
        u10.CanTouch = true;
        local v13 = u2:NextNumber(-180, 180);
        local v14 = u2:NextNumber(-180, 180);
        u10.Orientation = Vector3.new(v13, v14, u2:NextNumber(-180, 180));
        ParticleHandler.Unusualify(u10, {
            Character = p3.Character
        });
        local v15 = u10.Size.Magnitude / 2;

        for _, child in pairs(v9.Instance:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Clone().Parent = u10;
            end;
        end;

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("Attachment") then
                descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v15, descendant.Position.Z);
            end;
        end;

        ParticleHandler.ScaleParticle(u10, v15);
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u10;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        local v16 = u2:NextNumber(v6.Min, v6.Max);
        local v17 = u2:NextNumber(v7.Min, v7.Max);
        LinearVelocity.VectorVelocity = Vector3.new(v16, v17, u2:NextNumber(v6.Min, v6.Max));
        LinearVelocity.Attachment0 = Attachment;
        LinearVelocity.Parent = Attachment;
        ParticleHandler.EnableAllParticles(u10, true);
        local u18 = nil;
        u18 = u10.Touched:Connect(function(p19) -- Line: 83
            -- upvalues: u10 (copy), u18 (ref), ParticleHandler (ref)
            if p19.Parent and (u10.Parent and (p19.CollisionGroup ~= "Ghosted" and (p19.CanCollide == true and u18))) then
                ParticleHandler.EnableAllParticles(u10, false);
                u18:Disconnect();
                u18 = nil;
            end;
        end);
        task.delay(3, function() -- Line: 93
            -- upvalues: TweenService (ref), u10 (copy), ParticleHandler (ref)
            local v20 = TweenService:Create(u10, TweenInfo.new(3), {
                Size = Vector3.new(0, 0, 0)
            });
            v20:Play();
            v20.Completed:Connect(function() -- Line: 100
                -- upvalues: ParticleHandler (ref), u10 (ref)
                ParticleHandler.EnableAllParticles(u10, false);
                ParticleHandler.DestroyEmit(u10);
            end);
        end);
        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
    end;
end;