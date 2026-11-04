 
 

local SoundService = game:GetService("SoundService");
local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local VisualHost = require(script.Parent.VisualHost);

return function(u1) -- Line: 28
    -- upvalues: VisualHost (copy), Graph (copy), Range (copy), SoundService (copy)
    function u1._isSound(p2) -- Line: 30
        return p2:IsA("Sound");
    end;

    local function resolveHost(p3, p4, p5) -- Line: 35
        -- upvalues: VisualHost (ref)
        local v6 = p4.EmitParent or p5;
        local v7 = nil;

        if not v6 then
            v6 = p3.Parent;

            if v6 and (v6:IsA("BasePart") or v6:IsA("Attachment")) then
                v6 = VisualHost.acquireCarrier(v6);
                v7 = v6;
            end;
        end;

        if v6 and v6:IsA("Model") then
            local v8 = nil;

            for _, child in ipairs(v6:GetChildren()) do
                if child:IsA("BasePart") then
                    v8 = v8 or {};
                    v8[#v8 + 1] = child;
                end;
            end;

            if v8 then
                v6 = v8[math.ceil(#v8 / 2)];
            end;
        end;

        return v6, v7;
    end;

    function u1.UpdateSound(p9, p10, p11, p12) -- Line: 60
        -- upvalues: Graph (ref)
        local math_max_ret = math.max((p12 - p10.StartTime) / p10.LifeTime, 0);
        local math_min_ret = math.min(math_max_ret, 1);
        local v13;

        if p10._tsOverride == nil or p12 >= (p10._tsOverrideUntil or 0) then
            v13 = p10.Graphs.Timescale and (Graph.QueryPointsWithTime(math_min_ret, p10.Graphs.Timescale, p10.Seeds.Timescale) or 1) or 1;
        else
            v13 = p10._tsOverride;
        end;

        local LifeTime = p10.LifeTime;
        local v14 = (p10._effectiveElapsed or 0) + (p10._timeFrozen and 0 or p11 * v13);
        local v15 = v14 < 0 and 0 or v14;

        if LifeTime < v15 then
            v15 = LifeTime;
        end;

        p10._effectiveElapsed = v15;
        local VisualPart = p10.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return true;
        end;

        if p10._parentAlive and not p10._parentAlive[1] then
            return true;
        end;

        if p10._clipEnded then
            return true;
        end;

        if p10.TotalKeyFrames <= 0 then
            return true;
        end;

        local v16;

        if math_min_ret >= 1 then
            v16 = LifeTime <= v15 and true or v15 <= 0;
        else
            v16 = false;
        end;

        local math_max_ret2 = math.max(v15 / LifeTime, 0);
        local v17 = math.min(math_max_ret2, 1) * p10.TotalKeyFrames;
        local math_floor_ret = math.floor(v17);

        if math_floor_ret ~= p10.CurrentStep then
            p10.CurrentStep = math_floor_ret;
            local v18 = math_floor_ret / p10.TotalKeyFrames;

            if p10.Graphs.SndVolume then
                VisualPart.Volume = Graph.QueryPointsWithTime(v18, p10.Graphs.SndVolume, p10.Seeds.SndVolume);
            end;

            if p10.Graphs.SndPlaybackSpeed then
                p10._envelopeSpeed = Graph.QueryPointsWithTime(v18, p10.Graphs.SndPlaybackSpeed, p10.Seeds.SndPlaybackSpeed);
            end;
        end;

        local v19 = p10._timeFrozen and 0 or v13;

        if v19 < 0.01 then
            if p10._started and not p10._heldByTimescale then
                p10._heldByTimescale = true;
                VisualPart:Pause();

                return v16;
            end;
        else
            local v20 = p10._envelopeSpeed * v19;

            if v20 ~= p10._appliedSpeed then
                p10._appliedSpeed = v20;
                VisualPart.PlaybackSpeed = v20;
            end;

            if p10._heldByTimescale then
                p10._heldByTimescale = false;
                VisualPart:Resume();
            end;
        end;

        return v16;
    end;

    function u1.EmitSound(p21, p22, p23, p24) -- Line: 119
        -- upvalues: Graph (ref), Range (ref), VisualHost (ref), SoundService (ref), resolveHost (copy), u1 (copy)
        if not (p22 and p22.Parent) then
            return;
        end;

        local EmitData = p21:GetEmitData(p22, p24);

        if not (EmitData and EmitData.RenderTemplate) then
            return;
        end;

        local Instance_fromExisting_ret = Instance.fromExisting(EmitData.RenderTemplate);
        Instance_fromExisting_ret.Archivable = false;
        Instance_fromExisting_ret.Playing = false;
        Instance_fromExisting_ret.Looped = EmitData.Looped == true;
        Instance_fromExisting_ret.RollOffMinDistance = EmitData.RollOffMin or 10;
        Instance_fromExisting_ret.RollOffMaxDistance = EmitData.RollOffMax or 10000;
        pcall(function() -- Line: 130
            -- upvalues: Instance_fromExisting_ret (copy)
            Instance_fromExisting_ret:SetAttribute("_PartIcleEmit", true);
        end);
        local v25 = EmitData.SndVolume and (Graph.GenerateSeed(EmitData.SndVolume) or {}) or {};
        local v26 = EmitData.SndPlaybackSpeed and (Graph.GenerateSeed(EmitData.SndPlaybackSpeed) or {}) or {};
        local u27 = Graph.GenerateSeed(EmitData.SndTimescale);
        local u28 = EmitData.SndPlaybackSpeed and (Graph.QueryPointsWithTime(0, EmitData.SndPlaybackSpeed, v26) or 1) or 1;

        if EmitData.SndVolume then
            Instance_fromExisting_ret.Volume = Graph.QueryPointsWithTime(0, EmitData.SndVolume, v25);
        end;

        Instance_fromExisting_ret.PlaybackSpeed = u28;
        local v29 = Range.RandomValueFromRange(EmitData.Lifetime);
        local u30 = v29 <= 0;

        if u30 then
            local v31 = Instance_fromExisting_ret.IsLoaded and (Instance_fromExisting_ret.TimeLength or 0) or 0;
            v29 = v31 > 0 and not Instance_fromExisting_ret.Looped and (v31 / math.max(u28, 0.01) or 3600) or 3600;
        end;

        local v32 = v29 <= 0 and 0.001 or v29;
        local EditAudioHost = VisualHost.getEditAudioHost();
        local v33 = nil;
        local v34;

        if EditAudioHost then
            v34 = EditAudioHost;
        elseif EmitData.Local2D then
            v34 = SoundService;
        else
            v34, v33 = resolveHost(p22, EmitData, p23);
        end;

        if not v34 then
            return;
        end;

        local u35 = {
            Type = "Sound",
            CurrentStep = -1,
            PartLife = 0,
            _started = false,
            _heldByTimescale = false,
            VisualPart = Instance_fromExisting_ret,
            _carrier = v33,
            Events = EmitData.Events,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, EmitData.TotalKeyFrames),
            LifeTime = v32,
            Graphs = {
                SndVolume = EmitData.SndVolume,
                SndPlaybackSpeed = EmitData.SndPlaybackSpeed,
                Timescale = EmitData.SndTimescale
            },
            Seeds = {
                SndVolume = v25,
                SndPlaybackSpeed = v26,
                Timescale = u27
            },
            _effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.SndTimescale, u27, v32),
            _envelopeSpeed = u28,
            _appliedSpeed = u28,
            _sourceItem = p22
        };

        if p24 and (p24._parentAlive and not EmitData.EmitParent) then
            u35._parentAlive = p24._parentAlive;
        end;

        u1._seedTsOverride(u35, p22);
        Instance_fromExisting_ret.Parent = v34;

        local function play() -- Line: 194
            -- upvalues: Instance_fromExisting_ret (copy), u30 (copy), u35 (copy), u28 (copy), Graph (ref), EmitData (copy), u27 (copy), EditAudioHost (copy), SoundService (ref)
            if not Instance_fromExisting_ret.Parent then
                return;
            end;

            if u30 and (u35.LifeTime == 3600 and (Instance_fromExisting_ret.TimeLength > 0 and not Instance_fromExisting_ret.Looped)) then
                u35.LifeTime = Instance_fromExisting_ret.TimeLength / math.max(u28, 0.01);
                u35._effectiveElapsed = Graph.InitialEffectiveElapsed(EmitData.SndTimescale, u27, u35.LifeTime);
            end;

            u35.StartTime = os.clock();
            Instance_fromExisting_ret.TimePosition = EmitData.StartOffset or 0;

            if EmitData.Local2D and not EditAudioHost then
                SoundService:PlayLocalSound(Instance_fromExisting_ret);
            else
                Instance_fromExisting_ret:Play();
            end;

            u35._started = true;
        end;

        if u30 then
            Instance_fromExisting_ret.Ended:Once(function() -- Line: 212
                -- upvalues: u35 (copy)
                u35._clipEnded = true;
            end);
        end;

        if Instance_fromExisting_ret.IsLoaded then
            play();
        else
            Instance_fromExisting_ret.Loaded:Once(play);
        end;

        p21:_registerEmit(u35, p24);
    end;
end;