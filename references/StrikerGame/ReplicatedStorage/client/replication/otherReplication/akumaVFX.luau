 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("@game/ReplicatedStorage/util/animationUtil");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local u2 = require("@game/ReplicatedStorage/util/soundUtil");
local u3 = require("@game/ReplicatedStorage/util/vfxUtil");
local BaseAnimations = u3.getResources().akuma.BaseAnimations;
local ShoulderThrow = u3.getResources().akuma.ShoulderThrow;
local DemonStep = u3.getResources().akuma.DemonStep;
local hitstop = u3.getResources().hitstop;
local u4 = { {
        time = 0,
        speed = 0
    }, {
        time = 0.13333333333333333,
        speed = 133
    }, {
        time = 0.3,
        speed = 112
    }, {
        time = 0.4666666666666667,
        speed = 104
    }, {
        time = 0.5666666666666667,
        speed = 88
    }, {
        time = 0.6333333333333333,
        speed = 0
    } };
local u5 = { {
        time = 0,
        speed = 0
    }, {
        time = 0.13333333333333333,
        speed = 78
    }, {
        time = 0.3,
        speed = 88
    }, {
        time = 0.46666666666666673,
        speed = 72
    }, {
        time = 1.2333333333333334,
        speed = 0
    } };
local u6 = { {
        time = 0,
        speed = 0
    }, {
        time = 0.1,
        speed = 123
    }, {
        time = 0.6666666666666666,
        speed = 0
    } };
local u7 = { {
        time = 0,
        speed = 70
    }, {
        time = 0.8333333333333334,
        speed = 70
    } };
local u8 = {
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true
};
local u9 = {
    {
        active_time = 0.28,
        images_per_second = 24,
        lifetime = 0.16,
        mode = "outandin",
        direction = Vector3.new(0, 0, 1),
        position_offset = Vector3.new(0, 0.08, 0.35),
        color_fade_delay = 0.04,
        color_fade_time = 0.12,
        fade_out = true,
        fade_delay = 0.02,
        fade_time = 0.14,
        spread = Vector2.new(22, 22),
        distance = NumberRange.new(0, 1.5),
        start_color = Color3.fromRGB(245, 245, 245),
        end_color = Color3.fromRGB(0, 0, 0)
    },
    {
        active_time = 0.18,
        images_per_second = 32,
        lifetime = 0.1,
        mode = "out",
        direction = Vector3.new(1, 0, 0),
        position_offset = Vector3.new(0, 0.08, 0.2),
        color_fade_delay = 0.03,
        color_fade_time = 0.08,
        fade_out = true,
        fade_delay = 0,
        fade_time = 0.1,
        spread = Vector2.new(28, 28),
        distance = NumberRange.new(0, 2),
        start_color = Color3.fromRGB(255, 255, 255),
        end_color = Color3.fromRGB(20, 20, 20)
    }
};
local u10 = {
    {
        active_time = 0.8333333333333334,
        images_per_second = 22,
        lifetime = 0.18,
        mode = "outandin",
        direction = Vector3.new(0, 0, 1),
        position_offset = Vector3.new(0, 0.05, 0.25),
        color_fade_delay = 0.02,
        color_fade_time = 0.12,
        fade_out = true,
        fade_delay = 0.02,
        fade_time = 0.16,
        spread = Vector2.new(18, 18),
        distance = NumberRange.new(0, 1.2),
        start_color = Color3.fromRGB(48, 48, 48),
        end_color = Color3.fromRGB(0, 0, 0)
    },
    {
        active_time = 0.8333333333333334,
        images_per_second = 28,
        lifetime = 0.12,
        mode = "out",
        direction = Vector3.new(1, 0, 0),
        position_offset = Vector3.new(0, 0.05, 0.15),
        color_fade_delay = 0.02,
        color_fade_time = 0.08,
        fade_out = true,
        fade_delay = 0,
        fade_time = 0.12,
        spread = Vector2.new(24, 24),
        distance = NumberRange.new(0, 1.6),
        start_color = Color3.fromRGB(90, 90, 90),
        end_color = Color3.fromRGB(0, 0, 0)
    }
};
local v11 = {};
local Random_new_ret = Random.new();

local function is_local_character(p12) -- Line: 170
    -- upvalues: Players (copy)
    return Players.LocalPlayer == Players:GetPlayerFromCharacter(p12);
end;

local function smoothstep(p13: number) -- Line: 174
    return p13 * p13 * (3 - p13 * 2);
end;

