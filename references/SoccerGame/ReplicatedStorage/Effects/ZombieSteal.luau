  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), Debris (copy), VfxManager (copy), EmitModule (copy)
    local Char = p1.Char;
    local _ = p1.State;
    local _ = p1.Left;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if p1.State ~= "Start" then
        if p1.State == "Hit" then
            local v2 = script.MeshWork2:Clone();
            v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
                -0.121753693,
                -0.702720881,
                -1.50636232,
                -0.905559659,
                0.0406379066,
                0.422269404,
                0.422618449,
                4.37113989e-8,
                0.906307817,
                0.0368304923,
                0.999174297,
                -0.0171743315
            ));
            v2.Parent = workspace.Debris;
            EmitModule.emit(v2);
            Debris:AddItem(v2, 2);
        end;

        return;
    end;

    SoundManager.SpawnSound("Zombie steal ball", 0.6, HumanoidRootPart, 130, false);
    local u3 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = "GoldenDefense";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.5);
    local v4 = script.Part1:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        -0.0299758911,
        -2.6523056,
        -0.0000190734863,
        1.26758539e-6,
        1.22189772e-6,
        1,
        -4.50014022e-6,
        1,
        -1.22189203e-6,
        -1,
        -4.50013886e-6,
        1.26759085e-6
    );
    v4.Parent = workspace.Debris;
    VfxManager.Emit2(v4);
    table.insert(u3, v4);
    local v5 = script.Startup:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(
        0.0000228881836,
        -0.000305652618,
        0.000326156616,
        1,
        0,
        -0,
        0,
        -4.37113883e-8,
        -1,
        0,
        1,
        -4.37113883e-8
    );
    v5.Parent = workspace.Debris;
    VfxManager.Emit2(v5);
    table.insert(u3, v5);

    for _, child in script.HRP:GetChildren() do
        local v6 = child:Clone();
        v6.Parent = Char.HumanoidRootPart;
        table.insert(u3, v6);
        VfxManager.Emit2(v6);
    end;

    local v7 = script.Torso:Clone();
    v7.Parent = Char.Torso;
    table.insert(u3, v7);
    VfxManager.Emit2(v7);
    local v8 = { "Right Arm", "Right Leg", "Left Arm", "Left Leg", "Torso", "Head" };

    for _, child in Char:GetChildren() do
        if child:IsA("BasePart") and (table.find(v8, child.Name) and (child.Name ~= "Torso" and child.Name ~= "Head")) then
            local v9 = script.Trails.Attachment:Clone();
            v9.Parent = child;
            table.insert(u3, v9);
            VfxManager.Emit2(v9);
            local v10 = child;

            for _, child2 in script.BodyAura:GetChildren() do
                local v11 = child2:Clone();
                v11.Parent = v10;
                table.insert(u3, v11);
                VfxManager.Emit2(v11);
            end;
        elseif child:IsA("BasePart") and (table.find(v8, child.Name) and (child.Name == "Torso" or child.Name == "Head")) then
            local v12 = child;

            for _, child2 in script.BodyAura:GetChildren() do
                local v13 = child2:Clone();
                v13.Parent = v12;
                table.insert(u3, v13);
                VfxManager.Emit2(v13);
            end;
        end;
    end;

    local v14 = script.MeshWork1:Clone();
    v14:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        -0.175952911,
        -0.702724695,
        -4.39395332,
        0,
        0.0406379029,
        -0.999174058,
        -1,
        0,
        0,
        0,
        0.999174058,
        0.0406379141
    ));
    v14.Parent = workspace.Debris;
    table.insert(u3, v14);
    EmitModule.emit(v14);
    task.delay(3, function() -- Line: 88
        -- upvalues: u3 (copy)
        for _, v in u3 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;