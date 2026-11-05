  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local StateService = require(ReplicatedRoot.Services.StateService);
local AnimatorService = require(ReplicatedRoot.Services.AnimatorService);
local SharedFunctionService = require(ReplicatedRoot.Services.SharedFunctionService);
local u1 = {
    Name = "SequenceService",
    SequenceFunctions = {}
};
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
local Sequence = require(ReplicatedRoot.Libraries.Classes.Sequence);
local Binds = require(script.Binds);
local u2 = Random.new();
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

function u1.GetSequences(p3) -- Line: 24
    -- upvalues: StateService (copy)
    local v4 = StateService.GetState(p3, "SequenceState");

    return v4 and v4.Sequences or {};
end;

function u1.GetPlayingSequences(p5) -- Line: 29
    -- upvalues: u1 (copy)
    local v6 = {};

    for _, v in pairs(u1.GetSequences(p5)) do
        if v:IsPlaying() then
            table.insert(v6, v);
        end;
    end;

    return v6;
end;

function u1.CreateSequence(p7) -- Line: 39
    -- upvalues: Sequence (copy), Trove (copy), StateService (copy)
    local u8 = p7 or {};
    local Parent = u8.Parent;
    local u9 = Sequence.new(u8);
    u9._Trove = Trove.new();
    u9._Trove:Connect(u9.Destroying, function() -- Line: 46
        -- upvalues: u9 (copy)
        u9._Trove:Destroy();
    end);
    u9.Collector = u9._Trove:Extend();
    u9._Trove:Connect(u9.Played, function() -- Line: 51
        -- upvalues: u8 (copy), u9 (copy)
        if u8.CleanType == "Played" then
            u9.Collector:Clean();
        end;
    end);
    u9._Trove:Connect(u9.Ended, function() -- Line: 56
        -- upvalues: u8 (copy), u9 (copy)
        if u8.CleanType == "Ended" then
            u9.Collector:Clean();
        end;
    end);
    u9._Trove:Connect(u9.Stopped, function() -- Line: 61
        -- upvalues: u8 (copy), u9 (copy)
        if u8.CleanType == "Stopped" or u8.CleanType == nil then
            u9.Collector:Clean();
        end;
    end);
    u9._Trove:Connect(u9.Failed, function() -- Line: 66
        -- upvalues: u9 (copy)
        u9.Collector:Clean();
    end);

    if typeof(Parent) == "Instance" then
        local u10 = StateService.GetState(Parent, "SequenceState");

        if u10 == nil then
            u10 = StateService.CreateState(Parent, "SequenceState");
            u10.Sequences = {};
        end;

        u10.Collector:Add(function() -- Line: 77
            -- upvalues: u9 (copy)
            if not table.isfrozen(u9) then
                u9:Destroy();
            end;
        end);
        u9._Trove:Add(function() -- Line: 83
            -- upvalues: u10 (ref), u9 (copy)
            local v11 = table.find(u10.Sequences, u9);

            if v11 ~= nil then
                table.remove(u10.Sequences, v11);
            end;
        end);
        table.insert(u10.Sequences, u9);
    end;

    return u9;
end;

