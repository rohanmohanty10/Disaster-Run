 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.client.replication.BezierCurve);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.VfxHandler);
require(ReplicatedStorage.wiki.styles);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local BackgroundHighlight = require(ReplicatedStorage.client.replication.BackgroundHighlight);
local script_Afterimage = require(script.Afterimage);
require(ReplicatedStorage.LensFlare.Modules.LensFlare);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local forge = vfxUtil.forge;
local u1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(102, 213, 90);

local function applyRecolor(p2, ...) -- Line: 39
    -- upvalues: Util (copy), LocalPlayer (copy), vfxUtil (copy), Color3_fromRGB_ret (copy)
    if Util.canshiftcolor(LocalPlayer, p2) then
        vfxUtil.LeanTowardsColor({ ... }, p2:GetAttribute("CustomColor") or Color3_fromRGB_ret, p2:GetAttribute("CustomAlpha") or 0.985);
    end;
end;

local function getAccentColor(p3: any, p4) -- Line: 49
    -- upvalues: Util (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy)
    if Util.canshiftcolor(LocalPlayer, p3) then
        return p4:Lerp(p3:GetAttribute("CustomColor") or Color3_fromRGB_ret, p3:GetAttribute("CustomAlpha") or 0.985);
    end;

    return p4;
end;

local u5 = {
    transparencyTarget = 0.98,
    tweenTime = 0.35,
    fadein = 0.1,
    duration = 1,
    ensureOpaqueOnRestore = true,
    colorTarget = Color3.fromRGB(255, 255, 255)
};

function u1.ShurikenShot(u6) -- Line: 68
    -- upvalues: vfxUtil (copy), Players (copy), mainreplication (copy), KatUtil (copy), applyRecolor (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local u7 = u6.HumanoidRootPart or u6.PrimaryPart;
    local _ = u6.Humanoid;
    local _ = u6.Torso;
    local KusarigamaKick = vfxUtil.getResources().otoya.ShurikenShot.KusarigamaKick;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u6) then
        mainreplication.fov(true, 90, 0.43, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    end;

    task.delay(0.43, function() -- Line: 77
        -- upvalues: KatUtil (ref), KusarigamaKick (copy), u7 (copy), applyRecolor (ref), u6 (copy), Players (ref), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        local v8 = KatUtil.create_vfx_instance(KusarigamaKick.VFX.Kick, u7.CFrame, "offset");
        applyRecolor(u6, v8);
        KatUtil.forge_emit(v8);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u6) then
            mainreplication.springcamerashake(60, 50);
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v9 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v9.Parent = Lighting;
            v9.TintColor = Color3.fromRGB(131, 255, 145);
            v9.Brightness = 0.4;
            v9.Contrast = 1;
            v9.Saturation = -0.4;
            TweenService:Create(v9, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v9, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v9.Destroy, v9);
        end;
    end);
end;

