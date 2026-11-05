  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
require(PathShortcuts.KnitPath.Trove);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = ReplicatedStorage:FindFirstChild("Client Assets");

return function(p3) -- Line: 18
    -- upvalues: u1 (copy), u2 (copy), TweenService (copy)
    if not p3 then
        return;
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    local Position = HumanoidRootPart.Position;
    local v4 = os.clock() - 1.5;

    while true do
        if os.clock() - v4 > 1.325 or (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - Position).Magnitude > 4.5 then
            local v5 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -6.5, 0), u1);

            if v5 then
                v4 = os.clock();
                local u6 = u2.Misc.IcePlatform:Clone();
                u6.Size = u6.Size * (math.random(90, 110) / 100);
                local v7 = CFrame.new(v5.Position, v5.Position + v5.Normal);
                local Angles = CFrame.Angles;
                local v8 = math.random(-360, 360);
                u6.CFrame = v7 * Angles(-1.5707963267948966, math.rad(v8), 0);
                u6.Parent = workspace.Effects;
                u6.Sound:Play();
                task.delay(1.5, u6.Destroy, u6);
                local Size = u6.Size;
                u6.Size = Vector3.new(0, 0, 0);
                TweenService:Create(u6, TweenInfo.new(0.175, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = Size
                }):Play();
                task.delay(1.15, function() -- Line: 55
                    -- upvalues: TweenService (ref), u6 (copy)
                    TweenService:Create(u6, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Size = Vector3.new(0, 0, 0)
                    }):Play();
                end);
                Position = u6.Position * Vector3.new(1, 0, 1);
            end;
        end;

        task.wait();

        if not (p3:IsDescendantOf(game) and (p3:GetAttribute("Mount") or p3:GetAttribute("AokijiIce"))) then
            return;
        end;
    end;
end;