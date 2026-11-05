  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local LocalPlayer = game.Players.LocalPlayer;
require(ReplicatedRoot.Libraries.Classes.Signal);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Classes.Timer);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
local InputUtil = require(ReplicatedRoot.Libraries.Utility.InputUtil);
local CommonUtil = require(ReplicatedRoot.Libraries.Utility.CommonUtil);
require(ReplicatedRoot.Libraries.Networking.Replica);
local BridgeNet2 = require(ReplicatedRoot.Libraries.Networking.BridgeNet2);
local MoveService = require(ReplicatedRoot.Services.Gameplay.MoveService);
require(ReplicatedRoot.Libraries.Gameplay.Classes.MoveAction);
require(ReplicatedRoot.Services.CombatService);
require(ReplicatedRoot.Services.StateService);
local UserInputService = game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local ClientUIOutput = game.ReplicatedStorage:WaitForChild("Remotes").ClientUIOutput;
local u1 = {
    Name = "MoveInputController",
    MoveInputBridge = BridgeNet2.ReferenceBridge("MoveInput"),
    CallReplicationBridge = BridgeNet2.ReferenceBridge("CallReplication"),
    Requests = {},
    Queue = {}
};

if Core.Context == "Server" then
    return u1;
end;

require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.InvokeMove(p2, p3) -- Line: 70
    -- upvalues: HttpService (copy), Promise (copy), u1 (copy)
    local u4 = p3 or {};
    local _ = u4.Arguments;
    local u5 = u4.Type or "Activate";
    local Replica = p2.Replica;

    if Replica ~= nil then
        local u6 = u4.RequestId or `{os.clock()}-{HttpService:GenerateGUID()}`;

        return Promise.try(function() -- Line: 83
            -- upvalues: u1 (ref), u6 (copy), Replica (copy), u5 (copy), u4 (copy)
            u1.MoveInputBridge:Fire({
                RequestId = u6,
                ReplicaId = Replica.Id,
                Type = u5,
                Arguments = u4.Arguments or {}
            });
            local v7 = nil;

            while not v7 do
                v7 = u1.Requests[u6];
                task.wait();
            end;

            u1.Requests[u6] = nil;

            return v7 and unpack(v7.Arguments) or nil;
        end):catch(warn);
    end;
end;

function u1.GetMoveset() -- Line: 103
end;

function u1.HandleInput(p8) -- Line: 107
    -- upvalues: LocalPlayer (copy), InputUtil (copy), MoveService (copy), Core (copy), u1 (copy)
    if LocalPlayer.Character == nil then
        return;
    end;

    local v9 = p8 or {};

    if (v9.GameProcessed or false) == true then
        return;
    end;

    local v10 = InputUtil.Convert(v9.Input or {});

    if v10.UserInputState == Enum.UserInputState.None or v10.UserInputState == Enum.UserInputState.Cancel then
        return;
    end;

    local v11;

    if v10.UserInputType == Enum.UserInputType.Keyboard or v10.UserInputType == Enum.UserInputType.Gamepad1 then
        v11 = v10.KeyCode;
    else
        v11 = v10.UserInputType;
    end;

    local v12 = InputUtil.FormatKeybind({
        Input = v11
    });
    v10.Value = v11;
    v10.String = v12;
    local v13 = MoveService.FindFirstMove(LocalPlayer.Character, {
        Bound = true,
        IncludeFlags = {
            [v12] = true
        }
    });
    local v14 = MoveService.FindFirstMove(LocalPlayer.Character, {
        Bound = true,
        IncludeFlags = {
            [`{v12}+`] = true
        }
    });

    if v10.UserInputState == Enum.UserInputState.Begin then
        local v15;

        if Core.Context == "Client" then
            v15 = Core.GetLegacyService("MoveInputController");
        else
            v15 = nil;
        end;

        if v15 and v15.MoveBinding then
            return;
        end;

        local v16 = nil;

        if v13 and v14 then
            if v10.Held == nil then
                local Settings = LocalPlayer:FindFirstChild("Settings");
                local v17 = not (Settings and Settings:FindFirstChild("HeldFidelity")) and 0.2 or math.max(Settings.HeldFidelity.Value, 0.01);
                local v18 = 0;

                while v14 and (v14:IsEnabled() and (v18 < v17 and InputUtil.IsInputActive(v10))) do
                    v18 = v18 + task.wait();
                end;

                if v17 <= v18 and (v14 and v14:IsEnabled()) then
                    v10.Held = true;
                    v10.String = `{v12}+`;
                else
                    v14 = v13;
                end;
            elseif v10.Held == true then
                v10.Held = true;
                v10.String = `{v12}+`;
            elseif v10.Held == false then
                v14 = v13;
            else
                v14 = v16;
            end;
        elseif v13 then
            v14 = v13;
        elseif v14 then
            v10.Held = true;
            v10.String = `{v12}+`;
        else
            v14 = v16;
        end;

        if v14 then
            u1.QueueMove(v14, v10);
        end;
    elseif v10.UserInputState == Enum.UserInputState.End then
        if v14 then
            v14:Deactivate({
                Arguments = {
                    Input = v10
                }
            });
        end;

        if v13 then
            v13:Deactivate({
                Arguments = {
                    Input = v10
                }
            });
        end;
    end;
