  

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Signal = require(ReplicatedStorage.Packages.Signal);
local Trove = require(ReplicatedStorage.Packages.Trove);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local u1 = nil;
local u2 = {};
local u3 = {};
u3.__index = u3;

local function defaultCanDragFunction(p4) -- Line: 45
    return p4.Instance.Active;
end;

local function defaultShouldCancelFunction(p5) -- Line: 49
    return not p5.Instance.Active;
end;

local function stopAllDragging(p6) -- Line: 53
    -- upvalues: u1 (ref), PlayerGui (copy)
    if u1 then
        if p6 then
            u1.DragEnded:Fire(PlayerGui:GetGuiObjectsAtPosition(p6.X, p6.Y));
        else
            u1.DragEnded:Fire();
        end;

        u1._dragTrove:Destroy();
        u1 = nil;
    end;
end;

function u3.new(p7: userdata) -- Line: 65
    -- upvalues: Signal (copy), Trove (copy), defaultCanDragFunction (copy), defaultShouldCancelFunction (copy), u3 (copy)
    assert(p7:IsA("GuiObject"));
    local v8 = {
        DragStarted = Signal.new(),
        DragStepped = Signal.new(),
        DragEnded = Signal.new(),
        Activated = Signal.new(),
        Instance = p7,
        _trove = Trove.new(),
        _dragTrove = Trove.new(),
        _canDragFunction = defaultCanDragFunction,
        _shouldCancelFunction = defaultShouldCancelFunction
    };
    local v9 = setmetatable(v8, u3);
    v9._trove:AttachToInstance(p7);
    v9:_initialize();

    return v9;
end;

function u3.SetCanDragFunction(p10: any, p11: function) -- Line: 88
    local v12 = type(p11) == "function";
    assert(v12);
    p10._canDragFunction = p11;
end;

function u3.SetShouldCancelFunction(p13: any, p14: function) -- Line: 96
    local v15 = type(p14) == "function";
    assert(v15);
    p13._shouldCancelFunction = p14;
end;

function u3.Destroy(p16) -- Line: 104
    p16._dragTrove:Destroy();
    p16._trove:Destroy();
end;

function u3._initialize(u17) -- Line: 109
    -- upvalues: Trove (copy), UserInputService (copy), u1 (ref), GuiService (copy), RunService (copy), PlayerGui (copy)
    local Instance = u17.Instance;
    local _trove = u17._trove;
    local _dragTrove = u17._dragTrove;
    _trove:Connect(Instance.InputBegan, function(u18: userdata) -- Line: 117
        -- upvalues: u17 (copy), Trove (ref), UserInputService (ref)
        if u18.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        if not u17:_canDragFunction() then
            u17.Activated:Fire(Enum.UserInputType.MouseButton1);

            return;
        end;

        local u19 = Trove.new();
        u19:Connect(u18.Changed, function() -- Line: 129
            -- upvalues: u18 (copy), u19 (copy), u17 (ref)
            if u18.UserInputState == Enum.UserInputState.End then
                u19:Destroy();
                u17.Activated:Fire(Enum.UserInputType.MouseButton1);
            end;
        end);
        u19:Connect(UserInputService.InputChanged, function(p20) -- Line: 135
            -- upvalues: u19 (copy), u17 (ref)
            if p20.UserInputType == Enum.UserInputType.MouseMovement then
                u19:Destroy();
                u17.DragStarted:Fire();
            end;
        end);
    end);
    _trove:Connect(Instance.TouchPan, function(p21: userdata) -- Line: 144
        -- upvalues: u17 (copy)
        if not u17:_canDragFunction() then
            return;
        end;

        u17.DragStarted:Fire();
    end);
    _trove:Connect(Instance.Destroying, function() -- Line: 152
        -- upvalues: _trove (copy)
        _trove:Destroy();
    end);
    _trove:Add(function() -- Line: 156
        -- upvalues: u1 (ref), u17 (copy)
        if u1 == u17 and u1 then
            u1.DragEnded:Fire();
            u1._dragTrove:Destroy();
            u1 = nil;
        end;
    end);

    local function getDragPosition() -- Line: 163
        -- upvalues: UserInputService (ref), GuiService (ref)
        return UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    end;

    u17.DragStarted:Connect(function() -- Line: 171
        -- upvalues: u1 (ref), u17 (copy), _dragTrove (copy), RunService (ref), UserInputService (ref), GuiService (ref), PlayerGui (ref), getDragPosition (copy)
        if u1 then
            u1.DragEnded:Fire();
            u1._dragTrove:Destroy();
            u1 = nil;
        end;

        u1 = u17;
        _dragTrove:Connect(RunService.Stepped, function() -- Line: 175
            -- upvalues: u17 (ref), u1 (ref), UserInputService (ref), GuiService (ref), PlayerGui (ref)
            if u17:_shouldCancelFunction() then
                if u1 then
                    u1.DragEnded:Fire();
                    u1._dragTrove:Destroy();
                    u1 = nil;
                end;

                return;
            end;

            local v22 = not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
            local v23 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();

            if v22 then
                if u1 then
                    if v23 then
                        u1.DragEnded:Fire(PlayerGui:GetGuiObjectsAtPosition(v23.X, v23.Y));
                    else
                        u1.DragEnded:Fire();
                    end;

                    u1._dragTrove:Destroy();
                    u1 = nil;
                end;
            else
                u17.DragStepped:Fire(v23);
            end;
        end);
        u17.DragStepped:Fire(getDragPosition());
    end);
end;

UserInputService.InputBegan:Connect(function(u24) -- Line: 202
    -- upvalues: PlayerGui (copy), u2 (copy)
    if u24.UserInputType ~= Enum.UserInputType.Touch then
        return;
    end;

    local function getHoveredDragger() -- Line: 207
        -- upvalues: u24 (copy), PlayerGui (ref), u2 (ref)
        local Vector2_new_ret = Vector2.new(u24.Position.X, u24.Position.Y);
        local v25 = {};

        for _, v in PlayerGui:GetGuiObjectsAtPosition(Vector2_new_ret.X, Vector2_new_ret.Y) do
            v25[v] = true;
        end;

        for _, v in u2 do
            if v25[v.Instance] then
                return v;
            end;
        end;

        return nil;
    end;

    local u26 = getHoveredDragger();
    local u27 = nil;
    u27 = u24.Changed:Connect(function() -- Line: 224
        -- upvalues: u24 (copy), u27 (ref), getHoveredDragger (copy), u26 (copy)
        if u24.UserInputState == Enum.UserInputState.End then
            u27:Disconnect();

            if getHoveredDragger() == u26 then
                pcall(function() -- Line: 228
                    -- upvalues: u26 (ref)
                    u26.Activated:Fire(Enum.UserInputType.Touch);
                end);
            end;
        end;
    end);
end);

return u3;