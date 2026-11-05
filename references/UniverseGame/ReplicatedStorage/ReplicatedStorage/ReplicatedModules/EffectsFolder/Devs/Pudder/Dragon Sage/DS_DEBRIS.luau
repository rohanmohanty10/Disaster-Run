  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = PathShortcuts.ClientAssets;
local v1 = game.ReplicatedStorage["Client Assets"];
local _ = workspace.CurrentCamera;
local u2 = Random.new();
local RockTrail = v1.Assets.Abilities["Dragon Sage"].Particles.General.RockTrail;

return function(p3) -- Line: 16
    -- upvalues: ParticleHandler (copy), RockTrail (copy), u2 (copy), TweenService (copy)
    local v4 = p3 or {};
    local v5 = v4.Player or v4.Character;
    local v6 = 0;

    if v5 and (v5.Data and v5.Data.Skin:GetAttribute("UnusualHueId")) then
        v6 = v6 + v5.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local v7 = ParticleHandler.TranslateToCFrame(v4.Origin);
    local Amount = v4.Amount;
    local _ = v4.Particle;
    local v8 = v4.Size or NumberRange.new(1, 3);
    local v9 = v4.SideVelocity or NumberRange.new(-50, 50);
    local v10 = v4.UpVelocity or NumberRange.new(40, 50);
    local v11 = v4.Trail or RockTrail;
    local v12 = RaycastParams.new();
    v12.FilterType = Enum.RaycastFilterType.Include;
    v12.FilterDescendantsInstances = { workspace.Map };
    local v13 = workspace:Raycast(v7.Position, Vector3.new(0, -50, 0), v12);

    if not (v13 and (v13.Position and v13.Instance)) then
        return;
    end;

    for _ = 1, Amount do
        local u14 = v11:Clone();
        u14.CFrame = v7;
        local v15 = u2:NextNumber(v8.Min, v8.Max);
        local v16 = u2:NextNumber(v8.Min, v8.Max);
        u14.Size = Vector3.new(v15, v16, u2:NextNumber(v8.Min, v8.Max));
        u14.Anchored = false;
        u14.CanCollide = true;
        u14.CollisionGroup = "Ghosted";
        u14.BottomSurface = Enum.SurfaceType.Smooth;
        u14.TopSurface = Enum.SurfaceType.Smooth;
        u14.Parent = workspace.Effects;
        u14.Color = v13.Instance.Color;
        u14.Material = v13.Material;
        u14.Transparency = 0;
        u14.CanQuery = true;
        u14.CanTouch = true;
        local v17 = u2:NextNumber(-180, 180);
        local v18 = u2:NextNumber(-180, 180);
        u14.Orientation = Vector3.new(v17, v18, u2:NextNumber(-180, 180));

        if v6 > 0 and not v4.IgnoreUnusuals then
            ParticleHandler.HSVShiftParticles(u14, {
                HueShift = v6
            });
        end;

        local v19 = u14.Size.Magnitude / 2;

        for _, child in pairs(v13.Instance:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Clone().Parent = u14;
            end;
        end;

        for _, descendant in u14:GetDescendants() do
            if descendant:IsA("Attachment") then
                descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v19, descendant.Position.Z);
            end;
        end;

        ParticleHandler.ScaleParticle(u14, v19);
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u14;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        local v20 = u2:NextNumber(v9.Min, v9.Max);
        local v21 = u2:NextNumber(v10.Min, v10.Max);
        LinearVelocity.VectorVelocity = Vector3.new(v20, v21, u2:NextNumber(v9.Min, v9.Max));
        LinearVelocity.Attachment0 = Attachment;
        LinearVelocity.Parent = Attachment;
        ParticleHandler.EnableAllParticles(u14, true);
        local u22 = nil;
        u22 = u14.Touched:Connect(function(p23) -- Line: 101
            -- upvalues: u14 (copy), u22 (ref), ParticleHandler (ref)
            if p23.Parent and (u14.Parent and (p23.CollisionGroup ~= "Ghosted" and (p23.CanCollide == true and u22))) then
                ParticleHandler.EnableAllParticles(u14, false);
                u22:Disconnect();
                u22 = nil;
            end;
        end);
        task.delay(3, function() -- Line: 111
            -- upvalues: TweenService (ref), u14 (copy), ParticleHandler (ref)
            local v24 = TweenService:Create(u14, TweenInfo.new(3), {
                Size = Vector3.new(0, 0, 0)
            });
            v24:Play();
            v24.Completed:Connect(function() -- Line: 118
                -- upvalues: ParticleHandler (ref), u14 (ref)
                ParticleHandler.EnableAllParticles(u14, false);
                ParticleHandler.DestroyEmit(u14);
            end);
        end);
        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
    end;
end;