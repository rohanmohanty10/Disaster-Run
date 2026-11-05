  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
require(ReplicatedStorage.ClientModules.LightningBolt.LightningSparks);
local u2 = Random.new();

return function(u3, u4, p5, p6, p7) -- Line: 26
    -- upvalues: EffectsHandler (copy), u2 (copy), LightningBolt (copy), ParticleHandler (copy)
    if not u3 then
        return;
    end;

    local u8 = p5 + p6;
    task.delay(p6, function() -- Line: 30
        -- upvalues: EffectsHandler (ref), u3 (copy), u8 (ref), u4 (copy)
        EffectsHandler.CallEffect("Q_RADIAL", {
            Distance = 100,
            Effect = "Camera Shake",
            Origin = u3.CFrame,
            Arguments = { { 15, 15, 0, 0.9, Vector3.new(1, 1, 1), Vector3.new(1, 1, 1) } }
        });
        EffectsHandler.CallEffect("Q_RADIAL", {
            Distance = 75,
            Effect = "Vignette Gui",
            Origin = u3.CFrame,
            Arguments = {
                {
                    TweenTime = 0.2,
                    Blur = 5,
                    StartingColor = Color3.new(0.639216, 0, 0.0117647),
                    EndingColor = Color3.new(0.243137, 0, 0.00392157)
                }
            }
        });
        EffectsHandler.CallEffect("Rock Debris", {
            Size = Vector3.new(3.3, 3.3, 3.3),
            Origin = u3.CFrame,
            Lifetime = u8,
            Radius = u4,
            Amount = u4
        });
    end);
    local Model = Instance.new("Model");
    Model.Name = "Lightning";
    Model.Parent = workspace.CurrentCamera;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.new(0, 0, 0);
    Highlight.Parent = Model;
    task.delay(u8 + 2, Model.Destroy, Model);
    local v9 = os.clock();

    while true do
        local v10 = u3.CFrame * CFrame.new(0, -2.5, -2.1);
        local v11 = u2:NextNumber(0, 6.283185307179586);
        local v12 = u2:NextNumber(u4 / 1.5, u4 * 1.15);
        local v13 = u2:NextNumber(-v12, v12);
        local v14 = {
            WorldAxis = Vector3.new(0, 0, 0),
            WorldPosition = v10.Position
        };
        local v15 = math.sin(v11);
        local v16 = math.cos(v11);
        v14.WorldAxis = Vector3.new(v15, 0, v16);
        local v17 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0));
        local v18 = CFrame.Angles(0, 0, u2:NextNumber(0, 6.283185307179586));
        local Angles = CFrame.Angles;
        local v19 = u2:NextNumber(0.3420201433256688, -0.3420201433256687);
        local v20 = Angles(math.acos(v19), 0, 0);
        local v21 = {
            WorldAxis = Vector3.new(0, 0, 0),
            WorldPosition = v10.Position + v14.WorldAxis * v12 + Vector3.new(0, v13, 0),
            WorldAxis = (v17 * v18 * v20).LookVector
        };
        local v22 = LightningBolt.new(v14, v21, 12, Model);
        v22.AnimationSpeed = u2:NextNumber(6.3, 8.7);
        v22.Thickness = u2:NextNumber(0.6, 0.95);
        v22.Color = Color3.fromRGB(255, 41, 41);

        if p7 then
            v22.Color = ParticleHandler.HSVShift(Color3.fromRGB(255, 41, 41), p7);
        end;

        v22.PulseLength = u2:NextNumber(0.67, 0.9);
        v22.Frequency = 1.4;
        v22.MinRadius = 0;
        v22.MaxRadius = 4;
        v22.FadeLength = 0.25;
        v22.PulseSpeed = u2:NextNumber(4, 5);
        v22.MinThicknessMultiplier = 0.7;
        v22.MaxThicknessMultiplier = 1;
        v22.Velocity = (v21.WorldPosition - v14.WorldPosition).Unit * 0.1;
        task.wait(u2:NextNumber(0.0075, 0.01));

        if u8 <= os.clock() - v9 then
            return;
        end;
    end;
end;