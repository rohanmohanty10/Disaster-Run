 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local CharacterClone = require(script_Parent.CharacterClone);
local CharacterFrame = require(script_Parent.CharacterFrame);
local EmotePlayback = require(Parent.Emotes.EmotePlayback);
local u1 = {};
u1.__index = u1;

local function pose(u2, u3, p4) -- Line: 18
    -- upvalues: CharacterFrame (copy), CharacterClone (copy), Players (copy), EmotePlayback (copy), RunService (copy)
    local camera = u2.camera;
    local viewport = u2.viewport;
    u3.Name = "PoseCharacter";
    u3:PivotTo(CFrame.Angles(0, -0.3490658503988659, 0));
    u3.Parent = u2.world;
    u2.clone = u3;
    CharacterFrame.fit(camera, u3, viewport, 1.1);
    local u5 = p4:FindFirstChildOfClass("Animator");
    u2.idle = CharacterClone.knifeIdle(u3, u5, Players.LocalPlayer:GetAttribute("EquippedKnife"));
    CharacterClone.holdChains(u2.idle, u2.id);

    if u5 then
        u5 = EmotePlayback.load(u5, u2.id);
    end;

    if u5 then
        u2.track = u5;
        u5:Play(0, 1, 0);
        task.spawn(function() -- Line: 34
            -- upvalues: u2 (copy), u5 (copy), RunService (ref), CharacterFrame (ref), camera (copy), u3 (copy), viewport (copy)
            local v6 = os.clock() + 5;

            while u2.track == u5 and (u5.Length <= 0 and os.clock() < v6) do
                task.wait(0.1);
            end;

            if u2.track == u5 and u5.Length > 0 then
                u5.TimePosition = u5.Length * 0.5;
                RunService.Heartbeat:Wait();
                RunService.Heartbeat:Wait();

                if u2.track == u5 then
                    CharacterFrame.fit(camera, u3, viewport, 1.06);
                end;
            end;
        end);
    end;
end;

function u1.new(p7, p8) -- Line: 53
    -- upvalues: CharacterClone (copy), Players (copy), u1 (copy), pose (copy)
    local v9, v10 = CharacterClone.copy(Players.LocalPlayer.Character);

    if not v9 then
        return nil;
    end;

    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    Camera.Parent = p7;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p7;
    p7.CurrentCamera = Camera;
    local u11 = setmetatable({
        viewport = p7,
        camera = Camera,
        world = WorldModel,
        id = p8
    }, u1);
    pose(u11, v9, v10);

    if not CharacterClone.dressed(v9) then
        task.spawn(function() -- Line: 69
            -- upvalues: CharacterClone (ref), u11 (copy), Players (ref), pose (ref)
            for i = 1, CharacterClone.RETRIES do
                task.wait(CharacterClone.RETRY_SECONDS);

                if u11.destroyed or u11.playing then
                    return;
                end;

                local v12, v13 = CharacterClone.copy(Players.LocalPlayer.Character);

                if v12 and CharacterClone.dressed(v12) then
                    u11:clearPose();
                    pose(u11, v12, v13);

                    return;
                end;

                local v14;

                if v12 then
                    v12:Destroy();
                    v14 = i;
                else
                    v14 = i;
                end;
            end;
        end);
    end;

    return u11;
end;

function u1.clearPose(p15) -- Line: 91
    -- upvalues: CharacterClone (copy)
    local track = p15.track;
    p15.track = nil;

    if p15.ended then
        p15.ended:Disconnect();
        p15.ended = nil;
    end;

    if track then
        track:Stop(0);
        track:Destroy();
    end;

    CharacterClone.dropIdle(p15.idle);
    p15.idle = nil;

    if p15.clone then
        p15.clone:Destroy();
        p15.clone = nil;
    end;
end;

function u1.step(p16) -- Line: 110
end;

function u1.rest(p17) -- Line: 113
    local track = p17.track;
    p17.playing = false;

    if not track then
        return;
    end;

    if not track.IsPlaying then
        track:Play(0, 1, 0);
    end;

    track:AdjustSpeed(0);
    track.TimePosition = track.Length * 0.5;
end;

function u1.play(u18) -- Line: 127
    local track = u18.track;

    if not track or track.Length <= 0 then
        return false;
    end;

    if u18.playing then
        u18:rest();

        return true;
    end;

    u18.playing = true;

    if not u18.ended then
        u18.ended = track.Stopped:Connect(function() -- Line: 139
            -- upvalues: u18 (copy), track (copy)
            task.defer(function() -- Line: 140
                -- upvalues: u18 (ref), track (ref)
                if u18.playing and u18.track == track then
                    u18:rest();
                end;
            end);
        end);
    end;

    if not track.IsPlaying then
        track:Play(0, 1, 1);
    end;

    track.TimePosition = 0;
    track:AdjustSpeed(1);

    return true;
end;

function u1.destroy(p19) -- Line: 155
    p19.destroyed = true;
    p19:clearPose();

    if p19.viewport.CurrentCamera == p19.camera then
        p19.viewport.CurrentCamera = nil;
    end;

    p19.world:Destroy();
    p19.camera:Destroy();
end;

return u1;