function u1.kusarigama_dash(u10) -- Line: 103
    -- upvalues: vfxUtil (copy), KatUtil (copy), trove (copy), applyRecolor (copy), mainreplication (copy), script_Afterimage (copy), BackgroundHighlight (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(u10);
    local KusarigamaKick = vfxUtil.getResources().otoya.ShurikenShot.KusarigamaKick;

    if not KatUtil.get_track(u10, KusarigamaKick.Dash) then
        return;
    end;

    local u11 = trove.new();
    u11:AttachToInstance(u10);
    local u12 = u11:Construct(KusarigamaKick.VFX.Run);
    u12.Weld.Part0 = Root;
    u12.Parent = u10;
    applyRecolor(u10, u12);
    KatUtil.forge_emit(u12);
    u11:Add(function() -- Line: 122
        -- upvalues: u12 (copy)
        u12:Destroy();
    end);
    mainreplication.bodyVelocity(Root, 90, 1, nil, nil, nil, TweenInfo.new(0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 1);
    script_Afterimage({
        Enabled = true,
        Character = u10
    });
    local v13 = {
        Speed = 1,
        CFrames = true,
        Brightness = 1,
        ImageTransparency = 0.7,
        CountSpeed = 0.03,
        Count = 15,
        Whitelist = { u10 },
        BlacklistedParts = { "Ball" }
    };
    local v14 = Color3_fromRGB_ret;

    if Util.canshiftcolor(LocalPlayer, u10) then
        v14 = v14:Lerp(u10:GetAttribute("CustomColor") or Color3_fromRGB_ret, u10:GetAttribute("CustomAlpha") or 0.985);
    end;

    v13.Color = v14;
    BackgroundHighlight(v13);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u10) then
        mainreplication.fov(false, 60);
        mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(15, 25);
        local v15 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v15.Parent = Lighting;
        v15.TintColor = Color3.fromRGB(143, 212, 143);
        v15.Brightness = 0.3;
        v15.Contrast = 0.5;
        v15.Saturation = -0.3;
        TweenService:Create(v15, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v15, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v15.Destroy, v15);
    end;

    task.delay(0.8, function() -- Line: 160
        -- upvalues: script_Afterimage (ref), u10 (copy), u12 (copy), u11 (copy)
        script_Afterimage({
            Enabled = false,
            Character = u10
        });
        pcall(game.Destroy, u12);
        u11:Destroy();
    end);
end;

local function toggleSpotlight(p16, p17) -- Line: 167
    -- upvalues: TweenService (copy)
    local SpotlightPart = p16:FindFirstChild("SpotlightPart");

    if SpotlightPart and (SpotlightPart:FindFirstChild("SpotlightPart") and SpotlightPart.SpotlightPart:FindFirstChild("SpotLight")) then
        if p17 and not SpotlightPart:FindFirstChild("Weld") then
            SpotlightPart.Anchored = false;
            local Weld = Instance.new("Weld");
            Weld.Part0 = p16:FindFirstChild("HumanoidRootPart");
            Weld.Part1 = SpotlightPart;
            Weld.Parent = SpotlightPart;
            SpotlightPart.Weld.Enabled = p17;
        elseif not p17 and SpotlightPart:FindFirstChild("Weld") then
            SpotlightPart.Weld:Destroy();
            SpotlightPart.Anchored = true;
        end;

        if not SpotlightPart:GetAttribute("Dying") then
            TweenService:Create(SpotlightPart.SpotlightPart.SpotLight, TweenInfo.new(1), {
                Brightness = p17 and SpotlightPart:GetAttribute("Brightness") or 0
            }):Play();
        end;
    end;
end;

function u1.invisibility(u18) -- Line: 189
    -- upvalues: vfxUtil (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), trove (copy), u1 (copy), applyRecolor (copy), KatUtil (copy), toggleSpotlight (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), u5 (copy), actionUtil (copy)
    local u19 = {};
    local Root = vfxUtil.getRoot(u18);
    local Invisibility = vfxUtil.getResources().otoya.Invisibility;
    local highlight = mainreplication.highlight;
    local Color3_new_ret = Color3.new(0.505882, 1, 0.352941);

    if Util.canshiftcolor(LocalPlayer, u18) then
        Color3_new_ret = Color3_new_ret:Lerp(u18:GetAttribute("CustomColor") or Color3_fromRGB_ret, u18:GetAttribute("CustomAlpha") or 0.985);
    end;

    highlight(u18, Color3_new_ret, 0.5);
    local u20 = trove.new();
    u20:AttachToInstance(u18);

    local function DIE() -- Line: 200
        -- upvalues: u18 (copy), u1 (ref), u20 (copy)
        if not u18:GetAttribute("Invisible") then
            u1.Visibility(u18);
            u20:Destroy();
        end;
    end;

    u20:Connect(u18:GetAttributeChangedSignal("Invisible"), DIE);
    task.defer(DIE);
    local v21 = u20:Construct(Invisibility.invisibility);
    v21:PivotTo(Root.CFrame);
    v21.Parent = workspace.Effects;
    applyRecolor(u18, v21);
    KatUtil.forge_emit(v21);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.springcamerashake(5, 10);
    toggleSpotlight(u18, false);
    local v22 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v22.Parent = Lighting;
    v22.TintColor = Color3.fromRGB(118, 223, 113);
    v22.Brightness = 0.4;
    v22.Contrast = 0.7;
    v22.Saturation = -0.4;
    TweenService:Create(v22, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v22, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();

    local function TransparencyEffect(u23: userdata, p24: any) -- Line: 233
        -- upvalues: u5 (ref), u19 (copy), TweenService (ref)
        if not (u23 and u23:IsA("Model")) then
            return;
        end;

        local v25 = p24 or {};
        local u26 = v25.transparencyTarget or u5.transparencyTarget;

        if not v25.colorTarget then
            local _ = u5.colorTarget;
        end;

        local u27 = v25.tweenTime or u5.tweenTime;
        local v28 = v25.fadein or u5.fadein;

        if not v25.duration then
            local _ = u5.duration;
        end;

        local u29 = v25.ensureOpaqueOnRestore == nil and u5.ensureOpaqueOnRestore or v25.ensureOpaqueOnRestore;

        if u19[u23] then
            for _, v in ipairs(u19[u23].tweens) do
                pcall(function() -- Line: 245
                    -- upvalues: v (copy)
                    v:Cancel();
                end);
            end;
        end;

        local u30 = {};
        local u31 = {};
        u19[u23] = {
            token = u30,
            tweens = u31
        };
        local u32 = {};

        for _, descendant in ipairs(u23:GetDescendants()) do
            local v33 = descendant:IsA("Accessory") and descendant:FindFirstChild("Handle");

            if v33 then
                u32[v33] = {
                    Transparency = v33.Transparency
                };
                local v34 = TweenService:Create(v33, TweenInfo.new(v28), {
                    Transparency = 1
                });
                v34:Play();
                table.insert(u31, v34);
            end;

            if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and descendant.Transparency < u26 then
                u32[descendant] = {
                    Transparency = descendant.Transparency
                };
                local v35 = TweenService:Create(descendant, TweenInfo.new(v28), {
                    Transparency = u26
                });
                v35.Completed:Connect(function() -- Line: 269
                    -- upvalues: descendant (copy), u26 (copy)
                    descendant.Transparency = u26;
                end);
                v35:Play();
                table.insert(u31, v35);
            end;

            if descendant:IsA("TextLabel") then
                u32[descendant] = u32[descendant] or {};
                u32[descendant].TextTransparency = descendant.TextTransparency;
                local v36 = TweenService:Create(descendant, TweenInfo.new(v28), {
                    TextTransparency = u26,
                    TextStrokeTransparency = u26
                });
                v36.Completed:Connect(function() -- Line: 279
                    -- upvalues: descendant (copy), u26 (copy)
                    descendant.TextTransparency = u26;
                end);
                v36:Play();
                table.insert(u31, v36);
            end;

            if descendant:IsA("UIStroke") then
                u32[descendant] = u32[descendant] or {};
                u32[descendant].Transparency = descendant.Transparency;
                local v37 = TweenService:Create(descendant, TweenInfo.new(v28), {
                    Transparency = u26
                });
                v37.Completed:Connect(function() -- Line: 288
                    -- upvalues: descendant (copy), u26 (copy)
                    descendant.Transparency = u26;
                end);
                v37:Play();
                table.insert(u31, v37);
            end;
        end;

        local function restoreAll() -- Line: 294
            -- upvalues: u19 (ref), u23 (copy), u30 (copy), u31 (copy), u32 (copy), u29 (copy), TweenService (ref), u27 (copy)
            if not u19[u23] or u19[u23].token ~= u30 then
                return;
            end;

            for _, v in ipairs(u31) do
                pcall(function() -- Line: 298
                    -- upvalues: v (copy)
                    v:Cancel();
                end);
            end;

            for i, v in pairs(u32) do
                if i and i.Parent then
                    if v.Transparency ~= nil then
                        local v38 = u29 and 0 or v.Transparency;
                        TweenService:Create(i, TweenInfo.new(u27), {
                            Transparency = v38
                        }):Play();
                    end;

                    if v.TextTransparency ~= nil then
                        TweenService:Create(i, TweenInfo.new(u27), {
                            TextTransparency = v.TextTransparency
                        }):Play();
                    end;

                    if v.TextStrokeTransparency ~= nil then
                        TweenService:Create(i, TweenInfo.new(u27), {
                            TextStrokeTransparency = v.TextStrokeTransparency
                        }):Play();
                    end;
                end;
            end;

            u19[u23] = nil;
        end;

        u23:GetAttributeChangedSignal("Invisible"):Connect(restoreAll);

        if not u23:GetAttribute("Invisible") then
            task.defer(restoreAll);
        end;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = actionUtil.checksameTeam(Character, u18);
    end;

    TransparencyEffect(u18, {
        transparencyTarget = Character and 0.85 or u5.transparencyTarget
    });
end;

function u1.Visibility(p39) -- Line: 335
    -- upvalues: vfxUtil (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), trove (copy), vfxUtil (copy), applyRecolor (copy), KatUtil (copy), toggleSpotlight (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(p39);
    local Invisibility = vfxUtil.getResources().otoya.Invisibility;
    local highlight = mainreplication.highlight;
    local Color3_new_ret = Color3.new(0.505882, 1, 0.352941);

    if Util.canshiftcolor(LocalPlayer, p39) then
        Color3_new_ret = Color3_new_ret:Lerp(p39:GetAttribute("CustomColor") or Color3_fromRGB_ret, p39:GetAttribute("CustomAlpha") or 0.985);
    end;

    highlight(p39, Color3_new_ret, 0.5);
    local u40 = trove.new();
    u40:AttachToInstance(p39);
    u40:Add(task.delay(vfxUtil.getEmittersLifetime(Invisibility.invisibility), function() -- Line: 345
        -- upvalues: u40 (copy)
        u40:Destroy();
    end));
    local v41 = u40:Construct(Invisibility.invisibility);
    v41:PivotTo(Root.CFrame);
    v41.Parent = workspace.Effects;
    applyRecolor(p39, v41);
    KatUtil.forge_emit(v41);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.springcamerashake(8, 10);
    toggleSpotlight(p39, true);
    local v42 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v42.Parent = Lighting;
    v42.TintColor = Color3.fromRGB(118, 223, 113);
    v42.Brightness = 0.5;
    v42.Contrast = 0.8;
    v42.Saturation = -0.4;
    TweenService:Create(v42, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v42, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
end;

function u1.kusarigama_jump(p43) -- Line: 373
    -- upvalues: vfxUtil (copy), KatUtil (copy), mainreplication (copy), RunService (copy), Players (copy)
    local Root = vfxUtil.getRoot(p43);
    local KusarigamaKick = vfxUtil.getResources().otoya.ShurikenShot.KusarigamaKick;

    if not KatUtil.get_track(p43, KusarigamaKick.Dash) then
        return;
    end;

    KatUtil.destroy_all_velocities(p43);
    local u44 = mainreplication.bodyVelocity(Root, 1, 0.25, nil, nil, true);

    if u44 then
        u44.MaxForce = Vector3.new(300000, 300000, 300000);
        local u45 = nil;
        u45 = RunService.RenderStepped:Connect(function(p46) -- Line: 389
            -- upvalues: u44 (copy), u45 (ref), Root (copy)
            if u44 and u44:IsDescendantOf(game) then
                u44.Velocity = Root.CFrame.LookVector * 95 + Root.CFrame.UpVector * 8;

                return;
            end;

            u45:Disconnect();
        end);
        task.delay(15, u45.Disconnect, u45);
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p43) then
        return;
    end;

    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(false, 80);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.kusarigama_kick(p47) -- Line: 410
    -- upvalues: vfxUtil (copy), KatUtil (copy), applyRecolor (copy), script_Afterimage (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local Root = vfxUtil.getRoot(p47);
    local KusarigamaKick = vfxUtil.getResources().otoya.ShurikenShot.KusarigamaKick;
    local v48 = KatUtil.create_vfx_instance(KusarigamaKick.VFX.Kick, Root.CFrame, "offset");
    applyRecolor(p47, v48);
    KatUtil.forge_emit(v48);
    KatUtil.destroy_all_velocities(p47);
    script_Afterimage({
        Enabled = false,
        Character = p47
    });

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p47) then
        mainreplication.fov(false, 55);
        task.wait(0.13);
        mainreplication.fov(false, 120);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(10, 20);
        local v49 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v49.Parent = Lighting;
        v49.TintColor = Color3.fromRGB(81, 223, 65);
        v49.Brightness = 0.4;
        v49.Contrast = 1;
        v49.Saturation = -0.4;
        TweenService:Create(v49, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v49, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v49.Destroy, v49);
    end;
end;

function u1.shadowstep(u50, p51, u52) -- Line: 446
    -- upvalues: vfxUtil (copy), applyRecolor (copy), KatUtil (copy), vfxUtil (copy), RunService (copy), actionUtil (copy), ReplicatedStorage (copy), TweenService (copy), Lighting (copy), mainreplication (copy), script_Afterimage (copy), BackgroundHighlight (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), Players (copy)
    local HumanoidRootPart = u50:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p51:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local u53 = vfxUtil.getResources().otoya["Shadow Step"];
    local _ = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Unit;
    local u54 = u52 == "left";
    local CFrame_lookAt_ret = CFrame.lookAt(HumanoidRootPart2.Position, HumanoidRootPart.Position);
    local LookVector = CFrame_lookAt_ret.LookVector;
    local u55 = HumanoidRootPart2.Position + CFrame_lookAt_ret.RightVector * 8 + LookVector * 6;
    local u56 = HumanoidRootPart2.Position + -CFrame_lookAt_ret.RightVector * 8 + LookVector * 6;
    local u57 = u53.Flashstep:Clone();
    u57.Weld.Part0 = HumanoidRootPart;
    u57:PivotTo(HumanoidRootPart.CFrame);
    u57.Parent = workspace.Effects;
    applyRecolor(u50, u57);
    KatUtil.forge_emit(u57);
    vfxUtil.disposal(u57, 1);
    local u58 = nil;

    if vfxUtil.isLocalPlayer(u50) then
        u58 = RunService.RenderStepped:connect(function(p59) -- Line: 483
            -- upvalues: HumanoidRootPart (copy), actionUtil (ref), u58 (ref), u52 (copy), u56 (copy), u55 (copy)
            if not (HumanoidRootPart and (HumanoidRootPart:IsDescendantOf(game) and not actionUtil.is_disabled())) then
                u58:Disconnect();

                return;
            end;

            if u52 == "left" then
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(u55, u55 + HumanoidRootPart.CFrame.LookVector), p59 * 7);

                return;
            end;

            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(u56, u56 + HumanoidRootPart.CFrame.LookVector), p59 * 7);
        end);
    end;

    local u60 = nil;
    u60 = RunService.RenderStepped:connect(function(p61) -- Line: 495
        -- upvalues: HumanoidRootPart (copy), actionUtil (ref), u60 (ref), u52 (copy), u57 (copy), u56 (copy), u55 (copy)
        if not (HumanoidRootPart and (HumanoidRootPart:IsDescendantOf(game) and not actionUtil.is_disabled())) then
            u60:Disconnect();

            return;
        end;

        if u52 == "left" then
            u57.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(u55, u55 + HumanoidRootPart.CFrame.LookVector), p61 * 7);

            return;
        end;

        u57.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(u56, u56 + HumanoidRootPart.CFrame.LookVector), p61 * 7);
    end);
    task.delay(0.5, function() -- Line: 505
        -- upvalues: u53 (copy), HumanoidRootPart (copy), ReplicatedStorage (ref), applyRecolor (ref), u50 (copy), KatUtil (ref), TweenService (ref), vfxUtil (ref)
        local v62 = u53.Dash:Clone();
        v62.Weld.Part0 = HumanoidRootPart;
        v62.Parent = workspace.Effects;
        v62:PivotTo(HumanoidRootPart.CFrame);
        local u63 = ReplicatedStorage.Resources.rundasheff:Clone();
        u63.main.Weld.Part0 = HumanoidRootPart;
        u63.Parent = workspace.Effects;
        applyRecolor(u50, v62, u63);
        KatUtil.forge_emit(v62);
        u63.Air.Size = Vector3.new(4.998, 0.503, 4.998);
        u63.Air.Transparency = 0.8;
        local Air = u63.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u63.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u63.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u63.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u63.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u63.Wind1.Transparency = 0.9;
        TweenService:Create(u63.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 532
            -- upvalues: u63 (copy), TweenService (ref)
            u63.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u63.Wind1.Transparency = 0.9;
            TweenService:Create(u63.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u63.End.Size = Vector3.new(5, 1, 5);
        u63.End.Transparency = 0.65;
        local End = u63.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u63.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u63.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u63.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 548
            -- upvalues: u63 (copy), TweenService (ref)
            u63.End.Size = Vector3.new(5, 1, 5);
            u63.End.Transparency = 0.65;
            local End2 = u63.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u63.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u63.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u63.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u63.A.Size = Vector3.new(14.29, 4.752, 5.444);
        u63.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
        u63.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u63.A.Decal.Transparency = 0.9;
        TweenService:Create(u63.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u63.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u63.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u63.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u63.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        vfxUtil.disposal(v62, 1.5);
        vfxUtil.disposal(u63, 1.5);
    end);

    if u58 then
        task.delay(1, u58.Disconnect, u58);
    end;

    task.delay(1, u60.Disconnect, u60);

    if vfxUtil.isLocalPlayer(u50) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 18;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.25, BlurEffect.Destroy, BlurEffect);
        mainreplication.fov(false, 60);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(15, 20);
        script_Afterimage({
            Enabled = true,
            Character = u50
        });
        local v64 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v64.Parent = Lighting;
        v64.TintColor = Color3.fromRGB(118, 223, 113);
        v64.Brightness = 0.4;
        v64.Contrast = 1;
        v64.Saturation = -0.4;
        TweenService:Create(v64, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v64, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v64.Destroy, v64);
    end;

    task.delay(0.5, function() -- Line: 605
        -- upvalues: u58 (ref), script_Afterimage (ref), u50 (copy), BackgroundHighlight (ref), Color3_fromRGB_ret (ref), Util (ref), LocalPlayer (ref), Players (ref), Lighting (ref), TweenService (ref), mainreplication (ref), ReplicatedStorage (ref), vfxUtil (ref), HumanoidRootPart (copy), RunService (ref), u54 (ref)
        if u58 then
            u58:Disconnect();
        end;

        script_Afterimage({
            Enabled = false,
            Character = u50
        });
        local v65 = {
            Speed = 1.7,
            CFrames = true,
            Brightness = 1,
            ImageTransparency = 0.7,
            CountSpeed = 0.03,
            Count = 20,
            Whitelist = { u50 },
            BlacklistedParts = { "Ball" }
        };
        local v66 = u50;
        local v67 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, v66) then
            v67 = v67:Lerp(v66:GetAttribute("CustomColor") or Color3_fromRGB_ret, v66:GetAttribute("CustomAlpha") or 0.985);
        end;

        v65.Color = v67;
        BackgroundHighlight(v65);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u50) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 18;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.25, BlurEffect.Destroy, BlurEffect);
            mainreplication.fov(false, 110);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(35, 40);
            local v68 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v68.Parent = Lighting;
            v68.TintColor = Color3.fromRGB(81, 223, 65);
            v68.Brightness = 0.4;
            v68.Contrast = 1;
            v68.Saturation = -0.4;
            TweenService:Create(v68, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v68, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v68.Destroy, v68);
        end;

        if vfxUtil.isLocalPlayer(u50) then
            local u69, _, u70 = mainreplication.bodyVelocity(HumanoidRootPart, 80, 0.955, nil, nil, true, TweenInfo.new(1.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 1);

            if u69 then
                local u71 = 0.215;
                local os_clock_ret = os.clock();
                u70 = RunService.PreRender:Connect(function(p72) -- Line: 659
                    -- upvalues: u69 (copy), u70 (ref), os_clock_ret (copy), u71 (ref), HumanoidRootPart (ref), u54 (ref)
                    if not u69.Parent then
                        u70:Disconnect();
                    end;

                    if os.clock() - os_clock_ret > 0.1 then
                        u71 = u71 + p72;
                    end;

                    local v73 = math.clamp(u71 / 0.75, 0, 0.85) ^ 2 * 3.141592653589793 * 0.8;
                    local v74 = -HumanoidRootPart.CFrame.RightVector;
                    local LookVector2 = HumanoidRootPart.CFrame.LookVector;
                    local math_cos_ret = math.cos(v73);
                    local math_sin_ret = math.sin(v73);
                    local Unit = (v74 * math_cos_ret + LookVector2 * math_sin_ret).Unit;
                    local Unit2 = (-v74 * math_cos_ret + LookVector2 * math_sin_ret).Unit;

                    if u54 then
                        u69.Velocity = Unit2 * 80;

                        return;
                    end;

                    u69.Velocity = Unit * 80;
                end);
            end;
        end;

        task.delay(1.8, function() -- Line: 689
            -- upvalues: script_Afterimage (ref), u50 (ref)
            script_Afterimage({
                Enabled = false,
                Character = u50
            });
        end);
    end);
