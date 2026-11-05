  

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
local u5 = Random.new();
local v6 = {};
local u7 = nil;

local function selectRandomSound(p8) -- Line: 17
    -- upvalues: u1 (copy), CollectionService (copy), u5 (copy)
    local v9 = u1.get(p8, "SoundPoolTag", "");

    if v9 == "" then
        return p8;
    end;

    local v10 = {};
    local v11 = {};
    local v12 = 0;

    for _, v in CollectionService:GetTagged(v9) do
        if v:IsA("Sound") then
            table.insert(v10, v);
            local v13 = u1.get(v, "SoundPoolWeight", 1);
            table.insert(v11, v13);
            v12 = v12 + v13;
        end;
    end;

    if #v10 == 0 then
        return p8;
    end;

    if v12 > 0 then
        local v14 = u5:NextNumber() * v12;
        local v15 = 0;

        for i, v in v11 do
            v15 = v15 + v;

            if v14 <= v15 then
                return v10[i];
            end;
        end;
    end;

    return v10[u5:NextInteger(1, #v10)];
end;

local function createSoundClone(p16, p17, p18) -- Line: 64
    -- upvalues: u3 (copy), u7 (ref)
    local v19 = p17:Clone();

    for _, v in v19:GetTags() do
        v19:RemoveTag(v);
    end;

    local v20 = p16:FindFirstAncestorWhichIsA("BasePart");
    local v21 = nil;

    if u3.PLUGIN_CONTEXT then
        if v20 then
            v21 = Instance.new("Part");
            v21.Name = "SoundEmitter";
            v21.Anchored = true;
            v21.CanCollide = false;
            v21.CanQuery = false;
            v21.CanTouch = false;
            v21.Transparency = 1;
            v21.Size = Vector3.new(1, 1, 1);
            v21.CFrame = v20.CFrame;
            v21.Parent = u7;
            v19.Parent = v21;
            table.insert(p18, v21);
        else
            v19.Parent = u7;
            table.insert(p18, v19);
        end;
    else
        if v20 then
            v19.Parent = v20;
        else
            v19.Parent = workspace.Terrain;
        end;

        table.insert(p18, v19);
    end;

    return v19, v21;
end;

local function playSingleSound(p22, p23, u24, u25, p26, p27) -- Line: 109
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), RunService (copy)
    local PlaybackSpeed = u24.PlaybackSpeed;
    local u28 = u1.get(p23, "Volume_End", u24.Volume);
    local u29 = u1.get(p23, "Volume_Start", u24.Volume);
    u24.Volume = u29;

    if u29 == u28 then
        u24.Volume = u29;
    else
        local v30 = u1.get(p23, "Volume_Duration", u24.TimeLength);
        local fromParams = u2.fromParams;
        local v31 = u1.get(p23, "Volume_Curve", u3.default_bezier);
        table.insert(p26, fromParams(v31, v30, function(p32, p33) -- Line: 129
            -- upvalues: u24 (copy), u3 (ref), u29 (copy), u28 (copy), PlaybackSpeed (ref)
            u24.Volume = u3.lerp(u29, u28, p32);

            return p33 * PlaybackSpeed;
        end));
    end;

    local u34 = u1.get(p23, "Speed_End", u24.PlaybackSpeed);
    local u35 = u1.get(p23, "Speed_Start", u24.PlaybackSpeed);
    local u36 = u35;
    local u37 = nil;

    if u35 == u34 then
        u24.PlaybackSpeed = u35;
    else
        local v38 = u1.get(p23, "Speed_Duration", u24.TimeLength);
        u37 = u2.fromParams(u1.get(p23, "Speed_Curve", u3.default_bezier), v38, function(p39, p40) -- Line: 151
            -- upvalues: u36 (ref), u3 (ref), u35 (copy), u34 (copy), u24 (copy)
            u36 = u3.lerp(u35, u34, p39);
            u24.PlaybackSpeed = u36;

            return p40;
        end);
        table.insert(p26, u37);
    end;

    local u41 = u1.get(p23, "RollOff_End", u24.RollOffMinDistance);
    local u42 = u1.get(p23, "RollOff_Start", u24.RollOffMinDistance);

    if u42 ~= u41 then
        local v43 = u1.get(p23, "RollOff_Duration", u24.TimeLength);
        local fromParams = u2.fromParams;
        local v44 = u1.get(p23, "RollOff_Curve", u3.default_bezier);
        table.insert(p26, fromParams(v44, v43, function(p45, p46) -- Line: 174
            -- upvalues: u24 (copy), u3 (ref), u42 (copy), u41 (copy), u36 (ref)
            u24.RollOffMinDistance = u3.lerp(u42, u41, p45);

            return p46 * u36;
        end, u37));
    end;

    if u24.PlayOnRemove and not u3.PLUGIN_CONTEXT then
        u24:Destroy();
    else
        u24:Play();
    end;

    local u47 = u25 and p22:FindFirstAncestorWhichIsA("BasePart");

    if u47 then
        table.insert(p26, RunService.Heartbeat:Connect(function() -- Line: 195
            -- upvalues: u25 (copy), u47 (copy)
            if u25.Parent then
                u25.CFrame = u47.CFrame;
            end;
        end));
    end;

    if p27 > 0 then
        task.wait(p27);
        u24:Stop();
    else
        u2.timer(u24.TimeLength, function(p48, p49) -- Line: 208
            -- upvalues: u24 (copy), u37 (ref)
            if u24.PlaybackSpeed > 0 or p49 > 0 and (u37 and u37.Connected) then
                return p48 * u24.PlaybackSpeed;
            end;

            return nil;
        end, u37, p26);
    end;

    return u37;
end;

function v6.init() -- Line: 218
    -- upvalues: u3 (copy), u7 (ref)
    if not u3.PLUGIN_CONTEXT then
        return;
    end;

    local v50 = script:FindFirstAncestorOfClass("Plugin");

    if not v50 then
        return;
    end;

    u7 = v50:CreateDockWidgetPluginGui("VFXForgeSoundPlayer", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 200, 100, 100, 50));

    if u7 then
        u7.Name = "VFXForgeSoundPlayer";
    end;
