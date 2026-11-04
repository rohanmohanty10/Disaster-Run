 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
game:GetService("ServerScriptService");
local TeleportService = game:GetService("TeleportService");
local trove = require(ReplicatedStorage.forum.trove);
local packets = require(ReplicatedStorage.packets);
local Request = require(ServerStorage.Request);
local Util = require(ReplicatedStorage.util.Util);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local u1 = {};
local u2 = {
    __index = u1
};
local u3 = {};
local u4 = nil;

local function getBase(p5: userdata) -- Line: 28
    -- upvalues: Request (copy)
    return Request.Base(p5.Character);
end;

local u6 = nil;

local function getSoccer() -- Line: 33
    -- upvalues: u6 (ref), Request (copy)
    if not u6 then
        u6 = Request.Soccer();
    end;

    return u6;
end;

local u19 = {
    {
        Auto = true,
        Text = { "Hello diamond in the rough. Welcome to Striker Game.", "Let\'s start by learning the basic mechanics of the game!" }
    },
    {
        Text = { { "Press WASD to move around and spacebar to jump.", "Move around and jump!" } },

        Heartbeat = function(p7) -- Line: 48, Name: Heartbeat
            local Character = p7.Player.Character;

            if not Character then
                return;
            end;

            local v8 = Character:FindFirstChildWhichIsA("Humanoid");

            if not v8 then
                return;
            end;

            if v8:GetState() == Enum.HumanoidStateType.Freefall then
                p7:Advance();
            end;
        end
    },
    {
        Text = { "Yay, you know how to move.", { "Now, press F to do a super dash!", "Now, do a super dash!" } },
        Usable = { "run" }
    },
    {
        Text = { "Look at you go!", "Now, see that dummy?", "That\'s an opponent.", "You\'re going to want to take the ball from him.", { "Press Q to do a slide tackle.", "Do a slide tackle!" } },
        Dummy = { "kuon", nil, true },
        Usable = { "tackle" }
    },
    {
        Text = { "Nice tackle!", "You can also move to the side before dashing to side dash, try it out!" },
        Usable = { "sidedash" }
    },
    {
        Ball = true,
        Text = { "Fantastic!", "Now that you have the ball, people are going to try and tackle you to steal it.", "While holding the ball, go up to that dummy and see what happens!" },
        Dummy = { "nelisagi", "tackle" }
    },
    {
        KeepBall = true,
        Text = { "That looked like it hurt.", { "Now this time, go up to the dummy and press E to dribble when he tackles!", "Now this time, dribble when he tackles!" } },
        Dummy = { "nelisagi", "tackle" },
        Usable = { "dribble" }
    },
    {
        Text = { "Nice ankle breaker!", "If you look at your moveset, you\'ll see that you\'re Isagi!", "You see Naruhaya Footwork? That move has I-Frames.", "I-Frames are periods of time when tackles will not affect you", "Try out Naruhaya Footwork!" },
        Usable = { "skill2" }
    },
    {
        Text = { "Nice footwork!", "Now, theres a move called Reflex Tackle on another style, Aiku!", "That move can bypass I-Frames!", "Go try to get through that dummy!" },
        Dummy = { "aiku", "skill2" }
    },
    {
        Auto = true,
        Text = { "Very punishing.", "When you use a move, you\'ll notice a red bar on it slowly draining.", "When the red on the move completely goes away, your cooldown is refreshed and you can use the move again!", "But for the sake of this tutorial, we\'ll give you no cooldowns to help you out!" },

        MonologueEnd = function(p9) -- Line: 101, Name: MonologueEnd
            -- upvalues: Request (copy)
            Request.Base(p9.Player.Character):set("nocd", true);
        end
    },
    {
        Ball = true,
        Text = { "Sometimes, your moves will be on cooldown when you\'re trying to score.", { "So, you can also kick the ball with your Left Mouse Button!", "So, there\'s also a basic kick!" }, "When using your basic kick, you can move your character in either direction to curve the shot.", "Now, you\'re going to want to score on that guy.", "Don\'t worry about what shooting ability to try out, there\'s always time for practice later.", "Try to aim to the far corners to get it past the GK." },
        Usable = { "kick", "skill1" },

        MonologueStart = function(p10) -- Line: 113, Name: MonologueStart
            -- upvalues: Request (copy)
            local v11 = Request.Base(p10.Player.Character);
            p10.Container:Add(v11:createmovement(0, 0));
        end,

        Heartbeat = function(p12) -- Line: 117, Name: Heartbeat
            -- upvalues: Request (copy), u6 (ref), u4 (ref), Util (copy)
            local Character = p12.Player.Character;
            local v13 = Request.Base(p12.Player.Character);
            local Position = (workspace.map.something.barouU20B.CFrame * CFrame.new(0, 0, 25)).Position;
            local CFrame2 = v13.root.CFrame;
            v13.root.CFrame = CFrame.new((Vector3.new(Position.X, CFrame2.Y, Position.Z))) * CFrame2.Rotation;

            if not u6 then
                u6 = Request.Soccer();
            end;

            local v14 = u6;

            if v14.ballHolder == Character then
                u4 = Util.now();
            end;

            if not (v14.ballHolder or v14.holderBefore == Character and (not u4 or Util.now() - u4 <= 3)) then
                v13:set("cantgetBall", false);
                v14:giveBall(Character, true);
                v13:set("cantgetBall", true);
            end;
        end
    },
    {
        KeepBall = true,
        Text = { "Nice goal!", "Be aware that other players can be a goalkeeper as well.", "Now, it\'s time to go wild.", "Activate flow." },
        Usable = { "baseAwaken" },

        MonologueEnd = function(p15) -- Line: 142, Name: MonologueEnd
            -- upvalues: Request (copy)
            Request.Base(p15.Player.Character):set("flow", 100);
        end,

        Heartbeat = function(p16) -- Line: 145, Name: Heartbeat
            -- upvalues: Request (copy)
            Request.Base(p16.Player.Character):set("flow", 100);
        end
    },
    {
        KeepBall = true,
        Text = { "Use \"MY DIRECT SHOT\"" },
        Usable = { "skill3" },

        Heartbeat = function(p17) -- Line: 152, Name: Heartbeat
            -- upvalues: Request (copy)
            Request.Base(p17.Player.Character):set("flow", 100);
        end
    },
    {
        Text = { "Look at you! You’re ready to become the number one striker!", "Go get them!" },

        MonologueEnd = function(u18) -- Line: 160, Name: MonologueEnd
            -- upvalues: ServerStorage (copy), TeleportService (copy)
            if not u18.Player:GetAttribute("tutorialdone") then
                u18.Player:SetAttribute("tutorialdone", true);
                task.defer(function() -- Line: 163
                    -- upvalues: ServerStorage (ref), u18 (copy)
                    local Data = require(ServerStorage.profile).getData(u18.Player);
                    local Data2 = Data.profile.Data;
                    Data:change("money", Data2.money + 5000, {
                        force = true
                    });
                    Data:change("style_currency", Data2.style_currency + 5000, {
                        force = true
                    });
                end);
            end;

            task.wait(3.5);
            TeleportService:TeleportAsync(game.PlaceId, { u18.Player });
        end
    }
};

