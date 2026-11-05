  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: EffectsHandler (copy), u1 (copy), TweenService (copy)
    EffectsHandler.CallEffect("AC_CameraShake", "Explosion2", 60, p2);

    for _ = 1, 100 do
        local WedgePart = Instance.new("WedgePart", workspace.Effects);
        WedgePart.Size = Vector3.new(0.4, 1, 1);
        WedgePart.BrickColor = BrickColor.new("Institutional white");
        WedgePart.Material = Enum.Material.Glass;
        local Angles = CFrame.Angles;
        local v3 = u1:NextNumber(0, 360);
        local v4 = math.rad(v3);
        local v5 = u1:NextNumber(0, 360);
        local v6 = math.rad(v5);
        local v7 = u1:NextNumber(0, 360);
        WedgePart.CFrame = p2 * Angles(v4, v6, (math.rad(v7))) * CFrame.new(0, 0, -40);
        WedgePart.CanCollide = true;
        WedgePart.CastShadow = false;
        WedgePart.Anchored = false;
        WedgePart.Transparency = 0.4;
        WedgePart.Velocity = WedgePart.CFrame.LookVector * 100;
        task.delay(4, function() -- Line: 25
            -- upvalues: TweenService (ref), WedgePart (copy)
            TweenService:Create(WedgePart, TweenInfo.new(1), {
                Transparency = 1
            }):Play();
            task.delay(1, WedgePart.Destroy, WedgePart);
        end);
    end;
end;