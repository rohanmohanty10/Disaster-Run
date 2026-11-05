  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 7
    -- upvalues: Trove (copy), AssetHandler (copy), TweenService (copy)
    if not p1 then
        return;
    end;

    local v2 = Trove.new();
    local v3 = AssetHandler.GetAsset("Models/Needle", {
        AbilityName = "Misaka Mikoto"
    });

    local function Weld(p4, p5, p6) -- Line: 16
        local Weld = Instance.new("Weld");
        Weld.Part0 = p4;
        Weld.Part1 = p5;
        Weld.Parent = workspace.Effects;

        return Weld;
    end;

    local u7 = Random.new();

    local function Rad() -- Line: 27
        -- upvalues: u7 (copy)
        local v8 = u7:NextInteger(-360, 360);

        return math.rad(v8);
    end;

    local v9 = { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" };

    for _ = 1, 6 do
        local u10 = p1:FindFirstChild(v9[u7:NextInteger(1, #v9)]);

        if u10 then
            local u11 = v2:Clone(v3);
            u11.Anchored = true;
            u11.CanCollide = false;
            u11.Massless = true;
            local v12 = CFrame.new(u10.Position);
            local new = CFrame.new;
            local v13 = u7:NextInteger(-360, 360);
            local v14 = math.rad(v13);
            local v15 = math.cos(v14) * u7:NextInteger(5, 15);
            local v16 = u7:NextInteger(-3, 10);
            local v17 = u7:NextInteger(-360, 360);
            local v18 = math.rad(v17);
            local v19 = v12 * new(v15, v16, math.sin(v18) * u7:NextInteger(5, 15));
            u11.CFrame = CFrame.lookAt(v19.Position, u10.Position) * CFrame.fromOrientation(1.5707963267948966, 0, 0);
            local v20 = (v19.Position - u10.Position).Magnitude - u7:NextNumber(0.5, 0.75);
            u11.Parent = workspace.Effects;
            local v21 = u11.CFrame * CFrame.new(0, -v20, 0);
            local u22 = u10.CFrame:Inverse() * v21;
            local v23 = TweenService:Create(u11, TweenInfo.new(u7:NextInteger(5, 10) / 60, Enum.EasingStyle.Sine), {
                CFrame = v21
            });
            v23:Play();
            v23.Completed:Once(function() -- Line: 53
                -- upvalues: u11 (copy), u10 (copy), u22 (copy)
                u11.Anchored = false;
                local Weld2 = Instance.new("Weld");
                Weld2.Part0 = u10;
                Weld2.Part1 = u11;
                Weld2.Parent = workspace.Effects;
                Weld2.C0 = u22;
            end);
        end;
    end;

    task.delay(1, v2.Destroy, v2);
end;