local function sample_speed(p14: table, p15: number) -- Line: 178
    if p15 <= p14[1].time then
        return p14[1].speed;
    end;

    for i = 1, #p14 - 1 do
        local v16 = p14[i];
        local v17 = p14[i + 1];

        if p15 <= v17.time then
            local v18 = v17.time - v16.time;

            if v18 <= 0 then
                return v17.speed;
            end;

            local v19 = (p15 - v16.time) / v18;

            return v16.speed + (v17.speed - v16.speed) * (v19 * v19 * (3 - v19 * 2));
        end;

        local _ = i;
    end;

    return p14[#p14].speed;
end;

local function flat_unit(p20: vector) -- Line: 199
    local Vector3_new_ret = Vector3.new(p20.X, 0, p20.Z);

    if Vector3_new_ret.Magnitude < 0.05 then
        return nil;
    end;

    return Vector3_new_ret.Unit;
end;

local function apply_forward_move(u21: any, u22: table, u23: number, u24: number, u25: boolean?, p26: any) -- Line: 207
    -- upvalues: u3 (copy), Players (copy), mainreplication (copy), RunService (copy), sample_speed (copy)
    local Root = u3.getRoot(u21);

    if not Root or Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u21) then
        return;
    end;

    mainreplication.destroyVelocity(Root);
    local u27 = u21:FindFirstChildOfClass("Humanoid");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(400000, 0, 400000);
    BodyVelocity.Parent = Root;
    local u28 = 0;
    local os_clock_ret = os.clock();
    local u29 = false;
    local u30 = nil;

    local function cleanup() -- Line: 232
        -- upvalues: u29 (ref), u30 (ref), BodyVelocity (copy)
        if u29 then
            return;
        end;

        u29 = true;

        if u30.Connected then
            u30:Disconnect();
        end;

        if BodyVelocity.Parent then
            BodyVelocity:Destroy();
        end;
    end;

    if p26 then
        p26:Add(cleanup);
    end;

    u30 = RunService.PreRender:Connect(function(p31: number) -- Line: 249
        -- upvalues: u21 (copy), Root (copy), u29 (ref), u30 (ref), BodyVelocity (copy), os_clock_ret (copy), u23 (copy), sample_speed (ref), u22 (copy), u24 (copy), u28 (ref), u25 (copy), u27 (copy), mainreplication (ref)
        if not (u21.Parent and Root.Parent) then
            if u29 then
                return;
            end;

            u29 = true;

            if u30.Connected then
                u30:Disconnect();
            end;

            if BodyVelocity.Parent then
                BodyVelocity:Destroy();
            end;

            return;
        end;

        local v32 = os.clock() - os_clock_ret;

        if u23 <= v32 then
            if u29 then
                return;
            end;

            u29 = true;

            if u30.Connected then
                u30:Disconnect();
            end;

            if BodyVelocity.Parent then
                BodyVelocity:Destroy();
            end;

            return;
        end;

        local v33 = sample_speed(u22, v32);
        local math_min_ret = math.min(1, p31 * u24);
        u28 = u28 + (v33 - u28) * math_min_ret;
        local LookVector = Root.CFrame.LookVector;

        if u25 and u27 then
            local MoveDirection = u27.MoveDirection;
            local Vector3_new_ret = Vector3.new(MoveDirection.X, 0, MoveDirection.Z);
            local v34;

            if Vector3_new_ret.Magnitude < 0.05 then
                v34 = nil;
            else
                v34 = Vector3_new_ret.Unit;
            end;

            LookVector = v34 or LookVector;
        end;

        BodyVelocity.Velocity = mainreplication.fixVelocity(Root, LookVector * u28);
    end);
end;

local function is_afterimage_part(p35: userdata) -- Line: 277
    -- upvalues: u8 (copy)
    return u8[p35.Name] and true or p35:FindFirstAncestorOfClass("Accessory") ~= nil;
end;

local function apply_mode(p36: string, p37: vector, p38: boolean) -- Line: 284
    if p36 == "inward" then
        return -p37, p38;
    end;

    if p36 ~= "outandin" then
        return p37, p38;
    end;

    local v39 = not p38;

    if not v39 then
        p37 = -p37;
    end;

    return p37, v39;
end;

local function apply_spread(p40: vector, p41) -- Line: 295
    -- upvalues: Random_new_ret (copy)
    local v42 = Random_new_ret:NextNumber(-math.rad(p41.X * 0.5), (math.rad(p41.X * 0.5)));
    local v43 = Random_new_ret:NextNumber(-math.rad(p41.Y * 0.5), (math.rad(p41.Y * 0.5)));

    return (CFrame.lookAt(Vector3.new(0, 0, 0), p40) * CFrame.Angles(v43, v42, 0)).LookVector;
end;