end;

local function solveArch(p75, p76, p77, p78) -- Line: 695
    return p77 * p76 * math.sin(p75 * 3.141592653589793), p77 * p76 * 3.141592653589793 * math.cos(p75 * 3.141592653589793) / p78;
end;

local u79 = {};

local function createAuraCleaner(u80, u81, p82) -- Line: 703
    -- upvalues: u79 (copy), vfxUtil (copy)
    local v83 = p82:Extend();
    v83:Add(function() -- Line: 705
        -- upvalues: u79 (ref), u81 (copy), u80 (copy), vfxUtil (ref)
        u79[u81] = nil;

        for _, v in u80:QueryDescendants("ParticleEmitter,Trail") do
            v.Enabled = false;
        end;

        task.delay(vfxUtil.getEmittersLifetime(u80), function() -- Line: 710
            -- upvalues: u80 (ref)
            u80:Destroy();
        end);
    end);

    return v83;
end;

local function getAura(u84, p85) -- Line: 717
    -- upvalues: vfxUtil (copy), u79 (copy), applyRecolor (copy)
    local StealthySteps = vfxUtil.getResources().otoya.StealthySteps;
    local u86 = u79[u84];

    if not u86 then
        u86 = StealthySteps.Aura:Clone();
        vfxUtil.setupAura(u84, u86, true);
        u86.Parent = workspace.Effects;
        applyRecolor(u84, u86);
        u79[u84] = u86;
    end;

    local v87 = p85:Extend();
    v87:Add(function() -- Line: 705
        -- upvalues: u79 (ref), u84 (copy), u86 (copy), vfxUtil (ref)
        u79[u84] = nil;

        for _, v in u86:QueryDescendants("ParticleEmitter,Trail") do
            v.Enabled = false;
        end;

        task.delay(vfxUtil.getEmittersLifetime(u86), function() -- Line: 710
            -- upvalues: u86 (ref)
            u86:Destroy();
        end);
    end);

    return u86, v87;
