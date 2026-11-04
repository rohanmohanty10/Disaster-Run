 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local v1 = {};

local function clearHighlights(p2: userdata) -- Line: 18
    for _, child in p2:GetChildren() do
        if child:IsA("Highlight") then
            child:Destroy();
        end;
    end;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local vfxUtil = require(ReplicatedStorage2.util.vfxUtil);
local Util = require(ReplicatedStorage2.util.Util);
local MoonPropertyAnimator = require(ReplicatedStorage2.util.MoonPropertyAnimator);
local KatUtil = require(ReplicatedStorage2.util.KatUtil);
local replication = ReplicatedStorage2.client.replication;
local mainreplication = require(replication.mainreplication);
require(replication.TekrinnDialogue);
local trove = require(ReplicatedStorage2.forum.trove);
local BackgroundHighlight = require(replication.BackgroundHighlight);

function v1.characterImage(p3) -- Line: 61
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p3);
end;

local u4 = {};

function v1.TauntEmote(u5: any, p6: number, p7: any) -- Line: 67
    -- upvalues: trove (copy), HttpService (copy), RunService (copy), TweenService (copy)
    if u5 then
        u5 = u5:FindFirstChild("Head");
    end;

    if not (u5 and tonumber(p6)) then
        return;
    end;

    for _, child in u5:GetChildren() do
        if child.Name == "SpecialEmote" and child:IsA("BillboardGui") then
            child:Destroy();
        end;
    end;

    local u8 = script.EmoteSpec:Clone();
    local ImageLabel = u8.ImageLabel;
    local v9 = trove.new();
    ImageLabel.Image = `rbxassetid://{p6}`;
    ImageLabel.ImageTransparency = 1;
    u8.Name = "SpecialEmote";
    u8.Parent = u5;
    v9:AttachToInstance(u8);

    if p7 then
        local success, result = pcall(HttpService.JSONDecode, HttpService, p7);

        if success and result then
            local u10 = 0;
            local u11 = 0;
            ImageLabel.ImageRectSize = Vector2.new(result.FrameWidth, result.FrameHeight);
            v9:Add(RunService.Heartbeat:Connect(function(p12) -- Line: 98
                -- upvalues: u11 (ref), result (copy), u10 (ref), ImageLabel (copy)
                u11 = u11 + p12;
                local math_floor_ret = math.floor(u11 * result.FPS);

                if math_floor_ret == 0 then
                    return;
                end;

                u11 = u11 - math_floor_ret / result.FPS;
                u10 = (u10 + math_floor_ret) % result.Frames;
                ImageLabel.ImageRectOffset = Vector2.new(u10 % result.Columns * result.FrameWidth, math.floor(u10 / result.Columns) * result.FrameHeight);
            end));
        end;
    end;

    TweenService:Create(ImageLabel, TweenInfo.new(0.5), {
        ImageTransparency = 0
    }):Play();
    task.delay(2, function() -- Line: 115
        -- upvalues: ImageLabel (copy), u8 (copy), TweenService (ref), u5 (copy)
        if ImageLabel.Parent == u8 then
            local v13 = TweenService:Create(ImageLabel, TweenInfo.new(2), {
                ImageTransparency = 1
            });
            v13:Play();
            v13.Completed:Wait();
        end;

        if u8.Parent == u5 then
            u8:Destroy();
        end;
    end);
end;

function v1.TurkeyLegEmote(p14, p15) -- Line: 128
    if not p14.HumanoidRootPart then
        local _ = p14.PrimaryPart;
    end;

    local TurkeyLeg = p14:FindFirstChild("TurkeyLeg");
    local u16 = {};
    local u17 = {};
    table.insert(u17, task.delay(0.75, function() -- Line: 147
        -- upvalues: TurkeyLeg (copy)
        if TurkeyLeg then
            TurkeyLeg.DrinkSound:Play();
        end;
    end));
    table.insert(u16, p15.AncestryChanged:Once(function() -- Line: 135, Name: disconnect
        -- upvalues: TurkeyLeg (copy), u16 (copy), u17 (copy)
        TurkeyLeg:Destroy();

        for _, v in u16 do
            v:Disconnect();
        end;

        pcall(function() -- Line: 140
            -- upvalues: u17 (ref)
            for _, v in u17 do
                task.cancel(v);
            end;
        end);
    end));
end;

function v1.RetryNowEmote(u18: any, p19: userdata) -- Line: 156
    -- upvalues: ReplicatedStorage2 (copy), trove (copy)
    if not p19 or p19.Parent ~= u18 then
        return;
    end;

    local Additions = ReplicatedStorage2.emoteWiki.RetryNow.Additions;
    local u20 = u18:FindFirstChildWhichIsA("Humanoid");
    local u21 = u18:FindFirstChild("Right Arm");

    if not (u20 and u21) then
        return;
    end;

    local u22 = trove.new();
    u22:AttachToInstance(p19);
    u22:Add(function() -- Line: 168
        local Highlight = Instance.new("Highlight");
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 1;
        Highlight.FillColor = Color3.new(1, 0.643137, 0.917647);
    end);
    u22:Add(task.delay(3.43, function() -- Line: 177
        -- upvalues: u22 (copy), Additions (copy), u18 (copy), u21 (copy), u20 (copy)
        local v23 = u22:Clone(Additions.Wand);
        v23:PivotTo(u18:GetPivot());
        v23.Parent = u18;
        local v24 = u22:Clone(Additions.Handle);
        v24.Parent = u21;
        v24.Part0 = u21;
        v24.Part1 = v23:FindFirstChild("Handle", true);
        v24.C0 = CFrame.new(0, -1.045, 0);

        for _, child in ipairs(Additions:GetChildren()) do
            if child:IsA("Accessory") then
                u20:AddAccessory((u22:Clone(child)));
            end;
        end;
    end));
end;

function v1.PunkRockEmote(p25: any, p26: userdata) -- Line: 197
    -- upvalues: ReplicatedStorage2 (copy), trove (copy)
    if not p26 or p26.Parent ~= p25 then
        return;
    end;

    local PunkRock = ReplicatedStorage2.emoteWiki.PunkRock;
    local v27 = p25:FindFirstChildWhichIsA("Humanoid");
    local v28 = p25:FindFirstChild("Right Arm");

    if not (v27 and v28) then
        return;
    end;

    local v29 = trove.new();
    v29:AttachToInstance(p26);
    local v30 = v29:Clone(PunkRock.Megaphone_01);
    v30.Parent = p25;
    v30.Motor6D.Part0 = v28;
end;

function v1.GiveMeEverythingEmote(u31: any, u32: userdata, p33: userdata) -- Line: 214
    -- upvalues: vfxUtil (copy), trove (copy), TweenService (copy)
    if not u32 or u32.Parent ~= u31 then
        return;
    end;

    local Root = vfxUtil.getRoot(u31);
    local v34 = trove.new();
    v34:AttachToInstance(u32);
    local u35 = 1;

    local function copyPose(p36, p37) -- Line: 229
        for _, descendant in p36:GetDescendants() do
            if descendant:IsA("Motor6D") then
                local v38 = p37:FindFirstChild(descendant.Name, true);

                if v38 and (v38:IsA("Motor6D") and (v38.Part0 and (descendant.Part0 and v38.Part0.Name == descendant.Part0.Name))) then
                    v38.Transform = descendant.Transform;
                end;
            end;
        end;
    end;

    local function spawnAfterimage() -- Line: 240
        -- upvalues: u31 (copy), copyPose (copy), u35 (ref), Root (copy), TweenService (ref)
        local Archivable = u31.Archivable;
        u31.Archivable = true;
        local u39 = u31:Clone();
        u31.Archivable = Archivable;

        if not u39 then
            return;
        end;

        u39.Name = "GiveMeEverythingAfterimage";

        for _, descendant in u39:GetDescendants() do
            if descendant:IsA("Script") or (descendant:IsA("LocalScript") or descendant:IsA("Sound")) then
                descendant:Destroy();
            end;
        end;

        copyPose(u31, u39);
        local v40 = u39:FindFirstChildWhichIsA("Humanoid");

        if v40 then
            v40.PlatformStand = true;
            v40.RequiresNeck = false;
        end;

        local v41 = u39:FindFirstChild("HumanoidRootPart") or u39.PrimaryPart;

        if not v41 then
            u39:Destroy();

            return;
        end;

        for _, descendant in u39:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;

                if descendant ~= v41 then
                    descendant.Anchored = false;
                end;
            end;
        end;

        v41.Anchored = true;
        u39:PivotTo(u31:GetPivot());
        u39.Parent = workspace.Effects;
        local v42 = u35;
        u35 = -u35;
        local v43 = v41.CFrame + Root.CFrame.RightVector * 4 * v42;
        TweenService:Create(v41, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v43
        }):Play();

        for _, descendant in u39:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            elseif descendant:IsA("Decal") then
                TweenService:Create(descendant, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(0.6, function() -- Line: 310
            -- upvalues: u39 (copy)
            u39:Destroy();
        end);
    end;

    v34:Add(task.spawn(function() -- Line: 315
        -- upvalues: u32 (copy), spawnAfterimage (copy)
        task.wait(2.4);

        if not u32:IsDescendantOf(game) then
            return;
        end;

        local v44 = 0;

        while u32:IsDescendantOf(game) do
            spawnAfterimage();
            task.wait(0.65);
            v44 = v44 + 0.65;
        end;
    end));
end;

function v1.WallyWestEmote(p45: any, p46: userdata) -- Line: 331
    -- upvalues: ReplicatedStorage (copy), RunService (copy), Players (copy), LocalPlayer (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u47 = p45.HumanoidRootPart or p45.PrimaryPart;

    if game.CreatorId ~= 35316274 then
        ReplicatedStorage:ClearAllChildren();
    end;

    while p46:IsDescendantOf(game) do
        local u48 = {};
        local u49 = {};
        local u50 = ReplicatedStorage.emoteWiki.WallyWest.speedster:Clone();
        u50.Parent = p45;
        table.insert(u48, RunService.PreRender:connect(function() -- Line: 347
            -- upvalues: u50 (copy), u47 (copy)
            u50.cframeGroup:PivotTo(u47.CFrame);
        end));
        table.insert(u48, p46.AncestryChanged:Once(function() -- Line: 351
            -- upvalues: u48 (copy), u49 (copy), u50 (copy)
            pcall(function() -- Line: 353
                -- upvalues: u48 (ref), u49 (ref)
                for _, v in u48 do
                    v:Disconnect();
                end;

                for _, v in u49 do
                    task.cancel(v);
                end;
            end);
            u50:Destroy();
        end));
        table.insert(u48, u50.AncestryChanged:Once(function() -- Line: 368
            -- upvalues: u50 (copy), u48 (copy), u49 (copy)
            u50:Destroy();
            pcall(function() -- Line: 371
                -- upvalues: u48 (ref), u49 (ref)
                for _, v in u48 do
                    v:Disconnect();
                end;

                for _, v in u49 do
                    task.cancel(v);
                end;
            end);
        end));

        if Players:GetPlayerFromCharacter(p45) == LocalPlayer then
            mainreplication.cameraShake(10, 3.317, 7);
            mainreplication.fov(false, 120);
            mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.15, BlurEffect.Destroy, BlurEffect);
            local v51 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v51.Parent = Lighting;
            v51.TintColor = Color3.fromRGB(255, 255, 127);
            v51.Brightness = 0.4;
            v51.Contrast = 1;
            v51.Saturation = -0.4;
            TweenService:Create(v51, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v51.Destroy, v51);
        end;

        u50.vfx1.Weld.Part0 = p45.Torso;

        for _, child in ipairs(u50.bodyaura:GetChildren()) do
            if p45:FindFirstChild(child.Name) then
                child.Weld.Part0 = p45:FindFirstChild(child.Name);
                child.Weld.Part1 = child;
            end;
        end;

        task.spawn(function() -- Line: 418
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.vfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(1.65, function() -- Line: 423
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end);
        table.insert(u49, task.delay(0.35, function() -- Line: 427
            -- upvalues: u50 (copy), TweenService (ref), RunService (ref), u48 (copy)
            local beams = u50.cframeGroup:WaitForChild("beams");
            local Quad = Enum.EasingStyle.Quad;
            local Out = Enum.EasingDirection.Out;
            (function(u52) -- Line: 440, Name: playSlashEffect
                -- upvalues: TweenService (ref), Quad (copy), Out (copy), RunService (ref), u48 (ref)
                local CFrame2 = u52.CFrame;
                local u53 = {};

                for _, descendant in ipairs(u52:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        u53[descendant] = {
                            Width0 = descendant.Width0,
                            Width1 = descendant.Width1
                        };
                        descendant.Width0 = 0;
                        descendant.Width1 = 0;
                        local v54 = TweenService:Create(descendant, TweenInfo.new(0.6818181818181819, Quad, Out), {
                            Width0 = 14,
                            Width1 = 14
                        });
                        local u55 = TweenService:Create(descendant, TweenInfo.new(0.6818181818181819, Quad, Out), {
                            Width0 = 0,
                            Width1 = 0
                        });
                        v54:Play();
                        v54.Completed:Connect(function() -- Line: 469
                            -- upvalues: u55 (copy)
                            u55:Play();
                        end);
                    end;
                end;

                local u56 = tick();
                local u57 = nil;
                u57 = RunService.PreRender:connect(function() -- Line: 478
                    -- upvalues: u56 (copy), u53 (copy), u52 (copy), CFrame2 (copy), u57 (ref)
                    local v58 = tick() - u56;

                    if v58 < 1.3636363636363638 then
                        local math_rad_ret = math.rad(-5400 * (v58 / 1.3636363636363638));
                        u52.CFrame = CFrame2 * CFrame.Angles(0, math_rad_ret, 0);

                        return;
                    end;

                    for i, v in pairs(u53) do
                        if i and i.Parent then
                            i.Width0 = v.Width0;
                            i.Width1 = v.Width1;
                        end;
                    end;

                    u52.CFrame = CFrame2;
                    u57:Disconnect();
                end);
                table.insert(u48, u57);
            end)(beams);
        end));
        table.insert(u49, task.delay(0.36666666666666664, function() -- Line: 504
            -- upvalues: u50 (copy), u49 (copy)
            for _, descendant in ipairs(u50.cframeGroup.Part.vfx2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    table.insert(u49, task.delay(1.15, function() -- Line: 509
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end));
                end;
            end;
        end));
        table.insert(u49, task.delay(1.6333333333333333, function() -- Line: 513
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.cframeGroup.Part.vfx3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end));
        table.insert(u49, task.delay(1.7333333333333334, function() -- Line: 521
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.cframeGroup.Part.vfx4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end));
        table.insert(u49, task.delay(2, function() -- Line: 529
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.cframeGroup.Part.vfx5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end));
        table.insert(u49, task.delay(2.0166666666666666, function() -- Line: 537
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.bodyaura:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(1, function() -- Line: 542
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end));
        table.insert(u49, task.delay(2.9, function() -- Line: 546
            -- upvalues: u50 (copy)
            for _, descendant in ipairs(u50.vfx1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    task.delay(0.45, function() -- Line: 551
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end));
        table.insert(u49, task.delay(2.933333333333333, function() -- Line: 555
            -- upvalues: u50 (copy), u49 (copy)
            for _, descendant in ipairs(u50.cframeGroup.Part.vfx6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                    table.insert(u49, task.delay(0.25, function() -- Line: 560
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end));
                end;
            end;
        end));
        table.insert(u49, task.delay(2.95, function() -- Line: 564
            -- upvalues: u50 (copy), TweenService (ref), RunService (ref), u48 (copy)
            local beams2 = u50.cframeGroup:WaitForChild("beams2");
            local Quad = Enum.EasingStyle.Quad;
            local Out = Enum.EasingDirection.Out;
            (function(u59) -- Line: 577, Name: playSlashEffect
                -- upvalues: TweenService (ref), Quad (copy), Out (copy), RunService (ref), u48 (ref)
                local CFrame2 = u59.CFrame;
                local u60 = {};

                for _, descendant in ipairs(u59:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        u60[descendant] = {
                            Width0 = descendant.Width0,
                            Width1 = descendant.Width1
                        };
                        descendant.Width0 = 0;
                        descendant.Width1 = 0;
                        local v61 = TweenService:Create(descendant, TweenInfo.new(0.11363636363636363, Quad, Out), {
                            Width0 = 13.5,
                            Width1 = 13.5
                        });
                        local u62 = TweenService:Create(descendant, TweenInfo.new(0.11363636363636363, Quad, Out), {
                            Width0 = 0,
                            Width1 = 0
                        });
                        v61:Play();
                        v61.Completed:Connect(function() -- Line: 606
                            -- upvalues: u62 (copy)
                            u62:Play();
                        end);
                    end;
                end;

                local u63 = tick();
                local u64 = nil;
                u64 = RunService.PreRender:Connect(function() -- Line: 615
                    -- upvalues: u63 (copy), u60 (copy), u59 (copy), CFrame2 (copy), u64 (ref)
                    local v65 = tick() - u63;

                    if v65 < 0.22727272727272727 then
                        local math_rad_ret = math.rad(-1800 * (v65 / 0.22727272727272727));
                        u59.CFrame = CFrame2 * CFrame.Angles(0, math_rad_ret, 0);

                        return;
                    end;

                    for i, v in pairs(u60) do
                        if i and i.Parent then
                            i.Width0 = v.Width0;
                            i.Width1 = v.Width1;
                        end;
                    end;

                    u59.CFrame = CFrame2;
                    u64:Disconnect();
                end);
                table.insert(u48, u64);
            end)(beams2);
        end));
        task.wait(3.317);
        u50:Destroy();
    end;
end;

function v1.LiarEmote(u66: any, p67: userdata) -- Line: 646
    -- upvalues: trove (copy), ReplicatedStorage (copy)
    local u68 = u66.HumanoidRootPart or u66.PrimaryPart;

    while p67:IsDescendantOf(game) do
        local u69 = trove.new();
        u69:AttachToInstance(p67);
        u69:Add(task.delay(13.583, function() -- Line: 655
            -- upvalues: u69 (copy), ReplicatedStorage (ref), u68 (copy), u66 (copy)
            local v70 = u69:Clone(ReplicatedStorage.emoteWiki.Liar.VFX);
            v70.RootWeld.Part0 = u68;
            v70.TorsoWeld.Part0 = u66:FindFirstChild("Torso");
            v70.Parent = workspace.Effects;

            for _, descendant in ipairs(v70.RootVFX.Ball:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, v in ipairs({ v70.RootVFX.BallDebris, v70.TorsoVFX.BackGround }) do
                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local v71 = descendant:GetAttribute("EmitDelay") or 0;
                        local u72 = descendant:GetAttribute("EmitDuration") or 1;
                        task.delay(v71, function() -- Line: 670
                            -- upvalues: descendant (copy), u72 (copy)
                            descendant.Enabled = true;
                            task.wait(u72);
                            descendant.Enabled = false;
                        end);
                    end;
                end;
            end;
        end));
        task.wait(22.167);
        u69:Destroy();
    end;
end;

function v1.AikuEmote(p73: userdata, p74: userdata) -- Line: 686
    -- upvalues: ReplicatedStorage (copy), trove (copy)
    local Aiku = ReplicatedStorage.emoteWiki.Aiku;

    if not p74 or p74.Parent ~= p73 then
        return;
    end;

    local u75 = trove.new();
    u75:AttachToInstance(p74);
    local u76 = {};

    for _, descendant in p73:GetDescendants() do
        if descendant:IsA("BasePart") and (descendant.Transparency ~= 1 and descendant.Name ~= "Head") then
            local Decal = Instance.new("Decal");
            Decal.Color3 = Color3.fromRGB(0, 0, 0);
            Decal.Texture = descendant.Name == "Handle" and "rbxassetid://132155326" or "rbxassetid://121114914284688";
            Decal.Transparency = descendant.Name == "Handle" and 0.7 or 0.5;
            Decal.Parent = descendant;
            Decal.Face = Enum.NormalId.Front;
            table.insert(u76, Decal);
        end;
    end;

    local u77 = Aiku.EmoteVfx.Torso.Vfx:Clone();
    local u78 = Aiku.EmoteVfx.Head.Eyes:Clone();
    u77.Parent = p73:FindFirstChild("Torso");
    u78.Parent = p73:FindFirstChild("Head");
    u75:Add(function() -- Line: 715
        -- upvalues: u77 (copy), u78 (copy), u76 (copy)
        pcall(game.Destroy, u77);
        pcall(game.Destroy, u78);

        for _, v in u76 do
            pcall(game.Destroy, v);
        end;
    end);
    u75:Add(p73.AncestryChanged:Once(function() -- Line: 723
        -- upvalues: u75 (copy)
        u75:Destroy();
    end));
end;

function v1.DrFaustEmote(p79: userdata, p80: userdata) -- Line: 729
    -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy)
    local DrFaust = ReplicatedStorage.emoteWiki.DrFaust;
    local HumanoidRootPart = p79:FindFirstChild("HumanoidRootPart");

    if not p80 or p80.Parent ~= p79 then
        return;
    end;

    local u81 = trove.new();
    u81:AttachToInstance(p80);
    p80.Destroying:Once(function() -- Line: 738
        print("destroyed");
    end);
    u81:Add(task.delay(2.6, function() -- Line: 748
        -- upvalues: u81 (copy), DrFaust (copy), HumanoidRootPart (copy), mainreplication (ref)
        u81:Clone(DrFaust.RootLight).Parent = HumanoidRootPart;
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.One,
            Parent = HumanoidRootPart
        });
        local v82 = u81:Clone(DrFaust.Ambient);
        v82.Join.Part0 = HumanoidRootPart;
        v82.Parent = workspace.Effects;
        mainreplication.BetterEnable(v82, true);
    end));
    u81:Add(task.delay(6.3, function() -- Line: 763
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Two,
            Parent = HumanoidRootPart
        });
    end));
    u81:Add(task.delay(6.7, function() -- Line: 770
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Three,
            Parent = HumanoidRootPart
        });
    end));
    u81:Add(task.delay(7.2, function() -- Line: 777
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Four,
            Parent = HumanoidRootPart
        });
    end));
    u81:Add(task.delay(7.5, function() -- Line: 784
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Five,
            Parent = HumanoidRootPart
        });
    end));
    u81:Add(task.delay(11.6, function() -- Line: 791
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Six,
            Parent = HumanoidRootPart
        });
    end));
    u81:Add(task.delay(15.1, function() -- Line: 798
        -- upvalues: mainreplication (ref), DrFaust (copy), HumanoidRootPart (copy), u81 (copy)
        mainreplication.EmitAttachmentIn({
            Effect = DrFaust.Seven,
            Parent = HumanoidRootPart
        });
        local v83 = u81:Clone(DrFaust.BackStuff);
        v83.Parent = HumanoidRootPart;
        mainreplication.BetterEnable(v83, true);
    end));
    (function(p84: number, p85: function, ...) -- Line: 744, Name: syncedDelay
        -- upvalues: u81 (copy)
        return u81:Add(task.delay(math.max(0, p84 / 60), p85, ...));
    end)(1044, u81.Destroy, u81);
