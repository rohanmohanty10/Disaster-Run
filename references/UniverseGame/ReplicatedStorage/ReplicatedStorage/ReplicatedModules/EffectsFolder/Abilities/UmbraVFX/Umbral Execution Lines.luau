  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p2, p3) -- Line: 8
    -- upvalues: CurrentCamera (copy), u1 (copy), Trove (copy), TweenService (copy)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local sphere = u1.Umbra.sphere;
    local CFrame2 = CurrentCamera.CFrame;
    local v4 = Random.new();
    local v5 = Trove.new();
    local u6 = p3 or 1;

    for _ = 1, 10 do
        for _ = 1, 5 do
            local u7 = sphere:Clone();
            v5:Add(u7);
            u7.Color = p2;
            u7.Transparency = 0;
            u7.CFrame = CFrame2 * CFrame.new(v4:NextNumber(-15, 15), v4:NextNumber(-15, 15), v4:NextNumber(-5, -25));
            local CFrame3 = u7.CFrame;
            local Angles = CFrame.Angles;
            local v8 = v4:NextNumber(-360, 360);
            local v9 = math.rad(v8);
            local v10 = v4:NextNumber(-360, 360);
            u7.CFrame = CFrame3 * Angles(v9, math.rad(v10), 0);
            u7.Parent = workspace.Effects;
            local v11 = TweenService:Create(u7, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                Size = Vector3.new(0.25, 0.25, 100)
            });
            v11.Completed:Connect(function() -- Line: 35
                -- upvalues: TweenService (ref), u7 (copy), u6 (copy)
                local v12 = TweenService:Create(u7, TweenInfo.new(u6, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(0.05, 0.05, 100)
                });
                v12.Completed:Connect(function() -- Line: 38
                    -- upvalues: TweenService (ref), u7 (ref)
                    wait(0.5);
                    TweenService:Create(u7, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                        Transparency = 1
                    }):Play();
                end);
                v12:Play();
            end);
            v11:Play();
        end;

        wait();
    end;

    wait(2.5 * u6);
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    v5:Destroy();
end;