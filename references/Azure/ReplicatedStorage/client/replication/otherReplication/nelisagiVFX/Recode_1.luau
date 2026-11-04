 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("ServerStorage");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
require(ReplicatedStorage.allTypes.rig);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local trove = require(ReplicatedStorage.forum.trove);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local v1 = {};
local nelisagi = vfxUtil.getResources().nelisagi;
local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);

function v1.neoDirectShot_windup(p2: any, p3: number) -- Line: 32
    -- upvalues: vfxUtil (copy), mainreplication (copy), nelisagi (copy), trove (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local Root = vfxUtil.getRoot(p2);
    mainreplication.EmitAttachmentIn({
        Effect = nelisagi.StartNeo,
        AttachPart = Root
    });
    local u4 = trove.new();
    u4:AttachToInstance(p2);
    local u5 = u4:Extend();
    local v6 = u5:Clone(nelisagi.NeoWindTrail);
    v6.Join.Part0 = p2:FindFirstChild("Right Leg");
    v6.Parent = workspace.Effects;
    local u7 = {};

    for _, v in v6:QueryDescendants("Beam") do
        table.insert(u7, v);
        v.Enabled = true;
        TweenService:Create(v, TweenInfo_new_ret, {
            Width1 = 5
        }):Play();
    end;

    u4:Add(task.delay(0.3, function() -- Line: 56
        -- upvalues: u7 (copy), TweenService (ref), TweenInfo_new_ret (ref)
        for _, v in ipairs(u7) do
            TweenService:Create(v, TweenInfo_new_ret, {
                Width1 = 0
            }):Play();
        end;
    end));
    local u8 = u4:Clone(nelisagi.NeoLegTrail);
    u8.Join.Part0 = p2:FindFirstChild("Right Leg");
    u8.Parent = p2;
    u4:Add(task.delay(0.7 / p3, function() -- Line: 66
        -- upvalues: u4 (copy), u5 (copy), vfxUtil (ref), u8 (copy)
        u4:Remove(u5);
        vfxUtil.pick(u8);
        u4:Add(task.delay(vfxUtil.getEmittersLifetime(u8), function() -- Line: 69
            -- upvalues: u4 (ref)
            u4:Destroy();
        end));
    end));

    if vfxUtil.isLocalPlayer(p2) then
        mainreplication.fov(true, 120, 0.4, Enum.EasingStyle.Quart);
        mainreplication.cameraShake(15, 1.35, 3);
    end;
end;

function v1.neoDirectShot_landed(p9) -- Line: 80
    -- upvalues: vfxUtil (copy), mainreplication (copy), nelisagi (copy), ReplicatedStorage (copy)
    local Root = vfxUtil.getRoot(p9);
    mainreplication.bigshockwave(Root);
    mainreplication.Emit(Root, nelisagi.isagiKick, 3, CFrame.new(0, 0, -4));
    mainreplication.raycastEffect(Root, ReplicatedStorage.Resources.ForwardSmoke2);
    mainreplication.EmitAttachmentIn({
        Effect = nelisagi.NeoShoot,
        AttachPart = Root
    });

    if vfxUtil.isLocalPlayer(p9) then
        mainreplication.fov(true, 70, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.cameraShake(15, 1.5, 7);
    end;
end;

function v1.neoDirectVolley_windup(p10: any, p11: number, p12: number) -- Line: 94
    -- upvalues: vfxUtil (copy), trove (copy), nelisagi (copy), mainreplication (copy), ReplicatedStorage (copy)
    local Root = vfxUtil.getRoot(p10);
    local u13 = trove.new();
    u13:AttachToInstance(p10);
    local u14 = u13:Clone(nelisagi.NeoLegTrail);
    u14.Join.Part0 = p10:FindFirstChild("Right Leg");
    u14.Parent = p10;
    u13:Add(task.delay(p12, function() -- Line: 104
        -- upvalues: vfxUtil (ref), u14 (copy), u13 (copy)
        vfxUtil.pick(u14);
        u13:Add(task.delay(vfxUtil.getEmittersLifetime(u14), function() -- Line: 106
            -- upvalues: u13 (ref)
            u13:Destroy();
        end));
    end));

    if vfxUtil.isLocalPlayer(p10) then
        task.delay(p11, function() -- Line: 112
            -- upvalues: mainreplication (ref)
            mainreplication.cameraShake(15, 0.15, 7);
        end);
        task.delay(0.95, function() -- Line: 116
            -- upvalues: mainreplication (ref), Root (copy), ReplicatedStorage (ref)
            mainreplication.Emit(Root, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
            mainreplication.cameraShake(15, 0.15, 7);
        end);
    end;
end;

function v1.neoDirectVolley_landed(p15: any, p16: number) -- Line: 123
    -- upvalues: vfxUtil (copy), nelisagi (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy)
    local Root = vfxUtil.getRoot(p15);
    local v17 = nelisagi.NeoShootVolley:Clone();
    v17.Join.Part0 = Root;
    v17.Parent = workspace.Effects;

    if p16 > 0 then
        for _, v in v17:QueryDescendants("ParticleEmitter") do
            v.TimeScale = 0;
            v.LightEmission = -10;
            v:Emit(1);
        end;

        mainreplication.hitstopflash(p16, 0.3);
        mainreplication.highlight(p15, Color3.new(1, 1, 1), p16, true, 0);
        soundUtil:play(ReplicatedStorage.Resources.hitstop, Root);
        task.wait(p16);

        for _, v in v17:QueryDescendants("ParticleEmitter") do
            v.TimeScale = 0.5;
            v.LightEmission = -1;
            v:Emit((v:GetAttribute("EmitCount") or 0) - 1);
        end;
    end;

    if vfxUtil.isLocalPlayer(p15) then
        mainreplication.fov(true, 120, 0.01, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        task.delay(0.05, function() -- Line: 153
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end);
    end;

    mainreplication.bigshockwave(Root);
    mainreplication.Emit(Root, nelisagi.Kick, 3, CFrame.new(0, 0, -4));
    mainreplication.cameraShake(15, 1.5, 7);
    mainreplication.raycastEffect(Root, ReplicatedStorage.Resources.ForwardSmoke2);
    mainreplication.EmitAttachmentIn({
        Effect = nelisagi.NeoShoot,
        AttachPart = Root
    });
end;

local function weld_trail(p18: any, p19: userdata, p20: userdata?, p21: userdata) -- Line: 168
    if not p20 then
        return nil;
    end;

    local v22 = p18:Clone(p19);
    v22.Join.Part0 = p20;
    v22.Parent = p21;

    for _, descendant in v22:GetDescendants() do
        if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
            descendant.Enabled = true;
        end;
    end;

    return v22;
end;

local function release_trail(p23: any, p24: userdata?) -- Line: 186
    -- upvalues: vfxUtil (copy)
    if not p24 then
        p23:Destroy();

        return;
    end;

    vfxUtil.pick(p24);
    p23:Add(task.delay(vfxUtil.getEmittersLifetime(p24), p23.Destroy, p23));
end;

function v1.metaBurstPointLand(p25, p26) -- Line: 196
    -- upvalues: vfxUtil (copy), mainreplication (copy), weld_trail (copy), nelisagi (copy)
    local Root = vfxUtil.getRoot(p25);
    local v27 = 84;
    local v28, v29;

    if p26 then
        v27 = v27 * 2.25;
        v28 = 1.25;
        v29 = 2;
    else
        v28 = 0.7;
        v29 = 0.25;
    end;

    mainreplication.bodyVelocity(Root, v27, v28, p26 ~= true, nil, nil, TweenInfo.new(v29, Enum.EasingStyle.Quart));
    local u30 = vfxUtil.character_trove(p25);
    local u31 = weld_trail(u30, nelisagi.MetaBurstSlide, Root, p25);

    if p26 then
        local Sliding = u31.Sliding;
        Sliding.puzzles:Destroy();
        Sliding.Dots:Destroy();
        Sliding.Attachment.WaveBack:Destroy();
    end;

    u30:Add(task.delay(0.7, function() -- Line: 221
        -- upvalues: u30 (copy), u31 (copy), vfxUtil (ref)
        local v32 = u30;
        local v33 = u31;

        if not v33 then
            v32:Destroy();

            return;
        end;

        vfxUtil.pick(v33);
        v32:Add(task.delay(vfxUtil.getEmittersLifetime(v33), v32.Destroy, v32));
    end));
end;

function v1.metaBurstPointReuse(p34) -- Line: 226
    -- upvalues: vfxUtil (copy), weld_trail (copy), nelisagi (copy)
    local v35 = p34:FindFirstChild("Right Leg");

    if not v35 then
        return;
    end;

    local u36 = vfxUtil.character_trove(p34);
    local u37 = weld_trail(u36, nelisagi.NeoLegTrail, v35, p34);
    u36:Add(task.delay(0.75, function() -- Line: 234
        -- upvalues: u36 (copy), u37 (copy), vfxUtil (ref)
        local v38 = u36;
        local v39 = u37;

        if not v39 then
            v38:Destroy();

            return;
        end;

        vfxUtil.pick(v39);
        v38:Add(task.delay(vfxUtil.getEmittersLifetime(v39), v38.Destroy, v38));
    end));
end;

return v1;