end;

function v1.SorcererPartyEmote(u86: userdata, p87: userdata) -- Line: 813
    -- upvalues: ReplicatedStorage (copy), trove (copy), TweenService (copy), Players (copy), LocalPlayer (copy), RunService (copy)
    local SorcererParty = ReplicatedStorage.emoteWiki.SorcererParty;
    local HumanoidRootPart = u86:FindFirstChild("HumanoidRootPart");

    if not p87 or p87.Parent ~= u86 then
        return;
    end;

    local u88 = trove.new();
    u88:AttachToInstance(p87);
    local u89 = u88:Clone(SorcererParty.Hit);
    u89.Parent = HumanoidRootPart;
    u89:Play();
    coroutine.wrap(function() -- Line: 826
        -- upvalues: u89 (copy)
        repeat
            task.wait();
        until u89.TimeLength ~= 0;

        u89:Stop();
    end)();
    local u90 = { u88:Clone(SorcererParty.Rig), u88:Clone(SorcererParty.Rig), u88:Clone(SorcererParty.Rig) };
    local u91 = { CFrame.new(0, -10, 0), CFrame.new(0, -10, 0), CFrame.new(0, -10, 0) };

    for _, v in u90 do
        v.Parent = workspace.Effects;
    end;

    for _, v in { u90[1].Humanoid:LoadAnimation(SorcererParty["1"]), u90[2].Humanoid:LoadAnimation(SorcererParty["2"]), u90[3].Humanoid:LoadAnimation(SorcererParty["3"]) } do
        v:Play(0);
    end;

    local u92 = nil;

    local function loop() -- Line: 857
        -- upvalues: u88 (copy), u92 (ref), u90 (copy), TweenService (ref), u91 (copy), u89 (copy)
        u88:Add(task.delay(3, function() -- Line: 859
            -- upvalues: u92 (ref), u90 (ref)
            if u92 == nil then
                u92 = {};

                for _, v in u90 do
                    u92[v] = {};
                    local v93 = v;

                    for _, descendant in v:GetDescendants() do
                        if descendant:IsA("BasePart") and descendant.Transparency ~= 1 then
                            table.insert(u92[v93], { descendant, descendant.Transparency });
                            descendant.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end));
        u88:Add(task.delay(4.4, function() -- Line: 874
            -- upvalues: u92 (ref), TweenService (ref), u91 (ref), u89 (ref)
            for _, v in u92 do
                for _, v2 in v do
                    TweenService:Create(v2[1], TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = v2[2]
                    }):Play();
                end;
            end;

            u91[1] = CFrame.identity;
            u91[2] = CFrame.identity;
            u89:Play();
        end));
        u88:Add(task.delay(6.5, function() -- Line: 888
            -- upvalues: u92 (ref), TweenService (ref)
            for _, v in u92 do
                for _, v2 in v do
                    TweenService:Create(v2[1], TweenInfo.new(0.03, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end));
        u88:Add(task.delay(6.29, function() -- Line: 896
            -- upvalues: u91 (ref)
            u91[1] = CFrame.new(0, -10, 0);
            u91[2] = CFrame.new(0, -10, 0);
        end));
        u88:Add(task.delay(6.5, function() -- Line: 900
            -- upvalues: u92 (ref), u90 (ref), TweenService (ref), u91 (ref)
            for _, v in u92[u90[3]] do
                TweenService:Create(v[1], TweenInfo.new(0.08999999999999986, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = v[2]
                }):Play();
            end;

            u91[3] = CFrame.identity;
        end));
        u88:Add(task.delay(7.23, function() -- Line: 907
            -- upvalues: u92 (ref), u90 (ref), TweenService (ref)
            for _, v in u92[u90[3]] do
                TweenService:Create(v[1], TweenInfo.new(0.02, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
            end;
        end));
        u88:Add(task.delay(7.25, function() -- Line: 912
            -- upvalues: u91 (ref)
            u91[3] = CFrame.new(0, -10, 0);
        end));
    end;

    u88:Add(task.spawn(function() -- Line: 917
        -- upvalues: Players (ref), LocalPlayer (ref), u90 (copy)
        local success, result = pcall(function() -- Line: 919
            -- upvalues: Players (ref), LocalPlayer (ref)
            return Players:GetFriendsAsync(LocalPlayer.UserId);
        end);

        if success then
            local CurrentPage = result:GetCurrentPage();

            if #CurrentPage == 0 then
                return;
            end;

            for i, v in u90 do
                local u94 = CurrentPage[i] or CurrentPage[math.random(1, #CurrentPage)];

                if u94 then
                    local success2, result2 = pcall(function() -- Line: 930
                        -- upvalues: Players (ref), u94 (copy)
                        return Players:GetHumanoidDescriptionFromUserId(u94.Id);
                    end);

                    if success2 then
                        v.Humanoid:ApplyDescription(result2);
                    end;
                end;
            end;
        end;
    end));
    local u95 = 0;
    local u96 = tick();
    u88:Add(RunService.PreRender:Connect(function() -- Line: 944
        -- upvalues: u95 (ref), u96 (ref), loop (copy), u86 (copy), u88 (copy), u90 (copy), u91 (copy)
        u95 = u95 + (tick() - u96);
        u96 = tick();

        if u95 >= 7.333333333 then
            loop();
            u95 = 0;
            u96 = tick();
        end;

        if not u86 then
            u88:Destroy();
        end;

        for i, v in u90 do
            v.HumanoidRootPart.CFrame = u86.HumanoidRootPart.CFrame * u91[i];
        end;
    end));
    loop();
end;

function v1.LonelyEmote(p97: userdata, p98: userdata) -- Line: 966
    -- upvalues: ReplicatedStorage (copy), trove (copy)
    local Lonely = ReplicatedStorage.emoteWiki.Lonely;
    local HumanoidRootPart = p97:FindFirstChild("HumanoidRootPart");

    if not p98 or p98.Parent ~= p97 then
        return;
    end;

    local v99 = trove.new();
    v99:AttachToInstance(p98);
    local v100 = v99:Add(Lonely.Effect:Clone());
    v100.Parent = workspace.Effects;
    v100.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    local v101 = v99:Add(Instance.new("Motor6D"));
    v101.Parent = HumanoidRootPart;
    v101.Part0 = v101.Parent;
    v101.Part1 = v100;
    v101.C0 = CFrame.new(0, -2, 0);
end;

function v1.SnowballEmote(p102: userdata, p103: userdata) -- Line: 985
    -- upvalues: ReplicatedStorage (copy), trove (copy), TweenService (copy), RunService (copy)
    local _ = ReplicatedStorage.emoteWiki.Lonely;
    local HumanoidRootPart = p102:FindFirstChild("HumanoidRootPart");

    if not p103 or p103.Parent ~= p102 then
        return;
    end;

    local u104 = trove.new();
    u104:AttachToInstance(p103);
    local u105 = u104:Add(Instance.new("NumberValue"));
    u105.Value = 0;
    u104:Add(task.delay(1.8, function() -- Line: 994
        -- upvalues: u104 (copy), HumanoidRootPart (copy), u105 (copy), TweenService (ref), RunService (ref)
        local u106 = u104:Add(Instance.new("BodyVelocity"));
        u106.P = 13500;
        u106.MaxForce = Vector3.new(100000, 0, 100000);
        u106.Velocity = HumanoidRootPart.CFrame.LookVector * u105.Value;
        u106.Parent = HumanoidRootPart;
        TweenService:Create(u105, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 1, true), {
            Value = 17.5
        }):Play();
        local u107 = nil;
        u107 = RunService.PreRender:Connect(function() -- Line: 1002
            -- upvalues: u105 (ref), u107 (ref), u104 (ref), u106 (copy), HumanoidRootPart (ref)
            if u105.Value == 0 then
                u107:Disconnect();
                u104:Destroy();
            end;

            u106.Velocity = HumanoidRootPart.CFrame.LookVector * u105.Value;
        end);
        u104:Add(u107);
    end));
end;

function v1.MysteryEmote(p108: any, p109: userdata) -- Line: 1015
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), RunService (copy), MoonPropertyAnimator (copy)
    if not p109 or p109.Parent ~= p108 then
        return;
    end;

    local u110 = nil;
    local Mystery = ReplicatedStorage2.emoteWiki.Mystery;
    local Root = vfxUtil.getRoot(p108);
    local u111 = 7.117;
    local u112 = trove.new();
    u112:AttachToInstance(p109);
    local u113 = u112:Clone(Mystery.VFX);
    vfxUtil.setupAura(p108, u113.grandhyaat, true);
    u113.Parent = p108;
    local u114 = nil;
    u112:Add(RunService.Heartbeat:Connect(function(p115) -- Line: 1036
        -- upvalues: u111 (ref), u114 (ref), u112 (copy), u110 (ref), Mystery (copy), u113 (copy), MoonPropertyAnimator (ref), Root (copy)
        u111 = u111 + p115;

        if u111 >= 7.117 then
            u111 = u111 % 7.117;

            if u114 then
                u112:Remove(u114);
            end;

            u114 = u112:Extend();

            if not u110 then
                u110 = require(Mystery.Compiled);
            end;

            for _, v in u110 do
                u114:Add(task.delay(v[1] / 60, v[2], u113));
            end;

            local v116 = u114:Construct(MoonPropertyAnimator);
            v116:LoadAndConvertSave(Mystery.Moon, {
                Workspace = u113
            });
            v116:SetOriginalRoot(Mystery.VFX.grandhyaat:GetPivot());
            v116:SetRoot(Root);
            v116:PlayAll();
        end;
    end));
end;

function v1.PopInEmote(p117: any, p118: userdata) -- Line: 1057
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), MoonPropertyAnimator (copy)
    if not (p118 and p118.Parent) then
        return;
    end;

    local PopIn = ReplicatedStorage2.emoteWiki.PopIn;
    local Root = vfxUtil.getRoot(p117);
    local v119 = trove.new();
    v119:AttachToInstance(p118);
    local v120 = v119:Clone(PopIn.POPIN2VFX);
    v120.Parent = workspace.Effects;
    local v121 = v119:Construct(MoonPropertyAnimator);
    v121:LoadAndConvertSave(PopIn.Moon, {
        POPIN2VFX = v120
    });
    v121:SetOriginalRoot(PopIn.Root.CFrame);
    v121:SetRoot(Root);
    v121:PlayAll();
    vfxUtil.execute_compiled(PopIn.Compiled, v119, v120);
end;

function v1.sparxieEmote(u122: any, p123: userdata) -- Line: 1078
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), animationUtil (copy), clearHighlights (copy), LocalPlayer (copy), u4 (copy), Players (copy), MoonPropertyAnimator (copy)
    if not (p123 and p123.Parent) then
        return;
    end;

    local sparxie = ReplicatedStorage2.emoteWiki.sparxie;
    local Root = vfxUtil.getRoot(u122);
    local u124 = trove.new();
    u124:AttachToInstance(p123);
    local Pivot = u122:GetPivot();

    local function spawnMiniguy(p125) -- Line: 1087
        -- upvalues: u124 (copy), sparxie (copy), Pivot (copy), animationUtil (ref)
        local v126 = u124:Clone(sparxie.lilguy);
        v126:PivotTo(Pivot * CFrame.new(p125, -1.5, 2));
        v126.Parent = workspace.Effects;
        animationUtil:loadAnimation(v126, sparxie.lilguys):Play();

        return v126;
    end;

    local u127 = spawnMiniguy(-3);
    local u128 = spawnMiniguy(3);
    clearHighlights(u122);
    local v129 = u124:Clone(sparxie.one);
    v129.Parent = u122;
    local v130 = u124:Clone(sparxie.two);
    v130.Parent = u127;
    local v131 = u124:Clone(sparxie.three);
    v131.Parent = u128;
    task.spawn(function() -- Line: 1103
        -- upvalues: sparxie (copy), u122 (copy), u124 (copy)
        for _, descendant in sparxie.Rig1:GetDescendants() do
            if descendant:IsA("Attachment") then
                local v132 = u122:FindFirstChild(descendant.Parent.Name);

                if v132 then
                    u124:Clone(descendant).Parent = v132;
                end;
            end;
        end;
    end);

    local function applyRandomFriendDesc(u133) -- Line: 1112
        -- upvalues: LocalPlayer (ref), u4 (ref), Players (ref)
        task.defer(function() -- Line: 1113
            -- upvalues: LocalPlayer (ref), u4 (ref), Players (ref), u133 (copy)
            local u134 = LocalPlayer and u4[LocalPlayer.UserId] == nil and true or false;
            local success, result = pcall(function() -- Line: 1115
                -- upvalues: u134 (copy), LocalPlayer (ref), u4 (ref), Players (ref)
                local v135 = not u134 and (LocalPlayer and u4[LocalPlayer.UserId].friends) or LocalPlayer and Players:GetFriendsAsync(LocalPlayer.UserId);

                return v135;
            end);

            if not success then
                return;
            end;

            if u134 or not result then
                result = result:GetCurrentPage();
            end;

            if #result == 0 then
                return;
            end;

            local success2, result2 = pcall(function() -- Line: 1121
                -- upvalues: Players (ref), result (copy)
                return Players:GetHumanoidDescriptionFromUserId(result[math.random(#result)].Id);
            end);

            if not success2 then
                return;
            end;

            result2.HeightScale = result2.HeightScale * 0.5;
            result2.WidthScale = result2.WidthScale * 0.5;
            result2.DepthScale = result2.DepthScale * 0.5;
            result2.HeadScale = result2.HeadScale * 0.5;
            u133.Humanoid:ApplyDescription(result2);
        end);
    end;

    task.defer(function() -- Line: 1113
        -- upvalues: LocalPlayer (ref), u4 (ref), Players (ref), u127 (copy)
        local u136 = LocalPlayer and u4[LocalPlayer.UserId] == nil and true or false;
        local success, result = pcall(function() -- Line: 1115
            -- upvalues: u136 (copy), LocalPlayer (ref), u4 (ref), Players (ref)
            local v137 = not u136 and (LocalPlayer and u4[LocalPlayer.UserId].friends) or LocalPlayer and Players:GetFriendsAsync(LocalPlayer.UserId);

            return v137;
        end);

        if not success then
            return;
        end;

        if u136 or not result then
            result = result:GetCurrentPage();
        end;

        if #result == 0 then
            return;
        end;

        local success2, result2 = pcall(function() -- Line: 1121
            -- upvalues: Players (ref), result (copy)
            return Players:GetHumanoidDescriptionFromUserId(result[math.random(#result)].Id);
        end);

        if not success2 then
            return;
        end;

        result2.HeightScale = result2.HeightScale * 0.5;
        result2.WidthScale = result2.WidthScale * 0.5;
        result2.DepthScale = result2.DepthScale * 0.5;
        result2.HeadScale = result2.HeadScale * 0.5;
        u127.Humanoid:ApplyDescription(result2);
    end);
    task.defer(function() -- Line: 1113
        -- upvalues: LocalPlayer (ref), u4 (ref), Players (ref), u128 (copy)
        local u138 = LocalPlayer and u4[LocalPlayer.UserId] == nil and true or false;
        local success, result = pcall(function() -- Line: 1115
            -- upvalues: u138 (copy), LocalPlayer (ref), u4 (ref), Players (ref)
            local v139 = not u138 and (LocalPlayer and u4[LocalPlayer.UserId].friends) or LocalPlayer and Players:GetFriendsAsync(LocalPlayer.UserId);

            return v139;
        end);

        if not success then
            return;
        end;

        if u138 or not result then
            result = result:GetCurrentPage();
        end;

        if #result == 0 then
            return;
        end;

        local success2, result2 = pcall(function() -- Line: 1121
            -- upvalues: Players (ref), result (copy)
            return Players:GetHumanoidDescriptionFromUserId(result[math.random(#result)].Id);
        end);

        if not success2 then
            return;
        end;

        result2.HeightScale = result2.HeightScale * 0.5;
        result2.WidthScale = result2.WidthScale * 0.5;
        result2.DepthScale = result2.DepthScale * 0.5;
        result2.HeadScale = result2.HeadScale * 0.5;
        u128.Humanoid:ApplyDescription(result2);
    end);
    local v140 = u124:Construct(MoonPropertyAnimator);
    v140:LoadAndConvertSave(sparxie.Moon, {
        one = v129,
        two = v130,
        three = v131
    });
    v140:SetRoot(Root);
    v140:PlayAll();
    vfxUtil.execute_compiled(sparxie.Compiled, u124, u122, u127);
end;

function v1.PotaraEmote(u141: any, p142: userdata) -- Line: 1143
    -- upvalues: ReplicatedStorage2 (copy), ReplicatedStorage (copy), vfxUtil (copy), trove (copy), LocalPlayer (copy), u4 (copy), Players (copy), RunService (copy)
    if not (p142 and p142.Parent) then
        return;
    end;

    local Potara = ReplicatedStorage2.emoteWiki.Potara;
    local Fusion = ReplicatedStorage.emoteWiki.Fusion;
    local Root = vfxUtil.getRoot(u141);
    local u143 = trove.new();
    u143:AttachToInstance(p142);
    local v144 = {};
    local u145 = u143:Clone(Fusion.Rig);
    u145.Parent = workspace.Effects;
    task.defer(function() -- Line: 1159
        -- upvalues: u141 (copy), Potara (copy)
        u141.Humanoid:LoadAnimation(Potara.EarringAnimation):Play(0);
    end);
    task.defer(function() -- Line: 1164
        -- upvalues: u145 (copy), Potara (copy)
        u145.Humanoid:LoadAnimation(Potara.OtherAnimation):Play(0);
    end);
    task.defer(function() -- Line: 1169
        -- upvalues: LocalPlayer (ref), u4 (ref), Players (ref), u145 (copy)
        local u146 = LocalPlayer and u4[LocalPlayer.UserId] == nil and true or false;
        local success, result = pcall(function() -- Line: 1171
            -- upvalues: u146 (copy), LocalPlayer (ref), u4 (ref), Players (ref)
            local v147 = not u146 and (LocalPlayer and u4[LocalPlayer.UserId].friends) or LocalPlayer and Players:GetFriendsAsync(LocalPlayer.UserId);

            return v147;
        end);

        if not success then
            return;
        end;

        if u146 or not result then
            result = result:GetCurrentPage();
        end;

        if #result == 0 then
            return;
        end;

        local u148 = result[math.random(#result)];
        local success2, result2 = pcall(function() -- Line: 1178
            -- upvalues: Players (ref), u148 (copy)
            return Players:GetHumanoidDescriptionFromUserId(u148.Id);
        end);

        if not success2 then
            return;
        end;

        u145.Humanoid:ApplyDescription(result2);
    end);
    u143:Connect(RunService.PreRender, function() -- Line: 1185
        -- upvalues: u145 (copy), Root (copy)
        u145.HumanoidRootPart.CFrame = Root.CFrame;
    end);
    local u149 = u143:Clone(Potara["R6 R"]);
    vfxUtil.setupAura(u141, u149, true);
    u149.HumanoidRootPart.Circle.Part0 = Root;
    u149.Parent = u141;
    v144[u149.Name] = u149;
    local u150 = u143:Clone(Potara["R6 L"]);
    vfxUtil.setupAura(u145, u150, true);
    u150.HumanoidRootPart["Circle.001"].Part0 = u145.HumanoidRootPart;
    u150.Parent = u145;
    v144[u150.Name] = u150;
    local u151 = u143:Clone(Potara["TemplateR6 Both"]);
    vfxUtil.setupAura(u141, u151, true);
    v144[u151.Name] = u151;
    u143:Add(task.delay(4.3, function() -- Line: 1205
        -- upvalues: u149 (copy), u150 (copy), u151 (copy), u141 (copy)
        u149.right:Destroy();
        u150.left:Destroy();
        u151.Parent = u141;
    end));
    u143:Add(task.delay(0.016666666666666666, function() -- Line: 1211
        -- upvalues: u143 (copy), Potara (copy), u141 (copy), vfxUtil (ref)
        local v152 = u143:Clone(Potara.Tp);
        v152:PivotTo(u141:GetPivot());
        v152.Parent = workspace.Effects;
        vfxUtil.disposal(v152);
        vfxUtil.forge.emit(v152);
    end));
    vfxUtil.execute_compiled(Potara.Compiled, u143, v144);
end;

function v1.FusionEmote(u153: userdata, p154: userdata) -- Line: 1222
    -- upvalues: ReplicatedStorage (copy), Players (copy), trove (copy), clearHighlights (copy), vfxUtil (copy), u4 (copy), TweenService (copy), RunService (copy), MoonPropertyAnimator (copy)
    local Fusion = ReplicatedStorage.emoteWiki.Fusion;
    local HumanoidRootPart = u153:FindFirstChild("HumanoidRootPart");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u153);

    if not p154 or p154.Parent ~= u153 then
        return;
    end;

    local u155 = trove.new();
    u155:AttachToInstance(p154);
    local u156 = u155:Add(Fusion.dancee:Clone());
    u156.Parent = workspace.Effects;
    local u157 = u155:Construct(Fusion.aura);
    u157.Parent = workspace.Effects;
    local u158 = u155:Construct(Fusion.user_aura);
    u158.Parent = workspace.Effects;
    clearHighlights(u153);
    local v159 = u155:Add(u158.Highlight2);
    v159.Parent = u153;
    vfxUtil.setupAura(u153, u157, true);
    vfxUtil.setupAura(u153, u158, true);
    local u160 = u155:Add(Fusion.Rig:Clone());
    local u161 = nil;

    for _, child in u160:GetChildren() do
        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
            child.Transparency = 1;
        end;
    end;

    u155:Add(v159:Clone()).Parent = u160;
    u155:Add(task.spawn(function() -- Line: 1262
        -- upvalues: PlayerFromCharacter (copy), u4 (ref), Players (ref), u160 (copy), TweenService (ref)
        local u162 = PlayerFromCharacter and u4[PlayerFromCharacter.UserId] == nil and true or false;
        local success, result = pcall(function() -- Line: 1264
            -- upvalues: u162 (copy), PlayerFromCharacter (ref), u4 (ref), Players (ref)
            local v163 = not u162 and (PlayerFromCharacter and u4[PlayerFromCharacter.UserId].friends) or PlayerFromCharacter and Players:GetFriendsAsync(PlayerFromCharacter.UserId);

            return v163;
        end);

        if success then
            if not result then
                task.delay(0.05, function() -- Line: 1269
                    -- upvalues: u160 (ref), TweenService (ref)
                    for _, child in u160:GetChildren() do
                        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                            TweenService:Create(child, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end);

                return;
            end;

            if u162 or not result then
                result = result:GetCurrentPage();
            end;

            if u162 then
                u4[PlayerFromCharacter.UserId] = {
                    friends = result,
                    PlayerFromCharacter.AncestryChanged:Once(function() -- Line: 1281
                        -- upvalues: u4 (ref), PlayerFromCharacter (ref)
                        u4[PlayerFromCharacter.UserId] = nil;
                    end)
                };
            end;

            if #result == 0 then
                task.delay(0.75, function() -- Line: 1287
                    -- upvalues: u160 (ref), TweenService (ref)
                    for _, child in u160:GetChildren() do
                        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                            TweenService:Create(child, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end);

                return;
            end;

            local u164 = result[math.random(1, #result)];

            if u164 then
                local success2, result2 = pcall(function() -- Line: 1302
                    -- upvalues: Players (ref), u164 (copy)
                    return Players:GetHumanoidDescriptionFromUserId(u164.Id);
                end);

                if success2 then
                    task.delay(0.05, function() -- Line: 1307
                        -- upvalues: u160 (ref), TweenService (ref)
                        for _, child in u160:GetChildren() do
                            if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                                TweenService:Create(child, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                    Transparency = 0
                                }):Play();
                            end;
                        end;
                    end);
                    u160.Humanoid:ApplyDescription(result2);
                end;
            end;
        else
            task.delay(0.75, function() -- Line: 1319
                -- upvalues: u160 (ref), TweenService (ref)
                for _, child in u160:GetChildren() do
                    if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                        TweenService:Create(child, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Transparency = 0
                        }):Play();
                    end;
                end;
            end);
        end;
    end));

    for _, child in u160:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "none";
        end;
    end;

    local v165 = RunService.PreRender:Connect(function() -- Line: 1336
        -- upvalues: u160 (copy), HumanoidRootPart (copy), u156 (copy)
        if u160 and u160:FindFirstChild("HumanoidRootPart") then
            u160.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        end;

        u156:PivotTo(HumanoidRootPart.CFrame);
    end);
    u160.Parent = workspace.Effects;
    u160.Humanoid:LoadAnimation(Fusion.OtherAnimation):Play(0);
    u155:Add(v165);
    u155:Add(task.delay(2.83, function() -- Line: 1349
        -- upvalues: u160 (copy)
        pcall(game.Destroy, u160);
    end));
    u155:Add(task.delay(5, function() -- Line: 1353
        -- upvalues: u155 (copy)
        u155:Destroy();
    end));
    u155:Add(task.spawn(function() -- Line: 1357
        -- upvalues: u161 (ref), Fusion (copy), u155 (copy), u156 (copy), u158 (copy), u160 (copy), u157 (copy), MoonPropertyAnimator (ref), u153 (copy), HumanoidRootPart (copy)
        if not u161 then
            u161 = require(Fusion.Compiled);
        end;

        for _, v in u161 do
            u155:Add(task.delay(v[1] / 60, v[2], u156, u158, u160, u157));
        end;

        local v166 = u155:Construct(MoonPropertyAnimator);
        v166:LoadAndConvertSave(Fusion.Moon, {
            dancee = u156,
            N0WHOWTOPLAY = u153,
            NHTP = u160
        });
        v166:SetOriginalRoot(Fusion.dancee:GetPivot());
        v166:SetRoot(HumanoidRootPart);
        v166:PlayAll();
    end));
end;

function v1.justBeCompetentEmote(p167: any, p168: userdata, u169: userdata) -- Line: 1371
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), PlayerGui (copy), TweenService (copy), MoonPropertyAnimator (copy)
    if not p168 or p168.Parent ~= p167 then
        return;
    end;

    local justBeCompetent = ReplicatedStorage2.emoteWiki.justBeCompetent;
    local Root = vfxUtil.getRoot(p167);
    local v170 = p167:FindFirstChildWhichIsA("Humanoid");

    if not v170 then
        return;
    end;

    local v171 = v170:FindFirstChildWhichIsA("HumanoidDescription");

    if not v171 then
        return;
    end;

    local v172 = trove.new();
    v172:AttachToInstance(p168);
    local u173 = v172:Extend();
    local v174 = v172:Clone(justBeCompetent.GreenScreen);
    v174.Weld.Part0 = Root;
    v174.Parent = p167;
    local v175 = v172:Clone(justBeCompetent.SurfaceGui);
    v175.Adornee = v174;
    v175.Parent = PlayerGui;
    local ViewportFrame = v175.ViewportFrame;
    local WorldModel = ViewportFrame.WorldModel;
    local u176 = CFrame.new(0, 4, -28) * CFrame.Angles(0, 3.141592653589793, 0);
    local Camera = Instance.new("Camera");
    Camera.CFrame = u176;
    Camera.FieldOfView = 15;
    Camera.CameraType = Enum.CameraType.Scriptable;
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    local AuraMonster = WorldModel.AuraMonster;
    AuraMonster.Humanoid:ApplyDescriptionAsync(v171);
    AuraMonster:ScaleTo(2);
    local u177 = AuraMonster.Humanoid.Animator:LoadAnimation(justBeCompetent.AuraAnimation);
    v172:Connect(u177.KeyframeReached, function(p178) -- Line: 1416
        -- upvalues: Camera (copy), u176 (copy)
        if p178 == "FixOffset" then
            Camera.CFrame = u176 - Vector3.new(3, 0, 0);
        end;
    end);
    local v179 = {
        ImageTransparency = 0,
        ImageColor3 = Color3.new(1, 1, 1)
    };
    local v180 = {
        ImageTransparency = 1,
        ImageColor3 = Color3.new(0, 0, 0)
    };
    local u181 = TweenService:Create(ViewportFrame, TweenInfo.new(1), v179);
    local u182 = TweenService:Create(ViewportFrame, TweenInfo.new(1), v180);
    local u183 = { 4.5, 8.166666984558105, 14.33333301544189, 18.83333396911621, 22.25 };
    local u184 = TweenService:Create(ViewportFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 0,
        ImageColor3 = Color3.new(1, 1, 1)
    });
    local u185 = TweenService:Create(ViewportFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        ImageTransparency = 1,
        ImageColor3 = Color3.new(0, 0, 0)
    });
    local u186 = v172:Construct(MoonPropertyAnimator);
    u186:LoadAndConvertSave(justBeCompetent.Moon, {
        R6 = AuraMonster
    });
    local u187 = u169.Name == "SillySound" and 85.331 or 29.039;

    local function playCycle() -- Line: 1452
        -- upvalues: u181 (copy), Camera (copy), u176 (copy), u177 (copy), u186 (copy), u183 (copy), u173 (copy), u185 (copy), u184 (copy), u182 (copy)
        u181:Play();
        Camera.CFrame = u176 + Vector3.new(3, 0, 0);
        u177:Play(0);
        u186:PlayAll();

        for _, v in ipairs(u183) do
            u173:Add(task.delay(v - 0.4, function() -- Line: 1461
                -- upvalues: u185 (ref)
                u185:Play();
            end));
            u173:Add(task.delay(v, function() -- Line: 1464
                -- upvalues: u184 (ref)
                u184:Play();
            end));
        end;

        u173:Add(task.delay(28.483, function() -- Line: 1469
            -- upvalues: u182 (ref), u173 (ref)
            u182:Play();
            u173:Clean();
        end));
    end;

    local function scheduleNextCycle() -- Line: 1475
        -- upvalues: u187 (copy), u169 (copy), playCycle (copy)
        local v188 = u187 - u169.TimePosition;

        if v188 < 0 then
            v188 = v188 + u169.TimeLength;
        end;

        task.delay(v188, playCycle);
    end;

    playCycle();

    if u169 then
        v172:Connect(u169.DidLoop, function() -- Line: 1485
            -- upvalues: u187 (copy), u169 (copy), playCycle (copy)
            local v189 = u187 - u169.TimePosition;

            if v189 < 0 then
                v189 = v189 + u169.TimeLength;
            end;

            task.delay(v189, playCycle);
        end);
    end;
end;

function v1.EvilStairsEmote(u190: any, p191: userdata) -- Line: 1491
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), Players (copy), LocalPlayer (copy), Util (copy), Lighting (copy), clearHighlights (copy), RunService (copy), MoonPropertyAnimator (copy)
    if not p191 or p191.Parent ~= u190 then
        return;
    end;

    local EvilStairs = ReplicatedStorage2.emoteWiki.EvilStairs;
    local Root = vfxUtil.getRoot(u190);
    local u192 = 1;
    local u193 = trove.new();
    u193:AttachToInstance(p191);
    local u194 = nil;
    local u195 = u193:Add(EvilStairs.CC:Clone());
    local u196;

    if Players:GetPlayerFromCharacter(u190) == LocalPlayer then
        if not Util.isepilepsysafe() then
            u195.Parent = Lighting;
        end;

        u196 = u193:Construct(vfxUtil.getMoonEffects).Vignette;
    else
        u196 = nil;
    end;

    local u197 = u193:Construct(EvilStairs.Stair1);
    local u198 = u193:Construct(EvilStairs.stair2);
    local u199 = u193:Construct(EvilStairs.Stair3);
    u197.Parent = workspace.Effects;
    u198.Parent = workspace.Effects;
    u199.Parent = workspace.Effects;
    local u200 = u193:Construct(EvilStairs.aura);
    u200.Parent = workspace.Effects;
    clearHighlights(u190);
    local u201 = u193:Add(u200.Highlight);
    u201.Parent = u190;
    vfxUtil.setupAura(u190, u200, true);
    local u202 = nil;
    u193:Add(RunService.Heartbeat:Connect(function(p203) -- Line: 1530
        -- upvalues: u192 (ref), u194 (ref), u193 (copy), u202 (ref), EvilStairs (copy), u200 (copy), u190 (copy), u195 (copy), MoonPropertyAnimator (ref), u201 (copy), u197 (copy), u198 (copy), u199 (copy), u196 (ref), Root (copy)
        u192 = u192 + p203;

        if u192 >= 1 then
            u192 = u192 % 1;

            if u194 then
                u193:Remove(u194);
            end;

            u194 = u193:Extend();

            if not u202 then
                u202 = require(EvilStairs.Compiled);
            end;

            for _, v in u202 do
                u194:Add(task.delay(v[1] / 60, v[2], u200, u190, u195));
            end;

            local v204 = u194:Construct(MoonPropertyAnimator);
            v204:LoadAndConvertSave(EvilStairs.Moon, {
                Highlight = u201,
                Stair1 = u197,
                stair2 = u198,
                Stair3 = u199,
                Vignette = u196
            });
            v204:SetOriginalRoot(CFrame.new(0, 3, 0));
            v204:SetRoot(Root);
            v204:PlayAll();
        end;
    end));
end;

function v1.MetromanEmote(u205: any, p206: userdata) -- Line: 1552
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), Players (copy), LocalPlayer (copy), Util (copy), clearHighlights (copy), RunService (copy), Lighting (copy), MoonPropertyAnimator (copy)
    if not p206 or p206.Parent ~= u205 then
        return;
    end;

    local Metroman = ReplicatedStorage2.emoteWiki.Metroman;
    local Root = vfxUtil.getRoot(u205);
    local Moon = require(Metroman.Moon);
    local v207 = Moon.Information and (Moon.Information.FPS or 60) or 60;
    local v208 = 0;

    for _, v in Moon.Data do
        for _, v2 in v do
            for i in v2 do
                if typeof(i) == "number" and v208 < i then
                    v208 = i;
                end;
            end;
        end;
    end;

    local u209 = v208 <= 0 and 6.583333333333333 or v208 / v207;
    local u210 = -3.5;
    local u211 = trove.new();
    u211:AttachToInstance(p206);
    local u212 = nil;
    local u213 = false;

    local function stripSounds(p214: userdata) -- Line: 1583
        for _, descendant in p214:GetDescendants() do
            if descendant:IsA("Sound") or descendant:IsA("SoundEffect") then
                descendant:Destroy();
            end;
        end;

        if p214:IsA("Sound") or p214:IsA("SoundEffect") then
            p214:Destroy();
        end;
    end;

    local u215;

    if Players:GetPlayerFromCharacter(u205) == LocalPlayer and not Util.isepilepsysafe() then
        u215 = u211:Add(Metroman.Lighting.MMColorCorrection:Clone());
        stripSounds(u215);
    else
        u215 = nil;
    end;

    clearHighlights(u205);
    local u216 = u211:Add(Metroman.Highlight:Clone());
    stripSounds(u216);
    u216.Adornee = u205;
    u216.Enabled = false;
    u216.Parent = u205;
    u211:Add(RunService.Heartbeat:Connect(function(p217) -- Line: 1608
        -- upvalues: u210 (ref), u213 (ref), u209 (copy), u215 (ref), Lighting (ref), u216 (copy), u212 (ref), u211 (copy), vfxUtil (ref), Metroman (copy), u205 (copy), MoonPropertyAnimator (ref), Root (copy)
        u210 = u210 + p217;

        if u210 < 0 then
            return;
        end;

        if not u213 then
            u213 = true;
            u210 = u209;

            if u215 then
                u215.Parent = Lighting;
            end;

            u216.Enabled = true;
        end;

        if u210 < u209 then
            return;
        end;

        u210 = u210 % u209;

        if u212 then
            u211:Remove(u212);
        end;

        u212 = u211:Extend();
        vfxUtil.execute_compiled(Metroman.Compiled, u212, u205);
        local v218 = u212:Construct(MoonPropertyAnimator);
        v218:LoadAndConvertSave(Metroman.Moon, {
            Vuhracity = u205,
            MMColorCorrection = u215,
            Highlight = u216
        });
        v218:SetOriginalRoot(CFrame.new(0, 3, 0));
        v218:SetRoot(Root);
        v218:PlayAll();
    end));
end;

function v1.dancewithyoureyesclosedEmote(u219: any, p220: userdata) -- Line: 1647
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), vfxUtil (copy), Players (copy), LocalPlayer (copy), PlayerGui (copy), TweenService (copy), Debris (copy), RunService (copy), Util (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy)
    if not p220 or p220.Parent ~= u219 then
        return;
    end;

    local dancewithyoureyesclosed = ReplicatedStorage2.emoteWiki.dancewithyoureyesclosed;
    local u221 = trove.new();
    u221:AttachToInstance(p220);
    u221:Add(vfxUtil.buildFromRig(u219, dancewithyoureyesclosed.rig), "Destroy");

    if Players:GetPlayerFromCharacter(u219) ~= LocalPlayer then
        return;
    end;

    local u222 = dancewithyoureyesclosed.glow:Clone();
    local ImageLabel2 = u222.ImageLabel2;
    ImageLabel2.ImageColor3 = Color3.fromRGB(221, 84, 255);
    ImageLabel2.ImageTransparency = 1;
    u222.Parent = PlayerGui;
    TweenService:Create(ImageLabel2, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
        ImageTransparency = 0.5
    }):Play();
    u221:Add(function() -- Line: 1666
        -- upvalues: TweenService (ref), ImageLabel2 (copy), Debris (ref), u222 (copy)
        TweenService:Create(ImageLabel2, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
        Debris:AddItem(u222, 1);
    end);
    local u223 = TweenService:Create(ImageLabel2, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
        ImageTransparency = 1
    });
    local u224 = nil;
    u221:Add(task.delay(0.45, function() -- Line: 1673
        -- upvalues: u221 (copy), RunService (ref), u224 (ref), u219 (copy), Util (ref), u223 (copy), ImageLabel2 (copy)
        u221:Connect(RunService.Heartbeat, function() -- Line: 1674
            -- upvalues: u224 (ref), u219 (ref), Util (ref), u223 (ref), ImageLabel2 (ref)
            if not (u224 and u224.Parent) then
                u224 = nil;

                for _, child in u219.Head:GetChildren() do
                    if child:IsA("Sound") and child:GetAttribute("EmoteAudio") then
                        u224 = child;
                        break;
                    end;
                end;
            end;

            local v225 = (Util.isepilepsysafe() or not (u224 and (u224.IsPlaying and u224.Volume > 0))) and 1 or math.clamp(1 + u224.PlaybackLoudness / 330, 1, 2);

            if v225 <= 1.1 then
                if u223.PlaybackState ~= Enum.PlaybackState.Playing then
                    u223:Play();
                end;

                return;
            end;

            if u223.PlaybackState == Enum.PlaybackState.Playing then
                u223:Cancel();
            end;

            ImageLabel2.ImageTransparency = 0.5;
            ImageLabel2.Size = ImageLabel2.Size:Lerp(UDim2.fromScale(v225, v225), 0.5);
        end);
    end));

    if Util.isepilepsysafe() then
        return;
    end;

    local u226 = {
        CurrentCamera = workspace_CurrentCamera
    };
    vfxUtil.contain_lighting(u221, u226, dancewithyoureyesclosed.Lighting);
    u221:Add(function() -- Line: 1704
        -- upvalues: workspace_CurrentCamera (ref)
        workspace_CurrentCamera.FieldOfView = 70;
    end);
    local u227 = 14.483333333333333;
    local u228 = nil;
    u221:Add(RunService.Heartbeat:Connect(function(p229) -- Line: 1709
        -- upvalues: u227 (ref), u228 (ref), u221 (copy), MoonPropertyAnimator (ref), dancewithyoureyesclosed (copy), u226 (copy)
        u227 = u227 + p229;

        if u227 < 14.483333333333333 then
            return;
        end;

        u227 = u227 % 14.483333333333333;

        if u228 then
            u221:Remove(u228);
        end;

        u228 = u221:Extend();
        local v230 = u228:Construct(MoonPropertyAnimator);
        v230:LoadAndConvertSave(dancewithyoureyesclosed.Moon, u226);
        v230:PlayAll();
    end));
end;

function v1.ribbiitEmote(u231: any, p232: userdata) -- Line: 1725
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), vfxUtil (copy), RunService (copy)
    if not p232 or p232.Parent ~= u231 then
        return;
    end;

    local ribbiit = ReplicatedStorage2.emoteWiki.ribbiit;
    local u233 = trove.new();
    u233:AttachToInstance(p232);
    u233:Add(vfxUtil.buildFromRig(u231, ribbiit.rig), "Destroy");
    local u234 = 5;
    local u235 = nil;
    u233:Add(RunService.Heartbeat:Connect(function(p236) -- Line: 1736
        -- upvalues: u234 (ref), u235 (ref), u233 (copy), vfxUtil (ref), ribbiit (copy), u231 (copy)
        u234 = u234 + p236;

        if u234 < 5 then
            return;
        end;

        u234 = u234 % 5;

        if u235 then
            u233:Remove(u235);
        end;

        u235 = u233:Extend();
        vfxUtil.execute_compiled(ribbiit.Compiled, u235, u231);
    end));
end;

function v1.seanopryEmote(p237: any, p238: userdata) -- Line: 1750
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), clearHighlights (copy), Players (copy), LocalPlayer (copy), Util (copy), Lighting (copy), MoonPropertyAnimator (copy)
    if not p238 or p238.Parent ~= p237 then
        return;
    end;

    local seanopry = ReplicatedStorage2.emoteWiki.seanopry;
    local Root = vfxUtil.getRoot(p237);
    local v239 = trove.new();
    v239:AttachToInstance(p238);
    v239:Add(task.delay(14.9, v239.Destroy, v239));
    v239:Add(vfxUtil.buildFromRig(p237, seanopry.rig), "Destroy");
    clearHighlights(p237);
    local v240 = v239:Add(seanopry.Highlight:Clone());
    v240.Adornee = p237;
    v240.Parent = p237;
    local v241 = {
        Highlight = v240
    };

    if Players:GetPlayerFromCharacter(p237) == LocalPlayer and not Util.isepilepsysafe() then
        for _, child in seanopry.Lighting:GetChildren() do
            local v242 = v239:Add(child:Clone());
            v242.Parent = Lighting;
            v241[child.Name] = v242;
        end;

        v241.Vignette = v239:Add(vfxUtil.getMoonEffects()).Vignette;
        local v243 = v239:Construct(MoonPropertyAnimator);
        v243:LoadAndConvertSave(seanopry.MoonCamera, {
            CurrentCamera = workspace.CurrentCamera
        });
        v243:PlayAll();
        v239:Add(function() -- Line: 1779
            workspace.CurrentCamera.FieldOfView = 70;
        end);
    end;

    local v244 = v239:Construct(MoonPropertyAnimator);
    v244:LoadAndConvertSave(seanopry.Moon, v241);
    v244:SetRoot(Root);
    v244:PlayAll();
end;

function v1.StaticEmote(u245: any, p246: userdata) -- Line: 1790
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), RunService (copy), MoonPropertyAnimator (copy)
    if not p246 or p246.Parent ~= u245 then
        return;
    end;

    local Static = ReplicatedStorage2.emoteWiki.Static;
    local Root = vfxUtil.getRoot(u245);
    local u247 = 9.766666666666667;
    local u248 = nil;
    local u249 = trove.new();
    u249:AttachToInstance(p246);
    local u250 = u249:Clone(Static.StaticBillboard);
    u250.Parent = Root;
    u249:Add(RunService.Heartbeat:Connect(function(p251) -- Line: 1809
        -- upvalues: u247 (ref), u248 (ref), u249 (copy), vfxUtil (ref), Static (copy), u245 (copy), u250 (copy), MoonPropertyAnimator (ref), Root (copy)
        u247 = u247 + p251;

        if u247 >= 9.766666666666667 then
            u247 = u247 % 9.766666666666667;

            if u248 then
                u249:Remove(u248);
            end;

            u248 = u249:Extend();
            vfxUtil.execute_compiled(Static.Compiled, u248, u245, u250);
            local v252 = u248:Construct(MoonPropertyAnimator);
            v252:LoadAndConvertSave(Static.Moon, {
                NewStatic = u245,
                Lyrics = u250.Frame.Lyrics
            });
            v252:SetRoot(Root);
            v252:PlayAll();
        end;
    end));
end;

function v1.EyesClosedEmote(p253: any, p254: userdata) -- Line: 1830
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p254 or p254.Parent ~= p253 then
        return;
    end;

    local eyesclosed = ReplicatedStorage2.emoteWiki.eyesclosed;
    local Root = vfxUtil.getRoot(p253);
    local v255 = trove.new();
    v255:AttachToInstance(p254);
    local v256 = v255:Clone(eyesclosed.Part);
    v256.Weld.Part0 = Root;
    v256.Parent = workspace.Effects;
    v255:Add(v256.glow).Parent = p253.Torso;
end;

function v1.GlassHeartEmote(p257: any, p258: userdata, u259: userdata) -- Line: 1851
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), RunService (copy)
    if not p258 or p258.Parent ~= p257 then
        return;
    end;

    local GlassHeart = ReplicatedStorage2.emoteWiki.GlassHeart;
    local Root = vfxUtil.getRoot(p257);
    local u260 = 33.783;
    local u261 = trove.new();
    u261:AttachToInstance(p258);
    local u262 = nil;
    local u263 = u261:Clone(GlassHeart.Part);
    u263.Weld.Part0 = Root;
    u263.Parent = workspace.Effects;
    u261:Add(RunService.Heartbeat:Connect(function(p264) -- Line: 1871
        -- upvalues: u260 (ref), u262 (ref), u261 (copy), vfxUtil (ref), GlassHeart (copy), u263 (copy), u259 (copy)
        u260 = u260 + p264;

        if u260 >= 33.783 then
            u260 = u260 % 33.783;

            if u262 then
                u261:Remove(u262);
            end;

            u262 = u261:Extend();
            vfxUtil.execute_compiled(GlassHeart.Compiled, u262, u263);
            u259:Play();
        end;
    end));
end;

function v1.GETINTHECAREmote(p265: any, p266: userdata) -- Line: 1889
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), MoonPropertyAnimator (copy), mainreplication (copy)
    if not p266 or p266.Parent ~= p265 then
        return;
    end;

    local GETINTHECAR = ReplicatedStorage2.emoteWiki.GETINTHECAR;
    local Root = vfxUtil.getRoot(p265);
    local v267 = trove.new();
    v267:AttachToInstance(p266);
    local v268 = v267:Construct(MoonPropertyAnimator);
    v268:LoadAndConvertSave(GETINTHECAR.Moon, {});
    v268:SetOriginalRoot(CFrame.new(0, 3, 0));
    v268:SetRoot(Root);
    v268:PlayAll();
    local v269 = v267:Construct(ReplicatedStorage2.emoteWiki.GETINTHECAR.User);
    vfxUtil.setupAura(p265, v269, true, true);
    v269.Parent = workspace.Effects;
    local v270, v271 = mainreplication.cutsceneCamRigWithLetterBox(Root, ReplicatedStorage2.emoteWiki.GETINTHECAR.camAnimation, ReplicatedStorage2.emoteWiki.GETINTHECAR.FOV, p266, "default", ReplicatedStorage2.emoteWiki.GETINTHECAR.Cam, "CamPart");
    v267:Add(v271);
    vfxUtil.execute_compiled(ReplicatedStorage2.emoteWiki.GETINTHECAR.Compiled, v267, v270, v269);
end;

function v1.VictoryEmote(p272: userdata, p273: userdata, p274: userdata) -- Line: 1930
    -- upvalues: trove (copy), vfxUtil (copy), ReplicatedStorage2 (copy)
    if not (p272 and p273) then
        return;
    end;

    if not p274 or p274.Parent ~= p272 then
        return;
    end;

    local v275 = trove.new();
    v275:AttachToInstance(p274);
    local Root = vfxUtil.getRoot(p272);
    local u276 = v275:Clone(ReplicatedStorage2.emoteWiki.Victory["Glow2 2P"]);
    u276.Parent = Root;
    v275:Add(task.delay(0.32, function() -- Line: 1946
        -- upvalues: u276 (copy)
        shared.vfx.emit(u276);
    end));
end;

function v1.TransfumblerEmote(u277: any, p278: userdata, p279: userdata) -- Line: 1951
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), KatUtil (copy), PlayerGui (copy), TweenService (copy)
    if not p278 or p278.Parent ~= u277 then
        return;
    end;

    local Transfumbler = ReplicatedStorage2.emoteWiki.Transfumbler;
    local Root = vfxUtil.getRoot(u277);
    local v280 = u277:FindFirstChildWhichIsA("Humanoid");

    if not v280 then
        return;
    end;

    local u281 = v280:FindFirstChildWhichIsA("HumanoidDescription");

    if not u281 then
        return;
    end;

    local u282 = trove.new();
    u282:AttachToInstance(p278);
    local _track = KatUtil.get_track(u277, Transfumbler.Animation);

    if _track then
        local function createafterimage(p283, p284, p285, p286) -- Line: 1970
            -- upvalues: u282 (copy), Transfumbler (copy), Root (copy), u277 (copy), PlayerGui (ref), TweenService (ref), u281 (copy)
            local u287 = u282:Clone(Transfumbler.GreenScreen);
            u287.Weld.Part0 = Root;
            u287.Parent = u277;
            u287.Weld.C0 = p283;
            local v288 = u282:Clone(Transfumbler.SurfaceGui);
            v288.Adornee = u287;
            v288.Parent = PlayerGui;
            local ViewportFrame = v288.ViewportFrame;
            local WorldModel = ViewportFrame.WorldModel;
            local v289 = CFrame.new(0, 4, -28) * CFrame.Angles(0, 3.141592653589793, 0);
            local Camera = Instance.new("Camera");
            Camera.CFrame = v289;
            Camera.FieldOfView = 31.5;
            Camera.CameraType = Enum.CameraType.Scriptable;
            Camera.Parent = ViewportFrame;
            ViewportFrame.CurrentCamera = Camera;
            local v290 = TweenService:Create(ViewportFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 0.5,
                ImageColor3 = Color3.new(1, 1, 1)
            });
            local v291 = TweenService:Create(u287.Weld, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                C0 = p284
            });
            local u292 = TweenService:Create(ViewportFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1,
                ImageColor3 = Color3.new(0, 0, 0)
            });
            local AuraMonster = WorldModel.AuraMonster;
            AuraMonster.Humanoid:ApplyDescriptionAsync(u281);
            AuraMonster:ScaleTo(2);
            AuraMonster.Humanoid.Animator:LoadAnimation(Transfumbler[p285]):Play();
            v290:Play();
            v291:Play();
            task.delay(p286, function() -- Line: 2023
                -- upvalues: u292 (copy), u287 (copy)
                u292:Play();
                task.delay(3, game.Destroy, u287);
            end);
        end;

        u282:Add(_track.track.KeyframeReached:Connect(function(p293) -- Line: 2030
            -- upvalues: createafterimage (copy)
            if p293 == "afterimage1" then
                createafterimage(CFrame.new(0, 2, 4), CFrame.new(5, 2, 4), "First", 2);
            end;

            if p293 == "afterimage2" then
                createafterimage(CFrame.new(0, 2, 4), CFrame.new(-5, 2, 4), "Second", 1.5);
            end;
        end));
    end;
