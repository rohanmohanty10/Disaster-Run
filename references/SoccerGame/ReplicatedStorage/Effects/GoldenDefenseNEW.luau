  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    local _ = p1.State;
    local _ = p1.Left;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p1.State == "Side" then
        SoundManager.SpawnSound("GoldenDefense1", 0.6, HumanoidRootPart, 130, false);
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "GoldenDefense";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.4);
    local u2 = {};

    for _, child in script.HRP:GetChildren() do
        local v3 = child:Clone();
        v3.Parent = Char.HumanoidRootPart;
        table.insert(u2, v3);
        VfxManager.Emit2(v3);
    end;

    local v4 = script.Torso:Clone();
    v4.Parent = Char.Torso;
    table.insert(u2, v4);
    VfxManager.Emit2(v4);
    local v5 = { "Right Arm", "Right Leg", "Left Arm", "Left Leg", "Torso", "Head" };

    for _, child in Char:GetChildren() do
        if child:IsA("BasePart") and (table.find(v5, child.Name) and (child.Name ~= "Torso" and child.Name ~= "Head")) then
            local v6 = script.Trails.Attachment:Clone();
            v6.Parent = child;
            table.insert(u2, v6);
            VfxManager.Emit2(v6);
            local v7 = child;

            for _, child2 in script.BodyAura:GetChildren() do
                local v8 = child2:Clone();
                v8.Parent = v7;
                table.insert(u2, v8);
                VfxManager.Emit2(v8);
            end;
        elseif child:IsA("BasePart") and (table.find(v5, child.Name) and (child.Name == "Torso" or child.Name == "Head")) then
            local v9 = child;

            for _, child2 in script.BodyAura:GetChildren() do
                local v10 = child2:Clone();
                v10.Parent = v9;
                table.insert(u2, v10);
                VfxManager.Emit2(v10);
            end;
        end;
    end;

    task.delay(3, function() -- Line: 68
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;