  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedServices.StateService);
require(Core.ReplicatedServices.SequenceService);
require(Core.ReplicatedLibraries.Classes.Timer);
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local CommonUtil = require(Core.ReplicatedLibraries.Utility.CommonUtil);
local v1 = {
    Frames = { { 0, "Start" }, { 0, "Dash" }, { 24, "End" } },
    Callbacks = { { "Ended", "CleanTags" } }
};

return {
    Stack = {},
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

    Init = function(p2) -- Line: 63, Name: Init
        -- upvalues: TableUtil (copy)
        for i, v in pairs(p2.Data.States) do
            p2:CreateSequence(i, (TableUtil.Reconcile(v, p2.Data.BaseInfo)));
        end;
    end,

    Activate = function(p3, p4) -- Line: 70, Name: Activate
        -- upvalues: CommonUtil (copy)
        local v5 = p3.RootPart.CFrame:VectorToObjectSpace(p3.Humanoid.MoveDirection);
        local v6 = v5 == Vector3.new(0, 0, 0) and Vector3.new(0, 0, -1) or v5;
        local v7 = CommonUtil.GetDashDirection(v6);

        if not CommonUtil.IsMouseLocked() then
            v7 = "Forward";
            v6 = Vector3.new(0, 0, -1);
        end;

        local v8 = p3.Sequences[v7];

        if v8 then
            for _, v in pairs(p3.Sequences) do
                v:Stop();
            end;

            local v9 = {
                Normal = v6,
                Direction = v7
            };
            p4.Arguments.DashResult = v9;
            v8:Play(v9);
            p3:ActivateServer(p4);

            while v8 and v8:IsPlaying() do
                task.wait();
            end;
        end;
    end,

    Interrupt = function(p10) -- Line: 105, Name: Interrupt
    end
};