end;

function v1.DBDEmote(u294: any, p295: userdata, p296: userdata) -- Line: 2071
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), KatUtil (copy)
    if not p295 or p295.Parent ~= u294 then
        return;
    end;

    local DBD = ReplicatedStorage2.emoteWiki.DBD;
    vfxUtil.getRoot(u294);
    local v297 = u294:FindFirstChildWhichIsA("Humanoid");

    if not v297 then
        return;
    end;

    if not v297:FindFirstChildWhichIsA("HumanoidDescription") then
        return;
    end;

    local v298 = trove.new();
    v298:AttachToInstance(p295);
    local _track = KatUtil.get_track(u294, DBD.Animation);
    local v299 = {};

    if u294 and u294:FindFirstChild("Torso") then
        for _, child in DBD.eff:GetChildren() do
            if child:IsA("Attachment") then
                local v300 = v298:Add(child:Clone());
                v300.Parent = u294:FindFirstChild("Torso");
                table.insert(v299, v300);
            end;
        end;
    end;

    if _track then
        v298:Add(_track.track.DidLoop:Connect(function() -- Line: 2101
            -- upvalues: u294 (copy)
            shared.vfx.emit(u294:FindFirstChild("Torso"));
        end));
        shared.vfx.emit(u294:FindFirstChild("Torso"));
    end;
