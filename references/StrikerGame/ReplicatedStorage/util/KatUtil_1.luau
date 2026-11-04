 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require("@self/thread");
local u1 = require("../forum/trove");
local u2 = require("@self/MOSTRECENTFORGE");
u2.init();
local u3 = {};

local function make_tween_info(p4: table) -- Line: 11
    return TweenInfo.new(table.unpack(p4));
end;

local function reform_info(p5: table) -- Line: 15
    return { p5[1] / 60, p5[2] or Enum.EasingStyle.Linear, p5[3] or Enum.EasingDirection.Out };
end;

function u3.get_resource(p6: string) -- Line: 25
    -- upvalues: ReplicatedStorage (copy)
    local Resources = ReplicatedStorage.Resources;

    for _, v in p6:split("/") do
        if Resources:FindFirstChild(v) then
            Resources = Resources:FindFirstChild(v);
        end;
    end;

    return Resources;
end;

function u3.tween(p7: any, p8: table, p9: any) -- Line: 39
    -- upvalues: TweenService (copy)
    local v10 = TweenService:Create(p7, TweenInfo.new(table.unpack(p8)), p9);
    v10:Play();

    return v10;
end;

function u3.tween_frames(p11: any, p12: table, p13: any) -- Line: 46
    -- upvalues: u3 (copy)
    return u3.tween(p11, { p12[1] / 60, p12[2] or Enum.EasingStyle.Linear, p12[3] or Enum.EasingDirection.Out }, p13);
end;

function u3.get_track(p14: userdata, p15: userdata, p16: number?) -- Line: 63
    -- upvalues: u1 (copy), u3 (copy)
    local os_clock_ret = os.clock();
    local v17 = nil;

    if not p16 then
        p16 = 1;
    end;

    while true do
        if os.clock() - os_clock_ret >= p16 or v17 ~= nil then
            if v17 then
                local u18 = u1.new();
                u18:AttachToInstance(p14);
                u18:Add(v17.Stopped:Once(function() -- Line: 89
                    -- upvalues: u18 (copy)
                    u18:Destroy();
                end));
                local u19 = nil;
                u19 = {
                    is_kat = true,
                    trove = u18,
                    track = v17,

                    add = function(...) -- Line: 97, Name: add
                        -- upvalues: u18 (copy)
                        return u18:Add(...);
                    end,

                    destroy = function() -- Line: 101, Name: destroy
                        -- upvalues: u18 (copy)
                        u18:Destroy();
                    end,

                    construct = function(p20) -- Line: 105, Name: construct
                        -- upvalues: u18 (copy)
                        return u18:Construct(p20);
                    end,

                    clone = function(...) -- Line: 109, Name: clone
                        -- upvalues: u18 (copy)
                        return u18:Clone(...);
                    end,

                    sequence = function(p21: table) -- Line: 113, Name: sequence
                        -- upvalues: u19 (ref), u3 (ref)
                        for i, v in p21 do
                            u19.add(u3.frame_delay(i, v, i));
                        end;
                    end,

                    change_target = function(p22) -- Line: 118, Name: change_target
                        -- upvalues: u18 (copy)
                        return u18:AttachToInstance(p22);
                    end
                };

                return u19;
            end;

            return;
        end;

        for _, v in p14:FindFirstChild("Animator", true):GetPlayingAnimationTracks() do
            if v.Animation.AnimationId == p15.AnimationId then
                v17 = v;
                break;
            end;
        end;

        task.wait(0.016666666666666666);
    end;
end;

function u3.delay(p23: number, p24: function, ...) -- Line: 128
    return task.delay(p23, p24, ...);
end;

function u3.frame_delay(p25: number, p26: function, ...) -- Line: 132
    -- upvalues: u3 (copy)
    return u3.delay(p25 / 60, p26, ...);
end;

function u3.defer(p27: function, ...) -- Line: 136
    return task.defer(p27, ...);
end;

function u3.spawn(p28: function, ...) -- Line: 140
    return task.spawn(p28, ...);
end;

function u3.forge_emit(...) -- Line: 144
    -- upvalues: u2 (copy)
    return u2.emit(...);
end;

function u3.mesh_emit(...) -- Line: 148
    -- upvalues: u2 (copy)
    return u2.meshEmit(...);
end;

function u3.Enable(p29: userdata, p30: string, p31: boolean) -- Line: 152
    for _, v in p29:QueryDescendants(p30) do
        v.Enabled = p31;
    end;
end;

