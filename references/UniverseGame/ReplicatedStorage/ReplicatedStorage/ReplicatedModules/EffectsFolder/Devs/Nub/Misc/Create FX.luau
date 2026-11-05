  

 

local _ = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.KnitPath.Promise);
local ParticleInfo = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local Particle = require(PathShortcuts.ReplicatedModules.Classes.Particle);
local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LightningBolt = game.ReplicatedStorage.ClientModules.LightningBolt;
local u1 = require(LightningBolt);
local LightningSparks = require(LightningBolt.LightningSparks);
local LightningExplosion = require(LightningBolt.LightningExplosion);
local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

local function Tween(p2, p3, p4, p5) -- Line: 24
    -- upvalues: TweenService (copy)
    local v6 = TweenService:Create(p2, TweenInfo.new(p3, Enum.EasingStyle[p4.Style or "Linear"], Enum.EasingDirection[p4.Direction or "Out"]), p5);
    v6:Play();

    return v6;
end;

local function weld(p7, p8, p9, p10) -- Line: 30
    local Weld = p7:FindFirstChild("Weld");

    if Weld then
        Weld.Part0 = p7;
        Weld.Part1 = p8;
    else
        Weld = Instance.new("Weld");
        Weld.Parent = p7;
        Weld.Part0 = p7;
        Weld.Part1 = p8;
    end;

    if p9 then
        Weld.C0 = p9;
    end;

    if p10 then
        Weld.C1 = p10;
    end;
end;

local function weldconstraint(p11, p12) -- Line: 48
    local Weld = p11:FindFirstChild("Weld");

    if Weld then
        Weld.Part0 = p11;
        Weld.Part1 = p12;

        return Weld;
    end;

    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p11;
    WeldConstraint.Part1 = p12;
    WeldConstraint.Parent = p11;

    return WeldConstraint;
end;

local function fakeweldconstraint(p13, p14) -- Line: 61
    local Weld = p13:FindFirstChild("Weld");

    if Weld then
        Weld.Part0 = p13;
        Weld.Part1 = p14;

        return;
    end;

    local Weld2 = Instance.new("Weld");
    Weld2.C0 = p13.CFrame:ToObjectSpace(p14.CFrame);
    Weld2.Part0 = p13;
    Weld2.Part1 = p14;
    Weld2.Parent = p13;
end;

local function tweendeb(p15, p16) -- Line: 74
    p15:Play();
    p15.Completed:Wait();

    if p16 then
        p16:Destroy();
    end;

    return true;
end;

local function applyProps(p17, p18) -- Line: 80
    for i, v in pairs(p18) do
        p17[i] = v;
    end;
end;

local u19 = game.ReplicatedStorage["Client Assets"];
local _ = math.rad;