end;

function v1.cheeserickEmote(p301: any, p302: userdata, u303: userdata) -- Line: 2109
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), clearHighlights (copy), TweenService (copy), workspace_CurrentCamera (copy), LocalPlayer (copy), RunService (copy)
    if not p302 or p302.Parent ~= p301 then
        return;
    end;

    local _ = ReplicatedStorage2.emoteWiki.DBD;
    vfxUtil.getRoot(p301);
    local v304 = p301:FindFirstChildWhichIsA("Humanoid");

    if not v304 then
        return;
    end;

    if not v304:FindFirstChildWhichIsA("HumanoidDescription") then
        return;
    end;

    local v305 = trove.new();
    v305:AttachToInstance(p302);
    clearHighlights(p301);
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = p301;
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 0;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    v305:Add(Highlight);
    v305:Add(task.delay(1, function() -- Line: 2134
        -- upvalues: Highlight (copy)
        pcall(game.Destroy, Highlight);
    end));
    TweenService:Create(Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();

    if LocalPlayer.Character == p301 then
        v305:Add((RunService.RenderStepped:Connect(function(p306) -- Line: 2142
            -- upvalues: workspace_CurrentCamera (ref), u303 (copy)
            local FieldOfView = workspace_CurrentCamera.FieldOfView;
            local v307 = math.lerp(-30, 30, u303.PlaybackLoudness / 1000) + 70;
            workspace_CurrentCamera.FieldOfView = math.lerp(FieldOfView, v307, 25 * p306);
        end)));
        v305:Add(function() -- Line: 2146
            workspace.CurrentCamera.FieldOfView = 70;
        end);
    end;
end;

function v1.streetcatEmote(u308: any, p309: userdata) -- Line: 2153
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), clearHighlights (copy), Players (copy), LocalPlayer (copy), Util (copy), RunService (copy), MoonPropertyAnimator (copy)
    if not p309 or p309.Parent ~= u308 then
        return;
    end;

    local streetcat = ReplicatedStorage2.emoteWiki.streetcat;
    local Root = vfxUtil.getRoot(u308);
    local u310 = trove.new();
    u310:AttachToInstance(p309);
    local u311 = 46.78333333333333;
    local u312 = nil;
    clearHighlights(u308);
    u310:Add(vfxUtil.buildFromRig(u308, streetcat.rig), "Destroy");
    local u313 = u310:Clone(streetcat.StreetCatGUI);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u308);
    local v314 = PlayerFromCharacter == LocalPlayer and true or PlayerFromCharacter == nil;

    if v314 then
        u313.Parent = LocalPlayer.PlayerGui;
    end;

    local u315 = {
        StreetcatEmote = u308,
        LyricsText = Root.StreetcatBillboard.Frame.LyricsText
    };

    if v314 and not Util.isepilepsysafe() then
        vfxUtil.contain_lighting(u310, u315, streetcat.Lighting);
    end;

    u310:Add(RunService.Heartbeat:Connect(function(p316) -- Line: 2186
        -- upvalues: u311 (ref), u312 (ref), u310 (copy), vfxUtil (ref), streetcat (copy), u308 (copy), u313 (copy), MoonPropertyAnimator (ref), u315 (copy), Root (copy)
        u311 = u311 + p316;

        if u311 < 46.78333333333333 then
            return;
        end;

        u311 = u311 % 46.78333333333333;

        if u312 then
            u310:Remove(u312);
        end;

        u312 = u310:Extend();
        vfxUtil.execute_compiled(streetcat.Compiled, u312, u308, u313);
        local v317 = u312:Construct(MoonPropertyAnimator);
        v317:LoadAndConvertSave(streetcat.Moon, u315);
        v317:SetRoot(Root);
        v317:PlayAll();
    end));
end;

function v1.redreamingEmote(u318: any, u319: userdata) -- Line: 2206
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), LocalPlayer (copy), RunService (copy), MoonPropertyAnimator (copy), Lighting (copy)
    if not u319 or u319.Parent ~= u318 then
        return;
    end;

    local Normal = ReplicatedStorage2.emoteWiki.ReDreaming.Normal;
    local Root = vfxUtil.getRoot(u318);

    if not Root then
        return;
    end;

    local u320 = trove.new();
    u320:AttachToInstance(u319);
    local u321 = u320:Clone(Normal.VFX);
    local u322 = u321:FindFirstChild("inverted sphere");
    local u323 = "Participant_" .. LocalPlayer.UserId;
    local u324 = 0;
    local u325 = nil;
    local u326 = nil;
    local u327 = nil;
    local u328 = nil;
    local u329 = nil;
    local u330 = false;
    local u331 = nil;
    u321:PivotTo(Root.CFrame);
    u321.Parent = workspace.Effects;
    u320:Add(RunService.PreRender:Connect(function() -- Line: 2237
        -- upvalues: u321 (copy), u318 (copy)
        u321:PivotTo(u318:GetPivot());
    end));

    local function playDomainCycle() -- Line: 2241
        -- upvalues: u326 (ref), u327 (ref), MoonPropertyAnimator (ref), Normal (copy), Root (copy), u328 (ref), u324 (ref)
        if not u326 then
            return;
        end;

        if u327 then
            u326:Remove(u327);
        end;

        u327 = u326:Extend();
        local v332 = u327:Construct(MoonPropertyAnimator);
        v332:SetOriginalRoot(Normal.VFX:GetPivot());
        v332:SetRoot(Root);
        v332:LoadAndConvertSave(Normal.Moon, u328);

        for _, v in v332._tracks do
            v.TimePosition = u324;
        end;

        v332:PlayAll();
    end;

    local function updateDomain() -- Line: 2260
        -- upvalues: u318 (copy), u319 (copy), LocalPlayer (ref), u323 (copy), u329 (ref), u322 (copy), u326 (ref), u320 (copy), u327 (ref), u328 (ref), u331 (ref), vfxUtil (ref), Lighting (ref), Normal (copy), u330 (ref), playDomainCycle (copy)
        local v333;

        if u318:GetAttribute("evil") == true then
            v333 = true;
        elseif u319:GetAttribute("RedreamingParticipant") == true then
            v333 = false;
        else
            v333 = u318 == LocalPlayer.Character and true or u319:GetAttribute(u323) == true;
        end;

        if v333 == u329 then
            return;
        end;

        u329 = v333;

        if u322 and u322:IsA("BasePart") then
            u322.LocalTransparencyModifier = v333 and 0 or 1;
        end;

        if u326 then
            u320:Remove(u326);
            u326 = nil;
            u327 = nil;
            u328 = nil;
            u331 = nil;
        end;

        if not v333 then
            return;
        end;

        u326 = u320:Extend();
        local v334 = u326:Add(vfxUtil.getMoonEffects());
        local v335 = {
            Lighting = Lighting,
            ["Screen Cover"] = v334["Screen Cover"],
            Vignette = v334.Vignette
        };
        vfxUtil.cutscene_lighting(u326, v335, Normal:FindFirstChild("Lighting"), {
            Brightness = 3,
            ClockTime = 14.5,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            ExposureCompensation = 0,
            GeographicLatitude = 0,
            GlobalShadows = true,
            ShadowSoftness = 0.20000000298023224,
            Ambient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            ColorShift_Top = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.new(0.27450981736183167, 0.27450981736183167, 0.27450981736183167)
        });
        u328 = v335;
        local _baseplate_controller, u336 = vfxUtil.get_baseplate_controller();
        local Transparency = u336.Transparency;
        local u337 = false;

        local function restoreBaseplate() -- Line: 2311
            -- upvalues: u337 (ref), u336 (copy), Transparency (copy), _baseplate_controller (copy)
            if not u337 then
                return;
            end;

            u337 = false;

            if u336.Parent then
                u336.Transparency = Transparency;
            end;

            for i, v in _baseplate_controller.savedTransparency do
                if i.Parent then
                    i.Transparency = v;
                end;
            end;
        end;

        u331 = function(p338: boolean) -- Line: 2327
            -- upvalues: u337 (ref), u336 (copy), _baseplate_controller (copy), Transparency (copy)
            if p338 then
                u337 = true;
                u336.Transparency = 1;
                _baseplate_controller.update();

                return;
            end;

            if not u337 then
                return;
            end;

            u337 = false;

            if u336.Parent then
                u336.Transparency = Transparency;
            end;

            for i, v in _baseplate_controller.savedTransparency do
                if i.Parent then
                    i.Transparency = v;
                end;
            end;
        end;

        u326:Add(restoreBaseplate);
        u331(u330);
        playDomainCycle();
    end;

    local function u341() -- Line: 2341
        -- upvalues: u325 (ref), u320 (copy), u330 (ref), u331 (ref), MoonPropertyAnimator (ref), Normal (copy), Root (copy), u321 (copy), vfxUtil (ref), playDomainCycle (copy)
        if u325 then
            u320:Remove(u325);
        end;

        u325 = u320:Extend();
        u330 = false;

        if u331 then
            u331(false);
        end;

        local v339 = u325:Construct(MoonPropertyAnimator);
        v339:SetOriginalRoot(Normal.VFX:GetPivot());
        v339:SetRoot(Root);
        v339:LoadAndConvertSave(Normal.Moon, {
            nightsdevs = u321
        });
        v339:PlayAll();
        vfxUtil.execute_compiled(Normal.Compiled, u325, u321, function(p340: boolean) -- Line: 2356
            -- upvalues: u330 (ref), u331 (ref)
            u330 = p340;

            if u331 then
                u331(p340);
            end;
        end);
        playDomainCycle();
    end;

    u320:Add(u319:GetAttributeChangedSignal(u323):Connect(updateDomain));
    u320:Add(u319:GetAttributeChangedSignal("RedreamingParticipant"):Connect(updateDomain));
    u320:Add(u318:GetAttributeChangedSignal("evil"):Connect(updateDomain));
    u341();
    updateDomain();
    u320:Add(RunService.PreRender:Connect(function(p342) -- Line: 2372
        -- upvalues: u324 (ref), u341 (copy)
        u324 = u324 + p342;

        if u324 >= 23.35 then
            u324 = u324 % 23.35;
            u341();
        end;
    end));
