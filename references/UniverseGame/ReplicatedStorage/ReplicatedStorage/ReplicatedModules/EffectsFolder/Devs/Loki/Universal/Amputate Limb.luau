  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1, p2) -- Line: 9
    -- upvalues: Trove (copy)
    local v3 = p2 or {};
    local v4 = v3.Lifetime or 3;
    local BypassLifetime = v3.BypassLifetime;
    local v5 = v3.Limb or "Arm";
    local v6 = (v3.Direction or "Left") .. " " .. v5;

    if not (p1 and p1:FindFirstChild(v6)) then
        return;
    end;

    local u7 = Trove.new();
    u7:AttachToInstance(p1);
    local v8 = {};
    local v9 = p1:FindFirstChildWhichIsA(v5 == "Arm" and "Shirt" or "Pants");
    local v10 = p1:FindFirstChildWhichIsA("BodyColors") or {
        RightArmColor3 = Color3.fromRGB(255, 205, 144),
        LeftArmColor3 = Color3.fromRGB(255, 205, 144),
        RightLegColor3 = Color3.fromRGB(255, 205, 144),
        LeftLegColor3 = Color3.fromRGB(255, 205, 144)
    };
    local _ = {
        ["Left Arm"] = v10.LeftArmColor3,
        ["Left Leg"] = v10.LeftLegColor3,
        ["Right Arm"] = v10.RightArmColor3,
        ["Right Leg"] = v10.RightLegColor3
    };
    local u11 = p1:FindFirstChild(v6);
    local v12 = v6 ~= "Left Leg" and v10.RightLegColor3 or v10.LeftLegColor3;
    local v13 = u7:Clone(script.Container);
    v13.Parent = workspace.Effects;
    local v14 = v13:FindFirstChild(v6);
    v14.Color = v12;
    v14.CFrame = u11.CFrame;
    v14.CollisionGroup = "Ghosted";
    v14.CanCollide = true;

    if v9 then
        v9:Clone().Parent = v13;
    end;

    u11.Transparency = 1;
    v14.Transparency = 0;
    local v15 = next;
    local v16, v17 = u11:GetDescendants();

    for _, v in v15, v16, v17 do
        if v:IsA("Decal") or (v:IsA("BasePart") or v:IsA("Texture")) then
            v.Transparency = 1;
            table.insert(v8, v);
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail") and v.Enabled == true) then
            v.Enabled = false;
            table.insert(v8, v);
        end;
    end;

    if not BypassLifetime then
        task.delay(v4, function() -- Line: 89
            -- upvalues: u7 (copy), u11 (copy)
            u7:Destroy();
            u11.Transparency = 0;
        end);
    end;
end;