function u3.Emit(p32: userdata) -- Line: 158
    -- upvalues: u3 (copy)
    for _, v in p32:QueryDescendants("ParticleEmitter") do
        local u33 = v:GetAttribute("EmitDuration") or -1;
        local u34 = v:GetAttribute("EmitCount") or 1;
        local v35 = v:GetAttribute("EmitDelay") or -1;

        local function BasicEmit() -- Line: 164
            -- upvalues: u33 (copy), v (copy), u3 (ref), u34 (copy)
            if u33 > 0 then
                v.Enabled = true;
                u3.delay(u33, function() -- Line: 167
                    -- upvalues: v (ref)
                    v.Enabled = false;
                end);
            end;

            v:Emit(u34);
        end;

        if v35 > 0 then
            u3.delay(v35, BasicEmit);
        else
            if u33 > 0 then
                v.Enabled = true;
                u3.delay(u33, function() -- Line: 167
                    -- upvalues: v (copy)
                    v.Enabled = false;
                end);
            end;

            v:Emit(u34);
        end;
    end;
end;

function u3.create_vfx_instance(p36, p37, p38) -- Line: 183
    local v39 = p36:Clone();

    if typeof(p37) == "Instance" then
        p37 = p37.CFrame or p37;
    end;

    local v40 = typeof(p38) == "string" and p36:GetAttribute(p38) or (p36:GetAttribute("Offset") or CFrame.identity);
    v39.Parent = workspace.Effects;
    v39:PivotTo(p37 * v40);

    if v39:IsA("BasePart") then
        v39.Anchored = true;
        v39.CanCollide = false;
        v39.CanQuery = false;
        v39.CanTouch = false;
        v39.Massless = true;
    end;

    for _, v in v39:QueryDescendants("BasePart") do
        v.Anchored = true;
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;
        v.Massless = true;
    end;

    return v39;
end;

function u3.weld(p41: userdata, p42: userdata, p43: any, p44: any) -- Line: 210
    if p42:IsA("BasePart") then
        p42.Anchored = false;
        p42.CanCollide = false;
        p42.CanQuery = false;
        p42.CanTouch = false;
        p42.Massless = true;
    end;

    for _, v in p42:QueryDescendants("BasePart") do
        v.Anchored = false;
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;
        v.Massless = true;
    end;

    local v45 = p43 == nil and "nil" or p43;
    local v46 = p44 == nil and "nil" or p44;
    local Weld = Instance.new("Weld");
    Weld.Part0 = p41;
    Weld.Part1 = p42;
    Weld.C0 = typeof(v45) == "CFrame" and v45 and v45 or (p42:GetAttribute(v45) or CFrame.identity);
    Weld.C1 = typeof(v46) == "CFrame" and v46 and v46 or (p42:GetAttribute(v46) or CFrame.identity);
    Weld.Parent = p42;

    return Weld;
end;

function u3.get_life(p47: userdata) -- Line: 245
    local v48 = 0;

    for _, v in p47:QueryDescendants("Trail,Beam,ParticleEmitter") do
        local v49 = v:GetAttribute("EmitDuration") or 0;
        local v50;

        if typeof(v.Lifetime) == "number" then
            v50 = v.Lifetime;
        else
            v50 = v.Lifetime.Max;
        end;

        if v48 < v49 + v50 then
            v48 = v49 + v50;
        end;
    end;

    return v48;
end;

function u3.magnitude(p51: userdata) -- Line: 260
    local v52 = p51:FindFirstChild("HumanoidRootPart") or p51.PrimaryPart;

    return vector.magnitude(v52.AssemblyLinearVelocity);
end;

function u3.destroy_all_velocities(p53: userdata) -- Line: 264
    for _, v in p53:QueryDescendants("BodyVelocity,BodyPosition,BodyGyro,LinearVelocity") do
        v:Destroy();
    end;
end;

function u3.destroy_effect(p54: any, p55: number) -- Line: 270
    -- upvalues: u3 (copy)
    if typeof(p54) == "table" then
        for _, v in p54 do
            u3.destroy_effect(v);
        end;

        return;
    end;

    local _life = u3.get_life(p54);

    if p55 then
        _life = _life + p55;
    end;

    u3.delay(_life, p54.Destroy, p54);
end;

function u3.apply_lighting(p56: userdata) -- Line: 287
    -- upvalues: Lighting (copy)
    local Children = Lighting:GetChildren();
    local u57 = {};
    local u58 = {};

    for _, v in Children do
        v.Parent = nil;
    end;

    for _, child in p56:GetChildren() do
        local v59 = child:Clone();
        v59.Parent = Lighting;
        table.insert(u57, v59);
    end;

    for i, v in p56:GetAttributes() do
        u58[i] = Lighting[i];
        Lighting[i] = v;
    end;

    return function() -- Line: 308
        -- upvalues: u58 (copy), Lighting (ref), Children (copy), u57 (copy)
        for i, v in u58 do
            Lighting[i] = v;
        end;

        for _, v in Children do
            v.Parent = Lighting;
        end;

        for _, v in u57 do
            v:Destroy();
        end;
    end;
end;

function u3.setAttribute(p60: userdata, p61: string, p62: any) -- Line: 323
    if not (p60 and p61) then
        return;
    end;

    p60:SetAttribute(p61, p62);
end;

function u3.getAttribute(p63: userdata, p64: string) -- Line: 331
    if p63 and p64 then
        return p63:GetAttribute(p64);
    end;
end;

return u3;