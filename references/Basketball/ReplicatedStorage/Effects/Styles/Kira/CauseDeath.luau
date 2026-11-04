 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(script.Parent.Parent.ScreenEffects.KiraScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: Knit (copy), SfxManager (copy), LocalPlayer (copy), DarkScreenEffect (copy), Debris (copy), Essentials (copy), VfxManager (copy), RunService (copy), TweenService (copy)
    Knit.GetController("BallController");
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Forward" then
        if p2.Task == "Cause of Death" then
            SfxManager:playSound({
                Sound = "BBZ Kira Cause of Death Start",
                Parent = HumanoidRootPart
            });
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.new(0, 0, 0);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 1.85 - u3);
            Highlight.Parent = Character;
            TweenService:Create(Highlight, TweenInfo.new(0.25), {
                FillTransparency = -1,
                FillColor = Color3.fromRGB(133, 0, 0),
                OutlineColor = Color3.fromRGB(133, 0, 0)
            }):Play();
            task.delay(0.25, function() -- Line: 158
                -- upvalues: TweenService (ref), Highlight (copy), u3 (copy)
                TweenService:Create(Highlight, TweenInfo.new(1.6 - u3), {
                    FillTransparency = 1,
                    OutlineColor = Color3.fromRGB(0, 0, 0)
                }):Play();
            end);
            task.delay(1.6 - u3, function() -- Line: 162
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), Other (copy), TweenService (ref), SfxManager (ref)
                local v4 = script.Text:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2.75, -0.75) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                VfxManager.DestroyEffect(v4, 2);
                shared.vfx.emit(v4);
                local CFrame_new_ret = CFrame.new(Other.HumanoidRootPart.Position - CFrame.new(HumanoidRootPart.Position, Other.HumanoidRootPart.Position).RightVector, Other.HumanoidRootPart.Position);
                local v5 = CFrame.new(CFrame_new_ret.Position.X, 8.25, CFrame_new_ret.Position.Z) * CFrame_new_ret.Rotation;
                local v6 = script.Truck:Clone();
                v6.Parent = Debris;
                v6.PrimaryPart.CFrame = v5 * CFrame.new(0, 0, 500);
                VfxManager.DestroyEffect(v6, 1.8);
                TweenService:Create(v6.PrimaryPart, TweenInfo.new(1.9666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    CFrame = v5 * CFrame.new(0, 0, -500)
                }):Play();
                SfxManager:playSound({
                    Sound = "BBZ Kira Cause of Death Truck",
                    Parent = v6
                });
            end);
            task.delay(2.5833333333333335 - u3, function() -- Line: 183
                -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Other (copy), VfxManager (ref)
                SfxManager:playSound({
                    Sound = "BBZ Kira Cause of Death Hit",
                    Parent = HumanoidRootPart
                });
                local v7 = script.MetalHit:Clone();
                v7.Parent = Debris;
                v7.CFrame = Other.HumanoidRootPart.CFrame;
                VfxManager.DestroyEffect(v7, 2);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Kira Death Drive",
        Parent = HumanoidRootPart
    });

    if LocalPlayer.Character == Character or p2.Others and table.find(p2.Others, LocalPlayer.Character) then
        DarkScreenEffect();
    end;

    local u8 = script.Shinigami:Clone();
    u8.Parent = Debris;
    u8.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u8, HumanoidRootPart);
    VfxManager.DestroyEffect(u8, 2);
    local u9 = script.Path:Clone();
    u9.Parent = Debris;
    local v10 = HumanoidRootPart.CFrame + p2.Direction * 50;
    local Vector3_new_ret = Vector3.new(v10.Position.X, 1.5, v10.Position.Z);
    local u11 = RunService.Heartbeat:Connect(function() -- Line: 50
        -- upvalues: HumanoidRootPart (copy), Vector3_new_ret (copy), u9 (copy)
        local Vector3_new_ret2 = Vector3.new(HumanoidRootPart.Position.X, 1.5, HumanoidRootPart.Position.Z);

        if (Vector3_new_ret2 - Vector3_new_ret).Magnitude == 0 then
            return;
        end;

        u9.Start.CFrame = CFrame.new(Vector3_new_ret2, Vector3_new_ret);
        u9.End.CFrame = CFrame.new(Vector3_new_ret) * u9.Start.CFrame.Rotation;
    end);
    task.delay(0.16666666666666666 - u3, function() -- Line: 59
        -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
        local v12 = script.Dribble:Clone();
        v12.Parent = Debris;
        v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.1, -2.1);
        Essentials:Weld(v12, HumanoidRootPart);
        VfxManager.DestroyEffect(v12, 2);
        shared.vfx.emit(v12);
    end);
    task.delay(0.2 - u3, function() -- Line: 69
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v13 = script.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v13, 2);
        shared.vfx.emit(v13);
    end);
    task.delay(0.43333333333333335 - u3, function() -- Line: 78
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v14, 2);
        shared.vfx.emit(v14);
    end);
    task.delay(0.6666666666666666 - u3, function() -- Line: 87
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v15, 2);
        shared.vfx.emit(v15);
    end);
    task.delay(0.7666666666666667 - u3, function() -- Line: 96
        -- upvalues: VfxManager (ref), u8 (copy), u11 (copy), u9 (copy), TweenService (ref)
        VfxManager.Enable(u8, false);
        u11:Disconnect();
        local u16 = {};
        local u17 = {};

        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("Beam") then
                table.insert(u16, descendant);
                u17[descendant] = {};
                local v18 = descendant;

                for i, v in ipairs(descendant.Transparency.Keypoints) do
                    u17[v18][i] = {
                        Start = v.Value,
                        Needed = 1 - v.Value
                    };
                end;
            end;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Changed:Connect(function() -- Line: 119
            -- upvalues: u16 (copy), u17 (copy), NumberValue (copy)
            for _, v in u16 do
                local v19 = v;
                local v20 = {};

                for i, v2 in ipairs(v.Transparency.Keypoints) do
                    table.insert(v20, NumberSequenceKeypoint.new(v2.Time, u17[v19][i].Start + u17[v19][i].Needed * NumberValue.Value));
                end;

                v19.Transparency = NumberSequence.new(v20);
            end;
        end);
        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        VfxManager.DestroyEffect(NumberValue, 0.25);
        VfxManager.DestroyEffect(u9, 0.25);
    end);
    task.delay(0.9333333333333333 - u3, function() -- Line: 136
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v21 = script.Bounce:Clone();
        v21.Parent = Debris;
        v21.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v21, 2);
        shared.vfx.emit(v21);
    end);
end;