end;

function u1.toitoi_stealthy_steps(u88: any, u89: number, u90: number, u91: number, p92: number, u93: number, u94: string?) -- Line: 730
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), script_Afterimage (copy), TweenService (copy), getAura (copy), mainreplication (copy), RunService (copy), BackgroundHighlight (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy)
    if not u88:GetAttribute(u94) then
        return;
    end;

    local StealthySteps = vfxUtil.getResources().otoya.StealthySteps;
    local Root = vfxUtil.getRoot(u88);
    local u95 = 0;
    local u96 = 1;
    local u97 = u91;
    local u98 = 1;
    local u99 = soundUtil:play(StealthySteps.Sound, Root);
    local u100 = trove.new();
    u100:AttachToInstance(u88);
    u100:Add(function() -- Line: 755
        -- upvalues: script_Afterimage (ref), u88 (copy), TweenService (ref), u99 (copy)
        script_Afterimage({
            Enabled = false,
            Character = u88
        });
        TweenService:Create(u99, TweenInfo.new(0.6), {
            Volume = 0
        }):Play();
    end);
    u100:Connect(u88:GetAttributeChangedSignal(u94), function() -- Line: 760
        -- upvalues: u88 (copy), u94 (copy), u100 (copy)
        if not u88:GetAttribute(u94) then
            u100:Destroy();
        end;
    end);
    local _, u101 = getAura(u88, u100);
    u100:Connect(u88:GetAttributeChangedSignal("ZoomAttempt"), function() -- Line: 768
        -- upvalues: u88 (copy), u100 (copy), u101 (copy)
        if u88:GetAttribute("ZoomAttempt") then
            u100:Pop(u101);
        end;
    end);
    local u102 = nil;
    local u103 = nil;

    local function newDash() -- Line: 776
        -- upvalues: vfxUtil (ref), u88 (copy), u97 (ref), u98 (ref), u91 (copy), u102 (ref), u103 (ref), mainreplication (ref), Root (copy), u93 (copy), u100 (copy)
        if not vfxUtil.isLocalPlayer(u88) then
            u97 = u97 - 1;
            u98 = math.lerp(0.2, 1, u97 / u91);

            return;
        end;

        local v104, v105 = mainreplication.bodyVelocity(Root, u93 * 68, 1, false, nil, true, nil, -1);
        u102 = v104;
        u103 = v105;
        u100:Add(u102);
        u97 = u97 - 1;
        u98 = math.lerp(0.2, 1, u97 / u91);
    end;

    if vfxUtil.isLocalPlayer(u88) then
        u100:Connect(RunService.PreRender, function(p106) -- Line: 791
            -- upvalues: u88 (copy), u94 (copy), u100 (copy), u95 (ref), u89 (ref), u97 (ref), u90 (copy), u96 (ref), newDash (copy), u102 (ref), u98 (ref), Root (copy), u103 (ref)
            if not u88:GetAttribute(u94) then
                u100:Destroy();

                return;
            end;

            u95 = u95 + p106;

            if u89 < u95 then
                if u97 <= 0 or not u88:GetAttribute(u94) then
                    u100:Destroy();

                    return;
                end;

                u95 = u95 % u89;
                u89 = u89 - u89 * u90;
                u96 = -u96;
                newDash();
            end;

            if not u102 then
                return;
            end;

            local v107 = u95 / u89;
            local v108 = u98 * 6;
            local v109 = u96;
            local _ = v109 * v108 * math.sin(v107 * 3.141592653589793);
            local v110 = v109 * v108 * 3.141592653589793 * math.cos(v107 * 3.141592653589793) / u89;
            local CFrame2 = Root.CFrame;
            u102.Velocity = CFrame2.LookVector * u103.Value + CFrame2.RightVector * v110;
        end);
    else
        u100:Connect(RunService.PreRender, function(p111) -- Line: 818
            -- upvalues: u88 (copy), u94 (copy), u100 (copy), u95 (ref), u89 (ref), u97 (ref), u90 (copy), u96 (ref), newDash (copy)
            if not u88:GetAttribute(u94) then
                u100:Destroy();

                return;
            end;

            u95 = u95 + p111;

            if u89 >= u95 then
                return;
            end;

            if u97 <= 0 or not u88:GetAttribute(u94) then
                u100:Destroy();

                return;
            end;

            u95 = u95 % u89;
            u89 = u89 - u89 * u90;
            u96 = -u96;
            newDash();
        end);
    end;

    newDash();
    script_Afterimage({
        Enabled = true,
        Character = u88
    });
    local v112 = {
        Speed = 0.4,
        CFrames = true,
        Brightness = 1,
        ImageTransparency = 0.7,
        Count = 20,
        Whitelist = { u88 },
        BlacklistedParts = { "Ball" },
        CountSpeed = p92 / 20
    };
    local v113 = Color3_fromRGB_ret;

    if Util.canshiftcolor(LocalPlayer, u88) then
        v113 = v113:Lerp(u88:GetAttribute("CustomColor") or Color3_fromRGB_ret, u88:GetAttribute("CustomAlpha") or 0.985);
    end;

    v112.Color = v113;
    v112.StopAttribute = u94;
    BackgroundHighlight(v112);

    if vfxUtil.isLocalPlayer(u88) then
        local flash = vfxUtil.flash;
        local v114 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, u88) then
            v114 = v114:Lerp(u88:GetAttribute("CustomColor") or Color3_fromRGB_ret, u88:GetAttribute("CustomAlpha") or 0.985);
        end;

        flash(v114, 1);
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;
end;