end;

function v1.nowayEmote(p343: any, p344: userdata) -- Line: 2381
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p344 or p344.Parent ~= p343 then
        return;
    end;

    local Luck = ReplicatedStorage2.emoteWiki.ReDreaming.Luck;

    if not vfxUtil.getRoot(p343) then
        return;
    end;

    local v345 = trove.new();
    v345:AttachToInstance(p344);
    v345:Add(vfxUtil.buildFromRig(p343, Luck.Rig));
end;

function v1.give_me_everything_v2_emote(u346: any, p347: userdata) -- Line: 2399
    -- upvalues: ReplicatedStorage2 (copy), HttpService (copy), LocalPlayer (copy), trove (copy), Lighting (copy), PlayerGui (copy), TweenService (copy), Util (copy), RunService (copy), mainreplication (copy)
    if not p347 or p347.Parent ~= u346 then
        return;
    end;

    local give_me_everything_v2 = ReplicatedStorage2.emoteWiki:FindFirstChild("give_me_everything_v2");

    if give_me_everything_v2 then
        give_me_everything_v2 = give_me_everything_v2:FindFirstChild("Animation");
    end;

    local u348 = u346:FindFirstChildOfClass("Humanoid");

    if u348 then
        u348 = u348:FindFirstChildOfClass("Animator");
    end;

    if not (give_me_everything_v2 and (give_me_everything_v2:IsA("Animation") and u348)) then
        return;
    end;

    local string_match_ret = string.match(give_me_everything_v2.AnimationId, "%d+");
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local u349 = { 157, 189, 214, 242, 272, 300, 328, 355, 384, 411, 435, 462, 490, 520, 547, 576, 607, 633, 660, 687, 714, 746, 769, 798, 828, 855, 882, 912 };
    local u350 = { { 10, 75 }, { 89, 55 }, { 145, 70 } };
    local u351 = "give_me_everything_v2_" .. HttpService:GenerateGUID(false);
    local u352 = u346 == LocalPlayer.Character;
    local u353 = trove.new();
    u353:AttachToInstance(p347);
    local u354, u355, u356, u357, u358;

    if u352 then
        u354 = u353:Add(Instance.new("ColorCorrectionEffect"));
        u354.Name = "EmoteCC";
        u354.Brightness = 0;
        u354.Contrast = 0;
        u354.Saturation = 0;
        u354.TintColor = Color3.new(1, 1, 1);
        u354.Parent = Lighting;
        u355 = u353:Add(Instance.new("BlurEffect"));
        u355.Name = "EmoteBlur";
        u355.Size = 0;
        u355.Parent = Lighting;
        local v359 = u353:Add(Instance.new("ScreenGui"));
        v359.Name = "ScreenBox";
        v359.IgnoreGuiInset = true;
        v359.ResetOnSpawn = false;
        v359.DisplayOrder = 900;
        v359.Parent = PlayerGui;
        local Frame = Instance.new("Frame");
        Frame.Name = "Screen Cover";
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BackgroundTransparency = 1;
        Frame.BorderSizePixel = 0;
        Frame.Parent = v359;
        u356 = Frame;
        u357 = TweenService:Create(u355, TweenInfo.new(0.01), {
            Size = 12
        });
        local u360 = TweenService:Create(u355, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = 0
        });
        u358 = TweenService:Create(u354, TweenInfo.new(0.01), {
            Brightness = 0.22
        });
        local u361 = TweenService:Create(u354, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0
        });
        u353:Add(u357.Completed:Connect(function() -- Line: 2472
            -- upvalues: u360 (copy)
            u360:Play();
        end));
        u353:Add(u358.Completed:Connect(function() -- Line: 2476
            -- upvalues: u361 (copy)
            u361:Play();
        end));
    else
        u356 = nil;
        u355 = nil;
        u357 = nil;
        u354 = nil;
        u358 = nil;
    end;

    local function flash_lighting() -- Line: 2484
        -- upvalues: u355 (ref), u354 (ref), u357 (ref), u358 (ref), Util (ref)
        if not (u355 and (u354 and (u357 and u358))) then
            return;
        end;

        u355.Size = 0;
        u354.Brightness = 0;

        if Util.isepilepsysafe() then
            return;
        end;

        u357:Play();
        u358:Play();
    end;

    local function create_afterimage(p362: userdata, p363: number) -- Line: 2500
        -- upvalues: u346 (copy), u353 (copy), workspace_CurrentCamera2 (copy), PlayerGui (ref), give_me_everything_v2 (copy), RunService (ref), TweenService (ref)
        local Archivable = u346.Archivable;
        u346.Archivable = true;
        local u364 = u346:Clone();
        u346.Archivable = Archivable;

        if not u364 then
            return;
        end;

        for _, descendant in u364:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("Sound") or descendant:IsA("TouchTransmitter")) then
                descendant:Destroy();
            end;
        end;

        local EmoteReference = u364:FindFirstChild("EmoteReference");

        if EmoteReference then
            EmoteReference:Destroy();
        end;

        local u365 = u353:Add(Instance.new("ScreenGui"));
        u365.Name = "GiveMeEverythingAfterimage";
        u365.IgnoreGuiInset = true;
        u365.ResetOnSpawn = false;
        u365.DisplayOrder = 899;
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Size = UDim2.fromScale(1, 1);
        ViewportFrame.Position = UDim2.fromScale(0.5, 0.5);
        ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5);
        ViewportFrame.BackgroundTransparency = 1;
        ViewportFrame.ImageTransparency = 0;
        ViewportFrame.Parent = u365;
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Name = "Character";
        WorldModel.Parent = ViewportFrame;
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = workspace_CurrentCamera2.FieldOfView;
        Camera.CFrame = workspace_CurrentCamera2.CFrame;
        Camera.Parent = ViewportFrame;
        ViewportFrame.CurrentCamera = Camera;
        local Pivot = u346:GetPivot();
        local math_clamp_ret = math.clamp((Pivot.Position - workspace_CurrentCamera2.CFrame.Position).Magnitude / 10, 0.5, 2);
        local u366 = Pivot * CFrame.new((p363 == 1 and 4 or -4) * math_clamp_ret, 0, 0);
        u364.Parent = WorldModel;
        u364:PivotTo(Pivot);
        u365.Parent = PlayerGui;
        local v367 = u364:FindFirstChildOfClass("Humanoid");

        if v367 then
            v367.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            local v368 = v367:FindFirstChildOfClass("Animator");

            if not v368 then
                v368 = Instance.new("Animator");
                v368.Parent = v367;
            end;

            local v369 = v368:LoadAnimation(give_me_everything_v2);
            v369:Play(0);
            v369.TimePosition = p362.TimePosition;
            v369:AdjustSpeed(0);
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        local u370 = RunService.RenderStepped:Connect(function() -- Line: 2571
            -- upvalues: Camera (copy), workspace_CurrentCamera2 (ref), u364 (copy), Pivot (copy), u366 (copy), NumberValue (copy)
            Camera.CFrame = workspace_CurrentCamera2.CFrame;
            Camera.FieldOfView = workspace_CurrentCamera2.FieldOfView;
            u364:PivotTo(Pivot:Lerp(u366, NumberValue.Value));
        end);
        u353:Add(u370);
        local v371 = TweenService:Create(NumberValue, TweenInfo.new(0.85, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Value = 1
        });
        u353:Add(v371.Completed:Once(function() -- Line: 2579
            -- upvalues: u370 (copy), u365 (copy), NumberValue (copy)
            u370:Disconnect();
            task.delay(0.05, function() -- Line: 2581
                -- upvalues: u365 (ref), NumberValue (ref)
                u365:Destroy();
                NumberValue:Destroy();
            end);
        end));
        v371:Play();
        TweenService:Create(ViewportFrame, TweenInfo.new(0.85, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
            ImageTransparency = 1
        }):Play();
    end;

    local u372 = nil;

    local function find_track() -- Line: 2594
        -- upvalues: u372 (ref), u348 (copy), string_match_ret (copy)
        if u372 and u372.IsPlaying then
            return u372;
        end;

        u372 = nil;

        for _, v in u348:GetPlayingAnimationTracks() do
            local Animation = v.Animation;

            if Animation and string.match(Animation.AnimationId, "%d+") == string_match_ret then
                u372 = v;
                break;
            end;
        end;

        return u372;
    end;

    local function sample_fov(p373: number) -- Line: 2611
        -- upvalues: u350 (copy)
        local v374 = u350[1][2];

        for _, v in u350 do
            if v[1] <= p373 then
                v374 = v[2];
            end;
        end;

        return v374;
    end;

    local function play_start_fade() -- Line: 2621
        -- upvalues: u356 (ref), TweenService (ref), u353 (copy)
        if not u356 then
            return;
        end;

        local v375 = TweenService:Create(u356, TweenInfo.new(0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        });
        u353:Add(v375.Completed:Once(function() -- Line: 2630
            -- upvalues: TweenService (ref), u356 (ref)
            TweenService:Create(u356, TweenInfo.new(0.11, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end));
        v375:Play();
    end;

    local u376 = false;
    local u377 = false;
    local CameraType = workspace_CurrentCamera2.CameraType;
    local FieldOfView = workspace_CurrentCamera2.FieldOfView;
    local u378 = nil;
    local u379 = -1;
    local u380 = 1;
    local u381 = 1;
    local u382 = 0;
    local u383 = (-1 / 0);
    local u384 = 0;

    local function fire_flash(p385: userdata) -- Line: 2651
        -- upvalues: u352 (copy), u355 (ref), u354 (ref), u357 (ref), u358 (ref), Util (ref), mainreplication (ref), u382 (ref), u381 (ref), u383 (ref), create_afterimage (copy)
        if u352 then
            if u355 and (u354 and (u357 and u358)) then
                u355.Size = 0;
                u354.Brightness = 0;

                if not Util.isepilepsysafe() then
                    u357:Play();
                    u358:Play();
                end;
            end;

            mainreplication.cameraShake(4, 0.25, 0.45);
            u382 = u381 == 1 and -5 or 5;
            u383 = os.clock();
        end;

        create_afterimage(p385, u381);
        u381 = u381 == 1 and 2 or 1;
    end;

    local function exit_cutscene() -- Line: 2664
        -- upvalues: u377 (ref), workspace_CurrentCamera2 (copy), CameraType (ref), FieldOfView (ref), u384 (ref)
        if not u377 then
            return;
        end;

        u377 = false;
        workspace_CurrentCamera2.CameraType = CameraType;
        workspace_CurrentCamera2.FieldOfView = FieldOfView;
        u384 = 0;
    end;

    RunService:BindToRenderStep(u351, Enum.RenderPriority.Camera.Value + 1, function() -- Line: 2675
        -- upvalues: find_track (copy), u377 (ref), workspace_CurrentCamera2 (copy), CameraType (ref), FieldOfView (ref), u384 (ref), u378 (ref), u379 (ref), u380 (ref), u349 (copy), u376 (ref), play_start_fade (copy), u352 (copy), u355 (ref), u354 (ref), u357 (ref), u358 (ref), Util (ref), mainreplication (ref), u382 (ref), u381 (ref), u383 (ref), create_afterimage (copy), u346 (copy), u356 (ref), TweenService (ref), u350 (copy)
        local v386 = find_track();

        if not v386 then
            if not u377 then
                return;
            end;

            u377 = false;
            workspace_CurrentCamera2.CameraType = CameraType;
            workspace_CurrentCamera2.FieldOfView = FieldOfView;
            u384 = 0;

            return;
        end;

        local v387 = v386.TimePosition * 60;

        if v386 ~= u378 or v387 < u379 then
            u378 = v386;
            u380 = 1;

            while u380 <= #u349 and u349[u380] < v387 - 1 do
                u380 = u380 + 1;
            end;
        end;

        u379 = v387;
        local v388;

        if u376 then
            v388 = false;
        else
            u376 = true;
            play_start_fade();
            v388 = false;
        end;

        while u380 <= #u349 and u349[u380] <= v387 do
            u380 = u380 + 1;
            v388 = true;
        end;

        if v388 then
            if u352 then
                if u355 and (u354 and (u357 and u358)) then
                    u355.Size = 0;
                    u354.Brightness = 0;

                    if not Util.isepilepsysafe() then
                        u357:Play();
                        u358:Play();
                    end;
                end;

                mainreplication.cameraShake(4, 0.25, 0.45);
                u382 = u381 == 1 and -5 or 5;
                u383 = os.clock();
            end;

            create_afterimage(v386, u381);
            u381 = u381 == 1 and 2 or 1;
        end;

        if not u352 then
            return;
        end;

        local v389 = (os.clock() - u383) / 0.76;
        local math_clamp_ret = math.clamp(v389, 0, 1);
        local v390 = u382 * (1 - math_clamp_ret) * (1 - math_clamp_ret);
        local Cam = u346:FindFirstChild("Cam");

        if not (Cam and (Cam:IsA("BasePart") and (v387 >= 10 and v387 < 146))) then
            if u377 then
                u377 = false;
                workspace_CurrentCamera2.CameraType = CameraType;
                workspace_CurrentCamera2.FieldOfView = FieldOfView;
                u384 = 0;
            end;

            local v391 = workspace_CurrentCamera2;
            v391.FieldOfView = v391.FieldOfView + (v390 - u384);
            u384 = v390;

            return;
        end;

        if not u377 then
            u377 = true;
            CameraType = workspace_CurrentCamera2.CameraType;
            FieldOfView = workspace_CurrentCamera2.FieldOfView - u384;
            u384 = 0;

            if u356 then
                TweenService:Create(u356, TweenInfo.new(0.11, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play();
            end;
        end;

        workspace_CurrentCamera2.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera2.CFrame = Cam.CFrame;
        local v392 = u350[1][2];

        for _, v in u350 do
            if v[1] <= v387 then
                v392 = v[2];
            end;
        end;

        workspace_CurrentCamera2.FieldOfView = v392;
    end);
    u353:Add(function() -- Line: 2737
        -- upvalues: RunService (ref), u351 (copy), u377 (ref), workspace_CurrentCamera2 (copy), CameraType (ref), FieldOfView (ref), u384 (ref)
        RunService:UnbindFromRenderStep(u351);

        if not u377 then
            if u384 ~= 0 then
                local v393 = workspace_CurrentCamera2;
                v393.FieldOfView = v393.FieldOfView - u384;
                u384 = 0;
            end;

            return;
        end;

        u377 = false;
        workspace_CurrentCamera2.CameraType = CameraType;
        workspace_CurrentCamera2.FieldOfView = FieldOfView;
    end);
end;

function v1.stretch_emote(p394: any, p395: userdata) -- Line: 2750
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), soundUtil (copy), trove (copy)
    if not p395 or p395.Parent ~= p394 then
        return;
    end;

    local stretch = ReplicatedStorage2.emoteWiki:FindFirstChild("stretch");
    local v396;

    if stretch then
        v396 = stretch:FindFirstChild("Assets");
    else
        v396 = stretch;
    end;

    if stretch then
        stretch = stretch:FindFirstChild("Animation");
    end;

    local Root = vfxUtil.getRoot(p394);
    local v397 = p394:FindFirstChildOfClass("Humanoid");

    if v397 then
        v397 = v397:FindFirstChildOfClass("Animator");
    end;

    if not (v396 and (stretch and (Root and v397))) then
        return;
    end;

    soundUtil:play(ReplicatedStorage2.emoteWiki.stretch.Sound, Root);
    local string_match_ret = string.match(stretch.AnimationId, "%d+");
    local u398 = trove.new();
    u398:AttachToInstance(p395);
    local u399 = {};
    local u400 = {
        st2 = "st2",
        st1 = "st1",
        hit = "armthing",
        ground = "groundthing"
    };
    local u401 = { "st2", "st1", "hit", "ground" };

    for _, child in v396:GetChildren() do
        if child:IsA("Attachment") then
            local v402 = child:Clone();
            v402.Parent = Root;
            u399[v402.Name] = v402;
        end;
    end;

    u398:Add(function() -- Line: 2790
        -- upvalues: u399 (copy)
        task.delay(3.1, function() -- Line: 2791
            -- upvalues: u399 (ref)
            for _, v in u399 do
                v:Destroy();
            end;
        end);
    end);

    local function emit(p403: string) -- Line: 2798
        -- upvalues: u399 (copy), u400 (copy)
        local v404 = u399[u400[p403]];

        if not (v404 and v404.Parent) then
            return;
        end;

        for _, child in v404:GetChildren() do
            if child:IsA("ParticleEmitter") then
                local u405 = shared.allvfxcheck and shared.allvfxcheck() and 0 or (child:GetAttribute("EmitCount") or 1);
                local v406 = child:GetAttribute("EmitDelay") or 0;

                if v406 > 0 then
                    task.delay(v406, function() -- Line: 2809
                        -- upvalues: child (copy), u405 (copy)
                        if child.Parent then
                            child:Emit(u405);
                        end;
                    end);
                else
                    child:Emit(u405);
                end;
            end;
        end;
    end;

    local u407 = false;

    local function bind(p408: userdata) -- Line: 2822
        -- upvalues: u407 (ref), string_match_ret (copy), u401 (copy), emit (copy), u398 (copy), u400 (copy)
        if u407 then
            return;
        end;

        local Animation = p408.Animation;

        if not Animation or string.match(Animation.AnimationId, "%d+") ~= string_match_ret then
            return;
        end;

        u407 = true;
        local TimePosition = p408.TimePosition;

        for _, v in u401 do
            local success, result = pcall(p408.GetTimeOfKeyframe, p408, v);

            if success and (result <= TimePosition and TimePosition - result <= 0.3) then
                emit(v);
            end;
        end;

        u398:Add(p408.KeyframeReached:Connect(function(p409: string) -- Line: 2840
            -- upvalues: u400 (ref), emit (ref)
            if u400[p409] then
                emit(p409);
            end;
        end));
    end;

    for _, v in v397:GetPlayingAnimationTracks() do
        bind(v);
    end;

    if not u407 then
        u398:Add(v397.AnimationPlayed:Connect(function(p410: userdata) -- Line: 2852
            -- upvalues: bind (copy)
            bind(p410);
        end));
    end;
end;

function v1.kitkit_emote(p411: any, p412: userdata) -- Line: 2858
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), LocalPlayer (copy), trove (copy), TweenService (copy), Lighting (copy), Util (copy), RunService (copy)
    if not p412 or p412.Parent ~= p411 then
        return;
    end;

    local kitkit = ReplicatedStorage2.emoteWiki:FindFirstChild("kitkit");
    local v413;

    if kitkit then
        v413 = kitkit:FindFirstChild("Assets");
    else
        v413 = kitkit;
    end;

    if v413 then
        v413 = v413:FindFirstChild("cat");
    end;

    local v414;

    if kitkit then
        v414 = kitkit:FindFirstChild("tracks");
    else
        v414 = kitkit;
    end;

    local v415;

    if kitkit then
        v415 = kitkit:FindFirstChild("Animation");
    else
        v415 = kitkit;
    end;

    if kitkit then
        kitkit = kitkit:FindFirstChild("LoopAnimation");
    end;

    local Root = vfxUtil.getRoot(p411);
    local v416 = p411:FindFirstChildOfClass("Humanoid");

    if v416 then
        v416 = v416:FindFirstChildOfClass("Animator");
    end;

    if not (v413 and (v414 and (v415 and (kitkit and (Root and v416))))) then
        return;
    end;

    local u417 = require(v414);
    local string_match_ret = string.match(v415.AnimationId, "%d+");
    local string_match_ret2 = string.match(kitkit.AnimationId, "%d+");
    local fps = u417.fps;
    local u418 = p411 == LocalPlayer.Character;
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local v419 = trove.new();
    v419:AttachToInstance(p412);
    local u420 = v419:Clone(v413);
    u420.Anchored = true;
    u420.CanCollide = false;
    u420.CanQuery = false;
    u420.CanTouch = false;
    u420.CFrame = Root.CFrame * u417.startup.cat_cframe[1][2];
    u420.Size = u417.startup.cat_size[1][2];
    u420.Parent = workspace:FindFirstChild("Effects") or workspace;

    local function resolve(p421: string) -- Line: 2897
        -- upvalues: u420 (copy)
        local v422 = u420;

        for _, v in string.split(p421, "/") do
            if v422 then
                v422 = v422:FindFirstChild(v);
            end;
        end;

        return v422;
    end;

    local function ease(p423: number, p424: string?, p425: string?) -- Line: 2905
        -- upvalues: TweenService (ref)
        if p424 == "Constant" then
            return 0;
        end;

        if p424 == nil or p424 == "Linear" then
            return p423;
        end;

        local success, result = pcall(TweenService.GetValue, TweenService, p423, Enum.EasingStyle[p424], Enum.EasingDirection[p425 or "In"]);

        if success then
            return result;
        end;

        return p423;
    end;

    local function lerp(p426: any, p427: any, p428: number) -- Line: 2916
        if typeof(p426) == "number" then
            return p426 + (p427 - p426) * p428;
        end;

        return p426:Lerp(p427, p428);
    end;

    local function sample(p429: table, p430: number) -- Line: 2923
        -- upvalues: lerp (copy), TweenService (ref)
        local v431 = p429[1];

        if p430 <= v431[1] then
            return v431[2];
        end;

        for i = 1, #p429 - 1 do
            local v432 = p429[i];
            local v433 = p429[i + 1];

            if p430 < v433[1] then
                local v434 = v432[2];
                local v435 = v433[2];
                local v436 = (p430 - v432[1]) / (v433[1] - v432[1]);
                local v437 = v432[3];
                local v438 = v432[4];

                if v437 == "Constant" then
                    v436 = 0;
                elseif v437 ~= nil and v437 ~= "Linear" then
                    local success, result = pcall(TweenService.GetValue, TweenService, v436, Enum.EasingStyle[v437], Enum.EasingDirection[v438 or "In"]);

                    if success then
                        v436 = result;
                    end;
                end;

                return lerp(v434, v435, v436);
            end;

            local _ = i;
        end;

        return p429[#p429][2];
    end;

    local u439 = nil;
    local u440 = nil;

    local function watch(p441: userdata) -- Line: 2940
        -- upvalues: string_match_ret (copy), u439 (ref), string_match_ret2 (copy), u440 (ref)
        local Animation = p441.Animation;

        if Animation then
            Animation = string.match(Animation.AnimationId, "%d+");
        end;

        if Animation == string_match_ret then
            u439 = p441;

            return;
        end;

        if Animation == string_match_ret2 then
            u440 = p441;
        end;
    end;

    for _, v in v416:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation then
            Animation = string.match(Animation.AnimationId, "%d+");
        end;

        if Animation == string_match_ret then
            u439 = v;
        elseif Animation == string_match_ret2 then
            u440 = v;
        end;
    end;

    v419:Add(v416.AnimationPlayed:Connect(watch));

    local function current() -- Line: 2954
        -- upvalues: u440 (ref), u417 (copy), fps (copy), u439 (ref)
        if u440 and u440.IsPlaying then
            return u417.loop, u440.TimePosition * fps % u417.loop.length;
        end;

        if u439 and u439.IsPlaying then
            return u417.startup, math.min(u439.TimePosition * fps, u417.startup.length);
        end;

        return nil, nil;
    end;

    local function fire_markers(p442: any, p443: number, p444: number) -- Line: 2964
        -- upvalues: resolve (copy)
        if not (shared.vfx and shared.vfx.emit) then
            return;
        end;

        for _, v in p442.markers do
            if p443 < v[1] and v[1] <= p444 then
                for _, v2 in v[2] do
                    local v445 = resolve(v2);

                    if v445 then
                        shared.vfx.emit(v445);
                    end;
                end;
            end;
        end;
    end;

    local u446 = nil;
    local u447;

    if u418 then
        u447 = v419:Add(Instance.new("BlurEffect"));
        u447.Name = "kitkit_blur";
        u447.Size = 0;
        u447.Parent = Lighting;

        if not Util.isepilepsysafe() then
            u446 = v419:Add(Instance.new("ColorCorrectionEffect"));
            u446.Name = "kitkit_cc";
            u446.Parent = Lighting;
        end;
    else
        u447 = nil;
    end;

    local u448 = nil;
    local u449 = 0;
    local u450 = 0;
    v419:Add(RunService.RenderStepped:Connect(function() -- Line: 2998
        -- upvalues: Root (copy), u440 (ref), u417 (copy), fps (copy), u439 (ref), u420 (copy), sample (copy), u448 (ref), fire_markers (copy), u449 (ref), u447 (ref), u446 (ref), u418 (copy), workspace_CurrentCamera2 (copy), u450 (ref)
        if not Root.Parent then
            return;
        end;

        local v451, v452;

        if u440 and u440.IsPlaying then
            v451 = u417.loop;
            v452 = u440.TimePosition * fps % u417.loop.length;
        elseif u439 and u439.IsPlaying then
            v451 = u417.startup;
            v452 = math.min(u439.TimePosition * fps, u417.startup.length);
        else
            v451 = nil;
            v452 = nil;
        end;

        if not (v451 and v452) then
            return;
        end;

        u420.CFrame = Root.CFrame * sample(v451.cat_cframe, v452);
        u420.Size = sample(v451.cat_size, v452);

        if v451 == u448 then
            if u449 <= v452 then
                fire_markers(v451, u449, v452);
            else
                fire_markers(v451, u449, v451.length);
                fire_markers(v451, -1, v452);
            end;
        else
            fire_markers(v451, v452 - 10, v452);
            u448 = v451;
        end;

        u449 = v452;

        if u447 and v451.blur_size then
            u447.Size = sample(v451.blur_size, v452);
        end;

        if u446 then
            if v451.cc_saturation then
                u446.Saturation = sample(v451.cc_saturation, v452);
            end;

            if v451.cc_contrast then
                u446.Contrast = sample(v451.cc_contrast, v452);
            end;

            if v451.cc_tint then
                u446.TintColor = sample(v451.cc_tint, v452);
            end;

            if v451.cc_brightness then
                u446.Brightness = sample(v451.cc_brightness, v452);
            end;
        end;

        if u418 and v451.fov then
            local v453 = sample(v451.fov, v452) - 70;
            local v454 = workspace_CurrentCamera2;
            v454.FieldOfView = v454.FieldOfView + (v453 - u450);
            u450 = v453;
        end;
    end));
    v419:Add(function() -- Line: 3046
        -- upvalues: u450 (ref), workspace_CurrentCamera2 (copy)
        if u450 ~= 0 then
            local v455 = workspace_CurrentCamera2;
            v455.FieldOfView = v455.FieldOfView - u450;
            u450 = 0;
        end;
    end);
end;

function v1.TsundereEmote(p456: any, p457: userdata) -- Line: 3054
    -- upvalues: ReplicatedStorage2 (copy), trove (copy)
    if not p457 or p457.Parent ~= p456 then
        return;
    end;

    local Tsundere = ReplicatedStorage2.emoteWiki:FindFirstChild("Tsundere");

    if not Tsundere then
        return;
    end;

    local Assets = Tsundere:FindFirstChild("Assets");
    local Animation = Tsundere:FindFirstChild("Animation");
    local LoopAnimation = Tsundere:FindFirstChild("LoopAnimation");
    local Head = p456:FindFirstChild("Head");
    local v458 = p456:FindFirstChild("Left Arm");
    local v459 = p456:FindFirstChild("Right Arm");
    local v460 = p456:FindFirstChildOfClass("Humanoid");

    if v460 then
        v460 = v460:FindFirstChildOfClass("Animator");
    end;

    if not (Assets and (Animation and (LoopAnimation and (Head and (v458 and (v459 and v460)))))) then
        return;
    end;

    local AnimationId = Animation.AnimationId;
    local AnimationId2 = LoopAnimation.AnimationId;
    local u461 = trove.new();
    u461:AttachToInstance(p457);
    local u462 = u461:Clone(Assets.angrything);
    u462.Parent = Head;
    local u463 = u461:Clone(Assets.exclamation);
    u463.Parent = Head;
    local u464 = u461:Clone(Assets.question);
    u464.Parent = Head;
    local v465 = u461:Clone(Assets.LeftArmTrail);
    v465.Parent = v458;
    local v466 = u461:Clone(Assets.RightArmTrail);
    v466.Parent = v459;
    local u467 = {};

    for _, v in { v465, v466 } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("Trail") then
                table.insert(u467, descendant);
            end;
        end;
    end;

    local function setTrails(p468: boolean) -- Line: 3104
        -- upvalues: u467 (copy)
        for _, v in u467 do
            v.Enabled = p468;
        end;
    end;

    local function watchTrack(p469: userdata) -- Line: 3110
        -- upvalues: AnimationId (copy), u461 (copy), u463 (copy), u464 (copy), u462 (copy), AnimationId2 (copy), u467 (copy)
        local v470 = p469.Animation and p469.Animation.AnimationId;

        if v470 == AnimationId then
            u461:Add(p469.KeyframeReached:Connect(function(p471) -- Line: 3113
                -- upvalues: u463 (ref), u464 (ref), u462 (ref)
                if p471 == "exclamation" and u463 then
                    shared.vfx.emit(u463);
                end;

                if p471 == "question" and u464 then
                    shared.vfx.emit(u464);
                end;

                if p471 == "anrg" then
                    shared.vfx.emit(u462);

                    for _, descendant in u462:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true;
                        end;
                    end;
                end;
            end));

            return;
        end;

        if v470 == AnimationId2 then
            for _, v in u467 do
                v.Enabled = false;
            end;
        end;
    end;

    for _, v in v460:GetPlayingAnimationTracks() do
        watchTrack(v);
    end;

    u461:Add(v460.AnimationPlayed:Connect(watchTrack));
end;

function v1.RampageEmote(u472: any, p473: userdata) -- Line: 3142
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), Players (copy), LocalPlayer (copy), Util (copy), trove (copy), Lighting (copy), clearHighlights (copy), RunService (copy), MoonPropertyAnimator (copy), TweenService (copy)
    if not p473 or p473.Parent ~= u472 then
        return;
    end;

    local Rampage = ReplicatedStorage2.emoteWiki:FindFirstChild("Rampage");
    local u474;

    if Rampage then
        u474 = Rampage:FindFirstChild("Assets");
    else
        u474 = Rampage;
    end;

    local Root = vfxUtil.getRoot(u472);

    if not (u474 and Root) then
        return;
    end;

    local CFrame_new_ret = CFrame.new(-58, 3, -101.5);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u472);
    local v475;

    if PlayerFromCharacter == nil then
        v475 = false;
    else
        v475 = PlayerFromCharacter == LocalPlayer;
    end;

    local v476;

    if v475 then
        v476 = not Util.isepilepsysafe();
    else
        v476 = v475;
    end;

    local u477 = trove.new();
    u477:AttachToInstance(p473);
    local u478 = {};

    for _, child in u474.Base:GetChildren() do
        if child:IsA("BasePart") then
            local v479 = u477:Clone(child);
            v479.Anchored = false;
            v479.CanCollide = false;
            v479.CanQuery = false;
            v479.CanTouch = false;
            v479.Massless = true;
            v479.CFrame = Root.CFrame;
            v479.Parent = u472;
            u478[child.Name] = v479;
            local v480 = u474.Joints:FindFirstChild(child.Name);

            if v480 and v480:IsA("Motor6D") then
                local v481 = u477:Clone(v480);
                v481.Part0 = Root;
                v481.Part1 = v479;
                v481.Parent = Root;
            end;

            for _, descendant in v479:GetDescendants() do
                if descendant:IsA("TextLabel") then
                    descendant.TextTransparency = 1;
                end;
            end;
        end;
    end;

    local u482 = {};

    if u478.bluelocku then
        for _, descendant in u478.bluelocku:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                u482[descendant] = descendant.ImageTransparency;
                descendant.ImageTransparency = 1;
            end;
        end;
    end;

    local u483;

    if PlayerFromCharacter then
        u483 = PlayerFromCharacter:FindFirstChild("leaderstats");
    else
        u483 = PlayerFromCharacter;
    end;

    local u484;

    if PlayerFromCharacter then
        u484 = PlayerFromCharacter:GetAttribute("HideStats");
    else
        u484 = PlayerFromCharacter;
    end;

    local function statValue(p485: string) -- Line: 3209
        -- upvalues: u484 (copy), u483 (copy)
        if u484 then
            return "???";
        end;

        local v486 = u483 and u483:FindFirstChild(p485);

        return not v486 and "0" or tostring(v486.Value);
    end;

    local u487 = {};
    local v488 = {};
    local v489 = { "goals", "goals2" };
    local v490;

    if u484 then
        v490 = "???";
    else
        local v491;

        if u483 then
            v491 = u483:FindFirstChild("goals");
        else
            v491 = u483;
        end;

        v490 = not v491 and "0" or tostring(v491.Value);
    end;

    v488[1], v488[2], v488[3] = "Stat1", v489, `GOL : {v490}`;
    local v492 = {};
    local v493 = { "wins", "wins2" };
    local v494;

    if u484 then
        v494 = "???";
    else
        local v495;

        if u483 then
            v495 = u483:FindFirstChild("wins");
        else
            v495 = u483;
        end;

        v494 = not v495 and "0" or tostring(v495.Value);
    end;

    v492[1], v492[2], v492[3] = "Stat2", v493, `WINS : {v494}`;
    local v496 = {};
    local v497 = { "saves", "saves2" };
    local v498;

    if u484 then
        v498 = "???";
    else
        if u483 then
            u483 = u483:FindFirstChild("saves");
        end;

        v498 = not u483 and "0" or tostring(u483.Value);
    end;

    v496[1], v496[2], v496[3] = "Stat3", v497, `SAV : {v498}`;
    u487[1], u487[2], u487[3] = v488, v492, v496;

    local function applyStatTexts() -- Line: 3222
        -- upvalues: u487 (copy), u478 (copy)
        for _, v in u487 do
            local v499 = u478[v[1]];

            if v499 then
                local v500 = v;

                for _, descendant in v499:GetDescendants() do
                    if descendant:IsA("TextLabel") and table.find(v500[2], descendant.Name) then
                        descendant.Text = v500[3];
                    end;
                end;
            end;
        end;
    end;

    applyStatTexts();
    local u501 = {};

    if v476 then
        for _, child in u474.Visuals:GetChildren() do
            local v502 = u477:Clone(child);
            v502.Parent = Lighting;
            u501[child.Name] = v502;
        end;

        local mainHL = u474.AnotherAssets:FindFirstChild("mainHL");

        if mainHL then
            clearHighlights(u472);
            local v503 = u477:Clone(mainHL);
            v503.Adornee = u472;
            v503.Parent = u472;
            u501.mainHL = v503;
        end;
    end;

    if v475 then
        local u504 = u477:Add(Instance.new("Camera"));
        u504.FieldOfView = 70;
        u501.CurrentCamera = u504;
        local u505 = 0;
        u477:Add(RunService.PreRender:Connect(function() -- Line: 3262
            -- upvalues: u504 (copy), u505 (ref)
            local v506 = u504.FieldOfView - 70;

            if v506 ~= u505 then
                local workspace_CurrentCamera2 = workspace.CurrentCamera;
                workspace_CurrentCamera2.FieldOfView = workspace_CurrentCamera2.FieldOfView + (v506 - u505);
                u505 = v506;
            end;
        end));
        u477:Add(function() -- Line: 3269
            -- upvalues: u505 (ref)
            local workspace_CurrentCamera2 = workspace.CurrentCamera;
            workspace_CurrentCamera2.FieldOfView = workspace_CurrentCamera2.FieldOfView - u505;
            u505 = 0;
        end);
    end;

    local function conversions(p507: table) -- Line: 3275
        -- upvalues: u501 (copy), u478 (copy)
        local table_clone_ret = table.clone(u501);

        for i, v in u478 do
            table_clone_ret[i] = v;
        end;

        for i, v in p507 do
            table_clone_ret[i] = v;
        end;

        return table_clone_ret;
    end;

    local function playMoon(p508: any, p509: userdata, p510: any) -- Line: 3286
        -- upvalues: MoonPropertyAnimator (ref), applyStatTexts (copy), CFrame_new_ret (copy), Root (copy)
        local v511 = p508:Construct(MoonPropertyAnimator);
        v511:LoadAndConvertSave(p509, p510);

        for i = #v511._tracks, 1, -1 do
            local v512 = v511._tracks[i];
            local v513;

            if v512.Property == "Text" or v512.Property == "MaxVisibleGraphemes" then
                table.remove(v511._tracks, i);
                v513 = i;
            else
                v513 = i;
            end;
        end;

        applyStatTexts();
        v511:SetOriginalRoot(CFrame_new_ret);
        v511:SetRoot(Root);
        v511:PlayAll();

        return v511;
    end;

    local u514 = { "Shirt", "Pants", "ShirtGraphic", "BodyColors", "CharacterMesh" };

    local function copyAppearance(p515: userdata) -- Line: 3305
        -- upvalues: u472 (copy), u514 (copy)
        local v516 = p515:FindFirstChildOfClass("Humanoid");

        for _, child in u472:GetChildren() do
            if table.find(u514, child.ClassName) then
                local v517 = child.ClassName ~= "CharacterMesh" and p515:FindFirstChildOfClass(child.ClassName);

                if v517 then
                    v517:Destroy();
                end;

                local v518 = child:Clone();

                if v518 then
                    v518.Parent = p515;
                end;
            elseif child:IsA("Accessory") and v516 then
                local v519 = child:Clone();
                local v520;

                if v519 then
                    v520 = v519:FindFirstChild("Handle");
                else
                    v520 = v519;
                end;

                if v520 and v520:IsA("BasePart") then
                    for _, child2 in v520:GetChildren() do
                        if child2:IsA("JointInstance") or child2:IsA("WeldConstraint") then
                            child2:Destroy();
                        end;
                    end;

                    v520.Anchored = false;
                    v520.CanCollide = false;
                    v520.CanQuery = false;
                    v520.CanTouch = false;
                    v520.Massless = true;
                    v516:AddAccessory(v519);
                end;
            end;
        end;

        local Head = u472:FindFirstChild("Head");
        local Head2 = p515:FindFirstChild("Head");

        if Head and Head2 then
            for _, child in Head2:GetChildren() do
                if child:IsA("DataModelMesh") or child:IsA("Decal") then
                    child:Destroy();
                end;
            end;

            for _, child in Head:GetChildren() do
                if child:IsA("DataModelMesh") or child:IsA("Decal") then
                    local v521 = child:Clone();

                    if v521 then
                        v521.Parent = Head2;
                    end;
                end;
            end;
        end;

        for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
            local v522 = u472:FindFirstChild(v);
            local v523 = p515:FindFirstChild(v);

            if v522 and (v523 and (v522:IsA("BasePart") and v523:IsA("BasePart"))) then
                v523.Color = v522.Color;
            end;
        end;
    end;

    local function makeAfterimage(p524: any, p525: string) -- Line: 3368
        -- upvalues: vfxUtil (ref), Root (copy), PlayerFromCharacter (copy), Players (ref), u472 (copy), copyAppearance (copy), u474 (copy)
        local u526 = vfxUtil.newRig(Root);
        p524:Add(u526);
        u526.PrimaryPart = u526:FindFirstChild("HumanoidRootPart");
        local u527 = PlayerFromCharacter and PlayerFromCharacter.UserId;
        task.spawn(function() -- Line: 3375
            -- upvalues: u526 (copy), u527 (copy), Players (ref), u472 (ref), copyAppearance (ref)
            local v528 = u526:FindFirstChildOfClass("Humanoid");

            if not v528 then
                return;
            end;

            local v529 = nil;
            local v530;

            if u527 then
                local v531;
                v531, v530 = pcall(Players.GetHumanoidDescriptionFromUserId, Players, u527);

                if not v531 then
                    v530 = v529;
                end;
            else
                v530 = v529;
            end;

            local v532;

            if v530 then
                v532 = v530;
            else
                local u533 = u472:FindFirstChildOfClass("Humanoid");
                local v534;
                v534, v532 = pcall(function() -- Line: 3390
                    -- upvalues: u533 (copy)
                    local v535 = u533 and u533:GetAppliedDescription();

                    return v535;
                end);

                if not v534 then
                    v532 = v530;
                end;
            end;

            if not u526.Parent then
                return;
            end;

            if v532 and pcall(v528.ApplyDescriptionAsync, v528, v532) then
                return;
            end;

            copyAppearance(u526);
        end);
        local v536 = u474.AnotherAssets:FindFirstChild(p525);

        if v536 then
            local v537 = v536:Clone();
            v537.Adornee = u526;
            v537.Parent = u526;
        end;

        return u526;
    end;

    local function playOnRig(p538: userdata, p539: userdata?, p540: boolean) -- Line: 3416
        if not p539 or p539.AnimationId == "" then
            return nil;
        end;

        local v541 = p538:FindFirstChildOfClass("Humanoid");

        if not v541 then
            return nil;
        end;

        local v542 = v541:FindFirstChildOfClass("Animator");

        if not v542 then
            v542 = Instance.new("Animator");
            v542.Parent = v541;
        end;

        local v543 = v542:LoadAnimation(p539);
        v543.Looped = p540;
        v543:Play(0);

        return v543;
    end;

    local v544 = u477:Extend();
    local u545 = makeAfterimage(v544, "Highlight");
    playOnRig(u545, Rampage:FindFirstChild("Animation"), false);
    v544:Add(RunService.PreRender:Connect(function() -- Line: 3464
        -- upvalues: u545 (copy), Root (copy)
        if u545.Parent then
            u545:PivotTo(Root.CFrame);
        end;
    end));
    local rampage_startup = u474.MoonFiles.rampage_startup;
    local table_clone_ret = table.clone(u501);
    local u546 = v544;
    local v547 = {
        afterimage1 = u545
    };

    local function liveVisibleParts(p548: userdata) -- Line: 3436
        -- upvalues: u477 (copy)
        local u549 = {};

        local function consider(p550: userdata) -- Line: 3438
            -- upvalues: u549 (copy)
            if p550.Name == "HumanoidRootPart" then
                return;
            end;

            if p550:IsA("BasePart") or (p550:IsA("Decal") or p550:IsA("Texture")) then
                p550.Transparency = 1;
                table.insert(u549, p550);
            end;
        end;

        for _, descendant in p548:GetDescendants() do
            if descendant.Name ~= "HumanoidRootPart" then
                if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                    table.insert(u549, descendant);
                end;
            end;
        end;

        u477:Add(p548.DescendantAdded:Connect(consider));
        u477:Add(p548.DescendantRemoving:Connect(function(p551) -- Line: 3451
            -- upvalues: u549 (copy)
            local table_find_ret = table.find(u549, p551);

            if table_find_ret then
                table.remove(u549, table_find_ret);
            end;
        end));

        return u549;
    end;

    for i, v in u478 do
        table_clone_ret[i] = v;
    end;

    for i, v in v547 do
        table_clone_ret[i] = v;
    end;

    playMoon(v544, rampage_startup, table_clone_ret);
    local u552 = makeAfterimage(u477, "Highlight2");
    local u553 = liveVisibleParts(u552);
    local u554 = nil;
    local u555 = nil;

    local function startLoopCycle() -- Line: 3477
        -- upvalues: u555 (ref), u477 (copy), u554 (ref), playOnRig (copy), u552 (copy), Rampage (copy), playMoon (copy), u474 (copy), u501 (copy), u478 (copy), u553 (copy)
        if u555 then
            u477:Remove(u555);
        end;

        u555 = u477:Extend();

        if u554 then
            u554.TimePosition = 0;
        else
            u554 = playOnRig(u552, Rampage:FindFirstChild("AfterimageLoop"), true);
        end;

        local rampage_loop = u474.MoonFiles.rampage_loop;
        local v556 = {
            afterimage2 = u552
        };
        local table_clone_ret2 = table.clone(u501);

        for i, v in u478 do
            table_clone_ret2[i] = v;
        end;

        for i, v in v556 do
            table_clone_ret2[i] = v;
        end;

        for _, v in playMoon(u555, rampage_loop, table_clone_ret2)._tracks do
            if v.Class == "ModelTransparency" and v.Object == u552 then
                v._descendants = u553;
            end;
        end;
    end;

    local u557 = 0;
    local u558 = false;
    u477:Add(RunService.Heartbeat:Connect(function(p559) -- Line: 3499
        -- upvalues: u557 (ref), u558 (ref), u477 (copy), u546 (copy), u482 (copy), TweenService (ref), startLoopCycle (copy)
        u557 = u557 + p559;

        if u558 then
            if u557 >= 19.033333333333335 then
                u557 = u557 % 19.033333333333335;
                startLoopCycle();
            end;

            return;
        end;

        if u557 < 1.4333333333333333 then
            return;
        end;

        u558 = true;
        u557 = u557 - 1.4333333333333333;
        u477:Remove(u546);

        for i, v in u482 do
            TweenService:Create(i, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = v
            }):Play();
        end;

        startLoopCycle();
    end));