end;

function u1.QueueMove(p19, p20) -- Line: 212
    -- upvalues: ClientUIOutput (copy), u1 (copy)
    local v21 = p19:Validate();

    if v21.Success == true then
        p19:Activate({
            Arguments = {
                Input = p20
            }
        });

        return;
    end;

    if v21.Conditions.Meter == false then
        return;
    end;

    if v21.Conditions.Cooldown == false then
        return;
    end;

    if v21.Buffer == false then
        local v22 = v21.Conditions.Mastery == false and (p19.Data.Info and p19.Data.Info.MasteryRequirement or nil);

        if v22 then
            ClientUIOutput:Fire("CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "LOW RANK",
                Verb = "Failed",
                Subject = `Mastery Rank {v22} Required`
            });
            ClientUIOutput:Fire("PlaySound", "error_sfx1");
        end;

        return;
    end;

    local Queue = u1.Queue;
    local v23 = {
        Held = true,
        MoveAction = p19,
        Added = os.clock(),
        Input = p20
    };
    table.insert(Queue, v23);

    if #u1.Queue > 8 then
        for i = 9, #u1.Queue do
            u1.Queue[i] = nil;
        end;
    end;
end;

function u1._Start() -- Line: 265
    -- upvalues: u1 (copy), InputUtil (copy), UserInputService (copy), CommonUtil (copy)
    game:GetService("RunService").PreSimulation:Connect(function(p24) -- Line: 266
        -- upvalues: u1 (ref), InputUtil (ref)
        if #u1.Queue > 0 then
            local v25 = 1;

            while true do
                local v26 = #u1.Queue > 0 and u1.Queue[v25];

                if not v26 then
                    break;
                end;

                if not (v26.Input and InputUtil.IsInputActive(v26.Input)) then
                    v26.Held = false;
                end;

                local v27 = v26.MoveAction or nil;
                local v28 = v27 and (v27.Data.BufferTime or 0.15) or 0.15;
                local v29 = v27 and (v27.Data.BufferHeldTime or (v27.Data.BufferTime and v27.Data.BufferTime * 3 or 0.45)) or 0.45;

                if v26.Held ~= true then
                    v29 = v28;
                end;

                if v29 < os.clock() - v26.Added then
                    table.remove(u1.Queue, v25);
                    v25 = v25 - 1;
                end;

                v25 = v25 + 1;

                if #u1.Queue <= v25 then
                    break;
                end;
            end;
        end;

        local v30, v31 = next(u1.Queue);
        local v32;

        if v31 then
            v32 = v31.MoveAction or nil;
        else
            v32 = nil;
        end;

        if v32 ~= nil then
            local v33 = v32:Validate();

            if v33.Success == true then
                table.remove(u1.Queue, v30);
                v32:Activate({
                    Arguments = {
                        Input = v31.Input
                    }
                });
            elseif v33.Buffer == false then
                table.remove(u1.Queue, v30);
            end;
        end;

        for i, v in pairs(u1.Requests) do
            if os.clock() - v.Added >= 5 then
                u1.Requests[i] = nil;
            end;
        end;
    end);
    u1.MoveInputBridge:Connect(function(p34, ...) -- Line: 320
        -- upvalues: u1 (ref)
        u1.Requests[p34] = {
            Added = os.clock(),
            Arguments = { ... }
        };
    end);
    local u35 = 0;
    UserInputService.InputBegan:Connect(function(p36, p37) -- Line: 328
        -- upvalues: CommonUtil (ref), u35 (ref), u1 (ref)
        if not p37 and (p36.UserInputType == Enum.UserInputType.MouseButton2 and not CommonUtil.IsMouseLocked()) then
            local v38 = u35;
            u35 = os.clock();

            if os.clock() - v38 >= 0.2 then
                return;
            end;
        end;

        u1.HandleInput({
            Input = p36,
            GameProcessed = p37
        });
    end);
    UserInputService.InputEnded:Connect(function(p39, p40) -- Line: 345
        -- upvalues: u1 (ref)
        u1.HandleInput({
            Input = p39,
            GameProcessed = p40
        });
    end);
end;

return u1;