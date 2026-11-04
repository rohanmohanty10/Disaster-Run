 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local packets = require(ReplicatedStorage.packets);

local function isDebug() -- Line: 7
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy)
    local v1 = ReplicatedStorage:FindFirstChild("debugTest") and ReplicatedStorage.debugTest.Value or false;

    if v1 then
        return v1;
    end;

    if not RunService:IsClient() then
        return false;
    end;

    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting then
        return setting.showHitboxes.Value, true;
    end;

    return false;
end;

return function(p2, p3: any, p4: any, p5: number?, p6: userdata?) -- Line: 23, Name: drawHitbox
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy), packets (copy)
    local v7;

    if ReplicatedStorage:FindFirstChild("debugTest") and ReplicatedStorage.debugTest.Value or false or not RunService:IsClient() then
        v7 = nil;
    else
        local setting = Players.LocalPlayer:FindFirstChild("setting");

        if setting then
            local _ = setting.showHitboxes.Value;
            v7 = true;
        else
            v7 = nil;
        end;
    end;

    local v8 = ReplicatedStorage:FindFirstChild("debugTest") and ReplicatedStorage.debugTest.Value or false;

    if not v8 then
        if RunService:IsClient() then
            local setting = Players.LocalPlayer:FindFirstChild("setting");

            if setting then
                v8 = setting.showHitboxes.Value;
            else
                v8 = false;
            end;
        else
            v8 = false;
        end;
    end;

    if not v8 then
        if RunService:IsServer() and p6 then
            packets.bytenet_replication.sendTo({
                name = "drawHitbox",
                content = {
                    p2,
                    p3,
                    p4,
                    p5
                }
            }, p6);
        end;

        return;
    end;

    local v9 = typeof(p3) == "number";
    local Part = Instance.new("Part");
    Part.CFrame = p2;
    local v10;

    if v9 then
        v10 = Vector3.new(1, 1, 1) * (p3 * 2) or p3;
    else
        v10 = p3;
    end;

    Part.Size = v10;

    if not v7 then
        local v11 = script.BoundsDebug:Clone();

        if v9 then
            v11.Label.Text = p3;
        else
            v11.Label.Text = `{p3.X}x{p3.Y}x{p3.Z}`;
        end;

        v11.StudsOffset = Vector3.new(0, 1, 0) * (Part.Size.Y / 2);
        v11.Parent = Part;
    end;

    Part.Shape = v9 and Enum.PartType.Ball or Enum.PartType.Block;
    Part.Anchored = true;
    Part.CastShadow = false;
    Part.CanCollide = false;
    Part.Transparency = v7 and 0.975 or 0.95;
    Part.Material = Enum.Material.ForceField;

    if typeof(p4) ~= "Color3" then
        p4 = p4 and Color3.new(0.333333, 0.333333, 1) or Color3.new(0, 0.333333, 1);
    end;

    Part.Color = p4;
    Part.Parent = workspace;
    game.Debris:AddItem(Part, p5 or 0.15);
end;