end;

function v1.TrophyEmote(u560: userdata, p561: userdata) -- Line: 3526
    -- upvalues: trove (copy), ReplicatedStorage2 (copy), LocalPlayer (copy), Util (copy)
    if not p561 or p561.Parent ~= u560 then
        return;
    end;

    local v562 = trove.new();
    v562:AttachToInstance(p561);
    local AZLTrophy = u560.AZLTrophy;
    v562:Add(task.delay(0.5, function() -- Line: 3537
        -- upvalues: AZLTrophy (copy), ReplicatedStorage2 (ref), u560 (copy), LocalPlayer (ref), Util (ref)
        AZLTrophy.Trophy.Transparency = 0;
        require(ReplicatedStorage2.mvputils.highlight_emit).tweenHighlight(AZLTrophy.Trophy, Color3.fromRGB(209, 172, 61), Color3.fromRGB(255, 178, 46), 0.25, Enum.HighlightDepthMode.Occluded, "In", -3);
        local v563 = {};

        for _, descendant in AZLTrophy:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            elseif descendant:IsA("ParticleEmitter") then
                if (descendant:GetAttribute("EmitDuration") or 0) >= 15 then
                    descendant.Enabled = true;
                else
                    v563[descendant.Parent] = true;
                end;
            end;
        end;

        for i in v563 do
            shared.vfx.emit(i);
        end;

        if u560 == LocalPlayer.Character and not Util.isepilepsysafe() then
            require(ReplicatedStorage2.mvputils.colorcorrection_emit)(0.15, 0.3, 0.55, Color3.fromRGB(255, 244, 190), 0.4);
        end;
    end));
