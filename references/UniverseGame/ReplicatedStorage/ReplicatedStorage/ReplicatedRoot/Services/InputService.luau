  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
local InputService = require(ReplicatedRoot.Libraries.Networking.Packets.InputService);
local UserInputService = game:GetService("UserInputService");
game:GetService("HttpService");
local u1 = {
    Name = "InputService",
    InputGroups = {},
    InputListeners = {},
    InputBegan = Signal.new(),
    InputChanged = Signal.new(),
    InputEnded = Signal.new()
};
local Groups = require(script.Groups);
local InputGroup = require(script.InputGroup);

function u1.CreateListener(u2) -- Line: 72
    -- upvalues: u1 (copy), Trove (copy), Signal (copy), InputService (copy)
    local u3 = u1.InputListeners[u2];

    if not u3 then
        u3 = {
            Collector = Trove.new()
        };
        u3.Signal = u3.Collector:Construct(Signal);
        u3.ReceivedState = false;
        u3.Interfaces = {};
        u3.Groups = {};
        u3.Active = {};
        u1.InputListeners[u2] = u3;
        task.spawn(function() -- Line: 86
            -- upvalues: u2 (copy), u3 (ref), u1 (ref), InputService (ref)
            local v4 = os.clock();

            while u2 and (u3 and (u1.InputListeners[u2] == u3 and not u3.ReceivedState)) do
                InputService.Register.sendTo(true, u2);

                if os.clock() - v4 >= 10 then
                    break;
                end;

                task.wait(0.1);
            end;
        end);
        u3.Collector:Connect(u3.Signal, function(p5) -- Line: 97
            -- upvalues: u3 (ref)
            if p5.UserInputState == Enum.UserInputState.Begin then
                for i, v in pairs(p5.Groups) do
                    if not u3.Groups[i] then
                        u3.Groups[i] = {};
                    end;

                    for i2, _ in pairs(v) do
                        u3.Groups[i][i2] = true;
                    end;
                end;
            elseif p5.UserInputState == Enum.UserInputState.End then
                for i, v in pairs(p5.Groups) do
                    if u3.Groups[i] then
                        for i2, _ in pairs(v) do
                            u3.Groups[i][i2] = nil;
                        end;

                        if not next(u3.Groups[i]) then
                            u3.Groups[i] = nil;
                        end;
                    end;
                end;
            end;

            if p5.UserInputType == Enum.UserInputType.Keyboard or p5.UserInputType == Enum.UserInputType.Gamepad1 then
                if p5.UserInputState == Enum.UserInputState.Begin then
                    u3.Active[p5.KeyCode] = true;

                    return;
                end;

                if p5.UserInputState == Enum.UserInputState.End then
                    u3.Active[p5.KeyCode] = nil;
                end;
            elseif p5.UserInputType == Enum.UserInputType.MouseButton1 or (p5.UserInputType == Enum.UserInputType.MouseButton2 or p5.UserInputType == Enum.UserInputType.MouseButton3) then
                if p5.UserInputState == Enum.UserInputState.Begin then
                    u3.Active[p5.UserInputType] = true;

                    return;
                end;

                if p5.UserInputState == Enum.UserInputState.End then
                    u3.Active[p5.UserInputType] = nil;
                end;
            end;
        end);
        u3.Collector:Add(function() -- Line: 135
            -- upvalues: u2 (copy), InputService (ref), u1 (ref)
            if u2 and u2:IsDescendantOf(game) then
                InputService.Register.sendTo(false, u2);
            end;

            u1.InputListeners[u2] = nil;
        end);
    end;

    local u6 = {
        Collector = u3.Collector:Extend()
    };
    u6.Collector:Add(function() -- Line: 145
        -- upvalues: u3 (ref), u6 (copy)
        u3.Interfaces[u6] = nil;

        if not next(u3.Interfaces) then
            u3.Collector:Destroy();
        end;
    end);

    function u6.IsInputActive(p7, p8, p9) -- Line: 152
        -- upvalues: u3 (ref)
        if not (p8 and p9) then
            return u3.Active[p8] == true;
        end;

        local v10 = u3.Groups[p8];

        if v10 then
            return v10[p9] == true;
        end;

        return false;
    end;

    function u6.Connect(p11, u12) -- Line: 164
        -- upvalues: u3 (ref)
        return u3.Signal:Connect(function(p13) -- Line: 165
            -- upvalues: u12 (copy)
            u12(p13, p13.GameProcessed);
        end);
    end;

    function u6.Destroy(p14) -- Line: 170
        -- upvalues: u6 (copy)
        if table.isfrozen(u6) then
            return;
        end;

        u6.Collector:Destroy();
        table.clear(u6);
        table.freeze(u6);
    end;

    u3.Interfaces[u6] = true;

    return u6;
