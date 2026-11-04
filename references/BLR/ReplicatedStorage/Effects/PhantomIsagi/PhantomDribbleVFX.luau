  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return function(p1) -- Line: 14
    -- upvalues: SoundManager (copy), Debris (copy), EmitModule (copy), VfxManager (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u2 = {};
    SoundManager.SpawnSound("PhantomDribble", 0.9, Char.HumanoidRootPart, 130, false);
    task.wait(0.23);
    local Folder = Instance.new("Folder");
    Folder.Name = "PIsagiHighlight";
    Folder.Parent = Char;
    table.insert(u2, Folder);
    Debris:AddItem(Folder, 1.1);
    local v3 = script.Startup:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.84838033, -0.757770538, 0.00298922369, 0, -1, 0, -1, 0, -1, 0, -0.00298900018));
    v3.Parent = workspace.Debris;
    table.insert(u2, v3);
    EmitModule.emit(v3);
    Debris:AddItem(v3, 3);
    task.wait(0.64);
    local v4 = script.ZDDirtEmit:Clone();
    v4.Parent = Char.HumanoidRootPart;
    table.insert(u2, v4);
    VfxManager.Emit2(v4);
    Debris:AddItem(v4, 3);
    task.wait(0.2);
    local v5 = script.EndEmit:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        0.199996948,
        -0.0575797558,
        -7.25118256,
        0.040637739,
        0,
        -0.999174118,
        0,
        1,
        0,
        0.999174118,
        0,
        0.0406377502
    ));
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    EmitModule.emit(v5);
    Debris:AddItem(v5, 3);
    task.delay(3, function() -- Line: 55
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;