function u1.toitoi_zoomAttempt(u115: any, u116: number) -- Line: 863
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), getAura (copy), forge (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy)
    local Attempt = vfxUtil.getResources().otoya.Zoom.Attempt;
    local Root = vfxUtil.getRoot(u115);
    soundUtil:play(Attempt.Sound, Root);
    local u117 = trove.new();
    u117:AttachToInstance(u115);
    u117:Connect(u115:GetAttributeChangedSignal("ZoomAttempt"), function() -- Line: 871
        -- upvalues: u115 (copy), u117 (copy)
        if not u115:GetAttribute("ZoomAttempt") then
            u117:Destroy();
        end;
    end);

    if vfxUtil.isLocalPlayer(u115) then
        mainreplication.bodyVelocity(Root, u116 * 70, 2.5 / u116);
        u117:Add(task.delay(0.7, function() -- Line: 879
            -- upvalues: mainreplication (ref), Root (copy), u116 (copy)
            mainreplication.bodyVelocity(Root, u116 * 100, 0.5 / u116);
        end));
    end;

    local u118, u119 = getAura(u115, u117);
    u117:Connect(u115:GetAttributeChangedSignal("ZoomLanded"), function() -- Line: 886
        -- upvalues: u115 (copy), u117 (copy), u119 (copy)
        if u115:GetAttribute("ZoomLanded") then
            u117:Pop(u119);
        end;
    end);
    forge.emit(u118["Right Leg"].Trail, u118["Left Leg"].Trail, u118["Left Arm"].Trail, u118.HumanoidRootPart.Startup, u118["Right Arm"].Trail);
    u117:Add(task.delay(0.833, function() -- Line: 900
        -- upvalues: forge (ref), u118 (copy)
        forge.emit(u118.HumanoidRootPart.Dash);
    end));

    if vfxUtil.isLocalPlayer(u115) then
        local flash = vfxUtil.flash;
        local v120 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, u115) then
            v120 = v120:Lerp(u115:GetAttribute("CustomColor") or Color3_fromRGB_ret, u115:GetAttribute("CustomAlpha") or 0.985);
        end;

        flash(v120, 1);
        mainreplication.fov(false, 105);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;
end;

function u1.toitoi_zoomLanded(u121: any, u122: number) -- Line: 911
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), getAura (copy), forge (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), BackgroundHighlight (copy)
    local Landed = vfxUtil.getResources().otoya.Zoom.Landed;
    local Root = vfxUtil.getRoot(u121);
    soundUtil:play(Landed.Sound, Root);
    local u123 = trove.new();
    u123:AttachToInstance(u121);
    u123:Connect(u121:GetAttributeChangedSignal("ZoomLanded"), function() -- Line: 919
        -- upvalues: u121 (copy), u123 (copy)
        if not u121:GetAttribute("ZoomLanded") then
            u123:Destroy();
        end;
    end);

    if vfxUtil.isLocalPlayer(u121) then
        u123:Add(task.delay(0.3, function() -- Line: 929
            -- upvalues: u122 (copy), mainreplication (ref), Root (copy)
            local v124 = u122 - 0.3 + 0.15;
            mainreplication.bodyVelocity(Root, 100, v124, nil, nil, nil, TweenInfo.new(v124 + 1));
        end));
    end;

    local v125 = getAura(u121, u123);
    forge.emit(v125.HumanoidRootPart.Tap);

    if vfxUtil.isLocalPlayer(u121) then
        local flash = vfxUtil.flash;
        local v126 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, u121) then
            v126 = v126:Lerp(u121:GetAttribute("CustomColor") or Color3_fromRGB_ret, u121:GetAttribute("CustomAlpha") or 0.985);
        end;

        flash(v126, 1);
        mainreplication.fov(false, 35);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.cameraShake(12, u122, 6);
    end;

    local v127 = {
        Speed = 0.4,
        CFrames = true,
        Brightness = 1,
        ImageTransparency = 0.7,
        Count = 20,
        Whitelist = { u121 },
        BlacklistedParts = { "Ball" },
        CountSpeed = u122 / 20
    };
    local v128 = Color3_fromRGB_ret;

    if Util.canshiftcolor(LocalPlayer, u121) then
        v128 = v128:Lerp(u121:GetAttribute("CustomColor") or Color3_fromRGB_ret, u121:GetAttribute("CustomAlpha") or 0.985);
    end;

    v127.Color = v128;
    BackgroundHighlight(v127);