end;

function u1.CreateInputGroup(p15) -- Line: 189
    -- upvalues: u1 (copy), InputGroup (copy)
    local v16 = u1.GetInputGroup(p15);

    if v16 == nil then
        v16 = InputGroup.new(p15);
        u1.InputGroups[p15] = v16;
    end;

    return v16;
end;

function u1.RemoveInputGroup(p17) -- Line: 199
    -- upvalues: u1 (copy)
    local v18 = u1.GetInputGroup(p17);

    if v18 ~= nil then
        v18:Destroy();
        u1.InputGroups[p17] = nil;
    end;
end;

function u1.GetInputGroup(p19) -- Line: 207
    -- upvalues: u1 (copy)
    return u1.InputGroups[p19];
end;

function u1.GetInputGroups() -- Line: 211
    -- upvalues: u1 (copy)
    return u1.InputGroups;
end;

function u1.ProcessInput(p20, p21, p22) -- Line: 215
    -- upvalues: u1 (copy), InputService (copy)
    local v23 = {
        Value = nil,
        Groups = {},
        Delta = p20.Delta,
        KeyCode = p20.KeyCode,
        UserInputType = p20.UserInputType,
        UserInputState = p20.UserInputState,
        GameProcessed = p21
    };

    if v23.UserInputType == Enum.UserInputType.Keyboard then
        v23.Value = v23.KeyCode;
    else
        v23.Value = v23.UserInputType;
    end;

    for i, v in pairs(u1.GetInputGroups()) do
        for i2, v2 in pairs(v.Inputs) do
            if table.find(v2.Binds, v23.KeyCode) or table.find(v2.Binds, v23.UserInputType) then
                if not v23.Groups[i] then
                    v23.Groups[i] = {};
                end;

                v23.Groups[i][i2] = v2;
            end;
        end;
    end;

    if u1.InputListeners[game.Players.LocalPlayer] and (v23.UserInputState == Enum.UserInputState.Begin or (v23.UserInputState == Enum.UserInputState.Change or v23.UserInputState == Enum.UserInputState.End)) then
        local v24 = {
            Groups = {},
            Delta = v23.Delta,
            KeyCode = v23.KeyCode.Value,
            UserInputType = v23.UserInputType.Value,
            UserInputState = v23.UserInputState.Value,
            GameProcessed = p21
        };

        for i, v in pairs(v23.Groups) do
            v24.Groups[i] = {};

            for i2, _ in pairs(v) do
                v24.Groups[i][i2] = true;
            end;
        end;

        if v23.UserInputState == Enum.UserInputState.Change then
            InputService.SendUnreliable.send(v24);
        elseif v23.UserInputState == Enum.UserInputState.Begin or v23.UserInputState == Enum.UserInputState.End then
            InputService.Send.send(v24);
        end;
    end;

    if p22 ~= nil then
        p22(v23, p21);
    end;
end;

