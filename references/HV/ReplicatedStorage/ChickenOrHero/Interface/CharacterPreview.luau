 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local CharacterClone = require(script_Parent.CharacterClone);
local CharacterFrame = require(script_Parent.CharacterFrame);
local EmotePlayback = require(Parent.Emotes.EmotePlayback);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;

local function pressed(p2) -- Line: 15
    return p2.UserInputType == Enum.UserInputType.MouseButton1 and true or p2.UserInputType == Enum.UserInputType.Touch;
end;

function u1.new(p3) -- Line: 19
    -- upvalues: u1 (copy), UserInputService (copy)
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    Camera.Parent = p3;
    p3.CurrentCamera = Camera;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p3;
    local u4 = setmetatable({
        yaw = -0.3490658503988659,
        held = false,
        lastX = 0,
        viewport = p3,
        camera = Camera,
        world = WorldModel,
        connections = {}
    }, u1);
    table.insert(u4.connections, p3.InputBegan:Connect(function(p5) -- Line: 37
        -- upvalues: u4 (copy)
        if p5.UserInputType == Enum.UserInputType.MouseButton1 and true or p5.UserInputType == Enum.UserInputType.Touch then
            u4.held = true;
            u4.lastX = p5.Position.X;
        end;
    end));
    table.insert(u4.connections, UserInputService.InputChanged:Connect(function(p6) -- Line: 46
        -- upvalues: u4 (copy)
        if u4.held and (p6.UserInputType == Enum.UserInputType.MouseMovement or p6.UserInputType == Enum.UserInputType.Touch) then
            local v7 = u4;
            v7.yaw = v7.yaw + (p6.Position.X - u4.lastX) * 0.012;
            u4.lastX = p6.Position.X;
        end;
    end));
    table.insert(u4.connections, UserInputService.InputEnded:Connect(function(p8) -- Line: 61
        -- upvalues: u4 (copy)
        if p8.UserInputType == Enum.UserInputType.MouseButton1 and true or p8.UserInputType == Enum.UserInputType.Touch then
            u4.held = false;
        end;
    end));

    return u4;
end;

function u1.rebuild(p9, p10) -- Line: 72
    -- upvalues: LocalPlayer (copy), CharacterClone (copy), CharacterFrame (copy)
    local Character = LocalPlayer.Character;
    local Attribute = LocalPlayer:GetAttribute("EquippedKnife");
    local v11;

    if p9.source == Character then
        v11 = p9.knife == Attribute;
    else
        v11 = false;
    end;

    if not p10 and (p9.model and (p9.model.Parent and v11)) then
        return true;
    end;

    if not v11 then
        p9.tries = 0;
    end;

    p9:stop();
    CharacterClone.dropIdle(p9.idle);
    p9.idle = nil;

    if p9.model then
        p9.model:Destroy();
        p9.model = nil;
    end;

    local v12, v13 = CharacterClone.copy(Character);

    if not v12 then
        return false;
    end;

    v12:PivotTo(CFrame.new());
    v12.Name = "PreviewCharacter";
    v12.Parent = p9.world;
    CharacterFrame.fit(p9.camera, v12, p9.viewport, 1.12);
    p9.model = v12;
    p9.source = Character;
    p9.knife = Attribute;
    p9.shownYaw = nil;
    p9.animator = v13:FindFirstChildOfClass("Animator");
    p9.idle = CharacterClone.knifeIdle(v12, p9.animator, Attribute);
    p9.tries = (p9.tries or 0) + 1;
    local v14;

    if CharacterClone.dressed(v12) or p9.tries > CharacterClone.RETRIES then
        v14 = nil;
    else
        v14 = os.clock() + CharacterClone.RETRY_SECONDS;
    end;

    p9.retryAt = v14;

    return true;
end;

function u1.play(p15, p16) -- Line: 111
    -- upvalues: EmotePlayback (copy), CharacterClone (copy)
    p15:stop();
    p15.emote = p16;

    if not (p15:rebuild() and p15.animator) then
        return false;
    end;

    local v17 = EmotePlayback.load(p15.animator, p16);

    if v17 then
        p15.track = v17;
        v17:Play(0.15);
        CharacterClone.holdChains(p15.idle, p16);
    end;

    return v17 ~= nil;
end;

function u1.stop(p18) -- Line: 126
    -- upvalues: EmotePlayback (copy), CharacterClone (copy)
    if p18.track then
        local track = p18.track;
        p18.track = nil;
        EmotePlayback.dispose(track);
    end;

    CharacterClone.holdChains(p18.idle, nil);
end;

function u1.step(p19) -- Line: 135
    if p19.retryAt and os.clock() >= p19.retryAt then
        p19.retryAt = nil;
        local v20 = p19.track and p19.emote;

        if p19:rebuild(true) and v20 then
            p19:play(v20);
        end;
    end;

    if p19.model and p19.shownYaw ~= p19.yaw then
        p19.shownYaw = p19.yaw;
        p19.model:PivotTo(CFrame.Angles(0, p19.yaw, 0));
    end;
end;

function u1.destroy(p21) -- Line: 149
    -- upvalues: CharacterClone (copy)
    p21:stop();
    CharacterClone.dropIdle(p21.idle);
    p21.idle = nil;

    for _, v in p21.connections do
        v:Disconnect();
    end;

    table.clear(p21.connections);

    if p21.viewport.CurrentCamera == p21.camera then
        p21.viewport.CurrentCamera = nil;
    end;

    p21.world:Destroy();
    p21.camera:Destroy();
    p21.model = nil;
    p21.source = nil;
    p21.animator = nil;
end;

return u1;