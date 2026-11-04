  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: Debris (copy), EmitModule (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = "BachiraHighlight";
    Folder.Parent = Char;
    table.insert(u2, Folder);
    Debris:AddItem(Folder, 0.8);
    local v3 = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" };

    for _, child in Char:GetChildren() do
        local v4;

        if table.find(v3, child.Name) then
            v4 = child;

            for _, child2 in script["1"]:GetChildren() do
                local v5 = child2:Clone();
                v5.Parent = v4;
                Debris:AddItem(v5, 3);
                table.insert(u2, v5);
            end;
        else
            v4 = child;
        end;

        if v4.Name == "Head" then
            for _, child2 in script["3"]:GetChildren() do
                local v6 = child2:Clone();
                v6.Parent = v4;
                Debris:AddItem(v6, 3);
                table.insert(u2, v6);
            end;
        end;

        if v4.Name == "Torso" then
            for _, child2 in script["2"]:GetChildren() do
                local v7 = child2:Clone();
                v7.Parent = v4;
                Debris:AddItem(v7, 3);
                table.insert(u2, v7);
            end;
        end;
    end;

    task.wait(0.04);
    EmitModule.emit(Char);
    local v8 = script.Startup:Clone();
    v8:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0.0000305175781, -2.84800005, 0.0769996643, 0.00298885466, 0, -1, 0, -1, 0, -1, 0, -0.00298885466));
    v8.Parent = workspace.Debris;
    table.insert(u2, v8);
    EmitModule.emit(v8);
    Debris:AddItem(v8, 3);
    task.wait(0.3);
    local v9 = script.EndEmit:Clone();
    v9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        0.462280273,
        -0.652165651,
        -2.95210838,
        0,
        0.0406377576,
        0.999174118,
        0,
        -0.999174178,
        0.0406377278,
        0.99999994,
        0,
        0
    ));
    v9.Parent = workspace.Debris;
    table.insert(u2, v9);
    EmitModule.emit(v9);
    Debris:AddItem(v9, 3);
    task.delay(3, function() -- Line: 79
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;