end;

function u1.toitoi_bakyun(u129: any, p130: number, u131: any) -- Line: 962
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), applyRecolor (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), getAccentColor (copy), Color3_fromRGB_ret (copy)
    local Bakyun = vfxUtil.getResources().otoya.Bakyun;
    local Root = vfxUtil.getRoot(u129);
    local u132 = soundUtil:play(Bakyun.Sound, "default", {
        Character = u129
    }).Name == "Dub";
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u133 = trove.new();
    u133:AttachToInstance(u129);
    u133:Add(function() -- Line: 973
        -- upvalues: vfxUtil (ref), mainreplication (ref)
        vfxUtil.cutscene_ball(false);
        mainreplication.sceneEnabled(false);
    end);
    u133:Add(task.delay(p130, function() -- Line: 977
        -- upvalues: u133 (copy)
        u133:Destroy();
    end));
    local v134 = u133:Clone(Bakyun.VFX);
    v134:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u129, v134["real lofeu"], true);
    vfxUtil.setupAura(u131, v134["When he play"], true);
    v134.Parent = workspace.Effects;
    applyRecolor(u129, v134);
    local v135 = {
        Vignette = u133:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v134
    };
    vfxUtil.contain_lighting(u133, v135, Bakyun.Lighting);
    local v136 = u133:Construct(MoonPropertyAnimator);
    v136:LoadAndConvertSave(Bakyun.Moon, v135);
    v136:SetOriginalRoot(Bakyun.VFX:GetPivot());
    v136:SetRoot(Root);
    v136:PlayAll();
    local v137, v138 = mainreplication.cutsceneCamRigWithLetterBox(Root, Bakyun.CamAnimation, Bakyun.FOV, u129, "default", Bakyun.Cam, "CamPart");
    u133:Add(v138);
    vfxUtil.execute_compiled(Bakyun.Compiled, u133, v134.vfx, v134, v137);

    if vfxUtil.isLocalPlayer(u129) then
        u133:Add(task.delay(5.5, function() -- Line: 1006
            -- upvalues: u133 (copy), TekrinnDialogue (ref), u129 (copy), u132 (copy), getAccentColor (ref), Color3_fromRGB_ret (ref)
            u133:Add(TekrinnDialogue.Speak(u129, {
                {
                    Bold = true,
                    TypeSpeed = 0.05,
                    Text = u132 and "Ninja step." or "Zoom.",
                    Color = ColorSequence.new(Color3.new(1, 1, 1), getAccentColor(u129, Color3_fromRGB_ret)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 4));
        end));
    end;

    u133:Add(task.delay(7.25, function() -- Line: 1022
        -- upvalues: u133 (copy), TekrinnDialogue (ref), u131 (copy)
        u133:Add(TekrinnDialogue.Speak(u131, {
            {
                Text = "Tch.",
                TypeSpeed = 0.05,
                Color = ColorSequence.new(Color3.new(0, 0, 0), Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2));
    end));
end;

function u1.toitoi_tikipassdash(u139: any, p140: number) -- Line: 1037
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), script_Afterimage (copy), applyRecolor (copy), forge (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), mainreplication (copy), BackgroundHighlight (copy)
    local OnBall = vfxUtil.getResources().otoya.TikiTaka.OnBall;
    local Root = vfxUtil.getRoot(u139);
    local v141 = 0.533 / p140;
    soundUtil:play(OnBall.DashSFX, Root);
    local u142 = trove.new();
    u142:AttachToInstance(u139);
    u142:Add(task.delay(vfxUtil.getBulkEmittersLifetime(OnBall.Run, OnBall.camfx), function() -- Line: 1047
        -- upvalues: u142 (copy)
        u142:Destroy();
    end));
    u142:Add(task.delay(v141, function() -- Line: 1050
        -- upvalues: script_Afterimage (ref), u139 (copy)
        script_Afterimage({
            Enabled = false,
            Character = u139
        });
    end));
    script_Afterimage({
        Enabled = true,
        Character = u139
    });
    local v143 = u142:Clone(OnBall.Run);
    v143:PivotTo(Root.CFrame);
    v143.Parent = workspace.Effects;
    applyRecolor(u139, v143);
    forge.emit(v143);

    if vfxUtil.isLocalPlayer(u139) then
        local v144 = u142:Clone(OnBall.camfx);
        v144.Parent = workspace.Effects;
        applyRecolor(u139, v144);
        forge.emit(v144);
        local flash = vfxUtil.flash;
        local v145 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, u139) then
            v145 = v145:Lerp(u139:GetAttribute("CustomColor") or Color3_fromRGB_ret, u139:GetAttribute("CustomAlpha") or 0.985);
        end;

        flash(v145, 2);
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.bodyVelocity(Root, 50, v141, nil, nil, nil, TweenInfo.new(v141 + 1, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
        local v146 = {
            Speed = 0.4,
            CFrames = true,
            Brightness = 1,
            ImageTransparency = 0.7,
            Count = 10,
            Whitelist = { u139 },
            BlacklistedParts = { "Ball" },
            CountSpeed = v141 / 10
        };
        local v147 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, u139) then
            v147 = v147:Lerp(u139:GetAttribute("CustomColor") or Color3_fromRGB_ret, u139:GetAttribute("CustomAlpha") or 0.985);
        end;

        v146.Color = v147;
        BackgroundHighlight(v146);
    end;
end;

function u1.toitoi_tikionpass(p148) -- Line: 1095
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), applyRecolor (copy), forge (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), mainreplication (copy)
    local OnBall = vfxUtil.getResources().otoya.TikiTaka.OnBall;
    local Root = vfxUtil.getRoot(p148);
    soundUtil:play(OnBall.KickSFX, Root);
    local u149 = trove.new();
    u149:AttachToInstance(p148);
    u149:Add(task.delay(vfxUtil.getEmittersLifetime(OnBall.Kick, OnBall.Impact), function() -- Line: 1103
        -- upvalues: u149 (copy)
        u149:Destroy();
    end));
    local v150 = u149:Clone(OnBall.Kick);
    v150:PivotTo(Root.CFrame);
    v150.Parent = workspace.Effects;
    applyRecolor(p148, v150);
    forge.emit(v150);
    local v151 = u149:Clone(OnBall.Impact);
    v151.CFrame = CFrame.identity;
    v151.Parent = Root;
    applyRecolor(p148, v151);
    forge.emit(v151);

    if vfxUtil.isLocalPlayer(p148) then
        local flash = vfxUtil.flash;
        local v152 = Color3_fromRGB_ret;

        if Util.canshiftcolor(LocalPlayer, p148) then
            v152 = v152:Lerp(p148:GetAttribute("CustomColor") or Color3_fromRGB_ret, p148:GetAttribute("CustomAlpha") or 0.985);
        end;

        flash(v152, 1);
        mainreplication.cameraShake(10, 2, 6);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.bodyVelocity(Root, 110, 0.5, nil, nil, nil, TweenInfo.new(1.5, Enum.EasingStyle.Quart));
    end;
end;

function u1.toitoi_centerOfTheWorld(p153: any, p154: number) -- Line: 1134
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), applyRecolor (copy), MoonPropertyAnimator (copy)
    local CenterOfTheWorld = vfxUtil.getResources().otoya.CenterOfTheWorld;
    local Root = vfxUtil.getRoot(p153);
    soundUtil:play(CenterOfTheWorld.Sound, "default");
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u155 = trove.new();
    u155:AttachToInstance(p153);
    u155:Add(function() -- Line: 1145
        -- upvalues: vfxUtil (ref), mainreplication (ref)
        vfxUtil.cutscene_ball(false);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u155:Add(task.delay(p154, function() -- Line: 1150
        -- upvalues: u155 (copy)
        u155:Destroy();
    end));
    local v156 = u155:Clone(CenterOfTheWorld.VFX);
    v156:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p153, v156.TuffCharacterRig0, true);
    v156.Parent = workspace.Effects;
    applyRecolor(p153, v156);
    local v157, v158 = mainreplication.cutsceneCamRigWithLetterBox(Root, CenterOfTheWorld.CamAnimation, CenterOfTheWorld.FOV, p153, "default", CenterOfTheWorld["CamRigWithLetterBox "]);
    u155:Add(v158);
    local v159 = {
        Vignette = u155:Construct(vfxUtil.getMoonEffects).Vignette,
        Workspace = v156
    };
    vfxUtil.contain_lighting(u155, v159, CenterOfTheWorld.Lighting);
    local v160 = u155:Construct(MoonPropertyAnimator);
    v160:LoadAndConvertSave(CenterOfTheWorld.Moon, v159);
    v160:SetOriginalRoot(CenterOfTheWorld.VFX:GetPivot());
    v160:SetRoot(Root);
    v160:PlayAll();
    vfxUtil.execute_compiled(CenterOfTheWorld.Compiled, u155, v156, v157);
end;

function u1.toitoi_interceptFlow(p161: any, p162: number) -- Line: 1178
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), applyRecolor (copy), MoonPropertyAnimator (copy)
    local InterceptFlow = vfxUtil.getResources().otoya.InterceptFlow;
    local Root = vfxUtil.getRoot(p161);
    soundUtil:play(InterceptFlow.Sound, "default");
    mainreplication.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u163 = trove.new();
    u163:AttachToInstance(p161);
    u163:Add(function() -- Line: 1189
        -- upvalues: vfxUtil (ref), mainreplication (ref)
        vfxUtil.cutscene_ball(false);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u163:Add(task.delay(p162, function() -- Line: 1194
        -- upvalues: u163 (copy)
        u163:Destroy();
    end));
    local v164 = u163:Clone(InterceptFlow.VFX);
    v164:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p161, v164.TuffCharacterRig0, true);
    v164.Parent = workspace.Effects;
    applyRecolor(p161, v164);
    local v165, v166 = mainreplication.cutsceneCamRigWithLetterBox(Root, InterceptFlow.CamAnimation, InterceptFlow.FOV, p161, "default", InterceptFlow["CamRigWithLetterBox "]);
    u163:Add(v166);
    local v167 = {
        Vignette = u163:Construct(vfxUtil.getMoonEffects).Vignette,
        Workspace = v164
    };
    vfxUtil.contain_lighting(u163, v167, InterceptFlow.Lighting);
    local v168 = u163:Construct(MoonPropertyAnimator);
    v168:LoadAndConvertSave(InterceptFlow.Moon, v167);
    v168:SetOriginalRoot(InterceptFlow.VFX:GetPivot());
    v168:SetRoot(Root);
    v168:PlayAll();
    vfxUtil.execute_compiled(InterceptFlow.Compiled, u163, v164, v165);
end;

function u1.toitoi_offballFlow(p169: any, p170: number) -- Line: 1222
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), MoonPropertyAnimator (copy)
    local OffBallFlow = vfxUtil.getResources().otoya.OffBallFlow;
    local Root = vfxUtil.getRoot(p169);
    soundUtil:play(OffBallFlow.Sound, "default");
    mainreplication.sceneEnabled(true);
    local u171 = trove.new();
    u171:AttachToInstance(p169);
    u171:Add(function() -- Line: 1232
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u171:Add(task.delay(p170, function() -- Line: 1236
        -- upvalues: u171 (copy)
        u171:Destroy();
    end));
    local Ball = p169:FindFirstChild("Ball");
    u171:Connect(p169.ChildAdded, function(p172) -- Line: 1241
        -- upvalues: Ball (ref)
        if p172.Name == "Ball" and Ball ~= p172 then
            Ball:Destroy();
            Ball = p172;
        end;
    end);

    if not Ball then
        Ball = u171:Clone(vfxUtil.getResources().Ball);
        Ball.ball.Part0 = Root;
        Ball.Parent = p169;
    end;

    local v173 = u171:Clone(OffBallFlow.VFX);
    v173:PivotTo(Root.CFrame);
    v173.Parent = workspace.Effects;
    local _, v174 = mainreplication.cutsceneCamRigWithLetterBox(Root, OffBallFlow.CamAnimation, OffBallFlow.FOV, p169, "default", OffBallFlow["CamRigWithLetterBox "]);
    u171:Add(v174);
    local v175 = {
        Workspace = v173
    };
    vfxUtil.contain_lighting(u171, v175, OffBallFlow.Lighting);
    local v176 = u171:Construct(MoonPropertyAnimator);
    v176:LoadAndConvertSave(OffBallFlow.Moon, v175);
    v176:SetOriginalRoot(OffBallFlow.VFX:GetPivot());
    v176:SetRoot(Root);
    v176:PlayAll();
    vfxUtil.execute_compiled(OffBallFlow.Compiled, u171, v173);
end;

function u1.toitoi_extraordinaryCombo(p177: any, p178: number, p179: table) -- Line: 1273
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), applyRecolor (copy), animationUtil (copy), MoonPropertyAnimator (copy)
    local ExtraordinaryCombo = vfxUtil.getResources().otoya.ExtraordinaryCombo;
    local Root = vfxUtil.getRoot(p177);
    soundUtil:play(ExtraordinaryCombo.Sound, "default");
    mainreplication.sceneEnabled(true);
    local u180 = trove.new();
    u180:AttachToInstance(p177);
    u180:Add(function() -- Line: 1283
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u180:Add(task.delay(p178, function() -- Line: 1287
        -- upvalues: u180 (copy)
        u180:Destroy();
    end));
    local v181 = u180:Clone(ExtraordinaryCombo.VFX);
    v181:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p177, v181.TuffCharacterRig2, true);
    vfxUtil.setupAura(p179[1], v181.wojtekwroblox2, true);
    v181.Parent = workspace.Effects;
    applyRecolor(p177, v181);
    animationUtil:loadAnimation(v181.Kusarigama, ExtraordinaryCombo.KusarigamaAnimation):Play(0);
    local v182, v183 = mainreplication.cutsceneCamRigWithLetterBox(Root, ExtraordinaryCombo.CamAnimation, ExtraordinaryCombo.FOV, p177, ExtraordinaryCombo.CameraOffset.Value, ExtraordinaryCombo["CamRigWithLetterBox "]);
    u180:Add(v183);
    local v184 = {
        Vignette = u180:Construct(vfxUtil.getMoonEffects).Vignette,
        Workspace = v181
    };
    vfxUtil.contain_lighting(u180, v184, ExtraordinaryCombo.Lighting);
    local v185 = u180:Construct(MoonPropertyAnimator);
    v185:LoadAndConvertSave(ExtraordinaryCombo.Moon, v184);
    v185:SetOriginalRoot(ExtraordinaryCombo.VFX:GetPivot());
    v185:SetRoot(Root);
    v185:PlayAll();
    vfxUtil.execute_compiled(ExtraordinaryCombo.Compiled, u180, v181, v182);
end;

function u1.toitoi_notGonnaHappen(u186: any, p187: number, p188: any) -- Line: 1322
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy), getAccentColor (copy), Color3_fromRGB_ret (copy)
    local NotGonnaHappen = vfxUtil.getResources().otoya.NotGonnaHappen;
    local Root = vfxUtil.getRoot(u186);
    local _ = soundUtil:play(NotGonnaHappen.Sound, "default", {
        Character = u186
    }).Name == "Dub";
    soundUtil:play(NotGonnaHappen.Music, "default");
    mainreplication.sceneEnabled(true);
    local u189 = trove.new();
    u189:AttachToInstance(u186);
    u189:Add(function() -- Line: 1333
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u189:Add(task.delay(p187, function() -- Line: 1337
        -- upvalues: u189 (copy)
        u189:Destroy();
    end));
    local v190 = u189:Clone(NotGonnaHappen.VFX);
    v190:PivotTo(Root.CFrame);
    vfxUtil.setupAura(p188, v190.TuffCharacterRig0, true);
    v190.Parent = workspace.Effects;
    local v191, v192 = mainreplication.cutsceneCamRigWithLetterBox(Root, NotGonnaHappen.CamAnimation, NotGonnaHappen.FOV, u186, "default", NotGonnaHappen["CamRigWithLetterBox "]);
    u189:Add(v192);
    u189:Construct(vfxUtil.getMoonEffects);
    local v193 = {};
    vfxUtil.contain_lighting(u189, v193, NotGonnaHappen.Lighting);
    local v194 = u189:Construct(MoonPropertyAnimator);
    v194:LoadAndConvertSave(NotGonnaHappen.Moon, v193);
    v194:PlayAll();

    if vfxUtil.isLocalPlayer(u186) then
        u189:Add(task.delay(1, function() -- Line: 1360
            -- upvalues: u189 (copy), TekrinnDialogue (ref), u186 (copy), getAccentColor (ref), Color3_fromRGB_ret (ref)
            u189:Add(TekrinnDialogue.Speak(u186, {
                {
                    Text = "Sup.",
                    Bold = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new(Color3.new(1, 1, 1), getAccentColor(u186, Color3_fromRGB_ret)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
    end;

    if vfxUtil.isLocalPlayer(u186) then
        u189:Add(task.delay(4, function() -- Line: 1377
            -- upvalues: u189 (copy), TekrinnDialogue (ref), u186 (copy), getAccentColor (ref), Color3_fromRGB_ret (ref)
            u189:Add(TekrinnDialogue.Speak(u186, {
                {
                    Text = "Road\'s closed.",
                    Bold = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new(Color3.new(1, 1, 1), getAccentColor(u186, Color3_fromRGB_ret)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
    end;

    vfxUtil.execute_compiled(NotGonnaHappen.Compiled, u189, v190, v191);
    vfxUtil.flash(Color3_fromRGB_ret, 0.67);
end;

function u1.toitoi_tikioffdash(u195: any, u196: number, u197: number) -- Line: 1398
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), script_Afterimage (copy), BackgroundHighlight (copy), Color3_fromRGB_ret (copy), Util (copy), LocalPlayer (copy), trove (copy), applyRecolor (copy), forge (copy)
    local OffBall = vfxUtil.getResources().otoya.TikiTaka.OffBall;
    local Root = vfxUtil.getRoot(u195);
    soundUtil:play(OffBall.DashSFX, Root);
    local u198 = mainreplication.bodyVelocity(Root, 100, 0.9, nil, nil, nil, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In));

    if u198 then
        mainreplication.fov(true, 40, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
    end;

    task.delay(u196, function() -- Line: 1409
        -- upvalues: u197 (copy), u196 (copy), u198 (copy), mainreplication (ref), script_Afterimage (ref), u195 (copy)
        local v199 = u197 - u196;

        if u198 then
            mainreplication.fov(true, 90, v199, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;

        script_Afterimage({
            Enabled = true,
            Character = u195
        });
        task.delay(v199, function() -- Line: 1413
            -- upvalues: u198 (ref), mainreplication (ref), script_Afterimage (ref), u195 (ref)
            if u198 then
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end;

            script_Afterimage({
                Enabled = false,
                Character = u195
            });
        end);
    end);
    local v200 = {
        Speed = 0.4,
        CFrames = true,
        Brightness = 1,
        ImageTransparency = 0.7,
        Count = 10,
        Whitelist = { u195 },
        BlacklistedParts = { "Ball" },
        CountSpeed = u197 / 10
    };
    local v201 = Color3_fromRGB_ret;

    if Util.canshiftcolor(LocalPlayer, u195) then
        v201 = v201:Lerp(u195:GetAttribute("CustomColor") or Color3_fromRGB_ret, u195:GetAttribute("CustomAlpha") or 0.985);
    end;

    v200.Color = v201;
    BackgroundHighlight(v200);
    local u202 = trove.new();
    u202:AttachToInstance(u195);
    local v203 = u202:Clone(OffBall.Run);
    v203:PivotTo(Root.CFrame);
    v203.Parent = workspace.Effects;
    applyRecolor(u195, v203);
    forge.emit(v203);
    local v204 = u202:Clone(OffBall.Grass);
    v204.Parent = Root;
    local v205 = { 0, 0.267, 0.467, 0.783 };

    for _, v in v205 do
        u202:Add(task.delay(v, forge.emit, v204));
    end;

    local task_delay = task.delay;
    local v206 = v205[#v205] + vfxUtil.getEmittersLifetime(v204);
    u202:Add(task_delay(math.max(v206, vfxUtil.getEmittersLifetime(v203)), function() -- Line: 1454
        -- upvalues: u202 (copy)
        u202:Destroy();
    end));
end;

function u1.toitoi_tikioffpass(p207) -- Line: 1460
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), applyRecolor (copy), forge (copy), mainreplication (copy), Color3_fromRGB_ret (copy)
    local OffBall = vfxUtil.getResources().otoya.TikiTaka.OffBall;
    local Root = vfxUtil.getRoot(p207);
    soundUtil:play(OffBall.KickSFX, Root);
    local u208 = trove.new();
    u208:AttachToInstance(p207);
    local v209 = u208:Clone(OffBall.Impact);
    v209.Parent = Root;
    applyRecolor(p207, v209);
    forge.emit(v209);
    u208:Add(task.delay(vfxUtil.getEmittersLifetime(v209), function() -- Line: 1474
        -- upvalues: u208 (copy)
        u208:Destroy();
    end));

    if vfxUtil.isLocalPlayer(p207) then
        mainreplication.cameraShake(15, 2, 5);
        vfxUtil.flash(Color3_fromRGB_ret, 1);
    end;
end;

return u1;