local function spawn_afterimage(p44: userdata, p45: table, p46: boolean) -- Line: 301
    -- upvalues: apply_spread (copy), Random_new_ret (copy), u8 (copy), TweenService (copy)
    local Pivot = p44:GetPivot();
    local v47 = Pivot:VectorToWorldSpace(p45.direction);
    local mode = p45.mode;

    if mode == "inward" then
        v47 = -v47;
    elseif mode == "outandin" then
        p46 = not p46;

        if not p46 then
            v47 = -v47;
        end;
    end;

    local v48 = apply_spread(v47, p45.spread) * Random_new_ret:NextNumber(p45.distance.Min, p45.distance.Max) + Pivot:VectorToWorldSpace(p45.position_offset);
    local Folder = Instance.new("Folder");
    Folder.Name = "AkumaAfterImage";
    local TweenInfo_new_ret = TweenInfo.new(p45.fade_time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, p45.fade_delay);
    local TweenInfo_new_ret2 = TweenInfo.new(p45.color_fade_time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, p45.color_fade_delay);

    for _, descendant in p44:GetDescendants() do
        if descendant:IsA("BasePart") and (u8[descendant.Name] or descendant:FindFirstAncestorOfClass("Accessory") ~= nil) then
            local v49 = descendant:Clone();

            for _, descendant2 in v49:GetDescendants() do
                if descendant2:IsA("JointInstance") or (descendant2:IsA("WeldConstraint") or (descendant2:IsA("Decal") or (descendant2:IsA("Texture") or descendant2:IsA("SurfaceAppearance")))) then
                    descendant2:Destroy();
                elseif descendant2:IsA("SpecialMesh") then
                    descendant2.TextureId = "";
                end;
            end;

            if v49:IsA("MeshPart") then
                v49.TextureID = "";
            end;

            v49.Anchored = true;
            v49.CanCollide = false;
            v49.CanTouch = false;
            v49.CanQuery = false;
            v49.CastShadow = false;
            v49.Massless = true;
            v49.Color = p45.start_color;
            v49.Material = Enum.Material.Neon;
            v49.Transparency = 0;
            v49.CFrame = descendant.CFrame + v48;
            v49.Parent = Folder;

            if p45.fade_out then
                TweenService:Create(v49, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            end;

            TweenService:Create(v49, TweenInfo_new_ret2, {
                Color = p45.end_color
            }):Play();
        end;
    end;

    Folder.Parent = workspace.Effects;
    task.delay(p45.lifetime, Folder.Destroy, Folder);

    return p46;
end;

local function play_afterimage(u50: userdata, u51: table, p52: any) -- Line: 375
    -- upvalues: spawn_afterimage (copy)
    p52:Add(task.spawn(function() -- Line: 376
        -- upvalues: u51 (copy), u50 (copy), spawn_afterimage (ref)
        local v53 = 1 / u51.images_per_second;
        local v54 = os.clock() + u51.active_time;
        local v55 = false;

        while os.clock() < v54 and u50.Parent do
            v55 = spawn_afterimage(u50, u51, v55);
            task.wait(v53);
        end;
    end));
end;

local function play_parry_afterimages(u56, p57) -- Line: 387
    -- upvalues: u9 (copy), spawn_afterimage (copy)
    for _, v in u9 do
        p57:Add(task.spawn(function() -- Line: 376
            -- upvalues: v (copy), u56 (copy), spawn_afterimage (ref)
            local v58 = 1 / v.images_per_second;
            local v59 = os.clock() + v.active_time;
            local v60 = false;

            while os.clock() < v59 and u56.Parent do
                v60 = spawn_afterimage(u56, v, v60);
                task.wait(v58);
            end;
        end));
    end;
end;

local function play_black_vignette(p61) -- Line: 393
    -- upvalues: u3 (copy), TweenService (copy)
    local Vignette = p61:Add(u3.getMoonEffects()).Vignette;
    Vignette.ImageColor3 = Color3.new(0, 0, 0);
    Vignette.ImageTransparency = 1;
    TweenService:Create(Vignette, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0.08
    }):Play();
    p61:Add(task.delay(0.22, function() -- Line: 405
        -- upvalues: TweenService (ref), Vignette (copy)
        TweenService:Create(Vignette, TweenInfo.new(0.32, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end));
end;

local function play_parry_land_feedback(u62) -- Line: 414
    -- upvalues: u3 (copy), u9 (copy), spawn_afterimage (copy), play_black_vignette (copy), u2 (copy), hitstop (copy), Players (copy), mainreplication (copy)
    local v63 = u3.character_trove(u62);

    for _, v in u9 do
        v63:Add(task.spawn(function() -- Line: 376
            -- upvalues: v (copy), u62 (copy), spawn_afterimage (ref)
            local v64 = 1 / v.images_per_second;
            local v65 = os.clock() + v.active_time;
            local v66 = false;

            while os.clock() < v65 and u62.Parent do
                v66 = spawn_afterimage(u62, v, v66);
                task.wait(v64);
            end;
        end));
    end;

    play_black_vignette(v63);
    u2:play(hitstop, u3.getRoot(u62) or "default");

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u62) then
        mainreplication.cameraShake(12, 0.28, 5);
    end;

    v63:Add(task.delay(0.55, v63.Destroy, v63));
end;

function v11.akuma_burst_run(u67) -- Line: 429
    -- upvalues: u1 (copy), BaseAnimations (copy), apply_forward_move (copy), u4 (copy), Players (copy), mainreplication (copy)
    if not (u67 and u67.Parent) then
        return;
    end;

    u1:loadAnimation(u67, BaseAnimations.burst_run):Play();
    apply_forward_move(u67, u4, 0.6333333333333333, 14);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u67) then
        task.delay(0.16666666666666666, function() -- Line: 438
            -- upvalues: u67 (copy), mainreplication (ref)
            if not u67.Parent then
                return;
            end;

            mainreplication.cameraShake(5, 0.22, 3);
            mainreplication.fov(false, 73);
            mainreplication.fov(true, 70, 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        end);
    end;
end;

function v11.akuma_parry(p68) -- Line: 449
    -- upvalues: u1 (copy), BaseAnimations (copy)
    if not (p68 and p68.Parent) then
        return;
    end;

    u1:loadAnimation(p68, BaseAnimations.parry_start):Play();
end;

function v11.akuma_parry_land(p69) -- Line: 456
    -- upvalues: u1 (copy), BaseAnimations (copy), apply_forward_move (copy), u6 (copy), play_parry_land_feedback (copy)
    if not (p69 and p69.Parent) then
        return;
    end;

    u1:loadAnimation(p69, BaseAnimations.parry_land):Play();
    apply_forward_move(p69, u6, 0.6666666666666666, 16);
    play_parry_land_feedback(p69);
end;

function v11.akuma_demon_flip(p70) -- Line: 466
    -- upvalues: u3 (copy), u1 (copy), BaseAnimations (copy), apply_forward_move (copy), u5 (copy)
    if not (p70 and p70.Parent) then
        return;
    end;

    local v71 = u3.character_trove(p70);
    local u72 = u1:loadAnimation(p70, BaseAnimations.demon_flip);
    u72:Play();
    v71:Add(function() -- Line: 474
        -- upvalues: u72 (copy)
        u72:Stop(0);
    end);
    apply_forward_move(p70, u5, 1.2333333333333334, 11, false, v71);
    v71:Add(task.delay(1.3333333333333335, v71.Destroy, v71));
end;

local function play_demon_step(u73) -- Line: 482
    -- upvalues: u3 (copy), u1 (copy), DemonStep (copy), apply_forward_move (copy), u7 (copy), u10 (copy), spawn_afterimage (copy)
    local v74 = u3.character_trove(u73);
    local u75 = u1:loadAnimation(u73, DemonStep.Animation);
    u75:Play();
    v74:Add(function() -- Line: 486
        -- upvalues: u75 (copy)
        u75:Stop(0);
    end);
    apply_forward_move(u73, u7, 0.8333333333333334, 40, true, v74);

    for _, v in u10 do
        v74:Add(task.spawn(function() -- Line: 376
            -- upvalues: v (copy), u73 (copy), spawn_afterimage (ref)
            local v76 = 1 / v.images_per_second;
            local v77 = os.clock() + v.active_time;
            local v78 = false;

            while os.clock() < v77 and u73.Parent do
                v78 = spawn_afterimage(u73, v, v78);
                task.wait(v76);
            end;
        end));
    end;

    v74:Add(task.delay(1.0833333333333335, v74.Destroy, v74));
end;

function v11.akuma_demon_step(p79) -- Line: 499
    -- upvalues: play_demon_step (copy)
    if not (p79 and p79.Parent) then
        return;
    end;

    play_demon_step(p79);
end;

function v11.akuma_demon_step_tackle(p80) -- Line: 507
    -- upvalues: play_demon_step (copy)
    if not (p80 and p80.Parent) then
        return;
    end;

    play_demon_step(p80);
end;

function v11.akuma_shoulder_throw(p81, p82) -- Line: 515
    -- upvalues: u1 (copy), ShoulderThrow (copy)
    if not (p81 and (p81.Parent and (p82 and p82.Parent))) then
        return;
    end;

    u1:loadAnimation(p81, ShoulderThrow.user):Play();
    u1:loadAnimation(p82, ShoulderThrow.victim):Play();
end;

return v11;