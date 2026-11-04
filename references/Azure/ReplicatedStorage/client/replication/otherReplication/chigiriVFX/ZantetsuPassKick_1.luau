 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local mainreplication = require(script.Parent.Parent.Parent.mainreplication);
require(script.Parent.Parent.Parent.TekrinnDialogue);
require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local _ = Players.LocalPlayer;
local BackgroundHighlight = require(script.Parent.Parent.Parent.BackgroundHighlight);

function characterImage(p1)
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p1);
end;

return function(p2: table) -- Line: 27
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), Debris (copy)
    local Value = p2.Character.Value;
    local u3 = Value.HumanoidRootPart or Value.PrimaryPart;

    if p2.Variant == 0 then
        task.delay(0.383, function() -- Line: 32
            -- upvalues: Players (ref), Value (copy), mainreplication (ref), ReplicatedStorage (ref), u3 (copy)
            if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                mainreplication.springcamerashake(25, 45);
                mainreplication.fov(false, 50);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            end;

            local v4 = ReplicatedStorage.Resources.chigiri.AttachmentPart.KickImpact1:Clone();
            v4.Parent = u3;

            for _, descendant in pairs(v4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end;

    p2.Variant.Changed:Connect(function() -- Line: 50
        -- upvalues: mainreplication (ref), u3 (copy), Players (ref), Value (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), Debris (ref)
        mainreplication.bodyVelocity(u3, 210, 1.5, nil, nil, nil, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(10, 80);
            local v5 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v5.Parent = Lighting;
            v5.TintColor = Color3.fromRGB(33, 33, 33);
            v5.Brightness = 0.4;
            v5.Contrast = 1;
            v5.Saturation = -0.4;
            TweenService:Create(v5, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v5, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v5.Destroy, v5);
        end;

        characterImage({
            Speed = 1.5,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            ImageTransparency = 0.8,
            Count = 30,
            Whitelist = { Value },
            Color = Color3.fromRGB(0, 0, 0),
            Color2 = Color3.fromRGB(44, 44, 44)
        });
        task.delay(0.1, function() -- Line: 85
            -- upvalues: ReplicatedStorage (ref), u3 (ref), Debris (ref)
            local v6 = ReplicatedStorage.Resources.chigiri.zantetsuflashstep:Clone();
            v6.Weld.Part1 = u3;
            v6.Parent = u3;
            Debris:AddItem(v6, 10);

            for _, descendant in pairs(v6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            local v7 = ReplicatedStorage.Resources.chigiri.AttachmentPart.zantetsustart:Clone();
            v7.Parent = u3;
            Debris:AddItem(v7, 10);

            for _, descendant in pairs(v7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);

        if not (shared.allvfxcheck and shared.allvfxcheck()) then
            local u8 = ReplicatedStorage.Resources.chigiri.AttachmentPart.zantetsurun:Clone();
            u8.Parent = u3;
            Debris:AddItem(u8, 10);

            for _, descendant in pairs(u8:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            local u9 = ReplicatedStorage.Resources.chigiri.RunVFX:Clone();
            u9.HumanoidRootPart.Part1 = u3;
            u9.Parent = u3;
            Debris:AddItem(u9, 10);

            for _, descendant in pairs(u9:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            local u10 = ReplicatedStorage.Resources.chigiri.AttachmentPart.ZANTETSUBEAMS:Clone();
            u8.Parent = u3;
            Debris:AddItem(u8, 10);

            for _, descendant in pairs(u10:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Brightness = 1;
                end;
            end;

            task.delay(0.75, function() -- Line: 142
                -- upvalues: u8 (copy), u9 (copy), u10 (copy)
                for _, descendant in pairs(u8:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u10:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                        descendant.Brightness = 0;
                    end;
                end;
            end);
        end;
    end);
end;