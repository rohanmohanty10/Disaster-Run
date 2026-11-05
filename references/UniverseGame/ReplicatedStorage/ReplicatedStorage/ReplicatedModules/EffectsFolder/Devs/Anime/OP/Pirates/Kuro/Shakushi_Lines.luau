  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local ClientAssets = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local u1 = Random.new();

return function(p2, p3) -- Line: 15
    -- upvalues: ClientAssets (copy), u1 (copy), TweenService (copy)
    if not p2 then
        return;
    end;

    local v4 = p3 or {};
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local v5 = v4.ColorSet or { Color3.new(1, 1, 1), Color3.new(0, 0, 0) };
    local v6 = v4.Origin or HumanoidRootPart.CFrame;
    local u7 = v4.Duration or 0.5;
    local v8 = v4.OffsetX or { -15, 15 };
    local v9 = v4.OffsetY or { -15, 15 };
    local v10 = v4.OffsetZ or { -5, 25 };
    local v11 = v4.MaxSize or Vector3.new(0.25, 0.25, 100);
    local u12 = v4.MinSize or Vector3.new(0.05, 0.05, 100);

    for _ = 1, v4.Count or 40 do
        local u13 = ClientAssets.Kuro.Line:Clone();
        u13.Color = v5[math.random(1, #v5)];
        u13.Transparency = 0;
        local v14 = v6 * CFrame.new(u1:NextNumber(unpack(v8)), u1:NextNumber(unpack(v9)), u1:NextNumber(unpack(v10)));
        local Angles = CFrame.Angles;
        local v15 = u1:NextNumber(-360, 360);
        local v16 = math.rad(v15);
        local v17 = u1:NextNumber(-360, 360);
        u13.CFrame = v14 * Angles(v16, math.rad(v17), 0);
        u13.Parent = workspace.Effects;
        task.delay(u7 + 0.1, u13.Destroy, u13);
        local v18 = TweenService:Create(u13, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Size = v11
        });
        v18.Completed:Connect(function() -- Line: 52
            -- upvalues: TweenService (ref), u13 (copy), u7 (copy), u12 (copy)
            TweenService:Create(u13, TweenInfo.new(u7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = u12
            }):Play();
        end);
        v18:Play();
        task.wait(v4.Interval);
    end;
end;