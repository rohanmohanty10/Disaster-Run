 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Debris (copy), VfxManager (copy), SfxManager (copy), LocalPlayer (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");

    if p2.Task ~= "Steal" then
        if p2.Task == "Stun" then
            local Victim = p2.Victim;

            if not p2.Emperor then
                local v4 = script.Ball_Emit:Clone();
                v4.CFrame = Victim.HumanoidRootPart.CFrame;
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 3);
                SfxManager:playSound({
                    Sound = "BBZ Gambler LuckyPull ActivateHit",
                    Parent = Victim.HumanoidRootPart
                });
            end;

            local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(Victim);

            if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
                local workspace_CurrentCamera = workspace.CurrentCamera;
                workspace_CurrentCamera.FieldOfView = 40;
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                    FieldOfView = 70
                }):Play();
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Parent = game.Lighting;
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 80, 80);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Parent = game.Lighting;
                BlurEffect.Size = 10;
                TweenService:Create(BlurEffect, TweenInfo.new(1), {
                    Size = 0
                }):Play();
                task.delay(1.5, function() -- Line: 86
                    -- upvalues: ColorCorrectionEffect (copy), BlurEffect (copy)
                    ColorCorrectionEffect:Destroy();
                    BlurEffect:Destroy();
                end);
            end;

            local PlayerFromCharacter2 = game.Players:GetPlayerFromCharacter(Char);

            if PlayerFromCharacter2 and PlayerFromCharacter2 == LocalPlayer then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Parent = game.Lighting;
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 124, 124);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(1.5, function() -- Line: 99
                    -- upvalues: ColorCorrectionEffect (copy)
                    ColorCorrectionEffect:Destroy();
                end);

                return;
            end;
        else
            if p2.Task == "Pass" then
                SfxManager:playSound({
                    Sound = "BBZ Gambler Behind-The-Back Pass",
                    Parent = HumanoidRootPart
                });
                task.wait(0.3 - v3);

                if not HumanoidRootPart then
                    return;
                end;

                local v5 = script.Release:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6099700927734375, -0.5041000843048096, 1.398284912109375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);

                return;
            end;

            if p2.Task == "Dash" then
                Char:FindFirstChild("BALL", true);
                SfxManager:playSound({
                    Sound = "BBZ Gambler Dribble",
                    Parent = HumanoidRootPart
                });
                task.wait(0.217 - v3);

                if not HumanoidRootPart then
                    return;
                end;

                local v6 = script.Dribble_0:Clone();
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.15208816528320312, -3.246119499206543, -2.70989990234375) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
                task.wait(0.4);

                if not HumanoidRootPart then
                    return;
                end;

                local v7 = script.Ball_Emit:Clone();
                v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.1968154907226562, 0.8597705364227295, -0.8603286743164062) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
                task.wait(0.166);

                if not HumanoidRootPart then
                    return;
                end;

                local v8 = script.Dribble_1:Clone();
                v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6029129028320312, -3.246119499206543, -3.5908966064453125) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v8.Parent = Debris;
                VfxManager.Emit(v8);
                VfxManager.DestroyEffect(v8, 3);
            end;
        end;

        return;
    end;

    Char:FindFirstChild("BALL", true);
    local v9, v10;

    if p2.InAwakening then
        v9 = script.Awakening.Start_up1;
        v10 = script.Awakening.Ball_Emit;
    else
        v9 = script.Start_up1;
        v10 = script.Ball_Emit;
    end;

    local v11 = v9:Clone();
    v11:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.4068145751953125, 0.04318523406982422, 0.3726806640625) * CFrame.fromEulerAnglesYXZ(-0, 1.5707963705062866, 1.5707963705062866));
    v11.Parent = Debris;
    VfxManager.Emit(v11);
    VfxManager.DestroyEffect(v11, 3);
    SfxManager:playSound({
        Sound = "BBZ Gambler Steal",
        Parent = HumanoidRootPart
    });
    task.wait(0.517 - v3);

    if not HumanoidRootPart then
        return;
    end;

    local v12 = v10:Clone();
    v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4068145751953125, -1.3287056684494019, -3.2463226318359375) * CFrame.fromEulerAnglesYXZ(-1.4901161193847656e-8, 6.70552182668871e-8, -2.980232594040899e-8);
    v12.Parent = Debris;
    VfxManager.Emit(v12);
    VfxManager.DestroyEffect(v12, 3);
end;