  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v1 = game.ReplicatedStorage["Client Assets"];
local u2 = {};
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };
local Slide = v1.Assets.Abilities["Uber Oni"].Particles.Slide;
local u4 = v1.Assets.Abilities["Uber Oni"].Particles["Limb Trail"];
local u5 = Random.new();

return function(u6) -- Line: 23
    -- upvalues: u2 (copy), Slide (copy), ParticleHandler (copy), u4 (copy), u5 (copy), TweenService (copy), Trove (copy), RunService (copy), u3 (copy)
    local Character = u6.Character;
    local v7 = u6.State or false;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if v7 ~= true or u2[Character] then
        local v8 = v7 == false and (u2[Character] and u2[Character]);

        if v8 then
            v8:Destroy();
            u2[Character] = nil;
        end;

        return;
    end;

    local u9 = Slide:Clone();
    u9.Name = "Slide";
    u9.Parent = Character;
    ParticleHandler.AttachTo(u9, {
        Part = HumanoidRootPart,
        Offset = CFrame.new(0, 3, 0)
    });
    ParticleHandler.EnableAllParticles(u9, true);

    local function CreateRock(p10) -- Line: 44
        -- upvalues: u4 (ref), u6 (copy), ParticleHandler (ref), HumanoidRootPart (copy), u5 (ref), TweenService (ref)
        local u11 = u4:Clone();

        if u6.HSVData then
            ParticleHandler.Unusualify(u11, u6);
        end;

        u11.CFrame = HumanoidRootPart.CFrame;
        local v12 = u5:NextNumber(1, 2);
        local v13 = u5:NextNumber(1, 2);
        u11.Size = Vector3.new(v12, v13, u5:NextNumber(1, 2));
        u11.Anchored = false;
        u11.CanCollide = true;
        u11.CollisionGroup = "Ghosted";
        u11.BottomSurface = Enum.SurfaceType.Smooth;
        u11.TopSurface = Enum.SurfaceType.Smooth;
        u11.Parent = workspace.Effects;
        u11.Color = p10.Instance.Color;
        u11.Material = p10.Material;
        u11.Transparency = 0;
        u11.CanQuery = true;
        u11.CanTouch = true;
        local v14 = u5:NextNumber(-180, 180);
        local v15 = u5:NextNumber(-180, 180);
        u11.Orientation = Vector3.new(v14, v15, u5:NextNumber(-180, 180));
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = u11;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        local v16 = u5:NextNumber(-30, 30);
        local v17 = u5:NextNumber(25, 40);
        LinearVelocity.VectorVelocity = Vector3.new(v16, v17, u5:NextNumber(-30, 30));
        LinearVelocity.Attachment0 = Attachment;
        LinearVelocity.Parent = Attachment;
        local v18 = u11.Size.Magnitude / 2;

        for _, child in pairs(p10.Instance:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                child:Clone().Parent = u11;
            end;
        end;

        for _, descendant in u11:GetDescendants() do
            if descendant:IsA("Attachment") then
                descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v18, descendant.Position.Z);
            end;
        end;

        ParticleHandler.EnableAllParticles(u11, true);
        u11.Touched:Connect(function(p19) -- Line: 92
            -- upvalues: u11 (copy), ParticleHandler (ref)
            if p19.Parent and u11.Parent then
                ParticleHandler.EnableAllParticles(u11, false);
            end;
        end);
        task.delay(3, function() -- Line: 98
            -- upvalues: TweenService (ref), u11 (copy), ParticleHandler (ref)
            local v20 = TweenService:Create(u11, TweenInfo.new(3), {
                Size = Vector3.new(0, 0, 0)
            });
            v20:Play();
            v20.Completed:Connect(function() -- Line: 105
                -- upvalues: ParticleHandler (ref), u11 (ref)
                ParticleHandler.EnableAllParticles(u11, false);
                ParticleHandler.DestroyEmit(u11);
            end);
        end);
        task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
    end;

    local u21 = Trove.new();
    u21:AttachToInstance(Character);
    u2[Character] = u21;
    u21:Add(function() -- Line: 119
        -- upvalues: ParticleHandler (ref), u9 (copy), u2 (ref), Character (copy)
        ParticleHandler.EnableAllParticles(u9, false);
        ParticleHandler.DestroyEmit(u9);
        u2[Character] = nil;
    end);
    local u22 = 0;
    u21:Connect(RunService.RenderStepped, function(p23) -- Line: 129
        -- upvalues: Character (copy), u21 (copy), u22 (ref), HumanoidRootPart (copy), u3 (ref), ParticleHandler (ref), u9 (copy), CreateRock (copy)
        if not Character.Parent then
            u21:Destroy();

            return;
        end;

        u22 = u22 + p23;
        local v24 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -5, 0), u3);

        if not v24 then
            ParticleHandler.EnableAllParticles(u9, false);

            return;
        end;

        ParticleHandler.EnableAllParticles(u9, true);

        if u22 >= 0.03333333333333333 then
            u22 = 0;
            CreateRock(v24);
        end;
    end);
end;