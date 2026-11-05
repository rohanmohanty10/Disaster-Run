  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };
u3.IgnoreWater = true;

return function(p4) -- Line: 20
    -- upvalues: u3 (copy), u1 (copy), TweenService (copy), u2 (copy)
    local u5 = p4.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, -3, -3);
    local u6 = 4;
    local v7 = 0.5;

    for i = 1, 25 do
        local u8 = nil;

        for i2 = 1, 2 do
            local v9 = 1;

            if i2 == 1 then
                task.spawn(function() -- Line: 36
                    -- upvalues: u5 (copy), u6 (ref), i (copy), u8 (ref), u3 (ref)
                    local v10 = u5 * CFrame.new(u6, 1, -(i * 2.5));
                    u8 = workspace:Raycast(v10.Position, Vector3.new(0, -45, 0), u3);
                end);
            else
                task.spawn(function() -- Line: 41
                    -- upvalues: u5 (copy), u6 (ref), i (copy), u8 (ref), u3 (ref)
                    local v11 = u5 * CFrame.new(-u6, 1, -(i * 2.5));
                    u8 = workspace:Raycast(v11.Position, Vector3.new(0, -45, 0), u3);
                end);
                v9 = -1;
            end;

            local v12, v13, v14 = u5:ToOrientation();
            local u15 = u1.Assets.Abilities.Gryphon.Models.FinalDeparture[tostring(math.random(1, 6))]:Clone();
            u15.Position = u8.Position;
            u15.Size = u15.Size * v7;
            local v16 = u15.CFrame * CFrame.Angles(v12, v13, v14);
            local Angles = CFrame.Angles;
            local v17 = math.random(-33, 3) * v9;
            local v18 = v16 * Angles(0, 0, (math.rad(v17)));
            local Angles2 = CFrame.Angles;
            local v19 = math.random(-15, 15);
            local v20 = v18 * Angles2(math.rad(v19), 0, 0);
            u15.CFrame = u15.CFrame * CFrame.Angles(v12, v13, v14) * CFrame.new(0, -3, 0);
            u15.Parent = workspace.Effects;
            local CFrame2 = u15.CFrame;
            TweenService:Create(u15, TweenInfo.new(u2:NextNumber(0.05, 0.2)), {
                CFrame = v20
            }):Play();

            for _, descendant in pairs(u15:GetDescendants()) do
                if descendant:IsA("Decal") then
                    TweenService:Create(descendant, TweenInfo.new(0.35), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            task.delay(u2:NextNumber(2, 2.5), function() -- Line: 69
                -- upvalues: TweenService (ref), u15 (copy), u2 (ref), CFrame2 (copy)
                TweenService:Create(u15, TweenInfo.new(u2:NextNumber(1, 2)), {
                    CFrame = CFrame2 * CFrame.new(0, -(u15.Size.Y + 4), 0)
                }):Play();
                task.delay(1.5, u15.Destroy, u15);
            end);

            if i > 18 then
                u6 = u6 - 0.75;
            else
                u6 = u6 + 0.25;
            end;

            v7 = v7 + 0.03;
        end;

        task.wait();
    end;
end;