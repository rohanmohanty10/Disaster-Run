  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 11
    -- upvalues: SpectatorController (copy), Debris (copy), VfxManager (copy), ReplicatedStorage (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local _ = game.Workspace;
    local Char = u1.Char;
    local _ = Char.HumanoidRootPart;
    local Effect = u1.Effect;
    workspace.CurrentCamera.FieldOfView = 30;

    if not string.find(Effect, "1") then
        if Effect == "ScreenChange" then
            local v2 = script.Aura:Clone();

            for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
                local v3 = v;

                for _, child in v2[v]:GetChildren() do
                    if child:IsA("Attachment") or child:IsA("ParticleEmitter") then
                        child.Parent = Char[v3];
                        child:SetAttribute("KingAura", true);
                    end;
                end;
            end;

            task.delay(5, function() -- Line: 49
                -- upvalues: Char (copy), Debris (ref), VfxManager (ref)
                for _, descendant in Char:GetDescendants() do
                    if descendant:GetAttribute("KingAura") then
                        Debris:AddItem(descendant, 1);
                    end;
                end;

                for _, child in Char:GetChildren() do
                    if child:IsA("BasePart") then
                        VfxManager.Enable(child, false);
                    end;
                end;
            end);
            task.spawn(function() -- Line: 62
                -- upvalues: ReplicatedStorage (ref), u1 (copy), TweenService (ref)
                local v4 = ReplicatedStorage.Assets.UI.Popup:Clone();
                v4.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
                v4.Position = UDim2.new(0.5, 0, 0.8, 0);
                v4.Size = UDim2.new(1, 0, 0.1, 0);
                v4.BackgroundTransparency = 1;
                v4.AnchorPoint = Vector2.new(0.5, 0.5);
                v4.Font = Enum.Font.ArialBold;
                v4.MaxVisibleGraphemes = 0;
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Parent = v4;
                UIStroke.Thickness = 4;
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
                v4.MaxVisibleGraphemes = 0;
                v4.TextTransparency = 0;
                v4.TextStrokeTransparency = 0;
                UIStroke.Transparency = 0;
                v4.Text = "I\'ll feast on you " .. u1.Enemy.Name;
                TweenService:Create(v4, TweenInfo.new(0.25833333333333336, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = #v4.Text
                }):Play();
                task.wait(1.2666666666666666);
                TweenService:Create(v4, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                task.wait(0.55);
                v4.MaxVisibleGraphemes = 0;
                v4.TextTransparency = 0;
                v4.TextStrokeTransparency = 0;
                UIStroke.Transparency = 0;
                v4.Text = "Your light...";
                TweenService:Create(v4, TweenInfo.new(0.19166666666666668, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = #v4.Text
                }):Play();
                task.wait(1.2666666666666666);
                v4.MaxVisibleGraphemes = 0;
                v4.TextTransparency = 0;
                v4.TextStrokeTransparency = 0;
                UIStroke.Transparency = 0;
                v4.Text = "IS MINE!!!";
                TweenService:Create(v4, TweenInfo.new(0.19166666666666668, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = #v4.Text
                }):Play();
                task.wait(0.7666666666666667);
                TweenService:Create(v4, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
            end);
            local v5 = script.SCreencover:Clone();
            v5.CFrame = workspace.CurrentCamera.CFrame;
            v5.Parent = workspace.Debris;
            Debris:AddItem(v5, 1);
            VfxManager.Emit(v5);
            local v6 = script.Background:Clone();
            v6.Parent = workspace.Debris;
            v6:PivotTo(Char.Torso.CFrame * CFrame.new(
                -7.25576496,
                -6.8578701,
                109.203316,
                -0.122901142,
                0.233124495,
                -0.964649796,
                0.0460103527,
                0.972311616,
                0.229114383,
                0.991352141,
                -0.0162254255,
                -0.130224422
            ));
            Debris:AddItem(v6, 3);
            local v7 = script.InvertedDomain:Clone();
            v7.Parent = workspace.Debris;
            v7:PivotTo(Char.Torso.CFrame * CFrame.new(
                38.8923378,
                12.3549213,
                -29.734623,
                0.829921901,
                0.550152481,
                -0.0925303698,
                -0.549099088,
                0.834856689,
                0.0387883857,
                0.0985891297,
                0.0186170135,
                0.994954109
            ));
            Debris:AddItem(v7, 3);
            local v8 = script.BlackRoom:Clone();
            v8.Parent = workspace.Debris;
            v8:PivotTo(Char.Torso.CFrame * CFrame.new(
                35.4819298,
                0.0761482716,
                -88.7099915,
                0.0925303698,
                0.829921901,
                -0.550152481,
                -0.0387883857,
                -0.549099088,
                -0.834856689,
                -0.994954109,
                0.0985891297,
                -0.0186170135
            ));
            Debris:AddItem(v8, 3);
            workspace.CurrentCamera.FieldOfView = 70;
        end;

        return;
    end;

    local v9 = string.split(Effect, "1")[1];
    local v10 = script.Step:Clone();
    v10.Position = Char[v9 .. " Leg"].Position + Vector3.new(0, -1, 0);
    v10.Parent = workspace.Debris;
    Debris:AddItem(v10, 1);
    VfxManager.Emit(v10);
end;