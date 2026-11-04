 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    Char:FindFirstChild("Head");

    if p2.Task == "Dash" then
        SfxManager:playSound({
            Sound = "BBZ Gold Dash",
            Parent = HumanoidRootPart
        });

        if HumanoidRootPart then
            local v4 = Vector3.new(Value.Position.X, HumanoidRootPart.Position.Y, Value.Position.Z) - HumanoidRootPart.Position;
            local v5 = v4.Magnitude > 0 and v4.Unit or HumanoidRootPart.CFrame.LookVector;
            local v6 = script.Dash:Clone();
            v6:PivotTo(CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + v5));
            v6.Parent = Debris;
            shared.vfx.emit(v6);
            VfxManager.DestroyEffect(v6, 3);
        end;
    elseif p2.Task == "Jump" then
        SfxManager:playSound({
            Sound = "BBZ Gold Jump",
            Parent = HumanoidRootPart
        });

        if HumanoidRootPart then
            local v7 = script.Jump:Clone();
            v7:PivotTo(HumanoidRootPart.CFrame);
            v7.Parent = Debris;
            shared.vfx.emit(v7);
            VfxManager.DestroyEffect(v7, 3);
        end;
    elseif p2.Task == "Catch" then
        local v8 = Char:FindFirstChild(script.Name .. "Highlight");

        if v8 then
            local u9 = v8:Clone();
            u9.Name = "Highlight";
            u9.Parent = Char;
            u9.FillTransparency = 0;
            TweenService:Create(u9, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FillTransparency = 1,
                OutlineColor = Color3.new(0, 0, 0)
            }):Play();
            task.delay(0.85, function() -- Line: 59
                -- upvalues: u9 (copy)
                u9:Destroy();
            end);
            v8:Destroy();
        end;
    else
        if p2.Task == "Pressure" then
            SfxManager:playSound({
                Sound = "BBZ Gold Golden Defense",
                Parent = HumanoidRootPart
            });
            local Highlight = Instance.new("Highlight");
            Highlight.Name = script.Name .. "Highlight";
            Highlight.FillTransparency = 0.8;
            Highlight.FillColor = Color3.new(0.968627, 1, 0.4);
            Highlight.OutlineColor = Color3.new(1, 0.905882, 0.431373);
            Highlight.OutlineTransparency = 0;
            Highlight.Parent = Char;
            task.delay(2, function() -- Line: 76
                -- upvalues: Highlight (copy)
                Highlight:Destroy();
            end);
            local v10 = script.Defense:Clone();
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.5890045166015625, -2.4999887943267822, -1.0579986572265625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);

            return;
        end;

        if p2.Task == "Pass" then
            SfxManager:playSound({
                Sound = "BBZ Gold Needle Pass",
                Parent = HumanoidRootPart
            });
            task.delay(0.067 - v3, function() -- Line: 88
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v11 = script["Pass Spin"]:Clone();
                    v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.1993260383605957, -0.9731054306030273, -0.25669097900390625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v11.Parent = Debris;
                    VfxManager.Emit(v11);
                    VfxManager.DestroyEffect(v11, 3);
                end;
            end);
            task.delay(0.2 - v3, function() -- Line: 98
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v12 = script["Pass Throw"]:Clone();
                    v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6671712398529053, 0.974395751953125, -2.7866783142089844) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v12.Parent = Debris;
                    VfxManager.Emit(v12);
                    VfxManager.DestroyEffect(v12, 3);
                end;
            end);
        end;
    end;
end;