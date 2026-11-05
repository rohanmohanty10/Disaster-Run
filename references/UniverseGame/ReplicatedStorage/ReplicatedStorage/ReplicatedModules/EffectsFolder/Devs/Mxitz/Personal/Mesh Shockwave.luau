  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Meshes = script.Meshes;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

local function MeshEmit(p1, p2, p3) -- Line: 14
    -- upvalues: TweenService (copy)
    local v4 = p1:Clone();
    v4.Start.CFrame = p2;
    v4.End.CFrame = v4.Start.CFrame * p1.Start.CFrame:ToObjectSpace(p1.End.CFrame);
    v4.Parent = workspace.Effects;
    TweenService:Create(v4.Start, TweenInfo.new(unpack(p3)), {
        Transparency = v4.End.Transparency,
        Color = v4.End.Color,
        Size = v4.End.Size,
        CFrame = v4.End.CFrame
    }):Play();
    task.delay(p3[1], v4.Destroy, v4);
end;

return function(p5, p6) -- Line: 31
    -- upvalues: MeshEmit (copy), Meshes (copy), LocalPlayer (copy), EffectsHandler (copy)
    if typeof(p5) ~= "CFrame" then
        if table.find({ "Vector3", "vector" }, (typeof(p5))) then
            p5 = CFrame.new(p5);
        elseif typeof(p5) == "Instance" and p5:IsA("BasePart") then
            p5 = p5.CFrame;
        else
            p5 = error("Not a valid origin type");
        end;
    end;

    MeshEmit(Meshes.Mesh1, p5 * CFrame.new(0, 0.25, 0, 0.999999404, 0, -2.98023295e-8, 5.96046661e-8, 0, -1.00000119, 0, 0.999999523, 0), { 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out });
    MeshEmit(Meshes.Ring, p5 * CFrame.new(0, 0, 0, -2.98023295e-8, 0, -1, -1.00000119, 0, -2.98023295e-8, 0, 1, 0), { 0.85, Enum.EasingStyle.Quint, Enum.EasingDirection.Out });
    MeshEmit(Meshes.Wind4, p5 * CFrame.new(0, 0, 0, -2.98023295e-8, 0, -1, -1.00000119, 0, -2.98023295e-8, 0, 1, 0), { 1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out });
    local v7 = LocalPlayer:DistanceFromCharacter(p5.Position);

    if v7 <= 100 and p6 then
        local v8 = math.clamp(v7 <= 20 and 1 or 1 - (v7 - 20) / 80, 0, 1);
        EffectsHandler.CallEffect("Camera Shake", {
            v8 * 4,
            v8 * 10,
            0,
            0.8,
            Vector3.new(0.25, 0.25, 0.25),
            Vector3.new(2.5, 1, 1)
        });
    end;

    EffectsHandler.CallEffects({
        {
            Name = "Emit Particle V3",
            Data = {
                {
                    Path = "Particles/ViceGrip/Throw",
                    AbilityName = "The Strongest",
                    AutoSerialize = true,
                    Origin = p5
                }
            }
        },
        {
            Name = "Standalone_RingStroke",
            Data = {
                {
                    Duration = 0.6,
                    Thickness = { 15, 50 },
                    CFrame = p5 * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
                    Size = { 2, 25 },
                    Color = Color3.fromRGB(63, 63, 63)
                }
            }
        }
    });
end;