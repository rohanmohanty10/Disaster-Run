 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 19
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), TweenService (copy), Players (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local _ = u2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;

    if u2.Task ~= "Run" then
        if u2.Task ~= "Shoot" then
            if u2.Task == "Dunk" then
                SfxManager:playSound({
                    Sound = "BBZ Perfection V2 Unwilling Assist Dunk",
                    Parent = HumanoidRootPart
                });
                local v4 = script.Dunk.Emit:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0);
                VfxManager.DestroyEffect(v4, 2);
                shared.vfx.emit(v4);
                task.delay(1.3 - v3, function() -- Line: 151
                    -- upvalues: Players (ref), Character (copy), Debris (ref), VfxManager (ref)
                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

                    if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
                        local v5 = script.Dunk.Shoot:Clone();
                        v5.Parent = Debris;
                        v5:PivotTo(CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position));
                        VfxManager.DestroyEffect(v5, 4);
                        shared.vfx.emit(v5);
                    end;
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Unwilling Assist Shoot",
            Parent = HumanoidRootPart
        });
        local u6 = script.Shoot.Ball:Clone();
        u6.Parent = Debris;
        u6.CFrame = BALL.CFrame;
        Essentials:Weld(u6, BALL);
        VfxManager.DestroyEffect(u6, 4);
        local v7 = script.Shoot.Sweat:Clone();
        v7.Parent = Debris;
        v7:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v7, 2);
        shared.vfx.emit(v7);
        task.delay(0.7833333333333333 - v3, function() -- Line: 121
            -- upvalues: Debris (ref), VfxManager (ref), u6 (copy)
            local v8 = script.Shoot.CameraFX:Clone();
            v8.Parent = Debris;
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8, u6);
        end);
        task.delay(2.2 - v3, function() -- Line: 129
            -- upvalues: u6 (copy), Value (copy), Essentials (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            u6:FindFirstChild("WeldConstraint"):Destroy();
            u6.CFrame = Value.CFrame;
            Essentials:Weld(u6, Value);
            local v9 = script.Shoot.Shoot:Clone();
            v9.Parent = Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Perfection V2 Unwilling Run",
        Parent = HumanoidRootPart
    });
    SfxManager:playSound({
        Sound = "BBZ Perfection V2 Teleport",
        Parent = HumanoidRootPart
    });
    local v10 = script.Run.Teleport:Clone();
    v10.Parent = Debris;
    v10.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v10, HumanoidRootPart);
    VfxManager.DestroyEffect(v10, 2);
    shared.vfx.emit(v10);
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    TweenService:Create(Highlight, TweenInfo.new(0.3), {
        FillTransparency = 0
    }):Play();
    task.delay(0.3 - v3, function() -- Line: 51
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), TweenService (ref), Highlight (copy)
        local v11 = script.Run.Emit:Clone();
        v11.Parent = Debris;
        v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0);
        VfxManager.DestroyEffect(v11, 2);
        shared.vfx.emit(v11);
        TweenService:Create(Highlight, TweenInfo.new(0.45), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(0.75 - v3, function() -- Line: 62
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v12 = script.Run.TP:Clone();
        v12.Parent = Debris;
        v12:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v12, 2);
        shared.vfx.emit(v12);
    end);
    task.delay(1.2666666666666666 - v3, function() -- Line: 71
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v13 = script.Run.Grab:Clone();
        v13.Parent = Debris;
        v13:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v13, 2);
        shared.vfx.emit(v13);
    end);
    task.delay(0.75 - v3, function() -- Line: 80
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v14 = script.Run.TP:Clone();
        v14.Parent = Debris;
        v14:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v14, 2);
        shared.vfx.emit(v14);
    end);
    task.delay(1.4333333333333333 - v3, function() -- Line: 89
        -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), u2 (copy), Highlight (copy)
        local v15 = script.Run.Run:Clone();
        v15.Parent = Debris;
        v15:PivotTo(HumanoidRootPart.CFrame);
        Essentials:Weld(v15.PrimaryPart, HumanoidRootPart);
        VfxManager.DestroyEffect(v15, 4);
        VfxManager.Enable(v15, true);

        while u2.WeldEnemy and u2.WeldEnemy.Parent do
            task.wait();
        end;

        VfxManager.Enable(v15, false);
        Highlight:Destroy();
    end);
end;