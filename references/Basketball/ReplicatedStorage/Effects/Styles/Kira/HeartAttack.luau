 
 

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
local KiraScreenEffect = require(script.Parent.Parent.ScreenEffects.KiraScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: Knit (copy), ReplicatedStorage (copy), SfxManager (copy), VfxManager (copy), Debris (copy), Essentials (copy), TweenService (copy), LocalPlayer (copy), KiraScreenEffect (copy), DarkScreenEffect (copy), RunService (copy)
    local Controller = Knit.GetController("BallController");
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local u4;

    if Character then
        u4 = Character:FindFirstChild("HumanoidRootPart");
    else
        u4 = Character;
    end;

    local v5;

    if Character then
        v5 = Character:FindFirstChild("Torso");
    else
        v5 = Character;
    end;

    local u6;

    if Character then
        u6 = Character:FindFirstChild("BALL", true);
    else
        u6 = Character;
    end;

    local Value = ReplicatedStorage.Basketball.Value;

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Forward" then
            if p2.Task ~= "Heart Attack" then
                if p2.Task == "Trigger" then
                    if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                        SfxManager:playSound({
                            Sound = "BBZ Kira Trigger",
                            Parent = workspace.Debris
                        });
                        KiraScreenEffect(Character);

                        return;
                    end;
                else
                    if p2.Task == "Book" then
                        local u7 = script.Dash:Clone();
                        u7.Parent = Debris;
                        u7.CFrame = u4.CFrame * CFrame.new(0, 0, -2);
                        Essentials:Weld(u7, u4);
                        VfxManager.DestroyEffect(u7, 2);
                        local u8 = script.Shinigami:Clone();
                        u8.Parent = Debris;
                        u8.CFrame = u4.CFrame;
                        Essentials:Weld(u8, u4);
                        VfxManager.DestroyEffect(u8, 2);
                        local u9 = script.Path:Clone();
                        u9.Parent = Debris;
                        local u10 = nil;
                        local u11 = nil;

                        local function Cleanup() -- Line: 263
                            -- upvalues: u10 (ref), VfxManager (ref), u7 (copy), u8 (copy), u11 (ref), u9 (copy), TweenService (ref), Character (copy)
                            if u10 then
                                return;
                            end;

                            u10 = true;
                            VfxManager.Enable(u7, false);
                            VfxManager.Enable(u8, false);
                            u11:Disconnect();
                            local u12 = {};
                            local u13 = {};

                            for _, descendant in pairs(u9:GetDescendants()) do
                                if descendant:IsA("Beam") then
                                    table.insert(u12, descendant);
                                    u13[descendant] = {};
                                    local v14 = descendant;

                                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                                        u13[v14][i] = {
                                            Start = v.Value,
                                            Needed = 1 - v.Value
                                        };
                                    end;
                                end;
                            end;

                            local NumberValue = Instance.new("NumberValue");
                            NumberValue.Changed:Connect(function() -- Line: 290
                                -- upvalues: u12 (copy), u13 (copy), NumberValue (copy)
                                for _, v in u12 do
                                    local v15 = v;
                                    local v16 = {};

                                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                                        table.insert(v16, NumberSequenceKeypoint.new(v2.Time, u13[v15][i].Start + u13[v15][i].Needed * NumberValue.Value));
                                    end;

                                    v15.Transparency = NumberSequence.new(v16);
                                end;
                            end);
                            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Value = 1
                            }):Play();
                            VfxManager.DestroyEffect(NumberValue, 0.25);
                            VfxManager.DestroyEffect(u9, 0.25);
                            local u17 = Character:FindFirstChild(script.Name .. "Book");

                            if not u17 then
                                return;
                            end;

                            for _, descendant in u17:GetDescendants() do
                                if descendant:IsA("BasePart") then
                                    TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                        Transparency = 1
                                    }):Play();
                                end;
                            end;

                            task.delay(0.25, function() -- Line: 315
                                -- upvalues: u17 (copy)
                                u17:Destroy();
                            end);
                        end;

                        u11 = RunService.Heartbeat:Connect(function() -- Line: 320
                            -- upvalues: Controller (copy), u4 (copy), Cleanup (copy), u9 (copy)
                            local ServerBallPosition = Controller:GetServerBallPosition();

                            if (u4.Position - ServerBallPosition).Magnitude <= 5 then
                                Cleanup();

                                return;
                            end;

                            local Vector3_new_ret = Vector3.new(u4.Position.X, 1.5, u4.Position.Z);
                            local Vector3_new_ret2 = Vector3.new(ServerBallPosition.X, 1.5, ServerBallPosition.Z);
                            u9.Start.CFrame = CFrame.new(Vector3_new_ret, Vector3_new_ret2);
                            u9.End.CFrame = CFrame.new(Vector3_new_ret2) * u9.Start.CFrame.Rotation;
                        end);
                        task.delay(0.5 - v3, function() -- Line: 335
                            -- upvalues: Cleanup (copy)
                            Cleanup();
                        end);

                        return;
                    end;

                    if p2.Task == "Marked" then
                        if not Other:FindFirstChild("Torso") then
                            return;
                        end;

                        local v18 = script.Heart:Clone();
                        v18.Name = Character.Name .. script.Name .. "Heart";
                        v18.Parent = Debris;
                        v18.CFrame = Other.Torso.CFrame;
                        Essentials:Weld(v18, Other.Torso);
                        VfxManager.DestroyEffect(v18, 10 - v3);

                        if LocalPlayer.Character == Other then
                            local u19 = SfxManager:playSound({
                                Sound = "BBZ Kira Pulse",
                                Parent = workspace
                            });
                            VfxManager.DestroyEffect(u19, 10.25 - v3);
                            v18.Destroying:Connect(function() -- Line: 352
                                -- upvalues: TweenService (ref), u19 (copy)
                                TweenService:Create(u19, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Volume = 0
                                }):Play();
                            end);

                            return;
                        end;
                    else
                        if p2.Task == "Pulse" then
                            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
                            local PulseVignette = PlayerGui:FindFirstChild("PulseVignette");

                            if not PulseVignette then
                                PulseVignette = script.Vignette:Clone();
                                PulseVignette.Name = "PulseVignette";
                                PulseVignette.Parent = PlayerGui;
                                PulseVignette.Enabled = true;
                                VfxManager.DestroyEffect(PulseVignette, 10.5 - v3);
                            end;

                            local _ = PulseVignette.Vignette;
                            local Vignette1 = PulseVignette.Vignette1;
                            Vignette1.ImageTransparency = 0.5;
                            PulseVignette.Vignette2.ImageTransparency = 1 - p2.Percentage;
                            Vignette1.ImageColor3 = Color3.fromRGB(255, 0, 0);
                            TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            }):Play();

                            return;
                        end;

                        if p2.Task == "Cleanup" then
                            local v20 = Debris:FindFirstChild(Character.Name .. script.Name .. "Heart");

                            if v20 then
                                v20:Destroy();
                            end;

                            local v21 = LocalPlayer.Character == Other and LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("PulseVignette");

                            if v21 then
                                v21.Name = "Vignette";
                                TweenService:Create(v21.Vignette2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    ImageTransparency = 1
                                }):Play();
                                VfxManager.DestroyEffect(v21, 0.5);
                            end;
                        end;
                    end;
                end;

                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ Kira Heart Attack",
                Parent = u4
            });
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.new(0, 0, 0);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 1.8833333333333333 - v3);
            Highlight.Parent = Character;
            TweenService:Create(Highlight, TweenInfo.new(0.25), {
                FillTransparency = -1,
                FillColor = Color3.fromRGB(133, 0, 0),
                OutlineColor = Color3.fromRGB(133, 0, 0)
            }):Play();
            task.delay(0.5 - v3, function() -- Line: 226
                -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
                local v22 = script.Text:Clone();
                v22.Parent = Debris;
                v22.CFrame = u4.CFrame * CFrame.new(0, 2.75, -0.75) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                VfxManager.DestroyEffect(v22, 2);
                shared.vfx.emit(v22);
            end);
            task.delay(1.7833333333333334 - v3, function() -- Line: 235
                -- upvalues: TweenService (ref), Highlight (copy)
                TweenService:Create(Highlight, TweenInfo.new(0.1), {
                    FillTransparency = 1,
                    OutlineColor = Color3.fromRGB(0, 0, 0)
                }):Play();
            end);

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Kira Fate Drive",
            Parent = u4
        });
        local u23 = script.Torso:Clone();
        u23.Parent = Debris;
        u23.CFrame = v5.CFrame;
        Essentials:Weld(u23, v5);
        VfxManager.DestroyEffect(u23, 2);
        local v24 = script.Bounce:Clone();
        v24.Parent = Debris;
        v24.CFrame = u4.CFrame * CFrame.new(0, -2.5, 0);
        VfxManager.DestroyEffect(v24, 2);
        shared.vfx.emit(v24);
        task.delay(0.4166666666666667 - v3, function() -- Line: 173
            -- upvalues: LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), u4 (copy), VfxManager (ref), u6 (copy)
            if LocalPlayer.Character == Character then
                DarkScreenEffect();
            end;

            local v25 = script.Death:Clone();
            v25.Parent = Debris;
            v25.CFrame = u4.CFrame;
            VfxManager.DestroyEffect(v25, 2);
            local v26 = script.BigBounce:Clone();
            v26.Parent = Debris;
            v26.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
            VfxManager.DestroyEffect(v26, 2);
            shared.vfx.emit(v25, v26);
        end);
        task.delay(0.6666666666666666 - v3, function() -- Line: 191
            -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
            local v27 = script.SideBounce:Clone();
            v27.Parent = Debris;
            v27.CFrame = CFrame.new(u6.Position) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
            VfxManager.DestroyEffect(v27, 2);
            shared.vfx.emit(v27);
        end);
        task.delay(0.7833333333333333 - v3, function() -- Line: 200
            -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
            local v28 = script.Bounce:Clone();
            v28.Parent = Debris;
            v28.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
            VfxManager.DestroyEffect(v28, 2);
            shared.vfx.emit(v28);
        end);
        task.delay(0.8333333333333334 - v3, function() -- Line: 209
            -- upvalues: VfxManager (ref), u23 (copy)
            VfxManager.Enable(u23, false);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Kira Written Fate",
        Parent = u4
    });
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 2.5833333333333335 - v3);
    local u29 = nil;
    task.delay(0.31666666666666665 - v3, function() -- Line: 46
        -- upvalues: Debris (ref), u4 (copy), Essentials (ref), VfxManager (ref)
        local v30 = script.Dribble:Clone();
        v30.Parent = Debris;
        v30.CFrame = u4.CFrame * CFrame.new(0, -2.1, -2.1);
        Essentials:Weld(v30, u4);
        VfxManager.DestroyEffect(v30, 2);
        shared.vfx.emit(v30);
    end);
    task.delay(0.35 - v3, function() -- Line: 56
        -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
        local v31 = script.Bounce:Clone();
        v31.Parent = Debris;
        v31.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v31, 2);
        shared.vfx.emit(v31);
    end);
    task.delay(0.5 - v3, function() -- Line: 65
        -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
        local v32 = script.Bounce:Clone();
        v32.Parent = Debris;
        v32.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v32, 2);
        shared.vfx.emit(v32);
    end);
    task.delay(0.6 - v3, function() -- Line: 74
        -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
        local v33 = script.Bounce:Clone();
        v33.Parent = Debris;
        v33.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v33, 2);
        shared.vfx.emit(v33);
    end);
    task.delay(0.7 - v3, function() -- Line: 83
        -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
        local v34 = script.Bounce:Clone();
        v34.Parent = Debris;
        v34.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v34, 2);
        shared.vfx.emit(v34);
    end);
    task.delay(0.8 - v3, function() -- Line: 92
        -- upvalues: Debris (ref), u6 (copy), u4 (copy), VfxManager (ref)
        local v35 = script.Bounce:Clone();
        v35.Parent = Debris;
        v35.CFrame = CFrame.new(u6.Position.X, math.clamp(u6.Position.Y - u6.Size.Y / 2, 1.5, 2), u6.Position.Z) * CFrame.fromOrientation(u4.CFrame:ToOrientation());
        VfxManager.DestroyEffect(v35, 2);
        shared.vfx.emit(v35);
    end);
    task.delay(1.1833333333333333 - v3, function() -- Line: 101
        -- upvalues: Highlight (copy), Character (copy), TweenService (ref), Debris (ref), u4 (copy), VfxManager (ref), u29 (ref), Value (copy), Essentials (ref)
        Highlight.Parent = Character;
        TweenService:Create(Highlight, TweenInfo.new(0.25), {
            FillTransparency = -1,
            FillColor = Color3.fromRGB(133, 0, 0),
            OutlineColor = Color3.fromRGB(133, 0, 0)
        }):Play();
        local v36 = script.Throw:Clone();
        v36.Parent = Debris;
        v36.CFrame = u4.CFrame * CFrame.new(2.75, -2.1, -2.1) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        VfxManager.DestroyEffect(v36, 2);
        shared.vfx.emit(v36);
        u29 = script.Trail:Clone();
        u29.Parent = Debris;
        u29.CFrame = Value.CFrame;
        Essentials:Weld(u29, Value);
        VfxManager.Enable(u29, true);
    end);
    task.delay(1.75 - v3, function() -- Line: 120
        -- upvalues: Debris (ref), u4 (copy), VfxManager (ref)
        local v37 = script.Text:Clone();
        v37.Parent = Debris;
        v37.CFrame = u4.CFrame * CFrame.new(0, 2.75, -0.75) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        VfxManager.DestroyEffect(v37, 2);
        shared.vfx.emit(v37);
    end);
    task.delay(2.4833333333333334 - v3, function() -- Line: 129
        -- upvalues: TweenService (ref), Highlight (copy), Debris (ref), VfxManager (ref)
        TweenService:Create(Highlight, TweenInfo.new(0.1), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        local v38 = script.Swipe:Clone();
        v38.Parent = Debris;
        v38.CFrame = CFrame.new(0, -0.2, -2) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        VfxManager.DestroyEffect(v38, 2);
        shared.vfx.emit(v38);
    end);
    task.delay(2.5833333333333335 - v3, function() -- Line: 140
        -- upvalues: VfxManager (ref), u29 (ref), LocalPlayer (ref), Character (copy), Other (copy), SfxManager (ref), KiraScreenEffect (ref), Debris (ref), u6 (copy)
        VfxManager.Enable(u29, false);
        VfxManager.DestroyEffect(u29, 4);

        if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
            SfxManager:playSound({
                Sound = "BBZ Kira Trigger",
                Parent = workspace.Debris
            });
            KiraScreenEffect(Character);
        end;

        local v39 = script.Catch:Clone();
        v39.Parent = Debris;
        v39.CFrame = u6.CFrame;
        VfxManager.DestroyEffect(v39, 2);
        shared.vfx.emit(v39);
    end);
end;