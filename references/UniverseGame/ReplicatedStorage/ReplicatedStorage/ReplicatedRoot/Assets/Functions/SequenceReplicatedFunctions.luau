  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local SharedFunctionService = require(ReplicatedRoot.Services.SharedFunctionService);

return {
    StartSequence = function(p1, ...) -- Line: 9, Name: StartSequence
        -- upvalues: SharedFunctionService (copy)
        local _ = p1.Sequence;
        local _ = p1.Frame;
        SharedFunctionService.CallFunction("ClearHit", p1, ...);
    end,

    EndSequence = function(p2, ...) -- Line: 15, Name: EndSequence
        local _ = p2.Sequence;
        local _ = p2.Frame;
    end,

    CleanSequence = function(p3, ...) -- Line: 20, Name: CleanSequence
        -- upvalues: SharedFunctionService (copy)
        local Sequence = p3.Sequence;
        local _ = p3.Frame;
        Sequence.Collector:Destroy();
        Sequence:ClearState();
        SharedFunctionService.CallFunction("ClearTags", p3, ...);
        SharedFunctionService.CallFunction("ClearHit", p3, ...);
    end,

    ChangeSequence = function(p4, p5, ...) -- Line: 31, Name: ChangeSequence
        local Sequence = p4.Sequence;

        if typeof(p5) == "string" and p4.Move then
            if p4.Move.Sequences then
                p5 = p4.Move.Sequences[p5] or nil;
            else
                p5 = nil;
            end;
        end;

        if p5 ~= nil then
            if p4.Call then
                if p4.Call.State.Sequences then
                    table.insert(p4.Call.State.Sequences, p5);
                end;

                p5:SetCall(p4.Call);
            end;

            p5:Play(...);

            if p4.Move and p4.Move.State.AttackState then
                p4.Move.State.AttackState.LastAttack = p4.Move.State.AttackState.CurrentAttack;
                p4.Move.State.AttackState.CurrentAttack = p5.Name;
                p4.Move.State.AttackState.CurrentMove = p4.Move;
            end;

            Sequence:Stop();
        end;
    end,

    Delay = function(u6, p7, u8, ...) -- Line: 53, Name: Delay
        -- upvalues: SharedFunctionService (copy)
        local _ = u6.Sequence;
        local _ = u6.Frame;
        task.delay(p7 or 1, function(...) -- Line: 56
            -- upvalues: SharedFunctionService (ref), u8 (copy), u6 (copy)
            SharedFunctionService.CallFunction(u8, u6, ...);
        end, ...);
    end,

    Conditional = function(p9, p10) -- Line: 61, Name: Conditional
        -- upvalues: DirectoryUtil (copy), SharedFunctionService (copy)
        local Sequence = p9.Sequence;
        local _ = p9.Frame;
        local Call = p9.Call;
        local v11 = p10 or {};
        local Conditions = v11.Conditions;
        local Function = v11.Function;
        local v12 = v11.Arguments or {};

        if Conditions ~= nil then
            for i, v in pairs(Conditions) do
                local v13 = true;
                local v14 = DirectoryUtil.Get({
                    Path = i,
                    Roots = {
                        { "@Sequence", Sequence },
                        { "@Call", Call },
                        { "@Move", p9.Move },
                        { "@Ability", p9.Ability }
                    }
                });

                if typeof(v) == "function" then
                    if v(p9, v14) ~= true then
                        v13 = false;
                    end;
                elseif v ~= v14 then
                    v13 = false;
                end;

                if v13 == false then
                    return true;
                end;
            end;
        end;

        SharedFunctionService.CallFunction(Function, p9, unpack(v12));
    end,

    RepeatFrames = function(p15, p16) -- Line: 106, Name: RepeatFrames
        -- upvalues: DirectoryUtil (copy)
        local Sequence = p15.Sequence;
        local Call = p15.Call;
        local v17 = p16 or {};
        local v18 = v17.Frame or p15.Frame;
        local MinFrames = v17.MinFrames;
        local MaxFrames = v17.MaxFrames;
        local Conditions = v17.Conditions;
        local v19 = Sequence:GetPosition();
        local u20 = Sequence:GetState("_Repeat");

        if not u20.Valid then
            u20.Valid = true;
            u20.Frames = 0;
            u20.LastPosition = v19;
            u20.Updated = Sequence.Collector:Connect(Sequence.Updated, function(p21) -- Line: 125
                -- upvalues: u20 (copy)
                if u20 and u20.Valid then
                    local v22 = math.abs(p21 - u20.LastPosition);
                    u20.LastPosition = p21;
                    local v23 = u20;
                    v23.Frames = v23.Frames + v22;
                end;
            end);
            Sequence.Collector:Add(function() -- Line: 133
                -- upvalues: Sequence (copy)
                Sequence:ClearState("_Repeat");
            end);
        end;

        if MaxFrames and u20.Frames > MaxFrames then
            if u20.Updated then
                u20.Updated:Disconnect();
                u20.Updated = nil;
            end;

            Sequence:ClearState("_Repeat");

            return true;
        end;

        if (not MinFrames or MinFrames <= u20.Frames) and Conditions ~= nil then
            for i, v in pairs(Conditions) do
                local v24 = true;
                local v25 = DirectoryUtil.Get({
                    Path = i,
                    Roots = {
                        { "@Sequence", Sequence },
                        { "@Call", Call },
                        { "@Move", p15.Move },
                        { "@Ability", p15.Ability }
                    }
                });

                if typeof(v) == "function" then
                    if v(p15, v25) ~= true then
                        v24 = false;
                    end;
                elseif v ~= v25 then
                    v24 = false;
                end;

                if v24 == false then
                    if u20.Updated then
                        u20.Updated:Disconnect();
                        u20.Updated = nil;
                    end;

                    Sequence:ClearState("_Repeat");

                    return true;
                end;
            end;
        end;

        u20.LastPosition = v18 - 1;

        return "Repeat", v18;
    end
};