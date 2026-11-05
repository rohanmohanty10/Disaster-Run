  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
require(ReplicatedRoot.Services.StateService);
local SequenceService = require(ReplicatedRoot.Services.SequenceService);
require(ReplicatedRoot.Services.Gameplay.MoveService);
require(ReplicatedRoot.Services.CombatService);
local v1 = {
    Frames = { { 0, "Start" }, { 0, "Dash" }, { 12, "Stackable", true }, { 24, "End" } },
    Callbacks = { { "Ended", "CleanSequence" } }
};

return {
    Actionable = {},
    Stack = {
        ["@All"] = {
            Interrupt = true,
            Conditions = {
                ["Replicated/Stackable"] = true
            }
        },
        ["@Self"] = {
            Interrupt = true,
            Conditions = {
                ["Replicated/Stackable"] = true
            }
        }
    },
    States = {
        Forward = {
            Sequence = TableUtil.Reconcile({
                Animations = { {
                        Animation = "@Animations/Moves/Dash/Forward"
                    } }
            }, v1)
        },
        Left = {
            Sequence = TableUtil.Reconcile({
                Animations = { {
                        Animation = "@Animations/Moves/Dash/Left"
                    } }
            }, v1)
        },
        Back = {
            Sequence = TableUtil.Reconcile({
                Animations = { {
                        Animation = "@Animations/Moves/Dash/Back"
                    } }
            }, v1)
        },
        Right = {
            Sequence = TableUtil.Reconcile({
                Animations = { {
                        Animation = "@Animations/Moves/Dash/Right"
                    } }
            }, v1)
        }
    },

    Init = function(p2) -- Line: 82, Name: Init
        -- upvalues: SequenceService (copy), TableUtil (copy)
        p2.Sequences = {};

        for i, v in pairs(p2.Data.States) do
            local v3 = SequenceService.CreateMoveSequence(v.Sequence, {
                Move = p2,
                Name = i,
                Info = TableUtil.Reconcile(v.Info or {}, p2.Data.BaseInfo or {})
            });
            p2.Sequences[i] = v3;
        end;
    end,

    Activate = function(p4, p5) -- Line: 94, Name: Activate
        -- upvalues: CommonUtil (copy)
        local v6 = p4.RootPart.CFrame:VectorToObjectSpace(p4.Humanoid.MoveDirection);
        local v7 = v6 == Vector3.new(0, 0, 0) and Vector3.new(0, 0, -1) or v6;
        local v8 = CommonUtil.GetDashDirection(v7);

        if not CommonUtil.IsMouseLocked() then
            v8 = "Forward";
            v7 = Vector3.new(0, 0, -1);
        end;

        local v9 = p4.Sequences[v8];

        if v9 then
            for _, v in pairs(p4.Sequences) do
                v:Stop();
            end;

            local v10 = {
                Normal = v7,
                Direction = v8
            };
            p5.Arguments.DashResult = v10;
            v9:SetCall(p5);
            v9:Play(v10);
            local v11 = p4:ActivateServer(p5);
            p5:AwaitSequences({ v9 });
            v11:expect();
        end;
    end,

    Interrupt = function(p12, p13) -- Line: 128, Name: Interrupt
        for _, v in pairs(p12.Sequences) do
            v:Stop();
        end;
    end
};