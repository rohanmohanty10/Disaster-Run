 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), Debris (copy), VfxManager (copy), Essentials (copy), RunService (copy)
    local BallController = p1.BallController;
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Right Arm");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Activate" then
        if p2.Task == "Activate2" then
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in script["Aura yo"]:GetChildren() do
                if Char:FindFirstChild(child.Name) then
                    local v3 = child:Clone();
                    v3.Anchored = false;
                    v3.CFrame = Char:FindFirstChild(child.Name).CFrame;
                    v3.Parent = Model;
                    Essentials:Weld(v3, Char:FindFirstChild(child.Name));
                end;
            end;

            VfxManager.Enable(Model, true);
            task.delay(3, function() -- Line: 94
                -- upvalues: Model (copy), VfxManager (ref)
                if Model then
                    VfxManager.Enable(Model, false);
                    VfxManager.DestroyEffect(Model, 3);
                end;
            end);
        end;

        return;
    end;

    local v4 = script.emit:Clone();
    v4.CFrame = HumanoidRootPart.CFrame;
    v4.Parent = Debris;
    VfxManager.Emit(v4);
    VfxManager.DestroyEffect(v4, 3);
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v5 = child:Clone();
            v5.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v5.Parent = Model;
            Essentials:Weld(v5, Char:FindFirstChild(child.Name));
        end;
    end;

    VfxManager.Enable(Model, true);
    local u6 = nil;
    u6 = RunService.RenderStepped:Connect(function() -- Line: 50
        -- upvalues: BallController (copy), Char (copy), u6 (ref), VfxManager (ref), Model (copy)
        if not BallController:CharacterPossessesBall(Char) then
            return;
        end;

        u6:Disconnect();
        VfxManager.Enable(Model, false);
        task.wait(3);
        Model:Destroy();
    end);
    task.delay(0.75, function() -- Line: 65
        -- upvalues: u6 (ref), Model (copy), VfxManager (ref)
        u6:Disconnect();

        if Model then
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 3);
        end;
    end);
end;