function u1.new(p20: userdata) -- Line: 176
    -- upvalues: trove (copy), u2 (copy), u3 (copy)
    local v21 = trove.new();
    v21:AttachToInstance(p20);
    local v22 = setmetatable({
        Step = 0,
        CanAdvance = true,
        Player = p20,
        Container = v21
    }, u2);
    u3[p20] = v22;

    return v22;
end;

function u1.get(p23: userdata) -- Line: 189
    -- upvalues: u3 (copy)
    return u3[p23];
end;

function u1.GetUsable(p24) -- Line: 195
    -- upvalues: u19 (copy)
    local v25 = u19[p24.Step];

    return not (v25 and v25.Usable) and {} or v25.Usable;
end;

local function getWordDelay(p26: string) -- Line: 206
    return #p26:split(" ") * 0.25 + 2;
end;

function u1.DisplayText(p27: any, p28: string, p29: boolean?) -- Line: 213
    -- upvalues: packets (copy)
    packets.bytenet_replication.sendTo({
        name = "tutorialText",
        content = { p28 }
    }, p27.Player);

    if not p29 then
        task.wait(#p28:split(" ") * 0.25 + 2);
    end;
end;

function u1.Monologue(p30: any, p31: any, p32: boolean?) -- Line: 223
    -- upvalues: UserInputService (copy)
    if typeof(p31) == "string" then
        p30:DisplayText(p31);
    elseif typeof(p31) == "table" then
        for i, v in ipairs(p31) do
            if typeof(v) == "string" then
                p30:DisplayText(v, i == #p31);
            elseif typeof(v) == "table" then
                if UserInputService.KeyboardEnabled then
                    p30:DisplayText(v[1], i == #p31);
                else
                    p30:DisplayText(v[2], i == #p31);
                end;
            end;
        end;
    end;

    p30.CanAdvance = true;
end;

function u1.Advance(u33) -- Line: 244
    -- upvalues: u19 (copy), soundUtil (copy), ReplicatedStorage (copy), Request (copy), RunService (copy)
    task.defer(function() -- Line: 245
        -- upvalues: u33 (copy), u19 (ref), soundUtil (ref), ReplicatedStorage (ref), Request (ref), RunService (ref)
        if not u33.CanAdvance then
            return;
        end;

        u33.CanAdvance = false;
        local v34 = u33;
        v34.Step = v34.Step + 1;

        if u33.Step > 1 then
            local v35 = u19[u33.Step - 1];

            if v35 and not v35.Auto then
                soundUtil:play(ReplicatedStorage.Resources.TutSuccess, workspace);
            end;
        end;

        u33.Container:Clean();
        local u36 = u19[u33.Step];

        if not u36 then
            return;
        end;

        local u37 = Request.Base(u33.Player.Character);

        if u37 then
            u37.soccerUtil.timerspeed = -1;

            if u36.Ball then
                u37:set("cantgetBall", false);
                u37.soccerUtil:giveBall(u37.character, true);
            end;

            u37:set("cantgetBall", true);

            if u36.KeepBall then
                u33.Container:Connect(RunService.Heartbeat, function() -- Line: 267
                    -- upvalues: u37 (copy)
                    if not u37:haveball() then
                        u37:set("cantgetBall", false);
                        u37.soccerUtil:giveBall(u37.character, true);
                        u37:set("cantgetBall", true);
                    end;
                end);
            end;
        end;

        if u36.Heartbeat then
            u33.Container:Connect(RunService.Heartbeat, function() -- Line: 277
                -- upvalues: u36 (copy), u33 (ref)
                u36.Heartbeat(u33);
            end);
        end;

        local Dummy = u36.Dummy;

        if typeof(Dummy) == "table" then
            local u38 = 0;
            local table_unpack_ret, u39, v40 = table.unpack(Dummy);
            local u41 = Request.Dummy();
            u41:set("style", table_unpack_ret);
            u41:set("nocd", true);
            u33.Container:Add(u41.character);
            u33.Container:Connect(RunService.Heartbeat, function(p42) -- Line: 289
                -- upvalues: u39 (copy), u38 (ref), u33 (ref), u41 (copy), ReplicatedStorage (ref)
                if u39 then
                    if u38 >= 2 then
                        u38 = u38 - 2;

                        if u33.CanAdvance then
                            u41:use({ u39 });
                        end;
                    else
                        u38 = u38 + p42;
                    end;
                end;

                local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

                if CFBall and ((u41.root.Position - CFBall.Value.Position).Magnitude < 7 and not u41.character:GetAttribute("cantgetball")) then
                    u41.soccerUtil:giveBall(u41.character);
                end;
            end);

            if v40 then
                u41.soccerUtil:giveBall(u41.character, true);
            end;
        end;

        if u36.MonologueStart then
            u36.MonologueStart(u33);
        end;

        if not u36.Auto then
            u33:Monologue(u36.Text);

            if u36.MonologueEnd then
                u36.MonologueEnd(u33);
            end;

            return;
        end;

        u33:Monologue(u36.Text);

        if u36.MonologueEnd then
            u36.MonologueEnd(u33);
        end;

        u33:Advance();
    end);
end;

function u1.AdvancePlayerForStep(u43: userdata, u44: number) -- Line: 330
    -- upvalues: u3 (copy)
    task.defer(function() -- Line: 331
        -- upvalues: u43 (copy), u3 (ref), u44 (copy)
        if not u43 then
            return;
        end;

        local v45 = u3[u43];

        if not v45 then
            return;
        end;

        if v45.Step ~= u44 then
            return;
        end;

        v45:Advance();
    end);
end;

function u1.AdvanceBaseForStep(p46: any, p47: number) -- Line: 340
    -- upvalues: u1 (copy)
    if typeof(p46) == "table" then
        u1.AdvancePlayerForStep(p46.player, p47);
    end;
end;

return u1;