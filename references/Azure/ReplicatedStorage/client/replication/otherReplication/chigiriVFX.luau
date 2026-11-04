 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.allTypes.rig);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local styles = require(ReplicatedStorage.wiki.styles);
local trove = require(ReplicatedStorage.forum.trove);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local chigiri = vfxUtil.getResources().chigiri;
local v1 = {};

for _, child in script:GetChildren() do
    v1[child.Name] = require(child);
end;

local function clear_aura(p2) -- Line: 29
    -- upvalues: vfxUtil (copy)
    for _, v in p2 do
        if v:IsA("ParticleEmitter") then
            v.Enabled = false;
            vfxUtil.disposal(v, v.Lifetime.Max);
        else
            v:Destroy();
        end;
    end;

    table.clear(p2);
end;

local function aura_check(p3, p4) -- Line: 41
    -- upvalues: clear_aura (copy), chigiri (copy)
    clear_aura(p4);

    if p3:GetAttribute("chigiri_winger") then
        for _, child in p3:GetChildren() do
            if child:IsA("BasePart") and (child.Name:match(" Leg") or (child.Name:match(" Arm") or (child.Name == "Torso" or child.Name == "Head"))) then
                local v5 = child;

                for _, child2 in chigiri.auracontainerr:GetChildren() do
                    local v6 = child2:Clone();
                    v6.Parent = v5;
                    table.insert(p4, v6);
                    local Keypoints = v6.Transparency.Keypoints;

                    for i = 1, #Keypoints do
                        Keypoints[i] = NumberSequenceKeypoint.new(Keypoints[i].Time, (math.lerp(Keypoints[i].Value, 1, 0.5)));
                        local _ = i;
                    end;

                    v6.Transparency = NumberSequence.new(Keypoints);
                    v6.Rate = v6.Rate / 2;
                end;
            end;
        end;
    end;
end;

local function update_lane(p7: any, p8: vector, p9: number, p10: number) -- Line: 62
    for _, child in p7:GetChildren() do
        if child:IsA("Beam") then
            local Attribute = child:GetAttribute("Width");

            if not Attribute then
                Attribute = child.Width0;
                child:SetAttribute("Width", Attribute);
            end;

            child.Width0 = Attribute * p9 * p10;
            child.Width1 = child.Width0;
        end;
    end;

    p7.Size = Vector3.new(p8.X * p10, 0.001, p8.Z);
end;

function v1.chigiri_winger(u11: any, p12: userdata, p13, u14: vector) -- Line: 77
    -- upvalues: vfxUtil (copy), trove (copy), clear_aura (copy), aura_check (copy), chigiri (copy), update_lane (copy), styles (copy), soundUtil (copy)
    local v15 = vfxUtil.isLocalPlayer(u11);
    local v16 = trove.new();
    v16:AttachToInstance(u11);
    v16:AttachToInstance(p12);
    local u17 = {};
    v16:Add(function() -- Line: 87
        -- upvalues: clear_aura (ref), u17 (copy)
        clear_aura(u17);
    end);
    v16:Connect(u11:GetAttributeChangedSignal("chigiri_winger"), function() -- Line: 91
        -- upvalues: aura_check (ref), u11 (copy), u17 (copy)
        aura_check(u11, u17);
    end);
    aura_check(u11, u17);
    local u18;

    if v15 then
        local u19 = u14.X / chigiri.WingSpecials.Size.X;
        u18 = chigiri.WingSpecials:Clone();
        u18.CFrame = p13;
        u18.Size = Vector3.new(u14.X, 0.001, u14.Z);
        u18.Parent = workspace.Effects;

        for _, v in u18:QueryDescendants("Attachment") do
            local v20 = math.sign(v.Position.Z) * (u14.Z / 2);
            v.Position = Vector3.new(0, 0, v20);
        end;

        update_lane(u18, u14, u19, p12.Value);
        v16:Connect(p12.Changed, function(p21) -- Line: 113
            -- upvalues: update_lane (ref), u18 (ref), u14 (copy), u19 (copy)
            update_lane(u18, u14, u19, p21);
        end);
        vfxUtil.flash(styles.chigiri.color, 1);
        soundUtil:play(chigiri.LaneForm, "default");
    else
        u18 = nil;
    end;

    v16:Add(function() -- Line: 122
        -- upvalues: u18 (ref), vfxUtil (ref)
        if not u18 then
            return;
        end;

        vfxUtil.enableEffects(u18, false, "ParticleEmitter");
        local EmittersLifetime = vfxUtil.getEmittersLifetime(u18);
        local u22 = {};

        for _, child in u18:GetChildren() do
            if child:IsA("Beam") then
                local Keypoints = child.Transparency.Keypoints;
                local v23 = {
                    beam = child,
                    base = Keypoints,
                    scratch = table.clone(Keypoints)
                };
                table.insert(u22, v23);
            end;
        end;

        vfxUtil.pseudo_tween(TweenInfo.new(EmittersLifetime / 2), nil, function(p24) -- Line: 137
            -- upvalues: u22 (copy)
            for _, v in u22 do
                local base = v.base;
                local scratch = v.scratch;

                for i = 1, #base do
                    local v25 = base[i];
                    scratch[i] = NumberSequenceKeypoint.new(v25.Time, math.lerp(v25.Value, 1, p24), v25.Envelope);
                    local _ = i;
                end;

                v.beam.Transparency = NumberSequence.new(scratch);
            end;
        end);
        vfxUtil.disposal(u18, EmittersLifetime);
    end);
end;

return v1;