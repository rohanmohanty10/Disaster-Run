  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 21
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), RunService (copy), u2 (copy), TweenService (copy), u1 (copy)
    local Character = (p3 or {}).Player.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u4 = AssetHandler.GetAbilityData(Character);
    local u5 = { 17866633882, 17866635268, 17866635031, 17866634793, 17866634478, 17866636423, 17866636047, 7866635798, 17866635537, 17866637416, 17866637203, 17866637018, 17866636709, 17866638078, 17866637834, 17866637585 };
    local u6 = HumanoidRootPart.Position + Vector3.new(0, 10000, 0);
    local u7 = os.clock() - 0.32000000000000006;
    local u8 = AssetHandler.CloneAsset("Particles/WaterWheel/WheelFX", u4);
    u8.Parent = Character;
    ParticleHandler.AttachTo(u8, {
        Part = HumanoidRootPart
    });
    ParticleHandler.Emit(u8, ParticleHandler.GenerateEmitInfo(u8));
    local u9 = nil;
    u9 = RunService.Heartbeat:Connect(function() -- Line: 52
        -- upvalues: Character (copy), u9 (ref), ParticleHandler (ref), u8 (copy), HumanoidRootPart (copy), u6 (ref), u2 (ref), AssetHandler (ref), u4 (copy), TweenService (ref), u7 (ref), RunService (ref), u1 (ref), u5 (copy)
        if Character.Parent == nil or not Character:GetAttribute("WaterWheel") then
            if u9 then
                u9:Disconnect();
                u9 = nil;
            end;

            ParticleHandler.EnableAllParticles(u8, false);
            ParticleHandler.DestroyEmit(u8);

            return;
        end;

        local v10 = (HumanoidRootPart.Position - u6).Magnitude >= 10 and workspace:Raycast(HumanoidRootPart.Position + Vector3.new(0, 3, 0), Vector3.new(0, -15, 0), u2);

        if v10 then
            u6 = v10.Position;
            local Unit = HumanoidRootPart.CFrame.LookVector:Cross(v10.Normal).Unit;
            local v11 = CFrame.fromMatrix(v10.Position, Unit, v10.Normal, Unit:Cross(v10.Normal).Unit) * CFrame.new(0, 0.1, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
            local v12 = AssetHandler.CloneAsset("Particles/WaterWheel/Decal", u4);
            v12.CFrame = v11;
            v12.Parent = workspace.Effects;
            task.delay(0.65, v12.Destroy, v12);

            for _, child in v12:GetChildren() do
                if child:IsA("Decal") then
                    TweenService:Create(child, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;

        if os.clock() - u7 >= 0.32000000000000006 then
            u7 = os.clock();
            local u13 = AssetHandler.CloneAsset("Particles/WaterWheel/WheelMeshes", u4);
            u13.Parent = workspace.Effects;
            task.delay(0.9, u13.Destroy, u13);
            local v14 = math.random(0, 360);
            local u15 = math.rad(v14);
            task.spawn(function() -- Line: 104
                -- upvalues: u13 (copy), HumanoidRootPart (ref), u15 (ref), RunService (ref)
                while u13 and (u13:IsDescendantOf(game) and (HumanoidRootPart and HumanoidRootPart:IsDescendantOf(game))) do
                    u15 = u15 + -14.835298641951802 * RunService.Heartbeat:Wait();
                    u13:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(u15, 0, 0));
                end;
            end);

            if u13:FindFirstChild("Outline") then
                local v16 = u13.Outline.Size * u1:NextNumber(0.98, 1.05);
                u13:FindFirstChild("Outline").Size = v16 * 0.05;
                TweenService:Create(u13.Outline, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = v16
                }):Play();
                TweenService:Create(u13.Outline, TweenInfo.new(u1:NextNumber(0.5, 0.75), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;

            for i = 1, #u5 do
                if not Character:GetAttribute("WaterWheel") then
                    break;
                end;

                if u13:FindFirstChild("LargeWindRight") and u13.LargeWindRight:FindFirstChild("Decal") then
                    u13.LargeWindRight.Decal.Texture = "rbxassetid://" .. u5[i];
                end;

                if u13:FindFirstChild("LargeWindLeft") and u13.LargeWindLeft:FindFirstChild("Decal") then
                    u13.LargeWindLeft.Decal.Texture = "rbxassetid://" .. u5[i];
                end;

                task.wait(0.4 / #u5);
            end;

            if u13 and (u13:IsDescendantOf(game) and (u13:FindFirstChild("LargeWindRight") and u13:FindFirstChild("LargeWindLeft"))) then
                local LargeWindLeft = u13.LargeWindLeft;
                local LargeWindRight = u13.LargeWindRight;

                if LargeWindRight:FindFirstChild("Mesh") then
                    TweenService:Create(LargeWindRight.Mesh, TweenInfo.new(0.175), {
                        Scale = Vector3.new(-0.06, -0.014, -0.06)
                    }):Play();
                end;

                if LargeWindLeft:FindFirstChild("Mesh") then
                    TweenService:Create(LargeWindLeft.Mesh, TweenInfo.new(0.175), {
                        Scale = Vector3.new(-0.06, -0.014, -0.06)
                    }):Play();
                end;

                if LargeWindLeft:FindFirstChild("Decal") then
                    TweenService:Create(LargeWindLeft.Decal, TweenInfo.new(0.35), {
                        Transparency = 1
                    }):Play();
                end;

                if LargeWindRight:FindFirstChild("Decal") then
                    TweenService:Create(LargeWindRight.Decal, TweenInfo.new(0.35), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    end);
end;