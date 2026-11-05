  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local ChaosEmerald = PathShortcuts.ClientAssets["Soul Survivor"].Metallix.ChaosEmerald;
local u1 = {
    Color3.fromRGB(248, 0, 236),
    Color3.fromRGB(3, 0, 248),
    Color3.fromRGB(248, 35, 0),
    Color3.fromRGB(248, 233, 0)
};

return function(p2, p3, p4, u5) -- Line: 17
    -- upvalues: u1 (copy), ChaosEmerald (copy), TweenService (copy), RunService (copy), ParticleHandler (copy)
    if p2 == nil then
        return;
    end;

    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil or HumanoidRootPart:IsA("BasePart") ~= true then
        return;
    end;

    local u6 = {};
    local v7 = p2:GetAttribute("CanGoHyper") == true;
    local u8 = math.random() * 3.141592653589793 * 2;
    local v9 = table.clone(u1);

    if v7 or p3 then
        table.insert(v9, Color3.fromRGB(20, 196, 249));
        table.insert(v9, Color3.fromRGB(0, 211, 34));
        table.insert(v9, Color3.fromRGB(185, 185, 185));
    end;

    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;

    for _, v in v9 do
        local v10 = ChaosEmerald:Clone();
        v10.SurfaceAppearance.Color = v;
        v10.Light.SpotLight.Color = v;
        local SpotLight = v10.Light.SpotLight;
        SpotLight.Angle = SpotLight.Angle + 12.5;
        v10.Trail.Color = ColorSequence.new(v:Lerp(Color3.new(0, 0, 0), 0.3));
        v10.Trail.Enabled = true;
        v10.Star.Color = ColorSequence.new(v:Lerp(Color3.new(0, 0, 0), 0.1));
        local v11 = ColorSequence.new(v:Lerp(Color3.new(1, 1, 1), 0.25));

        for _, child in v10.Middle:GetChildren() do
            child.Color = v11;
        end;

        v10.Specs.Color = v10.Star.Color;
        v10.Star.Enabled = true;
        v10.Parent = Model;
        v10.Star:Emit(3);
        table.insert(u6, v10);
    end;

    if v7 or p4 then
        Model:ScaleTo(1.5);
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 0.25;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 0.25;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Adornee = Model;
    Highlight.Parent = Model;
    local v12 = TweenService:Create(Highlight, TweenInfo.new(0.756, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    });
    v12.Completed:Connect(function() -- Line: 69
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
    v12:Play();

    local function DisableTrail(p13) -- Line: 73
        p13.Trail.Enabled = false;
        p13.Star.Enabled = false;
    end;

    local u14 = 0;
    local u15 = #u6 == 4 and 90 or 360 / #u6;
    local u16 = nil;
    u16 = RunService.PreRender:Connect(function(p17) -- Line: 80
        -- upvalues: u14 (ref), u5 (copy), TweenService (ref), u8 (ref), u6 (copy), u15 (copy), HumanoidRootPart (copy), u16 (ref), ParticleHandler (ref), DisableTrail (copy), Model (copy)
        u14 = u14 + p17 * (u5 or 1);

        if u14 < 0.5 then
            local v18 = TweenService:GetValue(u14 * 2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
            u8 = u8 + (math.rad(p17 * 60) * ((1 - v18) * 20) + p17 * 2);

            for i, v in u6 do
                local v19 = math.rad(i * u15);
                local new = CFrame.new;
                local Position = HumanoidRootPart.Position;
                local v20 = math.sin(u8 + v19) * (4 + v18 * 3);
                local v21 = math.cos(u8 + v19) * (4 + v18 * 3);
                v.CFrame = new(Position + Vector3.new(v20, 0, v21));
            end;

            return;
        end;

        if u14 < 0.9 then
            local v22 = TweenService:GetValue((u14 - 0.4) * 2, Enum.EasingStyle.Circular, Enum.EasingDirection.In);
            u8 = u8 + (math.rad(p17 * 60) * (v22 * 35) + p17 * 2);

            for i, v in u6 do
                local v23 = math.rad(i * u15);
                local new = CFrame.new;
                local Position = HumanoidRootPart.Position;
                local v24 = math.sin(u8 + v23) * ((1 - v22) * 7);
                local v25 = math.cos(u8 + v23) * ((1 - v22) * 7);
                v.CFrame = new(Position + Vector3.new(v24, 0, v25));
            end;

            return;
        end;

        u16:Disconnect();
        u16 = nil;

        for _, v in u6 do
            v.CFrame = CFrame.new(HumanoidRootPart.Position);
            v.Transparency = 1;
            v.Light.SpotLight.Enabled = false;
            ParticleHandler.EnableAllParticles(v, false);

            for _, child in v.Middle:GetChildren() do
                child:Clear();
            end;

            task.delay(0.1, DisableTrail, v);
        end;

        task.delay(4, Model.Destroy, Model);
    end);
end;