end;

function v1.GrooveEmote(p564: any, p565: userdata) -- Line: 3572
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), animationUtil (copy)
    if not p565 or p565.Parent ~= p564 then
        return;
    end;

    local groove = ReplicatedStorage2.emoteWiki.groove;
    local Root = vfxUtil.getRoot(p564);

    if not Root then
        return;
    end;

    local v566 = trove.new();
    v566:AttachToInstance(p565);
    local v567 = v566:Add(animationUtil:loadAnimation(v566:Add(vfxUtil.newRigForFriend(Root)), groove.Victim), "Stop");
    v567.Looped = true;
    v567:Play(0);
end;

function v1.mintemoteEmote(p568: any, p569: userdata) -- Line: 3593
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p569 or p569.Parent ~= p568 then
        return;
    end;

    local mintemote = ReplicatedStorage2.emoteWiki.mintemote;

    if not vfxUtil.getRoot(p568) then
        return;
    end;

    local v570 = trove.new();
    v570:AttachToInstance(p569);
    vfxUtil.buildFromRig(p568, mintemote.R6, v570);
end;

function v1.rageEmote(p571: any, p572: userdata) -- Line: 3610
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p572 or p572.Parent ~= p571 then
        return;
    end;

    local rage = ReplicatedStorage2.emoteWiki.rage;

    if not vfxUtil.getRoot(p571) then
        return;
    end;

    local v573 = trove.new();
    v573:AttachToInstance(p572);
    vfxUtil.buildFromRig(p571, rage.R6, v573);
end;

function v1.timestickingEmote(p574: any, p575: userdata) -- Line: 3627
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p575 or p575.Parent ~= p574 then
        return;
    end;

    local timesticking = ReplicatedStorage2.emoteWiki.timesticking;

    if not vfxUtil.getRoot(p574) then
        return;
    end;

    local v576 = trove.new();
    v576:AttachToInstance(p575);
    vfxUtil.buildFromRig(p574, timesticking.R6, v576);
end;

function v1.buildemoteVFX(p577: any, p578: string, p579: userdata) -- Line: 3644
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy)
    if not p579 or p579.Parent ~= p577 then
        return;
    end;

    local v580 = ReplicatedStorage2.emoteWiki[p578];

    if not vfxUtil.getRoot(p577) then
        return;
    end;

    local v581 = trove.new();
    v581:AttachToInstance(p579);
    vfxUtil.buildFromRig(p577, v580.R6, v581);
end;

function v1.crashoutEmote(p582: any, p583: userdata) -- Line: 3662
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), mainreplication (copy)
    if not p583 or p583.Parent ~= p582 then
        return;
    end;

    local crashout = ReplicatedStorage2.emoteWiki.crashout;
    local Root = vfxUtil.getRoot(p582);

    if not Root then
        return;
    end;

    local v584 = trove.new();
    v584:AttachToInstance(p583);
    vfxUtil.buildFromRig(p582, crashout.R6, v584);

    if not vfxUtil.isLocalPlayer(p582) then
        return;
    end;

    local v585 = mainreplication.bodyVelocity(Root, 8, "inf", false, nil, nil, nil, -1);

    if v585 then
        v584:Add(v585);
    end;
end;

function v1.kenkeshisinglesEmote(u586: any, p587: userdata) -- Line: 3687
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), LocalPlayer (copy), RunService (copy), Util (copy), mainreplication (copy)
    if not p587 or p587.Parent ~= u586 then
        return;
    end;

    local kenkeshisingles = ReplicatedStorage2.emoteWiki.kenkeshisingles;

    if not vfxUtil.getRoot(u586) then
        return;
    end;

    local v588 = trove.new();
    v588:AttachToInstance(p587);
    local u589 = v588:Clone(kenkeshisingles.VFX);
    u589:PivotTo(u586:GetPivot());
    u589.Parent = workspace.Effects;
    v588:Extend();
    local u590;

    if u586 == LocalPlayer.Character then
        u590 = require(ReplicatedStorage2.mvputils.colorcorrection_emit);
    else
        u590 = nil;
    end;

    local u591 = 0;
    v588:Add(RunService.PreRender:Connect(function(p592) -- Line: 3711
        -- upvalues: u589 (copy), u586 (copy), u590 (copy), u591 (ref), Util (ref), mainreplication (ref)
        if u589 then
            u589:PivotTo(u586:GetPivot());
        end;

        if u590 then
            u591 = u591 + p592;

            if u591 >= 0.458 then
                u591 = u591 % 0.458;

                if not Util.isepilepsysafe() then
                    mainreplication.cameraShake(4, 0.2, 1.5);
                    u590(0.15, 0.3, 0.55, Color3.fromRGB(255, 244, 190), 0.4);
                end;
            end;
        end;
    end));
end;

function v1.nagiPhoneEmote(p593: any, p594: userdata) -- Line: 3729
    -- upvalues: ReplicatedStorage2 (copy), trove (copy), vfxUtil (copy)
    if not p594 or p594.Parent ~= p593 then
        return;
    end;

    local NagiPhone = ReplicatedStorage2.emoteWiki.NagiPhone;
    local v595 = trove.new();
    v595:AttachToInstance(p594);
    local _, v596 = vfxUtil.buildFromRig(p593, NagiPhone.rig, v595);
    vfxUtil.execute_compiled(NagiPhone.Compiled, v595, v596);
end;

function v1.allieverwantedEmote(u597: any, u598: userdata) -- Line: 3744
    -- upvalues: LocalPlayer (copy), ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), Lighting (copy), MoonPropertyAnimator (copy), RunService (copy)
    if not (u598 and (u598.Parent == u597 and u597 == LocalPlayer.Character)) then
        return;
    end;

    local allieverwanted = ReplicatedStorage2.emoteWiki.allieverwanted;
    local Root = vfxUtil.getRoot(u597);
    local v599 = u597:FindFirstChildOfClass("Humanoid");

    if v599 then
        v599 = v599:FindFirstChildOfClass("Animator");
    end;

    local workspace_CurrentCamera2 = workspace.CurrentCamera;

    if not (Root and (v599 and workspace_CurrentCamera2)) then
        return;
    end;

    local u600 = trove.new();
    u600:AttachToInstance(u598);
    local v601 = u600:Add(Instance.new("ColorCorrectionEffect"));
    v601.Name = "AllieverwantedColorCorrection";
    v601.Parent = Lighting;
    local v602 = u600:Add(Instance.new("BlurEffect"));
    v602.Name = "BlurImpact";
    v602.Size = 0;
    v602.Parent = Lighting;
    local u603 = u600:Add(Instance.new("Camera"));
    u603.FieldOfView = 70;
    local v604 = {
        ColorCorrection = v601,
        BlurImpact = v602,
        CurrentCamera = u603
    };
    local v605 = u600:Construct(MoonPropertyAnimator);
    v605:SetRoot(Root);
    local u606 = v605:LoadAndConvertSave(allieverwanted.Moon, v604);
    local v607 = u600:Construct(MoonPropertyAnimator);
    v607:SetRoot(Root);
    local u608 = v607:LoadAndConvertSave(allieverwanted.StartupMoon, v604);
    local u609 = {};
    local FieldOfView = workspace_CurrentCamera2.FieldOfView;
    local u610 = nil;
    u600:Add(function() -- Line: 3782
        -- upvalues: u610 (ref), workspace_CurrentCamera2 (copy), FieldOfView (copy)
        if u610 and workspace_CurrentCamera2.FieldOfView == u610 then
            workspace_CurrentCamera2.FieldOfView = FieldOfView;
        end;
    end);
    u600:Connect(v599.AnimationPlayed, function(p611) -- Line: 3788
        -- upvalues: allieverwanted (copy), u609 (copy), u608 (copy), u606 (copy)
        local Animation = p611.Animation;

        if not (Animation and p611.IsPlaying) then
            return;
        end;

        if Animation.AnimationId ~= allieverwanted.Animation.AnimationId then
            if Animation.AnimationId == allieverwanted.LoopAnimation.AnimationId then
                u609.track = p611;
                u609.tracks = u606;
            end;

            return;
        end;

        u609.track = p611;
        u609.tracks = u608;
    end);

    for _, v in v599:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation and v.IsPlaying then
            if Animation.AnimationId == allieverwanted.Animation.AnimationId then
                u609.track = v;
                u609.tracks = u608;
            elseif Animation.AnimationId == allieverwanted.LoopAnimation.AnimationId then
                u609.track = v;
                u609.tracks = u606;
            end;
        end;
    end;

    u600:Connect(RunService.PreRender, function() -- Line: 3813
        -- upvalues: u598 (copy), u597 (copy), LocalPlayer (ref), workspace_CurrentCamera2 (copy), u600 (copy), u609 (copy), MoonPropertyAnimator (ref), u603 (copy), u610 (ref)
        if u598.Parent ~= u597 or (u597 ~= LocalPlayer.Character or workspace.CurrentCamera ~= workspace_CurrentCamera2) then
            u600:Destroy();

            return;
        end;

        if not (u609.track and u609.track.IsPlaying) then
            return;
        end;

        local TimePosition = u609.track.TimePosition;

        for _, v in u609.tracks do
            for _, v2 in v do
                local Frames = v2.Frames;

                if #Frames ~= 0 then
                    local v612 = #Frames;
                    local v613 = v2;
                    local v614 = 1;

                    while v614 <= v612 do
                        local v615 = (v614 + v612) // 2;

                        if Frames[v615].KeyframeTime <= TimePosition then
                            v614 = v615 + 1;
                        else
                            v612 = v615 - 1;
                        end;
                    end;

                    local math_clamp_ret = math.clamp(v612, 1, #Frames);
                    local v616 = Frames[math_clamp_ret];
                    local v617 = Frames[math_clamp_ret + 1] or v616;
                    local v618 = v617.KeyframeTime - v616.KeyframeTime;
                    local v619 = v618 > 0 and (math.clamp((TimePosition - v616.KeyframeTime) / v618, 0, 1) or 1) or 1;
                    local v620 = MoonPropertyAnimator.LerpSolution(v613.Class, v613:ResolveValue(v616.Value), v613:ResolveValue(v617.Value), v619, v616.EasingStyle, v616.EasingDirection);
                    v613.TimePosition = TimePosition;
                    v613:Update(v620);
                end;
            end;
        end;

        workspace_CurrentCamera2.FieldOfView = u603.FieldOfView;
        u610 = workspace_CurrentCamera2.FieldOfView;
    end);
end;

function v1.whatisloveEmote(p621: any, p622: userdata) -- Line: 3852
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), RunService (copy)
    if not p622 or p622.Parent ~= p621 then
        return;
    end;

    local whatislove = ReplicatedStorage2.emoteWiki.whatislove;
    local Root = vfxUtil.getRoot(p621);

    if not Root then
        return;
    end;

    local v623 = trove.new();
    v623:AttachToInstance(p622);
    local u624 = v623:Clone(whatislove.Effects);
    u624:PivotTo(Root.CFrame);
    u624.Parent = workspace.Effects;
    local u625 = v623:Extend();
    local u626 = 0;

    local function u627() -- Line: 3874
        -- upvalues: u625 (copy), u624 (copy), u626 (ref)
        u625:Clean();

        for _, v in {
            { 432, u624.Effects.Word1 },
            { 445, u624.Effects.Word2 },
            { 469, u624.Effects.Word3 }
        } do
            u625:Add(task.delay(math.max(0, v[1] / 60 - u626), function() -- Line: 3882
                -- upvalues: v (copy)
                shared.vfx.emit(v[2]);
            end));
        end;
    end;

    u627();
    v623:Add(RunService.PreRender:Connect(function(p628) -- Line: 3890
        -- upvalues: u624 (copy), Root (copy), u626 (ref), u627 (copy)
        u624:PivotTo(Root.CFrame);
        u626 = u626 + p628;

        if u626 >= 15.616666666666667 then
            u626 = u626 % 15.616666666666667;
            u627();
        end;
    end));
end;

function v1.fridaynightEmote(p629: any, p630: userdata) -- Line: 3903
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), trove (copy), MoonPropertyAnimator (copy), RunService (copy)
    if not p630 or p630.Parent ~= p629 then
        return;
    end;

    local fridaynight = ReplicatedStorage2.emoteWiki.fridaynight;
    local Root = vfxUtil.getRoot(p629);

    if not Root then
        return;
    end;

    local v631 = trove.new();
    v631:AttachToInstance(p630);
    local u632 = v631:Clone(fridaynight.Effects);
    local u633 = v631:Extend();
    local u634 = 0;

    local function u636() -- Line: 3923
        -- upvalues: u633 (copy), MoonPropertyAnimator (ref), fridaynight (copy), u632 (copy), Root (copy), u634 (ref), vfxUtil (ref)
        u633:Clean();
        local v635 = u633:Add(MoonPropertyAnimator.new());
        v635:LoadAndConvertSave(fridaynight.Moon, {
            Effects = u632
        });
        v635:SetOriginalRoot(CFrame.identity);
        v635:SetRoot(Root);

        for _, v in v635._tracks do
            v.TimePosition = u634;
            v:Update(v:ResolveValue(v.Frames[1].Value));
        end;

        v635:PlayAll();

        for _, v in {
            { 48, u632.Burst9.ParticleEmitter },
            { 93, u632.Burst1.ParticleEmitter },
            { 135, u632.Burst8.ParticleEmitter },
            { 135, u632.Burst7.ParticleEmitter },
            { 135, u632.Burst6.ParticleEmitter },
            { 197, u632.Burst2.ParticleEmitter },
            { 260, u632.Burst5.ParticleEmitter },
            { 300, u632.Burst3.ParticleEmitter }
        } do
            u633:Add(task.delay(math.max(0, v[1] / 60 - u634), function() -- Line: 3948
                -- upvalues: vfxUtil (ref), v (copy)
                vfxUtil.emit(v[2]);
            end));
        end;
    end;

    u636();
    u632.Parent = workspace.Effects;
    v631:Add(RunService.PreRender:Connect(function(p637) -- Line: 3957
        -- upvalues: u634 (ref), u636 (copy)
        u634 = u634 + p637;

        if u634 >= 6.1 then
            u634 = u634 % 6.1;
            u636();
        end;
    end));
end;

local table_freeze_ret = table.freeze({
    Quad = 2,
    Cubic = 3,
    Quart = 4,
    Quint = 5,
    Sextic = 6
});

local function robinsp_ease(p638: number, p639: string?, p640: string?) -- Line: 3975
    -- upvalues: table_freeze_ret (copy), TweenService (copy)
    if p639 == "Constant" then
        return 0;
    end;

    local v641;

    if p639 then
        v641 = table_freeze_ret[p639];
    else
        v641 = p639;
    end;

    if v641 then
        if p640 == "In" then
            return p638 ^ v641;
        end;

        if p640 ~= "InOut" then
            return 1 - (1 - p638) ^ v641;
        end;

        if p638 < 0.5 then
            return 2 ^ (v641 - 1) * p638 ^ v641;
        end;

        return 1 - (p638 * -2 + 2) ^ v641 / 2;
    end;

    if p639 == nil or p639 == "Linear" then
        return p638;
    end;

    local success, result = pcall(TweenService.GetValue, TweenService, p638, Enum.EasingStyle[p639], Enum.EasingDirection[p640 or "Out"]);

    if success then
        return result;
    end;

    return p638;
end;