function u1.CreateMoveSequence(p12, p13) -- Line: 96
    -- upvalues: u1 (copy), SharedFunctionService (copy), Core (copy), u2 (copy)
    local v14 = p12 and table.clone(p12) or {};

    if p13 then
        for i, v in pairs(p13) do
            v14[i] = v;
        end;
    end;

    local Ability = v14.Ability;
    local Move = v14.Move;
    local u15 = Move and Move.Directory or Ability and Ability.Directory or (v14.Directory or nil);
    local Character = v14.Character;

    if not Character then
        if Move == nil then
            Character = nil;
        else
            Character = Move.Character or nil;
        end;
    end;

    if v14.Parent == nil then
        v14.Parent = Character;
    end;

    local u16 = u1.CreateSequence(v14);
    u16.Move = Move;
    u16.Ability = Ability or (Move and Move.Ability or nil);
    u16.Character = Character;
    local v17;

    if Character then
        v17 = Character:FindFirstChildWhichIsA("Humanoid") or nil;
    else
        v17 = nil;
    end;

    u16.Humanoid = v17;
    local v18;

    if Character then
        v18 = Character:FindFirstChild("HumanoidRootPart") or nil;
    else
        v18 = nil;
    end;

    u16.RootPart = v18;
    u16.Metadata = v14;
    u16.Info = v14.Info;
    u16.Name = v14.Name or u16.Info and u16.Info.Name or (u16.Name or "Sequence");
    u16.Directory = u15;

    function u16.SetTimescaleModifier(p19, p20) -- Line: 124
        p19._TimescaleModifier = p20;
    end;

    function u16.GetTimescaleModifier(p21) -- Line: 128
        return p21._TimescaleModifier or 1;
    end;

    function u16.GetTimescale(p22) -- Line: 132
        return p22._Timescale or 1;
    end;

    function u16.CalculateTimescale(p23) -- Line: 136
        local v24 = (p23.Character and (p23.Character:GetAttribute("Timescale") or 1) or 1) * (p23:GetTimescale() or 1);
        local v25 = p23:GetTimescaleModifier() or 1;
        local v26 = math.lerp(1, v24, v25);

        return math.clamp(v26, 0, v24);
    end;

    function u16.SetTimescale(p27, p28) -- Line: 144
        p27._Timescale = p28;
    end;

    function u16.GetSpeed(p29) -- Line: 148
        return p29._Speed * p29:CalculateTimescale();
    end;

    function u16.GetRawSpeed(p30) -- Line: 152
        return p30._Speed;
    end;

    function u16.GetCall(p31, p32) -- Line: 156
        -- upvalues: u16 (copy)
        return u16.Call;
    end;

    function u16.SetCall(p33, p34) -- Line: 160
        -- upvalues: u16 (copy)
        u16.Call = p34;
    end;

    function u16.CallFunction(p35, ...) -- Line: 164
        -- upvalues: SharedFunctionService (ref)
        local v36 = table.pack(...);

        if typeof(v36[1]) == "number" then
            local v37 = SharedFunctionService.GetFunction(v36[2], {
                Sequence = p35,
                Frame = v36[1]
            });

            if v37 ~= nil then
                return SharedFunctionService.CallFunction(v37, {
                    Sequence = p35,
                    Frame = v36[1]
                }, table.unpack(v36, 3));
            end;
        elseif typeof(v36[1]) == "string" then
            local v38 = SharedFunctionService.GetFunction(v36[1], {
                Sequence = p35
            });

            if v38 ~= nil then
                return SharedFunctionService.CallFunction(v38, {
                    Sequence = p35
                }, table.unpack(v36, 2));
            end;
        end;
    end;

    local function Handler(p39, p40, ...) -- Line: 189
        -- upvalues: SharedFunctionService (ref)
        if typeof(p39) == "function" then
            return p39(p40, ...);
        end;

        if typeof(p39) == "string" then
            local v41 = table.pack(...);
            local v42 = v41[1];
            local v43 = SharedFunctionService.GetFunction(p39, {
                Sequence = p40
            });

            if v43 ~= nil then
                return SharedFunctionService.CallFunction(v43, {
                    Sequence = p40,
                    Frame = v42
                }, table.unpack(v41, 2));
            end;
        end;
    end;

    u16:SetFrameHandler(Handler);
    u16:SetCallbackHandler(Handler);

    if v14.Animations ~= nil then
        for _, v in pairs(v14.Animations) do
            if not v.Manual and (not v.Character or v.Character == "Attacker") then
                if v.Animation ~= nil then
                    u1.BindToSequence(u16, v.Animation, v);
                end;

                if v.Animations ~= nil then
                    local u44 = nil;
                    local u45 = nil;

                    local function Select() -- Line: 230
                        -- upvalues: v (copy), Core (ref), u15 (copy), u2 (ref)
                        local Animations = v.Animations;

                        if typeof(Animations) == "string" then
                            Animations = Core.Get(u15, {
                                Path = Animations
                            });
                        end;

                        if v.SelectionType == "Random" or v.Type == nil then
                            local v46 = u2:NextInteger(1, #Animations);

                            return v46, Animations[v46];
                        end;
                    end;

                    local function Update() -- Line: 245
                        -- upvalues: Select (copy), u45 (ref), u44 (ref), u1 (ref), u16 (copy), v (copy)
                        local v47, v48 = Select();

                        if u45 ~= v47 then
                            if u44 then
                                u44:Destroy();
                                u44 = nil;
                            end;

                            u45 = v47;
                            u44 = u1.BindToSequence(u16, v48, v);
                        end;
                    end;

                    if v.SelectionType == "Random" or v.Type == nil then
                        u16._Trove:Connect(u16.Played, function() -- Line: 258
                            -- upvalues: Select (copy), u45 (ref), u44 (ref), u1 (ref), u16 (copy), v (copy)
                            local v49, v50 = Select();

                            if u45 ~= v49 then
                                if u44 then
                                    u44:Destroy();
                                    u44 = nil;
                                end;

                                u45 = v49;
                                u44 = u1.BindToSequence(u16, v50, v);
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end;

    if v14.Sounds ~= nil then
        for _, v in pairs(v14.Sounds) do
            if not v.Manual and (not v.Character or v.Character == "Attacker") and v.Sound ~= nil then
                u1.BindToSequence(u16, v.Sound, v);
            end;
        end;
    end;

    u16:SetTimescale(Character:GetAttribute("Timescale") or 1);

    return u16;
end;

u1.CreateCharacterSequence = u1.CreateMoveSequence;

function u1.BindToSequence(p51, p52, p53) -- Line: 288
    -- upvalues: Core (copy), AnimatorService (copy), Binds (copy)
    local v54 = p53 or {};
    local _Trove = p51._Trove;
    local Directory = p51.Directory;

    if typeof(p52) == "string" then
        p52 = Core.Get({
            Path = p52
        }, Directory);
    end;

    local v55 = nil;
    local v56;

    if typeof(p52) == "table" then
        if p52.AnimationId == nil then
            v56 = nil;
        else
            v56 = _Trove:Construct(AnimatorService.CreateAnimation, p52);
        end;

        if v56 == nil then
            v56 = p52;
        end;
    else
        v56 = p52;
    end;

    local v57;

    if typeof(v56) == "Instance" then
        v57 = v56.ClassName;
    else
        v57 = typeof(v56) == "table" and v56.SoundId and "SoundData" or v55;
    end;

    if not (v57 and Binds[v57]) then
        return nil;
    end;

    local v58 = table.pack(Binds[v57](p51, v56, v54));

    if v58[1] ~= nil then
        _Trove:Add(v58[1]);
    end;

    return table.unpack(v58);
end;

function u1._Start() -- Line: 331
end;

return u1;