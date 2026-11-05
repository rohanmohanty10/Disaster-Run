  

 

local TweenService = game:GetService("TweenService");
local u1 = Random.new();
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 13
    -- upvalues: AssetHandler (copy), u1 (copy), TweenService (copy), u2 (copy), ParticleHandler (copy)
    if not p3 then
        return;
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    local v4 = AssetHandler.GetAbilityData(p3);
    local v5 = AssetHandler.CloneAsset("Particles/SonicBlitz/Slashes", v4);
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = workspace.Effects;
    local v6 = os.clock();

    while p3:IsDescendantOf(game) and p3:GetAttribute("SonicBlitz") do
        local v7 = AssetHandler.CloneAsset("Particles/SonicBlitz/SlashMesh", v4);
        v7.Size = Vector3.new(15, 15, 1) * u1:NextNumber(0.8, 1.2) * 0.75;
        v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10) * 0.75, math.random(-10, 10) * 0.75, math.random(-10, 10) * 0.75) * CFrame.Angles(u1:NextNumber(0, 6.283185307179586), u1:NextNumber(0, 6.283185307179586), u1:NextNumber(0, 6.283185307179586));
        v7.Parent = workspace.Effects;
        task.delay(0.3, v7.Destroy, v7);
        TweenService:Create(v7, TweenInfo.new(u1:NextNumber(0.1, 0.3), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = v7.Size * Vector3.new(0, 0, 60)
        }):Play();

        if os.clock() - v6 > 0.05 then
            v6 = os.clock();
            local v8 = HumanoidRootPart.CFrame * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0);
            local v9 = math.random(-16, 16);
            local v10 = v8 + Vector3.new(v9, 0, math.random(-16, 16));
            local v11 = workspace:Raycast(v10.Position, Vector3.new(0, -15, 0), u2);

            if v11 then
                v10 = CFrame.new(v11.Position, v11.Position + v11.Normal) * CFrame.Angles(-1.5707963267948966, u1:NextNumber(0, 6.283185307179586), 0);
            end;

            local u12 = AssetHandler.CloneAsset("Particles/SonicBlitz/FloorSlash", v4);
            u12.Size = Vector3.new(0.6, 0, 3.7500002) * u1:NextNumber(0.8, 1.2);
            u12.CFrame = v10;
            u12.Parent = workspace.Effects;
            task.delay(5, u12.Destroy, u12);
            TweenService:Create(u12, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = u12.Size * 10
            }):Play();
            local v13 = TweenService:Create(u12.Decal, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0.5), {
                Color3 = Color3.new(0, 0, 0)
            });
            v13.Completed:Connect(function() -- Line: 65
                -- upvalues: TweenService (ref), u12 (copy)
                TweenService:Create(u12.Decal, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2), {
                    Transparency = 1
                }):Play();
            end);
            v13:Play();
        end;

        task.wait(0.01);
    end;

    task.delay(ParticleHandler.EnableParticle(v5, false), v5.Destroy, v5);
end;