return function(u20, ...) -- Line: 90
    -- upvalues: u19 (copy), u19 (copy), ParticleHandler (copy), TweenService (copy), CurrentCamera (copy), AnimationHandler (copy), applyProps (copy), Debris (copy), u1 (copy), LightningExplosion (copy), LightningSparks (copy), SoundGroups (copy), Trove (copy), ParticleInfo (copy), Particle (copy)
    local wait = task.wait;
    local delay = task.delay;
    ({
        ["Weld FX"] = function(p21, p22, p23, p24) -- Line: 93
            local u25 = p21:Clone();
            local v26 = u25;
            local Weld = v26:FindFirstChild("Weld");

            if Weld then
                Weld.Part0 = v26;
                Weld.Part1 = p22;
            else
                Weld = Instance.new("Weld");
                Weld.Parent = v26;
                Weld.Part0 = v26;
                Weld.Part1 = p22;
            end;

            if p23 then
                Weld.C0 = p23;
            end;

            if p24 then
                Weld.C1 = p24;
            end;

            u25.Parent = workspace.Effects;
            p22.AncestryChanged:Connect(function() -- Line: 97
                -- upvalues: u25 (ref)
                u25:Destroy();
            end);
        end,

        ["Destroy FX"] = function(p27) -- Line: 101
            local v28 = workspace.Effects:FindFirstChild(p27);

            if v28 then
                for _, descendant in ipairs(v28:GetDescendants()) do
                    if descendant.ClassName == "ParticleEmitter" then
                        descendant.Enabled = false;
                    end;
                end;

                task.delay(1, v28.Destroy, v28);
            end;
        end,

        ["Yone Ult Decals"] = function(p29, p30, p31) -- Line: 112
            -- upvalues: u19 (ref), u19 (ref), ParticleHandler (ref), TweenService (ref)
            local v32 = (p29 and u19.Yone:FindFirstChild(p29) or u19.Yone)["Ult Decal"]:Clone();
            ParticleHandler.Unusualify(v32, {
                HSVData = p31
            });
            v32.Size = Vector3.new(15, 0, 0);
            v32.CFrame = p30 * CFrame.new(0, -1.5, 0);
            local v33 = CFrame.new(0, 0, -25);

            if p29 == "Dawnbringer" then
                v32.CFrame = v32.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
                v33 = CFrame.new(0, 0, 25);
            end;

            v32.Parent = workspace.Effects;
            task.delay(5, v32.Destroy, v32);
            local v34 = TweenService:Create(v32, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                Size = Vector3.new(15, 0, 50),
                CFrame = v32.CFrame * v33
            });
            v34:Play();
            v34.Completed:Wait();
            local v35 = 1;

            for _, child in ipairs(v32:GetChildren()) do
                if child:IsA("Decal") then
                    if v35 == 3 then
                        TweenService:Create(child, TweenInfo.new(3, Enum.EasingStyle.Sine), {
                            Transparency = 1
                        }):Play();
                    else
                        TweenService:Create(child, TweenInfo.new(v35 * 0.5, Enum.EasingStyle.Sine), {
                            Transparency = 1
                        }):Play();
                    end;

                    v35 = v35 + 1;
                elseif child.Name == "FateFX" then
                    child:Emit(15);
                elseif child.Name == "Smoke" then
                    child.Enabled = true;
                    task.delay(2, function() -- Line: 141
                        -- upvalues: child (copy)
                        child.Enabled = false;
                    end);
                end;
            end;

            local v36 = ParticleHandler.GenerateEmitInfo(v32.StartupEffect);
            local v37 = ParticleHandler.GenerateEmitInfo(v32.EndEffect);
            ParticleHandler.Emit(v32.StartupEffect, v36);
            ParticleHandler.Emit(v32.EndEffect, v37);
        end,

        ["Yone Ult Indicator"] = function(p38, p39, p40, p41) -- Line: 152
            -- upvalues: ParticleHandler (ref), u19 (ref), TweenService (ref), wait (copy)
            local Size = p40.Hitbox.Size;
            local v42 = ParticleHandler.TryHSVShift(p40.UltColor or Color3.new(1, 0, 0), p41);
            local v43 = (p38 and u19.Yone:FindFirstChild(p38) or u19.Yone)["Ult Indicator"]:Clone();
            ParticleHandler.Unusualify(v43, {
                IncludeParts = true,
                HSVData = p41
            });
            v43.Anchored = true;
            v43.CanCollide = false;
            v43.Transparency = 1;
            v43.Size = Vector3.new(Size.X * 2.25, 0.5, 0);
            v43.CFrame = p39;
            p40.Hitbox.Offset = CFrame.new(0, 0, p40.Hitbox.Size.Z * -0.5);

            if p38 == "Dawnbringer" then
                v43.CFrame = v43.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
                p40.Hitbox.Offset = CFrame.new(0, 0, p40.Hitbox.Size.Z * 0.5);
                local v44 = { -10.5, 10.5 };

                for i = 1, #v44 do
                    local Part = Instance.new("Part");
                    Part.CFrame = p39 * CFrame.new(v44[i], 0.5, 0);
                    Part.Parent = workspace.Terrain;
                    Part.Anchored = true;
                    Part.Material = "Neon";
                    Part.Color = ParticleHandler.TryHSVShift(Color3.fromRGB(155, 199, 255), p41);
                    Part.Size = Vector3.new(0.4, 0.4, 0.25);
                    local u45 = v44[i] / 2;
                    local v46 = {
                        Style = "Sine",
                        Direction = "Out"
                    };
                    local v47 = {
                        Color = ParticleHandler.TryHSVShift(Color3.fromRGB(255, 29, 29), p41),
                        Size = Part.Size + Vector3.new(0, 0, 55),
                        CFrame = Part.CFrame * CFrame.new(0, 0, -27.5)
                    };
                    TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle[v46.Style or "Linear"], Enum.EasingDirection[v46.Direction or "Out"]), v47):Play();
                    task.delay(0.4, function() -- Line: 182
                        -- upvalues: Part (copy), u45 (copy), TweenService (ref)
                        local u48 = Part:Clone();
                        u48.Size = Vector3.new(0.25, 0.4, 0.4);
                        u48.CFrame = Part.CFrame * CFrame.new(0, 0, -Part.Size.Z / 2);
                        u48.Parent = Part.Parent;
                        local v49 = {
                            Style = "Sine",
                            Direction = "InOut"
                        };
                        local v50 = {};
                        local Size2 = u48.Size;
                        local v51 = math.abs(u45 * 2);
                        v50.Size = Size2 + Vector3.new(v51, 0, 0);
                        v50.CFrame = u48.CFrame * CFrame.new(-u45, 0, 0);
                        TweenService:Create(u48, TweenInfo.new(0.15, Enum.EasingStyle[v49.Style or "Linear"], Enum.EasingDirection[v49.Direction or "Out"]), v50):Play();
                        task.delay(0.4, function() -- Line: 190
                            -- upvalues: Part (ref), TweenService (ref), u48 (copy)
                            local v52 = {
                                Style = "Quad",
                                Direction = "Out"
                            };
                            local v53 = {
                                Transparency = 1,
                                Size = Part.Size - Vector3.new(0.2, 0.2, 0)
                            };
                            TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle[v52.Style or "Linear"], Enum.EasingDirection[v52.Direction or "Out"]), v53):Play();
                            local v54 = {
                                Style = "Quad",
                                Direction = "Out"
                            };
                            local v55 = {
                                Transparency = 1,
                                Size = u48.Size - Vector3.new(0, 0.2, 0.2)
                            };
                            TweenService:Create(u48, TweenInfo.new(1.5, Enum.EasingStyle[v54.Style or "Linear"], Enum.EasingDirection[v54.Direction or "Out"]), v55):Play();
                            task.wait(1.55);
                            Part:Destroy();
                            u48:Destroy();
                        end);
                    end);
                end;
            end;

            v43.Parent = workspace.Effects;
            TweenService:Create(v43, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                CFrame = v43.CFrame * p40.Hitbox.Offset,
                Size = Vector3.new(Size.X * 2.25, 0.5, Size.Z * 1.25)
            }):Play();

            for _, descendant in ipairs(v43:GetDescendants()) do
                if (descendant:IsA("Decal") or descendant:IsA("ImageLabel")) and (descendant.Name ~= "Main" or p38 ~= "Dawnbringer") then
                    local v56 = descendant:IsA("ImageLabel") and ({
                        ImageColor3 = v42
                    } or {
                        Color3 = v42
                    }) or {
                        Color3 = v42
                    };
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Linear), v56):Play();
                end;
            end;

            wait(0.6);

            for _, descendant in ipairs(v43:GetDescendants()) do
                if descendant:IsA("Decal") or descendant:IsA("ImageLabel") then
                    local v57 = descendant:IsA("ImageLabel") and {
                        ImageTransparency = 1
                    } or {
                        Transparency = 1
                    };
                    TweenService:Create(descendant, TweenInfo.new(2, Enum.EasingStyle.Linear), v57):Play();
                end;
            end;

            task.delay(2.5, v43.Destroy, v43);
        end,

        ["Yone Mortal Dash"] = function(p58, p59) -- Line: 218
            -- upvalues: u19 (ref), ParticleHandler (ref), TweenService (ref), wait (copy)
            if not (p58 and p58:IsDescendantOf(workspace)) then
                return;
            end;

            local v60 = u19.Yone.Particles["Mortal Dash"]:Clone();
            ParticleHandler.Unusualify(v60, {
                IncludeParts = true,
                HSVData = p59
            });
            v60.CFrame = p58.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
            v60.Parent = workspace.Effects;
            TweenService:Create(v60, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Size = Vector3.new(v60.Size.X, v60.Size.Y, 20),
                CFrame = v60.CFrame * CFrame.new(0, 0, 10)
            }):Play();
            wait(0.3);
            TweenService:Create(v60, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Size = Vector3.new(v60.Size.X, v60.Size.Y, 10),
                CFrame = v60.CFrame * CFrame.new(0, 0, 20)
            }):Play();
            wait(0.3);
            TweenService:Create(v60, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                Size = Vector3.new(v60.Size.X, v60.Size.Y, 0),
                CFrame = v60.CFrame * CFrame.new(0, 0, 5)
            }):Play();
            wait(0.15);
            task.delay(1, v60.Destroy, v60);
        end,

        ["Yas Ult Cam"] = function(p61) -- Line: 232
            -- upvalues: u19 (ref), CurrentCamera (ref), AnimationHandler (ref)
            local wait2 = task.wait;
            local u62 = u19.Yasuo.CameraRig:Clone();
            u62.HumanoidRootPart.CFrame = p61;
            u62.Parent = workspace.Effects;
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local u63 = nil;
            task.spawn(function() -- Line: 239
                -- upvalues: u63 (ref), CurrentCamera (ref), u62 (copy), wait2 (copy)
                while not u63 do
                    CurrentCamera.CFrame = u62.Head.CFrame;
                    wait2();
                end;
            end);
            local v64 = AnimationHandler.CreateAnimationByName("Yasuo", nil, "Ult Cam");
            local v65 = u62.Humanoid:LoadAnimation(v64);
            v65:Play();
            v65.Stopped:Wait();
            u63 = true;
            CurrentCamera.CameraType = Enum.CameraType.Custom;
            u62:Destroy();
        end,

        ["Yas Grab Cam"] = function(u66) -- Line: 253
            -- upvalues: u19 (ref), CurrentCamera (ref), AnimationHandler (ref)
            local wait2 = task.wait;
            local u67 = u19.Universal.DefaultCamRig:Clone();
            u67.HumanoidRootPart.CFrame = u66.CFrame;
            u67.Parent = workspace.Effects;
            CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local u68 = nil;
            task.spawn(function() -- Line: 260
                -- upvalues: u68 (ref), u66 (copy), CurrentCamera (ref), u67 (copy), wait2 (copy)
                while not u68 and (u66.Parent and u66.Parent.Parent) do
                    CurrentCamera.CFrame = u67.Head.CFrame;
                    wait2();
                end;
            end);
            local v69 = AnimationHandler.CreateAnimationByName("Yasuo", nil, "Grab Cam");
            local v70 = u67.Humanoid:LoadAnimation(v69);
            v70:Play();
            v70.Stopped:Wait();
            u68 = true;
            CurrentCamera.CameraType = Enum.CameraType.Custom;
            u67:Destroy();
        end,

        ["CFrame Part"] = function(p71, p72, p73) -- Line: 274
            if not (p71 and (p72 and (p71:IsDescendantOf(workspace) and p72:IsDescendantOf(workspace)))) then
                return;
            end;

            p71.CFrame = p72.CFrame * (p73 or CFrame.identity);
        end,

        ["Slash FX"] = function(p74, p75, p76) -- Line: 278
        end,

        ["Slash FX V2"] = function(p77, u78) -- Line: 301
            -- upvalues: wait (copy)
            local Angles = CFrame.Angles;
            local _ = math.rad;
            local v79 = {
                RIGHT = function() -- Line: 304
                    -- upvalues: u78 (copy)
                    local front = u78.front;
                    u78.front = u78.back;
                    u78.back = front;
                end,

                UP = function() -- Line: 307
                    -- upvalues: u78 (copy), Angles (copy)
                    u78.offset = Angles(0, -1.5707963267948966, -1.5707963267948966);
                end,

                DOWN = function() -- Line: 310
                    -- upvalues: u78 (copy), Angles (copy)
                    local front = u78.front;
                    u78.front = u78.back;
                    u78.back = front;
                    u78.offset = Angles(0, -1.5707963267948966, -1.5707963267948966);
                end,

                D_LEFT_UP = function() -- Line: 314
                    -- upvalues: u78 (copy), Angles (copy)
                    u78.offset = Angles(1.5707963267948966, 0, 0) * Angles(0, -0.7853981633974483, 0);
                end,

                D_LEFT_DOWN = function() -- Line: 317
                    -- upvalues: u78 (copy), Angles (copy)
                    local front = u78.front;
                    u78.front = u78.back;
                    u78.back = front;
                    u78.offset = Angles(1.5707963267948966, 0, 0) * Angles(0, -0.7853981633974483, -0);
                end,

                D_RIGHT_UP = function() -- Line: 321
                    -- upvalues: u78 (copy), Angles (copy)
                    local front = u78.front;
                    u78.front = u78.back;
                    u78.back = front;
                    u78.offset = Angles(1.5707963267948966, 0, 0) * Angles(0, 0.7853981633974483, -0);
                end,

                D_RIGHT_DOWN = function() -- Line: 325
                    -- upvalues: u78 (copy), Angles (copy)
                    u78.offset = Angles(1.5707963267948966, 0, 0) * Angles(0, 0.7853981633974483, 0);
                end
            };

            if v79[u78.preset] then
                v79[u78.preset]();
            end;

            local HumanoidRootPart = p77:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local v80 = HumanoidRootPart.CFrame * (u78.offset or CFrame.Angles(1.5707963267948966, 0, 0));
            local u81 = u78.part:Clone();
            u81.CFrame = v80;
            local u82 = 1 / u78.fps;

            for i = 1, 2 do
                task.spawn(function() -- Line: 339
                    -- upvalues: u81 (copy), HumanoidRootPart (copy), u78 (copy), i (copy), wait (ref), u82 (copy)
                    local v83 = u81;
                    local v84 = HumanoidRootPart;
                    local Weld = v83:FindFirstChild("Weld");

                    if Weld then
                        Weld.Part0 = v83;
                        Weld.Part1 = v84;
                    else
                        local Weld2 = Instance.new("Weld");
                        Weld2.C0 = v83.CFrame:ToObjectSpace(v84.CFrame);
                        Weld2.Part0 = v83;
                        Weld2.Part1 = v84;
                        Weld2.Parent = v83;
                    end;

                    local Texture = Instance.new("Texture");
                    Texture.Color3 = u78.color or Color3.new(1, 1, 1);
                    Texture.Texture = i == 1 and u78.front or u78.back;
                    Texture.Face = i == 1 and "Front" or "Back";
                    u81.Size = u78.size;
                    local Size = u81.Size;
                    local v85 = 0;
                    local v86 = 0;
                    Texture.StudsPerTileU = u78.columns * Size.X;
                    Texture.StudsPerTileV = u78.rows * Size.Y;
                    Texture.Parent = u81;
                    u81.Parent = workspace.Effects;
                    local u87 = nil;

                    if u78.rotation then
                        local u88 = Vector3.new(0, 0, -u78.rotation);
                        task.spawn(function() -- Line: 355
                            -- upvalues: u87 (ref), u81 (ref), u88 (copy), wait (ref)
                            while not u87 do
                                local v89 = u81;
                                v89.Orientation = v89.Orientation + u88;
                                wait();
                            end;
                        end);
                    end;

                    for _ = 1, u78.frames do
                        v86 = v86 + 1;

                        if u78.columns < v86 then
                            v85 = v85 + 1;
                            v86 = 1;
                        end;

                        Texture.OffsetStudsU = Size.X * (v86 - 1);
                        Texture.OffsetStudsV = Size.Y * (v85 - 1);
                        wait(u82);
                    end;

                    Texture.Texture = "";
                    u87 = true;
                    u81:Destroy();
                end);
            end;
        end,

        ["Slash FX V3"] = function(p90, u91) -- Line: 378
            -- upvalues: applyProps (ref), u20 (copy), delay (copy)
            local Angles = CFrame.Angles;
            local _ = math.rad;
            u91.Offset = u91.Offset or CFrame.new();
            u91.Angle = u91.Angle or CFrame.new();
            u91.ParticleProps = u91.ParticleProps or {};
            local v92 = {
                LEFT = function() -- Line: 393
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(-90);

                    return Angles(0, -0.7853981633974483, 3.12413936106985);
                end,

                RIGHT = function() -- Line: 397
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(-90);

                    return Angles(0, 0.7853981633974483, 0);
                end,

                UP = function() -- Line: 401
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(-90);

                    return Angles(0, 0, 1.5707963267948966);
                end,

                D_RIGHT_UP = function() -- Line: 405
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(-90);

                    return Angles(0, 0, 0.7853981633974483);
                end,

                D_LEFT_UP = function() -- Line: 409
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(-90);

                    return Angles(0, 0, 2.356194490192345);
                end,

                DOWN = function() -- Line: 413
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(90);

                    return Angles(0, 0, -1.5707963267948966);
                end,

                D_LEFT_DOWN = function() -- Line: 417
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(90);

                    return Angles(0, 0, -0.7853981633974483);
                end,

                D_RIGHT_DOWN = function() -- Line: 421
                    -- upvalues: u91 (copy), Angles (copy)
                    u91.ParticleProps.Rotation = NumberRange.new(90);

                    return Angles(0, 0, -2.356194490192345);
                end
            };
            local v93 = CFrame.new();

            if v92[u91.Preset] then
                v93 = v92[u91.Preset]();
            end;

            local HumanoidRootPart = p90:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local v94 = HumanoidRootPart.CFrame * u91.Offset * v93 * u91.Angle;
            local v95 = u91.Part:Clone();
            v95.CFrame = v94;
            v95.Anchored = false;
            v95.CanCollide = false;
            v95.Transparency = 1;
            local Weld = v95:FindFirstChild("Weld");

            if Weld then
                Weld.Part0 = v95;
                Weld.Part1 = HumanoidRootPart;
            else
                local Weld2 = Instance.new("Weld");
                Weld2.C0 = v95.CFrame:ToObjectSpace(HumanoidRootPart.CFrame);
                Weld2.Part0 = v95;
                Weld2.Part1 = HumanoidRootPart;
                Weld2.Parent = v95;
            end;

            local v96 = 1.5;

            for _, descendant in ipairs(v95:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    if v96 < descendant.Lifetime.Max then
                        v96 = descendant.Lifetime.Max or v96;
                    end;

                    if descendant.Name == "CanModify" then
                        local success, result = pcall(applyProps, descendant, u91.ParticleProps);

                        if not success then
                            warn("Error in", u20, result);
                        end;
                    end;
                end;
            end;

            v95.Parent = workspace.Effects;

            for _, descendant in ipairs(v95:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(tonumber(descendant.Name) or 1);
                end;
            end;

            delay(v96 + 1, v95.Destroy, v95);
        end,

        Airborne = function(p97, p98) -- Line: 464
            -- upvalues: TweenService (ref)
            if not (p97 and p97:IsDescendantOf(workspace)) then
                return;
            end;

            TweenService:Create(p97, TweenInfo.new(p98.AirborneTime / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
                CFrame = p97.CFrame + p98.AirbornePos
            }):Play();
        end,

        ["Umbra Judgement Cut"] = function(p99, p100, p101, p102, p103) -- Line: 469
            -- upvalues: u19 (ref), TweenService (ref), Debris (ref)
            local v104 = u19.Umbra.judgement:Clone();
            local Trail = v104.Trail;
            local v105;

            if p102 and p102.CustomColor then
                v105 = ColorSequence.new(p102.CustomColor);
            else
                v105 = v104.Trail.Color;
            end;

            Trail.Color = v105;
            v104.CFrame = p99.CFrame;
            v104.Parent = workspace.Effects;
            local v106 = TweenService:Create(v104, TweenInfo.new(p101, Enum.EasingStyle.Linear), {
                CFrame = p100
            });
            v106:Play();
            v106.Completed:Wait();
            Debris:AddItem(v104, 0.5);
        end,

        ["Umbra Sovereign"] = function(p107, p108, p109, p110) -- Line: 491
            -- upvalues: u19 (ref), TweenService (ref), Debris (ref)
            local v111 = u19.Umbra.SovereignFX:Clone();

            for _, descendant in ipairs(v111:GetDescendants()) do
                if (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) and descendant.Name ~= "Smoke" then
                    descendant.Color = ColorSequence.new(p107.SovereignColor or Color3.fromRGB(255, 85, 255));
                end;
            end;

            local v112 = p107.FXDuration / 2;
            TweenService:Create(p110, TweenInfo.new(v112, Enum.EasingStyle.Sine), {
                Transparency = 0
            }):Play();
            local Start = v111.Start;
            local End = v111.End;
            local Smoke = v111.Smoke;
            Start:WaitForChild("Core");
            End:WaitForChild("Core");
            local v113 = CFrame.Angles(0, 0, -1.5707963267948966);
            local v114 = p109.CFrame * CFrame.new(0, -3, 0) * v113;
            Start.Core.CFrame = v114;
            Start.Core2.CFrame = v114;
            End.Core.CFrame = v114;
            End.Core2.CFrame = v114;
            Smoke.CFrame = Start:GetBoundingBox() * CFrame.new(-Start.Core.Size.X / 2, 0, 0) * v113;
            v111.Parent = workspace.Effects;

            for _, descendant in ipairs(v111:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" or descendant.ClassName == "Beam" then
                    descendant.Enabled = true;
                end;
            end;

            local v115 = p109.CFrame * CFrame.new(0, 200, 0) * v113;
            TweenService:Create(End.Core, TweenInfo.new(v112, Enum.EasingStyle.Sine), {
                CFrame = v115
            }):Play();
            local v116 = TweenService:Create(End.Core2, TweenInfo.new(v112, Enum.EasingStyle.Sine), {
                CFrame = v115
            });
            v116:Play();
            v116.Completed:Wait();

            for _, descendant in ipairs(p110:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(v111:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = false;
                end;
            end;

            TweenService:Create(Start.Core, TweenInfo.new(v112, Enum.EasingStyle.Sine), {
                CFrame = v115
            }):Play();
            local v117 = TweenService:Create(Start.Core2, TweenInfo.new(v112, Enum.EasingStyle.Sine), {
                CFrame = v115
            });
            v117:Play();
            v117.Completed:Wait();
            Debris:AddItem(v111, 0.5);
        end,

        ["Umbra Erasure"] = function(p118, p119, p120, p121, p122, u123) -- Line: 539
            -- upvalues: u1 (ref), LightningExplosion (ref), LightningSparks (ref), wait (copy)
            if not p118 then
                warn("Core is nil!");

                return;
            end;

            local u124 = workspace.Effects:WaitForChild(p122, 1);

            if not u124 then
                warn("GoalPart not found: " .. tostring(p122));

                return;
            end;

            local Umbra = game:GetService("ReplicatedStorage")["Client Assets"].Umbra;
            local u125 = Umbra[p119]:Clone();
            local u126 = Umbra[p120]:Clone();
            u125.Parent = workspace.Effects;
            u126.Parent = workspace.Effects;
            local u127 = u1;
            local u128 = LightningSparks;
            u125.CFrame = p118.CFrame * CFrame.new(0, 5, 0);
            u126.CFrame = p118.CFrame * CFrame.new(0, -3, 0);
            pcall(function() -- Line: 567
                -- upvalues: u126 (copy)
                u126.Debris.Enabled = true;
            end);

            local function generateBolt(p129, p130) -- Line: 571
                -- upvalues: u127 (copy), u123 (copy)
                local v131 = u127.new(p129, p130, 40);
                v131.Thickness = 0.5;
                v131.MaxRadius = 2.5;
                v131.AnimationSpeed = 20;
                v131.PulseSpeed = 5;
                v131.Color = u123 or Color3.fromRGB(255, 0, 255);

                return v131;
            end;

            local u132 = {};
            local u133 = {};
            pcall(function() -- Line: 584
                -- upvalues: u132 (copy), u125 (copy), u126 (copy), u127 (copy), u123 (copy), u133 (copy), u128 (copy)
                local v134 = u127.new(u125.Attach, u126["A" .. 1], 40);
                v134.Thickness = 0.5;
                v134.MaxRadius = 2.5;
                v134.AnimationSpeed = 20;
                v134.PulseSpeed = 5;
                v134.Color = u123 or Color3.fromRGB(255, 0, 255);
                table.insert(u132, v134);
                local v135 = u127.new(u125.Attach, u126["A" .. 2], 40);
                v135.Thickness = 0.5;
                v135.MaxRadius = 2.5;
                v135.AnimationSpeed = 20;
                v135.PulseSpeed = 5;
                v135.Color = u123 or Color3.fromRGB(255, 0, 255);
                table.insert(u132, v135);
                local v136 = u127.new(u125.Attach, u126["A" .. 3], 40);
                v136.Thickness = 0.5;
                v136.MaxRadius = 2.5;
                v136.AnimationSpeed = 20;
                v136.PulseSpeed = 5;
                v136.Color = u123 or Color3.fromRGB(255, 0, 255);
                table.insert(u132, v136);

                for _, v in ipairs(u132) do
                    table.insert(u133, u128.new(v));
                end;
            end);
            coroutine.wrap(function() -- Line: 594
                -- upvalues: u124 (copy), u126 (copy), wait (ref), u125 (copy), u132 (copy), u133 (copy)
                while u124 and u124:IsDescendantOf(workspace) do
                    pcall(function() -- Line: 596
                        -- upvalues: u126 (ref), u124 (ref)
                        u126.CFrame = u124.CFrame * CFrame.new(0, -3, 0);
                    end);
                    wait();
                end;

                pcall(function() -- Line: 602
                    -- upvalues: u126 (ref)
                    if u126 and u126:IsDescendantOf(workspace) then
                        u126.Debris.Enabled = false;
                    end;
                end);
                task.delay(1, function() -- Line: 608
                    -- upvalues: u125 (ref), u126 (ref)
                    pcall(function() -- Line: 609
                        -- upvalues: u125 (ref)
                        if u125 and u125.Destroy then
                            u125:Destroy();
                        end;
                    end);
                    pcall(function() -- Line: 610
                        -- upvalues: u126 (ref)
                        if u126 and u126.Destroy then
                            u126:Destroy();
                        end;
                    end);
                end);

                for _, v in ipairs(u132) do
                    pcall(function() -- Line: 614
                        -- upvalues: v (copy)
                        if v and v.Destroy then
                            v:Destroy();
                        end;
                    end);
                end;

                for _, v in ipairs(u133) do
                    pcall(function() -- Line: 618
                        -- upvalues: v (copy)
                        if v and v.Destroy then
                            v:Destroy();
                        end;
                    end);
                end;
            end)();
        end,

        ["Umbra Rebirth"] = function(p137, p138) -- Line: 622
            -- upvalues: u19 (ref), wait (copy), TweenService (ref)
            local u139 = u19.Umbra.BigHitFX:Clone();
            u139.CFrame = p138 * CFrame.new(0, 0, 0);

            for _, descendant in ipairs(u139:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Size = NumberSequence.new(0, 200);
                end;
            end;

            u139.Parent = workspace.Effects;
            local v140 = u19.Umbra.BigSword:Clone();
            local SwordHandle = v140.SwordHandle;
            local v141 = p137.CFrame * CFrame.new(0, 100, 50);
            local v142 = CFrame.new(v141.Position, p138.Position) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);
            SwordHandle.CFrame = v142;
            v140.Parent = workspace.Effects;
            local _, v143 = v140:GetBoundingBox();
            task.delay(3, function() -- Line: 638
                -- upvalues: u139 (copy), wait (ref)
                for _ = 1, 5 do
                    for _, descendant in ipairs(u139:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(descendant.Name == "Hit" and 5 or 1);
                        end;
                    end;

                    wait(1);
                end;
            end);
            local v144 = TweenService:Create(SwordHandle, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                CFrame = v142 + -v142.UpVector * (110 + v143.Y / 2)
            });
            v144:Play();
            v144.Completed:Wait();

            if v140 then
                v140:Destroy();
            end;

            game.Debris:AddItem(u139, 20);
        end,

        ["Hollow Spin"] = function(p145, p146) -- Line: 652
            -- upvalues: u19 (ref), wait (copy)
            local Head = p146.Head;
            local v147 = u19.Hollow.Whirl:Clone();
            v147.Anchored = true;
            v147.CanCollide = false;
            v147.CFrame = CFrame.new(Head.CFrame.Position + Vector3.new(0, 2, 0));
            v147.Parent = workspace.Effects;

            repeat
                v147.CFrame = CFrame.new(Head.CFrame.Position + Vector3.new(0, 2, 0));
                wait();
            until not p145.Values.HollowSpin.Value;

            task.delay(1.5, v147.Destroy, v147);

            for _, descendant in ipairs(v147:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = false;
                end;
            end;
        end,

        ["Ice Stampede Rain"] = function(p148, p149) -- Line: 670
            -- upvalues: u19 (ref), SoundGroups (ref), TweenService (ref), wait (copy), delay (copy)
            local v150 = u19["Candy Cutlass"]["Ice Stampede"].cloud:Clone();
            local v151 = u19["Candy Cutlass"]["Ice Stampede"].rain:Clone();
            SoundGroups:AssignSoundTag(v150.Spawn);
            SoundGroups:AssignSoundTag(v150.Rain);
            v150.Spawn:Play();
            v150.Rain:Play();
            TweenService:Create(v150, TweenInfo.new(0.5), {
                Size = Vector3.new(50, 34, 50)
            }):Play();
            v150.CFrame = p148.CFrame * CFrame.new(0, 30, 0);
            v151.CFrame = p148.CFrame * CFrame.new(0, 30, 0);
            v150.Parent = workspace.Effects;
            v151.Parent = workspace.Effects;

            for _, descendant in ipairs(v150:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(v151:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = true;
                end;
            end;

            wait(p149);

            for _, descendant in ipairs(v150:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in ipairs(v151:GetDescendants()) do
                if descendant.ClassName == "ParticleEmitter" then
                    descendant.Enabled = false;
                end;
            end;

            v150.Despawn:Play();
            TweenService:Create(v150, TweenInfo.new(0.5), {
                Size = Vector3.new()
            }):Play();
            delay(3, v151.Destroy, v151);
            delay(3, v150.Destroy, v150);
        end,

        ["Thousand Volt Plexus"] = function(u152, p153) -- Line: 708
            -- upvalues: Trove (ref), u19 (ref), ParticleHandler (ref), ParticleInfo (ref), Particle (ref)
            if p153 and p153.Parent:IsDescendantOf(workspace) then
                local u154 = Trove.new();
                u154:AttachToInstance(u152);
                u154:Connect(u152:GetAttributeChangedSignal("ThousandVoltPlexus"), function() -- Line: 712
                    -- upvalues: u152 (copy), u154 (copy)
                    if not u152:GetAttribute("ThousandVoltPlexus") then
                        u154:Destroy();
                    end;
                end);
                local v155 = u154:Add(u19.Assets.Abilities["Weather Report"].ChargeFX:Clone());
                ParticleHandler.Unusualify(v155, {
                    Character = u152
                });
                v155.CFrame = p153.CFrame * CFrame.new(0, -1, 0);
                v155.WeldConstraint.Part1 = p153;
                v155.Parent = workspace.Effects;
                local v156 = ParticleInfo.GetParticleInfo("WeatherReportHitEffect");
                local u157 = u154:Add(Particle.new({
                    Particle = v156.Object:Clone(),
                    ParticleInfo = v156.ParticleInfo
                }));
                ParticleHandler.Unusualify(u157.Particle, {
                    Character = u152
                });
                u157:Goto(p153.CFrame * CFrame.new(0, -1, 0));
                u157:Start();
                task.delay(2, function() -- Line: 732
                    -- upvalues: u157 (copy)
                    if u157.Particle then
                        u157:Destroy();
                    end;
                end);
            end;
        end,

        ["Blood Oxidation"] = function(p158) -- Line: 737
            -- upvalues: u19 (ref)
            if not (p158 and p158:IsDescendantOf(workspace)) then
                return;
            end;

            local v159 = u19.Assets.Abilities["Weather Report"].Particles.BloodOxBleed:Clone();
            local Weld = Instance.new("Weld");
            Weld.Part0 = v159;
            Weld.Part1 = p158;
            Weld.Parent = v159;
            v159.Parent = workspace.Effects;
            task.delay(2, v159.Destroy, v159);
        end,

        ["Air Bomb"] = function(p160, p161, p162) -- Line: 747
            -- upvalues: u19 (ref), TweenService (ref)
            if not (p160 and p160:IsDescendantOf(workspace)) then
                return;
            end;

            local u163 = u19.Assets.Abilities["Weather Report"].Particles["Air Bomb"]:Clone();
            p162.Changed:Connect(function() -- Line: 750
                -- upvalues: u163 (copy)
                for _, child in ipairs(u163:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child:Emit(30);
                    end;
                end;

                local v164 = 1;

                for _, descendant in ipairs(u163:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;

                        if v164 < descendant.Lifetime.Max then
                            v164 = descendant.Lifetime.Max;
                        end;
                    end;
                end;

                task.delay(math.max(v164, 3), u163.Destroy, u163);
            end);
            u163.CFrame = p160.CFrame;
            u163.Parent = workspace.Effects;
            TweenService:Create(u163, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                CFrame = p161
            }):Play();
            u163.Blast:Play();
            u163.Start:Play();
        end,

        ["Air Bomb V2"] = function(p165, p166, p167) -- Line: 775
            -- upvalues: Trove (ref), TweenService (ref)
            if not (p165 and p165:IsDescendantOf(workspace)) then
                return;
            end;

            local u168 = workspace.Effects:WaitForChild(p167, 5);

            if not u168 then
                return;
            end;

            local u169 = Trove.new();
            u169:Connect(u168:GetAttributeChangedSignal("Air_Bomb"), function() -- Line: 781
                -- upvalues: u169 (copy), u168 (copy)
                u169:Destroy();

                for _, child in ipairs(u168:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child:Emit(30);
                    end;
                end;

                local v170 = 1;

                for _, descendant in ipairs(u168:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;

                        if v170 < descendant.Lifetime.Max then
                            v170 = descendant.Lifetime.Max;
                        end;
                    end;
                end;
            end);
            u168.CFrame = p165.CFrame;
            TweenService:Create(u168, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                CFrame = p166
            }):Play();
            u168.Blast:Play();
            u168.Start:Play();
        end
    })[u20](...);
end;