end;

function v6.deinit() -- Line: 239
    -- upvalues: u7 (ref)
    if u7 then
        u7:Destroy();
        u7 = nil;
    end;
end;

function v6.emit(u51, u52) -- Line: 246
    -- upvalues: u1 (copy), selectRandomSound (copy), u4 (copy), createSoundClone (copy), playSingleSound (copy), u5 (copy)
    if u51.Playing then
        u51:Stop();
    end;

    local v53 = u1.get(u51, "SoundPoolIsSource", false);
    local v54 = u1.get(u51, "SoundPoolInheritAttributes", false);

    if v54 then
        if not v53 then
            u51 = selectRandomSound(u51) or u51;
        end;
    end;

    local v55 = u1.get(u51, "EmitDelay", 0);
    local u56 = u1.get(u51, "EmitDuration", 0);
    local v57 = u1.get(u51, "EmitCount", 1);
    local v58 = u1.getRange(u51, "EmitInterval", NumberRange.new(0, 0));
    local v59 = u1.get(u51, "RepeatCount", 1);
    local v60 = u1.getRange(u51, "RepeatInterval", NumberRange.new(0, 0));
    task.wait(v55);
    local v61 = {};

    for i = 1, v57 do
        local u62 = v54 and u51;

        if not u62 then
            if v53 then
                u62 = u51;
            else
                u62 = selectRandomSound(u51) or u51;
            end;
        end;

        if u62 then
            local u63;

            if v54 and u62 ~= u51 then
                u63 = u62;
            else
                u63 = u51;
            end;

            for i2 = 1, v59 do
                table.insert(v61, u4.new(function(p64) -- Line: 283
                    -- upvalues: createSoundClone (ref), u51 (ref), u62 (copy), u52 (copy), playSingleSound (ref), u63 (copy), u56 (copy)
                    local v65, v66 = createSoundClone(u51, u62, u52);
                    playSingleSound(u51, u63, v65, v66, u52, u56);

                    if v66 then
                        v66:Destroy();
                    else
                        v65:Destroy();
                    end;

                    p64();
                end));

                if i2 < v59 and v60.Max > 0 then
                    task.wait(u5:NextNumber(v60.Min, v60.Max));
                end;
            end;

            if i < v57 and v58.Max > 0 then
                task.wait(u5:NextNumber(v58.Min, v58.Max));
            end;
        end;
    end;

    u4.all(v61):await();
end;

return v6;