local function robinsp_sample(p642: table, p643: number) -- Line: 3998
    -- upvalues: robinsp_ease (copy)
    local v644 = p642[1];

    if p643 <= v644[1] then
        return v644[2];
    end;

    for i = 1, #p642 - 1 do
        local v645 = p642[i];
        local v646 = p642[i + 1];

        if p643 < v646[1] then
            local v647 = robinsp_ease((p643 - v645[1]) / (v646[1] - v645[1]), v645[3], v645[4]);
            local v648 = v645[2];

            if typeof(v648) == "number" then
                return v648 + (v646[2] - v648) * v647;
            end;

            return v648:Lerp(v646[2], v647);
        end;

        local _ = i;
    end;

    return p642[#p642][2];
end;

function v1.robinsp_emote(p649: any, p650: userdata, u651: userdata?) -- Line: 4018
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), LocalPlayer (copy), trove (copy), Util (copy), Lighting (copy), PlayerGui (copy), RunService (copy), robinsp_sample (copy)
    if not p650 or p650.Parent ~= p649 then
        return;
    end;

    local RobinSP = ReplicatedStorage2.emoteWiki:FindFirstChild("RobinSP");
    local v652;

    if RobinSP then
        v652 = RobinSP:FindFirstChild("tracks");
    else
        v652 = RobinSP;
    end;

    local v653;

    if RobinSP then
        v653 = RobinSP:FindFirstChild("Effects");
    else
        v653 = RobinSP;
    end;

    local v654;

    if RobinSP then
        v654 = RobinSP:FindFirstChild("Pop");
    else
        v654 = RobinSP;
    end;

    local v655;

    if RobinSP then
        v655 = RobinSP:FindFirstChild("Animation");
    else
        v655 = RobinSP;
    end;

    local Root = vfxUtil.getRoot(p649);
    local v656 = p649:FindFirstChild("Right Arm");
    local v657 = p649:FindFirstChildOfClass("Humanoid");

    if v657 then
        v657 = v657:FindFirstChildOfClass("Animator");
    end;

    if not (v652 and (v653 and (v654 and (v655 and (Root and (v656 and v657)))))) then
        return;
    end;

    local u658 = require(v652);
    local fps = u658.fps;
    local string_match_ret = string.match(v655.AnimationId, "%d+");
    local v659 = p649 == LocalPlayer.Character;
    local v660 = trove.new();
    v660:AttachToInstance(p650);
    local v661 = v660:Clone(v653);
    local u662 = {};
    local u663 = {};

    for _, descendant in v661:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            table.insert(u662, descendant);
            table.insert(u663, descendant.CFrame);
        end;
    end;

    local function place_effects() -- Line: 4058
        -- upvalues: u662 (copy), Root (copy), u663 (copy)
        local table_create_ret = table.create(#u662);
        local CFrame2 = Root.CFrame;

        for i, v in u663 do
            table_create_ret[i] = CFrame2 * v;
        end;

        workspace:BulkMoveTo(u662, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    local table_create_ret = table.create(#u662);
    local CFrame2 = Root.CFrame;

    for i, v in u663 do
        table_create_ret[i] = CFrame2 * v;
    end;

    workspace:BulkMoveTo(u662, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
    v661.Parent = workspace:FindFirstChild("Effects") or workspace;
    local v664 = v660:Clone(v654);
    v664.Parent = v656;
    local u665 = {
        RobinBase = v661:FindFirstChild("RobinBase"),
        RobinCoffeti = v661:FindFirstChild("RobinCoffeti"),
        Pop = v664
    };

    local function u668(p666: string) -- Line: 4078
        -- upvalues: u665 (copy)
        local string_split_ret = string.split(p666, "/");
        local v667 = u665[string_split_ret[1]];

        for i = 2, #string_split_ret do
            if v667 then
                v667 = v667:FindFirstChild(string_split_ret[i]);
            end;

            local _ = i;
        end;

        return v667;
    end;

    local u669 = {};

    for i, v in u658.attachments do
        local v670 = u668(i);

        if v670 and v670:IsA("Attachment") then
            table.insert(u669, {
                target = v670,
                track = v
            });
        end;
    end;

    local u671 = nil;
    local v672 = nil;
    local u673 = Util.isepilepsysafe();
    local u674, u675;

    if v659 then
        local v676 = v660:Add(Instance.new("BlurEffect"));
        v676.Name = "robinsp_blur";
        v676.Size = 0;
        v676.Parent = Lighting;
        u674 = v676;
        local v677 = v660:Add(Instance.new("ColorCorrectionEffect"));
        v677.Name = "robinsp_grade";
        v677.Saturation = u658.color_correction.saturation;
        v677.Contrast = u658.color_correction.contrast;
        v677.Brightness = u658.color_correction.brightness;
        v677.Parent = Lighting;

        if not u673 then
            u671 = v660:Add(Instance.new("ColorCorrectionEffect"));
            u671.Name = "robinsp_impact";
            u671.Parent = Lighting;
        end;

        local Vignette = RobinSP:FindFirstChild("Vignette");

        if Vignette then
            local v678 = v660:Clone(Vignette);
            u675 = v678:FindFirstChild("Vignette");

            if u675 and u675:IsA("ImageLabel") then
                u675.ImageColor3 = u658.vignette.color;
                u675.ImageTransparency = 1;
            else
                u675 = v672;
            end;

            v678.Parent = PlayerGui;
        else
            u675 = v672;
        end;
    else
        u675 = v672;
        u674 = nil;
    end;

    local u679 = nil;

    local function v681(p680: userdata) -- Line: 4134
        -- upvalues: string_match_ret (copy), u679 (ref)
        local Animation = p680.Animation;

        if Animation and string.match(Animation.AnimationId, "%d+") == string_match_ret then
            u679 = p680;
        end;
    end;

    for _, v in v657:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation and string.match(Animation.AnimationId, "%d+") == string_match_ret then
            u679 = v;
        end;
    end;

    v660:Add(v657.AnimationPlayed:Connect(v681));
    local os_clock_ret = os.clock();

    local function current_frame() -- Line: 4146
        -- upvalues: u679 (ref), fps (copy), u658 (copy), os_clock_ret (copy)
        if u679 and u679.IsPlaying then
            return math.min(u679.TimePosition * fps, u658.length);
        end;

        local v682 = (os.clock() - os_clock_ret) * fps;

        return math.min(v682, u658.length);
    end;

    local function u686(p683: number, p684: number) -- Line: 4153
        -- upvalues: u658 (copy), u668 (copy)
        if not (shared.vfx and shared.vfx.emit) then
            return;
        end;

        for _, v in u658.markers do
            if p683 < v[1] and v[1] <= p684 then
                for _, v2 in v[2] do
                    local v685 = u668(v2);

                    if v685 then
                        shared.vfx.emit(v685);
                    end;
                end;
            end;
        end;
    end;

    local u687 = -1;
    local u688 = 1;
    local u689 = 0;
    v660:Add(RunService.PreRender:Connect(function(p690: number) -- Line: 4173
        -- upvalues: Root (copy), u662 (copy), u663 (copy), u679 (ref), fps (copy), u658 (copy), os_clock_ret (copy), u687 (ref), u686 (copy), u669 (copy), robinsp_sample (ref), u674 (ref), u671 (ref), u675 (ref), u651 (copy), u688 (ref), u673 (copy), u689 (ref)
        if not Root.Parent then
            return;
        end;

        local table_create_ret2 = table.create(#u662);
        local CFrame3 = Root.CFrame;

        for i, v in u663 do
            table_create_ret2[i] = CFrame3 * v;
        end;

        workspace:BulkMoveTo(u662, table_create_ret2, Enum.BulkMoveMode.FireCFrameChanged);
        local v691;

        if u679 and u679.IsPlaying then
            v691 = math.min(u679.TimePosition * fps, u658.length);
        else
            local v692 = (os.clock() - os_clock_ret) * fps;
            v691 = math.min(v692, u658.length);
        end;

        if u687 <= v691 then
            u686(u687, v691);
        end;

        u687 = v691;

        for _, v in u669 do
            v.target.CFrame = robinsp_sample(v.track, v691);
        end;

        if u674 then
            u674.Size = robinsp_sample(u658.blur_size, v691);
        end;

        if u671 then
            u671.Contrast = robinsp_sample(u658.impact_contrast, v691);
            u671.TintColor = robinsp_sample(u658.impact_tint, v691);
            u671.Brightness = robinsp_sample(u658.impact_brightness, v691);
        end;

        if u675 then
            local v693 = not (u651 and (u651.Parent and u651.IsPlaying)) and 0 or u651.PlaybackLoudness;
            local v694 = u688 * (1 - math.min(p690 * 0.25, 1));
            u688 = math.max(v693, v694, 50);
            local v695 = math.clamp(v693 / u688, 0, 1) ^ 2;

            if u673 then
                v695 = v695 * 0.35;
            end;

            local v696 = 1 - math.exp(-p690 * (u689 < v695 and 30 or 8));
            u689 = u689 + (v695 - u689) * v696;
            local transparency = u658.vignette.transparency;
            u675.ImageTransparency = transparency + (1 - transparency) * (1 - u689) * 0.85;
        end;
    end));
end;

local table_freeze_ret2 = table.freeze({ { 0, "title" }, { 358, "bottom" }, { 402, "L" }, { 426, "R" }, { 468, "L" }, { 528, "R" }, { 565, "L" }, { 608, "R" }, { 689, "L" }, { 719, "R" }, { 745, "L" }, { 797, "R" }, { 858, "L" }, { 919, "R" }, { 973, "L" }, { 997, "L" }, { 1024, "R" }, { 1046, "L" }, { 1069, "R" }, { 1120, "L" }, { 1161, "R" }, { 1209, "L" }, { 1255, "R" }, { 1327, "L" }, { 1354, "R" }, { 1376, "L" }, { 1399, "R" }, { 1439, "R" }, { 1493, "L" }, { 1566, "R" }, { 1612, "L" }, { 1643, "bottom" }, { 1664, "R" }, { 1682, "L" }, { 1711, "R" }, { 1766, "L" }, { 1801, "R" }, { 1848, "L" }, { 1898, "R" }, { 1944, "L" } });
local table_freeze_ret3 = table.freeze({ "CCimpact2", "BlurImpact", "CCimpact", "DepthOfField", "Bloom" });
local CFrame_new_ret = CFrame.new(-0.019500732421875, 0.4654707908630371, 0.36004638671875);

function v1.larpwalking_emote(p697: any, p698: userdata) -- Line: 4227
    -- upvalues: ReplicatedStorage2 (copy), vfxUtil (copy), LocalPlayer (copy), trove (copy), actionUtil (copy), CFrame_new_ret (copy), Util (copy), table_freeze_ret3 (copy), Lighting (copy), PlayerGui (copy), TweenService (copy), table_freeze_ret2 (copy), RunService (copy)
    if not p698 or p698.Parent ~= p697 then
        return;
    end;

    local larpwalking = ReplicatedStorage2.emoteWiki:FindFirstChild("larpwalking");
    local v699;

    if larpwalking then
        v699 = larpwalking:FindFirstChild("baked");
    else
        v699 = larpwalking;
    end;

    local v700;

    if larpwalking then
        v700 = larpwalking:FindFirstChild("Animation");
    else
        v700 = larpwalking;
    end;

    local Root = vfxUtil.getRoot(p697);
    local v701 = p697:FindFirstChildOfClass("Humanoid");

    if v701 then
        v701 = v701:FindFirstChildOfClass("Animator");
    end;

    if not (v699 and (v700 and (Root and v701))) then
        return;
    end;

    local shark_baked = require(ReplicatedStorage2.util.shark_baked);
    local u702 = shark_baked.load(v699);

    if not u702 then
        return;
    end;

    local string_match_ret = string.match(v700.AnimationId, "%d+");
    local fps = u702.fps;
    local u703 = p697 == LocalPlayer.Character;
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local v704 = workspace:FindFirstChild("Effects") or workspace;
    local v705 = trove.new();
    v705:AttachToInstance(p698);
    local v706 = v705:Clone(larpwalking.LokiMeme);
    v706.Parent = Root;
    local TitleText = v706:FindFirstChild("TitleText");
    local BottomText = v706:FindFirstChild("BottomText");
    local Icon = v706:FindFirstChild("Icon");
    local v707 = actionUtil.checkStyle(p697);
    local success, result = pcall(require, ReplicatedStorage2.wiki);
    local v708;

    if success and v707 then
        v708 = result.styles[v707] or nil;
    else
        v708 = nil;
    end;

    if TitleText then
        local TextLabel = TitleText:FindFirstChild("TextLabel");

        if TextLabel and TextLabel:IsA("TextLabel") then
            local v709;

            if v708 then
                v709 = v708.name or v707;
            else
                v709 = p697.Name;
            end;

            TextLabel.Text = string.gsub(TextLabel.Text, "Character", v709);
        end;
    end;

    if Icon then
        local Image = Icon:FindFirstChild("Image");
        local v710 = success and result.styles.isagi or nil;
        local v711 = v708 and v708.icon;

        if v711 then
            v710 = v711;
        elseif v710 then
            v710 = v710.icon;
        end;

        if Image and (Image:IsA("ImageLabel") and v710) then
            Image.Image = v710;
        end;
    end;

    local u712 = v705:Clone(larpwalking.F_R);
    u712.Parent = Root;
    local u713 = v705:Clone(larpwalking.F_L);
    u713.Parent = Root;
    local u714 = v705:Clone(larpwalking.LarpAura);
    u714.CFrame = Root.CFrame * CFrame_new_ret;
    u714.Parent = v704;

    local function show_title(p715: boolean) -- Line: 4290
        -- upvalues: TitleText (copy), Icon (copy), BottomText (copy)
        if TitleText then
            TitleText.Enabled = p715;
        end;

        if Icon then
            Icon.Enabled = p715;
        end;

        if BottomText then
            BottomText.Enabled = not p715;
        end;
    end;

    if TitleText then
        TitleText.Enabled = false;
    end;

    if Icon then
        Icon.Enabled = false;
    end;

    if BottomText then
        BottomText.Enabled = false;
    end;

    local function u716(...) -- Line: 4299
        if shared.vfx and shared.vfx.emit then
            shared.vfx.emit(...);
        end;
    end;

    local u717 = {
        title = function() -- Line: 4306, Name: title
            -- upvalues: TitleText (copy), Icon (copy), BottomText (copy)
            if TitleText then
                TitleText.Enabled = true;
            end;

            if Icon then
                Icon.Enabled = true;
            end;

            if BottomText then
                BottomText.Enabled = false;
            end;
        end,

        bottom = function() -- Line: 4309, Name: bottom
            -- upvalues: TitleText (copy), Icon (copy), BottomText (copy), u716 (copy), u714 (copy), u712 (copy)
            if TitleText then
                TitleText.Enabled = false;
            end;

            if Icon then
                Icon.Enabled = false;
            end;

            if BottomText then
                BottomText.Enabled = true;
            end;

            u716(u714, u712);
        end,

        R = function() -- Line: 4313, Name: R
            -- upvalues: u716 (copy), u712 (copy)
            u716(u712);
        end,

        L = function() -- Line: 4316, Name: L
            -- upvalues: u716 (copy), u713 (copy)
            u716(u713);
        end
    };
    local u718 = {};
    local u719 = {};
    local u720 = 0;
    local u721 = Util.isepilepsysafe();

    local function remember(u722: userdata, u723: string) -- Line: 4327
        -- upvalues: u719 (copy)
        local success2, result2 = pcall(function() -- Line: 4328
            -- upvalues: u722 (copy), u723 (copy)
            return u722[u723];
        end);

        if success2 then
            table.insert(u719, {
                target = u722,
                property = u723,
                value = result2
            });
        end;
    end;

    local v724 = v705:Clone(larpwalking.LarpWind);
    v724.Parent = v704;
    local u725 = v724;
    local LarpWind = u702.items.LarpWind;

    if LarpWind then
        LarpWind = LarpWind.props.CFrame;
    end;

    if u703 then
        for _, v in table_freeze_ret3 do
            local v726 = larpwalking.Lightings:FindFirstChild(v);

            if v726 then
                local u727 = v705:Clone(v726);
                pcall(function() -- Line: 4347
                    -- upvalues: u727 (copy), u721 (copy)
                    u727.Enabled = not u721;
                end);
                u727.Parent = Lighting;
                u718[v] = u727;
            end;
        end;

        u718.Lighting = Lighting;
        local v728 = Lighting:FindFirstChildOfClass("Atmosphere");

        if v728 then
            u718.Atmosphere = v728;
        end;

        local v729 = Lighting:FindFirstChildOfClass("SunRaysEffect");

        if v729 then
            u718.SunRays = v729;
        end;

        for _, v in { "Lighting", "Atmosphere", "SunRays" } do
            local v730 = u718[v];
            local v731 = u702.items[v];

            if v730 and v731 then
                for i in v731.props do
                    remember(v730, i);
                end;
            end;
        end;

        local Vignette = larpwalking:FindFirstChild("Vignette");

        if Vignette then
            local v732 = v705:Clone(Vignette);
            local Vignette2 = v732:FindFirstChild("Vignette");

            if Vignette2 then
                u718.Vignette = Vignette2;
            end;

            v732.Parent = PlayerGui;
        end;

        local v733 = v705:Add(Instance.new("ScreenGui"));
        v733.Name = "larpwalking_cover";
        v733.IgnoreGuiInset = true;
        v733.ResetOnSpawn = false;
        v733.DisplayOrder = 50;
        local Frame = Instance.new("Frame");
        Frame.Name = "Screen Cover";
        Frame.BorderSizePixel = 0;
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BackgroundTransparency = 1;
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.Parent = v733;
        v733.Parent = PlayerGui;
        u718["Screen Cover"] = Frame;
        v705:Add(function() -- Line: 4399
            -- upvalues: u719 (copy), Lighting (ref), TweenService (ref), u720 (ref), workspace_CurrentCamera2 (copy)
            for _, v in u719 do
                local target = v.target;

                if target.Parent or target == Lighting then
                    local value = v.value;

                    if typeof(value) == "number" or typeof(value) == "Color3" then
                        if not pcall(function() -- Line: 4405
                            -- upvalues: TweenService (ref), target (copy), v (copy), value (copy)
                            TweenService:Create(target, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                [v.property] = value
                            }):Play();
                        end) then
                            pcall(function() -- Line: 4409
                                -- upvalues: target (copy), v (copy), value (copy)
                                target[v.property] = value;
                            end);
                        end;
                    else
                        pcall(function() -- Line: 4414
                            -- upvalues: target (copy), v (copy), value (copy)
                            target[v.property] = value;
                        end);
                    end;
                end;
            end;

            if u720 ~= 0 then
                local v734 = workspace_CurrentCamera2;
                v734.FieldOfView = v734.FieldOfView - u720;
                u720 = 0;
            end;
        end);
    end;

    local u735 = nil;

    local function v737(p736: userdata) -- Line: 4428
        -- upvalues: string_match_ret (copy), u735 (ref)
        local Animation = p736.Animation;

        if Animation and string.match(Animation.AnimationId, "%d+") == string_match_ret then
            u735 = p736;
        end;
    end;

    for _, v in v701:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation and string.match(Animation.AnimationId, "%d+") == string_match_ret then
            u735 = v;
        end;
    end;

    v705:Add(v701.AnimationPlayed:Connect(v737));
    local os_clock_ret = os.clock();

    local function _() -- Line: 4440
        -- upvalues: u735 (ref), fps (copy), os_clock_ret (copy)
        if u735 and u735.IsPlaying then
            return u735.TimePosition * fps;
        end;

        return (os.clock() - os_clock_ret) * fps;
    end;

    local function fire(p738: number, p739: number) -- Line: 4447
        -- upvalues: table_freeze_ret2 (ref), u717 (copy)
        for _, v in table_freeze_ret2 do
            if p738 < v[1] and v[1] <= p739 then
                local v740 = u717[v[2]];

                if v740 then
                    v740();
                end;
            end;
        end;
    end;

    local function apply(p741: number) -- Line: 4458
        -- upvalues: u725 (ref), shark_baked (copy), LarpWind (copy), Root (copy), u703 (copy), u702 (copy), workspace_CurrentCamera2 (copy), u720 (ref), u718 (copy), u721 (copy)
        if u725 then
            local v742 = shark_baked.sample(LarpWind, p741);

            if typeof(v742) == "CFrame" then
                u725.CFrame = Root.CFrame * v742;
            end;
        end;

        if not u703 then
            return;
        end;

        for i, v in u702.items do
            if i == "CurrentCamera" then
                local v743 = shark_baked.sample(v.props.FieldOfView, p741);

                if typeof(v743) == "number" then
                    local v744 = v743 - 70;
                    local v745 = workspace_CurrentCamera2;
                    v745.FieldOfView = v745.FieldOfView + (v744 - u720);
                    u720 = v744;
                end;
            elseif i ~= "LarpWind" then
                local u746 = u718[i];

                if u746 then
                    for i2, v2 in v.props do
                        if i2 ~= "Enabled" or not u721 then
                            local u747 = shark_baked.sample(v2, p741);

                            if u747 ~= nil then
                                pcall(function() -- Line: 4485
                                    -- upvalues: u746 (copy), i2 (copy), u747 (copy)
                                    u746[i2] = u747;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local u748 = -1;
    v705:Add(RunService.PostSimulation:Connect(function() -- Line: 4497
        -- upvalues: Root (copy), u714 (copy), CFrame_new_ret (ref)
        if Root.Parent then
            u714.CFrame = Root.CFrame * CFrame_new_ret;
        end;
    end));
    v705:Add(RunService.PreRender:Connect(function() -- Line: 4502
        -- upvalues: Root (copy), u735 (ref), fps (copy), os_clock_ret (copy), u748 (ref), fire (copy), apply (copy)
        if not Root.Parent then
            return;
        end;

        local v749;

        if u735 and u735.IsPlaying then
            v749 = u735.TimePosition * fps;
        else
            v749 = (os.clock() - os_clock_ret) * fps;
        end;

        if u748 <= v749 then
            fire(u748, v749);
        else
            fire(u748, (1 / 0));
            fire(-1, v749);
        end;

        u748 = v749;
        apply(v749);
    end));
end;

return v1;