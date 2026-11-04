  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.HighlightController);

return function(p1) -- Line: 11
    -- upvalues: Debris (copy), SoundManager (copy), VfxManager (copy), Essentials (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Name = "GoldenDefense";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1);
    SoundManager.SpawnSound("ZombieDribble", 0.6, HumanoidRootPart, 130, false);
    local script_drrible = script.drrible;
    local v2 = {};

    for _, v in { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
        local v3 = Char:FindFirstChild(v);

        if v3 then
            for _, child in script_drrible[v ~= "Head" and v ~= "Torso" and "Left Arm" or v]:GetChildren() do
                local v4 = child:Clone();
                v4.Parent = v3;

                if v4.Name == "PartHead" then
                    local Part = v4.Part;
                    Part.Part0 = v3;
                    Part.Part1 = v4;
                end;

                VfxManager.Enable(v4, true);
                table.insert(v2, v4);
            end;
        end;
    end;

    local v5 = script.drrible.vfx:Clone();
    v5.Name = "VFXPart";
    v5.Parent = Char;
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0, 0);
    Essentials:Weld(HumanoidRootPart, v5);
    table.insert(v2, v5);
    VfxManager.Emit(v5);
    task.wait(0.6);
    task.wait(1.2);
    VfxManager.Enable(v5, false);

    for _, v in pairs(v2) do
        print(v);
        VfxManager.Enable(v, false);
    end;

    task.wait(3);

    for _, v in v2 do
        v:Destroy();
    end;
end;