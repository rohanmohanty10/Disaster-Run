  

 

local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2, p3) -- Line: 10
    -- upvalues: u1 (copy), ParticleHandler (copy), TweenService (copy)
    local u4 = p3 or 0.5;
    local u5 = {};

    local function CreateSpiral(p6) -- Line: 14
        -- upvalues: u1 (ref), ParticleHandler (ref), TweenService (ref), u4 (ref), u5 (copy)
        local v7 = p6.Name == "Head" and 0.25 or 1.2;
        local v8 = p6.Name == "Head" and 0.45 or 0.3;
        local v9 = p6.Name == "Torso" and 2 or 1.5;

        for _ = 1, p6.Name == "Head" and 2 or 4 do
            local v10 = u1:NextNumber(0, 1);
            local v11 = u1:NextNumber(0.1, 0.2);
            local v12 = script.Spiral:Clone();
            v12.Parent = workspace.Effects;
            v12.Size = Vector3.new(v9 + v10, 0.15, v9 + v10);
            v7 = v7 - (v8 + v11);
            ParticleHandler.AttachTo(v12, {
                Part = p6,
                Offset = CFrame.new(0, v7, 0)
            });
            TweenService:Create(v12, TweenInfo.new(u4 / 7, Enum.EasingStyle.Cubic), {
                Transparency = 0.6
            }):Play();
            table.insert(u5, v12);
        end;
    end;

    if p2:IsA("Model") or typeof(p2) == "table" then
        if p2:IsA("Model") then
            p2 = p2:GetChildren() or p2;
        end;

        for _, v in p2 do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                CreateSpiral(v);
            end;
        end;
    elseif p2:IsA("Part") then
        CreateSpiral(p2);
    end;

    task.delay(u4 or 0.5, function() -- Line: 46
        -- upvalues: u5 (copy), TweenService (ref)
        for _, v in u5 do
            TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Cubic), {
                Transparency = 1
            }):Play();
            task.delay(0.7, v.Destroy, v);
        end;
    end);
end;