function u1._Init() -- Line: 276
    -- upvalues: Core (copy), UserInputService (copy), u1 (copy), InputService (copy), Groups (copy)
    if Core.Context ~= "Client" then
        if Core.Context == "Server" then
            local function Listen(p25, p26) -- Line: 354
                -- upvalues: u1 (ref)
                local v27 = u1.InputListeners[p26];

                if v27 then
                    local v28 = Enum.UserInputType:FromValue(p25.UserInputType) or Enum.UserInputType.None;
                    local v29 = Enum.KeyCode:FromValue(p25.KeyCode) or Enum.KeyCode.Unknown;
                    local Signal2 = v27.Signal;
                    local v30 = {
                        Groups = p25.Groups,
                        Delta = p25.Delta,
                        KeyCode = v29,
                        UserInputType = v28
                    };

                    if v28 ~= Enum.UserInputType.Keyboard then
                        v29 = v28;
                    end;

                    v30.Value = v29;
                    v30.UserInputState = Enum.UserInputState:FromValue(p25.UserInputState) or Enum.UserInputState.None;
                    v30.GameProcessed = p25.GameProcessed;
                    Signal2:Fire(v30);
                end;
            end;

            InputService.Send.listen(function(p31, p32) -- Line: 371
                -- upvalues: Listen (copy)
                if p31.UserInputState ~= Enum.UserInputState.Begin.Value and p31.UserInputState ~= Enum.UserInputState.End.Value then
                    return nil;
                end;

                Listen(p31, p32);
            end);
            InputService.SendUnreliable.listen(function(p33, p34) -- Line: 378
                -- upvalues: Listen (copy)
                if p33.UserInputState ~= Enum.UserInputState.Change.Value then
                    return nil;
                end;

                Listen(p33, p34);
            end);
            InputService.SendState.listen(function(p35, p36) -- Line: 385
                -- upvalues: u1 (ref)
                local v37 = u1.InputListeners[p36];

                if v37 and not v37.ReceivedState then
                    v37.ReceivedState = true;

                    for _, v in pairs(p35.KeyCodes) do
                        if Enum.KeyCode:FromValue(v) then
                            v37.Active[Enum.KeyCode:FromValue(v)] = true;
                        end;
                    end;

                    for _, v in pairs(p35.InputTypes) do
                        if Enum.UserInputType:FromValue(v) then
                            v37.Active[Enum.UserInputType:FromValue(v)] = true;
                        end;
                    end;

                    for i, v in pairs(p35.Groups) do
                        if not v37.Groups[i] and next(v) then
                            v37.Groups[i] = {};

                            for _, v2 in pairs(v) do
                                v37.Groups[i][v2] = true;
                            end;
                        end;
                    end;
                end;
            end);
            game.Players.PlayerRemoving:Connect(function(p38) -- Line: 413
                -- upvalues: u1 (ref)
                local v39 = u1.InputListeners[p38];

                if v39 then
                    v39.Collector:Destroy();
                end;
            end);
        end;

        return;
    end;

    local LocalPlayer = game.Players.LocalPlayer;
    UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 280
        -- upvalues: u1 (ref)
        u1.ProcessInput(p40, p41, function(p42, p43) -- Line: 281
            -- upvalues: u1 (ref)
            u1.InputBegan:Fire(p42, p43);

            for _, v in pairs(p42.Groups) do
                for _, v2 in pairs(v) do
                    v2.Active = true;
                end;
            end;
        end);
    end);
    UserInputService.InputChanged:Connect(function(p44, p45) -- Line: 291
        -- upvalues: u1 (ref)
        u1.ProcessInput(p44, p45, function(p46, p47) -- Line: 292
            -- upvalues: u1 (ref)
            u1.InputChanged:Fire(p46, p47);
        end);
    end);
    UserInputService.InputEnded:Connect(function(p48, p49) -- Line: 297
        -- upvalues: u1 (ref)
        u1.ProcessInput(p48, p49, function(p50, p51) -- Line: 298
            -- upvalues: u1 (ref)
            u1.InputEnded:Fire(p50, p51);

            for _, v in pairs(p50.Groups) do
                for _, v2 in pairs(v) do
                    v2.Active = false;
                end;
            end;
        end);
    end);
    InputService.Register.listen(function(p52) -- Line: 308
        -- upvalues: u1 (ref), LocalPlayer (copy), UserInputService (ref), InputService (ref)
        if not p52 or u1.InputListeners[LocalPlayer] then
            if not p52 and u1.InputListeners[LocalPlayer] then
                u1.InputListeners[LocalPlayer] = nil;
            end;

            return;
        end;

        u1.InputListeners[LocalPlayer] = true;
        local v53 = {
            Groups = {},
            InputTypes = {},
            KeyCodes = {}
        };

        for _, v in pairs(UserInputService:GetKeysPressed()) do
            if not table.find(v53.KeyCodes, v.KeyCode.Value) then
                table.insert(v53.KeyCodes, v.KeyCode.Value);
            end;
        end;

        for _, v in pairs(UserInputService:GetMouseButtonsPressed()) do
            if (v.UserInputType == Enum.UserInputType.MouseButton1 or (v.UserInputType == Enum.UserInputType.MouseButton2 or v.UserInputType == Enum.UserInputType.MouseButton3)) and not table.find(v53.InputTypes, v.UserInputType.Value) then
                table.insert(v53.InputTypes, v.UserInputType.Value);
            end;
        end;

        for i, v in pairs(u1.InputGroups) do
            for i2, _ in pairs(v:GetActiveInputs()) do
                if not v53.Groups[i] then
                    v53.Groups[i] = {};
                end;

                if not table.find(v53.Groups[i], i2) then
                    table.insert(v53.Groups[i], i2);
                end;
            end;
        end;

        InputService.SendState.send(v53);
    end);

    for i, v in pairs(Groups) do
        u1.CreateInputGroup(i):AddInputs(v);
    end;
end;

return u1;